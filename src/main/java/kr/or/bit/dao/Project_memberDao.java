package kr.or.bit.dao;

import kr.or.bit.dto.project_member;

public interface Project_memberDao {
	
	public project_member isExistFromProject(int projectNum, String email);
	
	public void joinToPieAsTeam(int projectNum, String email);
}

 