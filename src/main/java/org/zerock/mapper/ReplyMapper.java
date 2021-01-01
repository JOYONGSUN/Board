package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	/* 댓글 등록 */
	public int insert(ReplyVO vo);

	/* 댓글 상세보기 */
	public ReplyVO read(Long rno);

	/* 댓글 삭제 */
	public int delete(Long rno);

	/* 댓글 수정 */
	public int update(ReplyVO reply);

	/* 댓글 목록 with 페이징 */
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri, 
			@Param("bno") Long bno);
	
	/* 댓글의 갯수 */
	public int getCountByBno(Long bno); 


}
