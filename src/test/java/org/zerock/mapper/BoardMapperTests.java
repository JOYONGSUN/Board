package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;  //����
	

//	public void testGetList() {        //���ٽ�
//		mapper.getList().forEach(board -> log.info(board));
//        // getList()�� ���ϰ��� board �� ���� (ü�̴� ���)
//	}
//
//	@Test
//	public void testInsert() {
//		BoardVO board = new BoardVO();
//		board.setTitle("a���� �ۼ��ϴ� ��aaaaaaaaaaaaa");
//		board.setContent("���� �ۼ��ϴ� ����");
//		board.setWriter("newbie");
//		
//		mapper.insert(board);
//		
//		log.info(board);  //toString()�� �̿��ؼ� bno�� ���� �˾ƺ��� ����.
//	}

//	@Test
//	public void testInsertSelectKey() {
//		BoardVO board = new BoardVO();
//		board.setTitle("새로 작성하는 글 select key");
//		board.setContent("새로 작성하는 내용 select key");
//		board.setWriter("newbie");
//		
//		mapper.insertSelectKey(board);
//		
//		log.info(board);
//	}

//	public void testRead() {
//		// �����ϴ� �Խù� ��ȣ�� �׽�Ʈ
//		BoardVO board = mapper.read(2L);  //2L=bno
//		log.info(board);
//	}
//	
//	public void testDelete() {
//		log.info("DELETE COUNT: " + mapper.delete(3L));
//	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(125L);  // �۹�ȣ
		board.setTitle("테스트55");
		board.setContent("테스트");
		board.setWriter("테스트");
		
		int count = mapper.update(board);
		log.info("UPDATE COUNT: " + count);
	}


//	@Test
//	public void testDelete() {
//		log.info("DELETE COUNT: " + mapper.delete(3L));
//	}
	




}
