package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper { //DAO
	
	// 목록
	public List<BoardVO> getList();
	
    /* -- 추가 -------------------------- */
	// 등록 (인덱스를 알 필요 없는 경우)
	public void insert(BoardVO board);
	
	// 등록2 (인덱스 알아내기)
	public void insertSelectKey(BoardVO board);
	
	// 상세보기
	public BoardVO read(Long bno);
	
	// 삭제
	public int delete(Long bno);
	
	// 수정
	public int update(BoardVO board);  //추가
	
	// 목록 with 페이징
	public List<BoardVO> getListWithPaging(Criteria cri);

	public int getTotalCount(Criteria cri);
	
	
	
}
