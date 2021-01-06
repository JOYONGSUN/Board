package kr.or.bit.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.bit.dao.CheckListDao;
import kr.or.bit.dto.checkList;

/*
파일명: CheckListService.java
설명: 칸반 보드 모달에서 체크리스트 추가,수정,삭제 작업 후 db에 저장
작성일: 2021-01-05 ~ 
작성자: 문지연
*/

@Service
public class CheckListService {

	@Autowired
	private SqlSession sqlsession;

	//Get Last CheckList Seq 
	public int getLastCheckSeqService() {
		CheckListDao chkdao  = sqlsession.getMapper(CheckListDao.class);
		int check_seq = chkdao.getLastCheckSeq();
		System.out.println("check_seq:"+check_seq);
		return check_seq;
	}
	
	//Insert CheckList 
	public boolean insertCheckListService(HashMap<String,Object> checkListInfo) {
		CheckListDao chkdao = sqlsession.getMapper(CheckListDao.class);
		chkdao.insertCheckList(checkListInfo);
		System.out.println("insert chk Service:"+checkListInfo);
		return true;
	}
	
	//Load Whole CheckList
	public ArrayList<checkList> loadWholeChkListService(int cardSeq) {
		CheckListDao chkdao = sqlsession.getMapper(CheckListDao.class);
		ArrayList<checkList> chkList = new ArrayList<>();
		chkList = chkdao.loadCheckList(cardSeq);
		return chkList;
	}
	
}
