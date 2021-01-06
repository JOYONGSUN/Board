package kr.or.bit.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.bit.dao.ProjectDao;
import kr.or.bit.dao.Project_memberDao;
import kr.or.bit.dto.project;
import kr.or.bit.dto.project_member;

/*
파일명: ProjectService.java
설명: 프로젝트 추가,수정,삭제 및 정렬 작업 후 db에 저장
작성일: 2020-12-31 ~ 
작성자: 문지연,변재홍
*/

@Service
public class ProjectService {

	@Autowired
	private SqlSession sqlsession;
	
	//edit project title
	public void editProjectTitleService(project pro) {
		ProjectDao projectdao = sqlsession.getMapper(ProjectDao.class);
		projectdao.editProjectTitle(pro);			
	}
	
	//create pie 
	public void createPieService(project pro) {
		ProjectDao projectdao = sqlsession.getMapper(ProjectDao.class);
		projectdao.createPie(pro);
	}
	
	//create pie 
	public ArrayList<project> getPieListService(String userEmail) {
		ProjectDao projectdao = sqlsession.getMapper(ProjectDao.class);
		ArrayList<project> proList = projectdao.getPieList(userEmail);
		System.out.println("DAO를 거친 LIST : "+proList);
		return proList;
	}
	
	//get project title  
	public String getProjectTitleService(int projectNum) {
		ProjectDao projectdao = sqlsession.getMapper(ProjectDao.class);
		String title = projectdao.getProjectTitle(projectNum);
		return title;
	}
	
	//초대 승락시 이메일 중복 검
	public project_member isExistFromProjectService(int projectNum, String email) {
		Project_memberDao project_memberDao = sqlsession.getMapper(Project_memberDao.class);
		project_member pm = project_memberDao.isExistFromProject(projectNum, email);
		return pm;
	}
	
	//초대 승락!!
	public void joinToPieAsTeamService(int projectNum, String email) {
		Project_memberDao project_memberDao = sqlsession.getMapper(Project_memberDao.class);
		project_memberDao.joinToPieAsTeam(projectNum, email);
	}
		
}
