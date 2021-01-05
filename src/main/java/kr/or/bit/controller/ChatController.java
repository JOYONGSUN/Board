package kr.or.bit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.bit.dto.room;
import kr.or.bit.dto.roomlist;
import kr.or.bit.dto.user;
import kr.or.bit.service.ChatService;

@RestController
public class ChatController {
	
	@Autowired
	private ChatService chatservice;

	@RequestMapping(value="/chat/members", method = RequestMethod.GET)
	public List<user> chatUserList(){
		List<user> memberList = null;
		System.out.println("ChatMembers Controller");
		try {
			memberList = chatservice.chatUserList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberList;
	}
	
	@RequestMapping(value="/chat/members", method = RequestMethod.POST)
	public Map<String, Object> makeRoom(String[] user_array){
		List<user> memberList = null;
		List<room> roomList = null;
		List<roomlist> user_room_list = null;
		HashMap<String, Object> insertMap = new HashMap<String, Object>();
		HashMap<String, Object> selectMap = new HashMap<String, Object>();
		try {
			// 선택된 파이원의 이메일 정보로 회원정보를 가져옴
			memberList = chatservice.chatUserListByEmail(user_array);
			
			// 채팅방 이름 가공 (...추가)
			String chatting_room_name = "";
			int index = 0;
			for(user user : memberList) {
				if(memberList.size()-1 == index++) {
					chatting_room_name += user.getNickName();
				}else {
					chatting_room_name += user.getNickName() + ",";
				}
			}
			
			// 해당 이름으로 채팅방 생성
			chatservice.insertChattingRoom(chatting_room_name);
			
			//채팅방 리스트 페이지에 바인딩
			roomList = chatservice.getRoomList();
			
			// 생성한 채팅방 번호 추출
			for(int i=0; i < roomList.size(); i++) {
				if(i == roomList.size()-1) {
					insertMap.put("room_number", roomList.get(i).getChatting_room_seq());
				}
			}
			
			//채팅방 리스트 생성
			insertMap.put("user_array", user_array);
			chatservice.insertChattingRoomList(insertMap);
			
			ArrayList<String> nicknames = new ArrayList<String>();
			
			String nickname = "";
			for(room room2 : roomList) {
				user_room_list = chatservice.getChattingRoomList(room2.getChatting_room_seq());
				for(roomlist list : user_room_list) {
					nickname += "#" + list.getNickName();
				}
				nicknames.add(nickname);
				nickname = "";
			}
			selectMap.put("chat_room_list", roomList);
			selectMap.put("nicknames", nicknames);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectMap;
	}
	
	@RequestMapping(value="/chat/members/search", method = RequestMethod.GET)
	public List<user> searchUser(String nickName){
		System.out.println("searchKeyword: " + nickName);
		List<user> user_list = null;
		try {
			user_list = chatservice.searchUser(nickName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user_list;
	}
	
	@RequestMapping(value="/chat/members/search", method = RequestMethod.POST)
	public List<user> searchAnotherUser(String[] user_array, String nickName){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("nickName", nickName);
		map.put("user_array", user_array);
		
		List<user> memberList = null;
		try {
			memberList = chatservice.searchAnotherUser(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberList;
	}
	
	@RequestMapping(value="/chat/members/close", method = RequestMethod.GET)
	public List<user> selectUser(String[] user_array, String nickName){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("nickName", nickName);
		map.put("user_array", user_array);
		
		List<user> memberList = null;
		try {
			memberList = chatservice.selectedUserClose(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberList;
	}
	
	@RequestMapping(value="/chat/roomlist", method = RequestMethod.GET)
	public Map<String, Object> chatRoomList(){
		List<room> chat_room_list = null;
		List<roomlist> user_room_list = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			chat_room_list = chatservice.getRoomList();
			
			ArrayList<String> nicknames = new ArrayList<String>();
			
			String nickname = "";
			for(room room : chat_room_list) {
				user_room_list = chatservice.getChattingRoomList(room.getChatting_room_seq());
				for(roomlist list : user_room_list) {
					nickname += "#" + list.getNickName();
				}
				nicknames.add(nickname);
				nickname = "";
			}
			
			System.out.println("nicknames: " + nicknames);
			
			map.put("chat_room_list", chat_room_list);
			map.put("nicknames", nicknames);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	@RequestMapping(value="/chat/roomlist", method = RequestMethod.POST)
	public List<room> insertChatRoomList(){
		List<room> chat_room_list = null;
		try {
			chat_room_list = chatservice.getRoomList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return chat_room_list;
	}
	
	@RequestMapping(value="/chat/roomlist", method = RequestMethod.DELETE)
	public void deleteRoom(@RequestParam("chatting_room_seq") int chatting_room_seq){
		try {
			chatservice.deleteRoomList(chatting_room_seq);
			chatservice.deleteRoom(chatting_room_seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/chat/room", method = RequestMethod.GET)
	public HashMap<String, Object> updateRoom(	@RequestParam("chatting_room_seq") int chatting_room_seq,
												@RequestParam("chatting_room_name") String chatting_room_name){
		List<roomlist> room_list = null;
		String chat_member = "";
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			chatservice.updateRoom(chatting_room_seq, chatting_room_name);
			//room_list = chatservice.getChattingRoomList(chatting_room_seq);
			
			//for(roomlist room : room_list) {
			//	chat_member += "#" + room.getNickName();
			//}
			System.out.println("chat_member_tag:" + chat_member);
			
			//map.put("chat_member", chat_member);
			//map.put("chatting_room_seq", chatting_room_seq);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	@RequestMapping(value="/chat/room", method = RequestMethod.POST)
	public Map<String, Object> searchRoom(String searchKeyword){
		List<room> room_list = null;
		List<roomlist> user_room_list = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			room_list = chatservice.searchRoom(searchKeyword);
			
			ArrayList<String> nicknames = new ArrayList<String>();
			
			String nickname = "";
			for(room room : room_list) {
				user_room_list = chatservice.getChattingRoomList(room.getChatting_room_seq());
				for(roomlist list : user_room_list) {
					nickname += "#" + list.getNickName();
				}
				nicknames.add(nickname);
				nickname = "";
			}
			map.put("chat_room_list", room_list);
			map.put("nicknames", nicknames);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
}
