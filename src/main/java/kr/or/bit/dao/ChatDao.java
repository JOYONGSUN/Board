package kr.or.bit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.bit.dto.room;
import kr.or.bit.dto.roomlist;
import kr.or.bit.dto.user;

public interface ChatDao {
	
	 public List<user> chatUserList(Map<String, Object> chatUserListMap);
	 
	 public List<user> chatUserListByEmail(String[] user_array);
	 
	 public List<user> selectedUserClose(HashMap<String, Object> map);
	 
	 public void insertChattingRoom(String chatting_room_name, int projectNum);
	 
	 public room getChattingRoomByName(String chatting_room_name);
	 
	 public void insertChattingRoomList(HashMap<String, Object> map);
	 
	 public List<room> getRoomList(int projectNum);
	 
	 public room getRoomListBySeq(int room_seq);
	 
	 public List<user> searchUser(Map<String, Object> searchUserMap);
	 
	 public List<user> searchAnotherUser(HashMap<String, Object> map);
	 
	 public void deleteRoom(int chatting_room_seq);
	 
	 public void deleteRoomList(int chatting_room_seq);
	 
	 public void updateRoom(int chatting_room_seq, String chatting_room_name);
	 
	 public List<room> searchRoom(Map<String, Object> searchRoomMap);
	 
	 public List<roomlist> getChattingRoomList(int chatting_room_seq);
}
