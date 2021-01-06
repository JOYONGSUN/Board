package kr.or.bit.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.bit.dao.ChatDao;
import kr.or.bit.dto.room;
import kr.or.bit.dto.roomlist;
import kr.or.bit.dto.user;

@Service
public class ChatService {
	
	@Autowired
	private SqlSession sqlsession;

	public List<user> chatUserList(Map<String, Object> chatUserListMap){
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		return dao.chatUserList(chatUserListMap);
	}

	public List<user> chatUserListByEmail(String[] user_array){
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		return dao.chatUserListByEmail(user_array);
	}
	
	public List<user> selectedUserClose(HashMap<String, Object> map){
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		return dao.selectedUserClose(map);
	}
	
	public void insertChattingRoom(String chatting_room_name, int projectNum){
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		dao.insertChattingRoom(chatting_room_name, projectNum);
	}
	
	public room getChattingRoomByName(String chatting_room_name){
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		return dao.getChattingRoomByName(chatting_room_name);
	}
	
	public void insertChattingRoomList(HashMap<String, Object> map){
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		dao.insertChattingRoomList(map);
	}
	
	public List<room> getRoomList(int projectNum) {
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		return dao.getRoomList(projectNum);
	}
	
	public room getRoomListBySeq(int room_seq) {
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		return dao.getRoomListBySeq(room_seq);
	}
	
	public List<user> searchUser(Map<String, Object> searchUserMap) {
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		return dao.searchUser(searchUserMap);
	}
	
	public List<user> searchAnotherUser(HashMap<String, Object> map) {
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		return dao.searchAnotherUser(map);
	}
	
	public void deleteRoom(int chatting_room_seq) {
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		dao.deleteRoom(chatting_room_seq);
	}
	
	public void deleteRoomList(int chatting_room_seq) {
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		dao.deleteRoomList(chatting_room_seq);
	}
	
	public void updateRoom(int chatting_room_seq, String chatting_room_name) {
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		dao.updateRoom(chatting_room_seq, chatting_room_name);
	}
	
	public List<room> searchRoom(Map<String, Object> searchRoomMap) {
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		return dao.searchRoom(searchRoomMap);
	}
	
	public List<roomlist> getChattingRoomList(int chatting_room_seq) {
		ChatDao dao = sqlsession.getMapper(ChatDao.class);
		return dao.getChattingRoomList(chatting_room_seq);
	}
	
}