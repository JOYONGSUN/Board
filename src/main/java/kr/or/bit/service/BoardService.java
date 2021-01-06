package kr.or.bit.service;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.velocity.VelocityEngineFactoryBean;
import org.springframework.ui.velocity.VelocityEngineUtils;

import kr.or.bit.dao.BoardDao;
import kr.or.bit.dao.ChatDao;
import kr.or.bit.dto.article;

@Service
public class BoardService {	
	@Autowired
	private SqlSession sqlsession;
	
	public List<article> selectAllArticlesList(){
		BoardDao dao = sqlsession.getMapper(BoardDao.class);
		return dao.selectAllArticlesList();
	}
	
	public int insertNewArticle(Map articleMap){
		BoardDao dao = sqlsession.getMapper(BoardDao.class);
		return dao.insertNewArticle(articleMap);
	}
	
	public article selectArticle(int articleNO){
		BoardDao dao = sqlsession.getMapper(BoardDao.class);
		return dao.selectArticle(articleNO);
	}
	
	public void updateArticle(Map articleMap){
		BoardDao dao = sqlsession.getMapper(BoardDao.class);
		dao.updateArticle(articleMap);
	}
	
	public void deleteArticle(int articleNO){
		BoardDao dao = sqlsession.getMapper(BoardDao.class);
		dao.deleteArticle(articleNO);
	}
	
	public List<article> selectImageFileList(int articleNO){
		BoardDao dao = sqlsession.getMapper(BoardDao.class);
		return dao.selectImageFileList(articleNO);
	}
	
	public int selectNewImageFileNO(){
		BoardDao dao = sqlsession.getMapper(BoardDao.class);
		return dao.selectNewImageFileNO();
	}
}