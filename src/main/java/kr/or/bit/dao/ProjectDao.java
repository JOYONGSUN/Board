package kr.or.bit.dao;

import java.util.ArrayList;

import kr.or.bit.dto.project;

public interface ProjectDao {
	
	public void editProjectTitle(project pro);
	
	public void createPie(project pro);

	public ArrayList<project> getPieList(String userEmail);
	
	public String getProjectTitle(int projectNum);
}
