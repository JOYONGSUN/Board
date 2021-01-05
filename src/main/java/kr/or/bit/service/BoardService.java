package kr.or.bit.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.bit.dao.BoardDao;
import kr.or.bit.dto.board;
import kr.or.bit.dto.user;


@Service
public class BoardService{
	@Autowired
	private SqlSession sqlsession;

	public List<board> listBoardes(){
		BoardDao boarddao = sqlsession.getMapper(BoardDao.class);
		return boarddao.chatUserList();
	}	
	
	
	
	
	
	
	
	
	BoardDAO boardDAO;
	
	
	/*오류날수도~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	public void listBoardes(int level, int BoardNO, int parentNO, String title, String content, String imageFileName,
			String id, Date writeDate) {
		// TODO Auto-generated method stub
		
	}*/
	
	
	public List<board> listBoardes() throws Exception{
		BoardesList boardeslist = sqlsession.getMapper(BoardDao.class);
		BoardesList boardeslist = sqlsession.getMapper(BoardDao.class);
				
				boardDAO.selectAllBoardesList();
        return BoardesList;
	}
	//���� �̹��� �߰��ϱ�
	public int addNewBoard(Map boardMap) throws Exception{
		return boardDAO.insertNewBoard(boardMap);
	}
	
	 //���� �̹��� �߰��ϱ�
	/*
	@Override
	public int addNewBoard(Map boardMap) throws Exception{
		int boardNO = boardDAO.insertNewBoard(boardMap);
		boardMap.put("boardNO", boardNO);
		boardDAO.insertNewImage(boardMap);
		return boardNO;
	}
	*/
	/*
	//���� ���� ���̱�
	@Override
	public Map viewBoard(int boardNO) throws Exception {
		Map boardMap = new HashMap();
		Board board = boardDAO.selectBoard(boardNO);
		List<ImageVO> imageFileList = boardDAO.selectImageFileList(boardNO);
		boardMap.put("board", board);
		boardMap.put("imageFileList", imageFileList);
		return boardMap;
	}
   */
	
	
	 //���� ���� ���̱�
	public board viewBoard(int boardNO) throws Exception {
		board board = boardDAO.selectBoard(boardNO);
		return board;
	}
	public void modBoard(Map boardMap) throws Exception {
		boardDAO.updateBoard(boardMap);
	}
	public void removeBoard(int boardNO) throws Exception {
		boardDAO.deleteBoard(boardNO);
	}
}
/*public interface BoardService {
	public List<board> listBoard() throws Exception;
	public int addNewBoard(Map boardMap) throws Exception;
	public board viewBoard(int boardNO) throws Exception;
	//public Map viewBoard(int boardNO) throws Exception;
	public void modBoard(Map boardMap) throws Exception;
	public void removeBoard(int boardNO) throws Exception;
	
}*/
