package kr.or.bit.dao.Board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import kr.or.bit.dao.BoardDao;
import kr.or.bit.dto.board;
import kr.or.bit.vo.Board.ImageVO;


@Repository("boardDAO")
public class BoardDaoImpl implements BoardDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List selectAllBoardesList() throws DataAccessException {
		List<board> boardesList = boardesList = sqlSession.selectList("mapper.board.selectAllBoardesList");
		return boardesList;
	}

	
	@Override
	public int insertNewBoard(Map boardMap) throws DataAccessException {
		int boardNO = selectNewBoardNO();
		boardMap.put("boardNO", boardNO);
		sqlSession.insert("mapper.board.insertNewBoard",boardMap);
		return boardNO;
	}
    
	//���� ���� ���ε�
	/*
	@Override
	public void insertNewImage(Map boardMap) throws DataAccessException {
		List<ImageVO> imageFileList = (ArrayList)boardMap.get("imageFileList");
		int boardNO = (Integer)boardMap.get("boardNO");
		int imageFileNO = selectNewImageFileNO();
		for(ImageVO imageVO : imageFileList){
			imageVO.setImageFileNO(++imageFileNO);
			imageVO.setABoardNO(boardNO);
		}
		sqlSession.insert("mapper.board.insertNewImage",imageFileList);
	}
	
   */
	
	@Override
	public board selectBoard(int boardNO) throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectBoard", boardNO);
	}

	@Override
	public void updateBoard(Map boardMap) throws DataAccessException {
		sqlSession.update("mapper.board.updateBoard", boardMap);
	}

	@Override
	public void deleteBoard(int boardNO) throws DataAccessException {
		sqlSession.delete("mapper.board.deleteBoard", boardNO);
		
	}
	
	@Override
	public List selectImageFileList(int boardNO) throws DataAccessException {
		List<ImageVO> imageFileList = null;
		imageFileList = sqlSession.selectList("mapper.board.selectImageFileList",boardNO);
		return imageFileList;
	}
	
	private int selectNewBoardNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectNewBoardNO");
	}
	
	private int selectNewImageFileNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectNewImageFileNO");
	}

}
