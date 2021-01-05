package kr.or.bit.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import kr.or.bit.dto.board;

/*
파일명: BoardDao.java(DAO)
설명: public interface BoardDao로 할일(kr.or.bit.dto.board의 class)
     dto랑 dao는 같이보고 작업해야 한다,dto내용을 dao로 묶어줌
작성일: 2021-01-05 ~ 
작성자: 조용선
*/

public interface BoardDao {
	
	/*모든 글 정보를 조회*/
	public List<board> selectAllArticlesList();	
	
	/*글정보를 저장*/
	public int insertNewArticle(Map articleMap);
	
	/*글정보 조회(열기)*/
	public board selectArticle(int boardNO);
	
	/*글정보를 수정*/
	public void updateArticle(Map articleMap);
	
	/*글정보를 삭제*/
	public void deleteArticle(int boardNO);
	
	/*이미지파일 조회*/
	public List<board> selectImageFileList(int boardNO);
		
}

