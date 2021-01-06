package kr.or.bit.dao;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.or.bit.dto.article;
import lombok.Data;

public interface BoardDao {

	public List<article> selectAllArticlesList();
	
	public int insertNewArticle(Map articleMap);
	
	public article selectArticle(int articleNO);
	
	public void updateArticle(Map articleMap);
	
	public void deleteArticle(int articleNO);
	
	public List<article> selectImageFileList(int articleNO);
	
	public int selectNewImageFileNO();
}