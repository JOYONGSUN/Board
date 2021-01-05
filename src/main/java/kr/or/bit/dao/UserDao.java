package kr.or.bit.dao;

import kr.or.bit.dto.user;

public interface UserDao {

	public void insertUser(user u);
	
	public user searchEmail(String email); 
	
	public void modifyPassword(user u);
	
}
