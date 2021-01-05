package kr.or.bit.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.or.bit.dto.list;

public interface ListDao {
	
	public void updateKanbanList(HashMap<String,Object> listAndProjectNum);
	
	public ArrayList<list> loadWholeList(int projectNum);
	
	public void insertKanbanList(HashMap<String,Object> listAndProjectNum);
	
	public int getListSeq(int projectNum);
	
	public int getLastListNum(int projectNum);
	
	public void editKanbanListTitle(list li);
	
	public void deleteKanbanList(int listSeq);
	
	
}
