package kr.or.bit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.bit.dto.room;
import kr.or.bit.dto.roomlist;
import kr.or.bit.dto.user;
import kr.or.bit.service.ChatService;

@Controller
public class ChatController {
	
	@Autowired
	private ChatService chatservice;

	@ResponseBody
	@RequestMapping(value="/chat/members", method = RequestMethod.GET)
	public List<user> chatUserList(@RequestParam("sessionEmail") String sessionEmail,
									HttpServletRequest request){
		//프로젝트 번호 세션에서 가져오기
		HttpSession httpsession = request.getSession();
		int projectNum = (int)httpsession.getAttribute("projectNum");
				
		List<user> memberList = null;
		Map<String, Object> chatUserListMap = new HashMap<String, Object>();
		System.out.println("ChatMembers Controller");
		try {
			
			chatUserListMap.put("sessionEmail", sessionEmail);
			chatUserListMap.put("projectNum", projectNum);
			memberList = chatservice.chatUserList(chatUserListMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberList;
	}
	
	@ResponseBody
	@RequestMapping(value="/chat/members", method = RequestMethod.POST)
	public Map<String, Object> makeRoom(@RequestParam("sessionEmail") String sessionEmail, 
										String[] user_array, 
										HttpServletRequest request){
		//프로젝트 번호 세션에서 가져오기
		HttpSession httpsession = request.getSession();
		int projectNum = (int)httpsession.getAttribute("projectNum");
		
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
			chatservice.insertChattingRoom(chatting_room_name, projectNum);
			
			//채팅방 리스트 페이지에 바인딩
			roomList = chatservice.getRoomList(projectNum);
			
			// 생성한 채팅방 번호 추출
			for(int i=0; i < roomList.size(); i++) {
				if(i == roomList.size()-1) {
					insertMap.put("room_number", roomList.get(i).getChatting_room_seq());
				}
			}
			
			//채팅방 리스트 생성
			insertMap.put("user_array", user_array);
			insertMap.put("sessionEmail", sessionEmail);
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
	
	@ResponseBody
	@RequestMapping(value="/chat/members/search", method = RequestMethod.GET)
	public List<user> searchUser(HttpServletRequest request, 
								@RequestParam("sessionEmail") String sessionEmail,
								String nickName){
		
		HttpSession httpsession = request.getSession();
		int projectNum = (int)httpsession.getAttribute("projectNum");
		
		System.out.println("searchKeyword: " + nickName);
		List<user> user_list = null;
		Map<String, Object> searchUserMap = new HashMap<String, Object>();
		try {
			searchUserMap.put("nickName", nickName);
			searchUserMap.put("projectNum", projectNum);
			searchUserMap.put("sessionEmail", sessionEmail);
			
			user_list = chatservice.searchUser(searchUserMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user_list;
	}
	
	@ResponseBody
	@RequestMapping(value="/chat/members/search", method = RequestMethod.POST)
	public List<user> searchAnotherUser(HttpServletRequest request, 
										@RequestParam("sessionEmail") String sessionEmail, 
										String[] user_array, 
										String nickName){
		
		HttpSession httpsession = request.getSession();
		int projectNum = (int)httpsession.getAttribute("projectNum");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("nickName", nickName);
		map.put("user_array", user_array);
		map.put("projectNum", projectNum);
		map.put("sessionEmail", sessionEmail);
		
		List<user> memberList = null;
		try {
			memberList = chatservice.searchAnotherUser(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberList;
	}
	
	@ResponseBody
	@RequestMapping(value="/chat/members/close", method = RequestMethod.GET)
	public List<user> selectUser(	HttpServletRequest request, 
									@RequestParam("sessionEmail") String sessionEmail, 
									String[] user_array, 
									String nickName){
		
		HttpSession httpsession = request.getSession();
		int projectNum = (int)httpsession.getAttribute("projectNum");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("nickName", nickName);
		map.put("user_array", user_array);
		map.put("projectNum", projectNum);
		map.put("sessionEmail", sessionEmail);
		
		List<user> memberList = null;
		try {
			memberList = chatservice.selectedUserClose(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberList;
	}
	
	@ResponseBody
	@RequestMapping(value="/chat/roomlist", method = RequestMethod.GET)
	public Map<String, Object> chatRoomList(HttpServletRequest request){
		HttpSession httpsession = request.getSession();
		int projectNum = (int)httpsession.getAttribute("projectNum");
		
		List<room> chat_room_list = null;
		List<roomlist> user_room_list = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			chat_room_list = chatservice.getRoomList(projectNum);
			
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
	
	@ResponseBody
	@RequestMapping(value="/chat/roomlist", method = RequestMethod.DELETE)
	public void deleteRoom(@RequestParam("chatting_room_seq") int chatting_room_seq){
		try {
			chatservice.deleteRoomList(chatting_room_seq);
			chatservice.deleteRoom(chatting_room_seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/chat/room", method = RequestMethod.GET)
	public void updateRoom(	@RequestParam("chatting_room_seq") int chatting_room_seq,
												@RequestParam("chatting_room_name") String chatting_room_name){
		List<roomlist> room_list = null;
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		try {
			
			chatservice.updateRoom(chatting_room_seq, chatting_room_name);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/chat/room", method = RequestMethod.POST)
	public Map<String, Object> searchRoom(HttpServletRequest request, String searchKeyword){
		HttpSession httpsession = request.getSession();
		int projectNum = (int)httpsession.getAttribute("projectNum");
		
		Map<String, Object> searchRoomMap = new HashMap<String, Object>();
		List<room> room_list = null;
		List<roomlist> user_room_list = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			
			searchRoomMap.put("searchKeyword", searchKeyword);
			searchRoomMap.put("projectNum", projectNum);
			room_list = chatservice.searchRoom(searchRoomMap);
			
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
	
	@RequestMapping(value="/chat/open", method = RequestMethod.GET)
	public String openChatRoom(String select, String roomname, Model model, HttpServletRequest request){
		System.out.println("select: " + select);
		System.out.println("roomname: " + roomname);
		return "chat";
	}
}
