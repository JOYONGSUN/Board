package org.zerock.service;

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
public class BoardServiceTests {
	
	@Setter(onMethod_ = { @Autowired })
	private BoardService service;

//	@Test
//	public void testExist() {
//		log.info(service);
//		assertNotNull(service);
//	}

//	@Test
//	public void testRegister() {
//		BoardVO board = new BoardVO();
//		board.setTitle("���� �ۼ��ϴ� ��");
//		board.setContent("���� �ۼ��ϴ� ����");
//		board.setWriter("newbie");
//
//		service.register(board);
//
//		log.info("������ �Խù��� ��ȣ: " + board.getBno());
//	}
	
	@Test
	public void testModify() {
		BoardVO board = new BoardVO();
		board.setBno(63L);  // �۹�ȣ
		board.setTitle("ffffff2");
		board.setContent("dddd2");
		board.setWriter("user2");
		
		boolean count = service.modify(board);
		/* service.modify(board); */
		log.info("UPDATE COUNT: " + count);
	}
	


}
