package kr.or.bit.dto;

import lombok.Data;
import java.sql.Date;

@Data

/*
파일명: boaed.java(DTO)
설명: 소스구성,추후 DB설계 다시 해야할듯,롬북활용하여get set처리
     dto랑 dao는 같이보고 작업해야 한다.
작성일: 2021-01-05 ~ 
작성자: 조용선
*/

public class board {
	
	//level이 1보다 크면 답글을 표시:삭제할수도
	private int board_level;
	
	//이미지파일명
	private String board_imagefilename;
	
	/*
	PASS : 비밀번호
	READCOUNT : 게시글을 읽은 횟수
	*/
	
	
	
	//BOARD시작
	//[게시물&답글]번호:BOARD,BOARD_REPLY공통사항
	private int board_content_number; //프라이머리키
	 
	//[게시물]제목
	private String board_content_title;

	//[게시물]내용
	private String board_content;

	//[게시물]작성일
	private Date board_reporting_date;

	//[게시물]파일이름
	private String board_filename;

	//[게시물]파일사이즈
	private int board_filesize;

	//[게시물&답글]유저이메일(작성자)
	private String board_email; //포링키
	
	//[답글]답변글의 깊이:게시판 화면 상에서 댓글을 들여쓰기 위해 공란 하나당 1 만큼부여하는 숫자
	private int board_depth;

	//[답글]출력순서:한 REF 내에서 각 게시글 간의 화면출력순서를 정의하기 위해부여하는 숫자
	private int board_step;

	//[답글]글이 참조하는 원본 번호:본래의 게시물과 그에 따른 답글들을 하나로 묶어 그 각각의 묶음에 부여하는 숫자
	private int board_refer;
	
	//[답글]댓글번호
	private int board_re_number; //프라이머리키

	//[답글]댓글내용
	private String board_re_content;

	//[답글]댓글작성일
	private Date board_re_date;
	
	
	
/*
3) REF 계산법
ⓐ 새글 :
① REF --> { 글번호 복사 후 + 1 } 또는 { MAX(REF) + 1 }
② STEP --> 0
③ DEPTH --> 0
ⓑ 답글 :
① 원래 글의 REF, STEP, DEPTH를 복사
② 같은 GROUP 내에서 나보다 STEP이 큰 글의 STEP을 +1
③ 나의 STEP과 DEPTH를 각각 +1
ⓒ DB에서 자료를 순서대로 출력하는 방법
select * from BOARD order by REF desc, STEP asc
*/

	
	
/*
SQL 문
1) 테이블 생성
※ 주의사항 : READCOUNT, REF, STEP, DEPTH, REGDATE 는 사용자가 직접 입력하는 속성이 아니므로 DEFAULT 값을 지정해 주어야 한다.
CREATE TABLE "BOARD"(
"NUM" NUMBER(7,0) NOT NULL ENABLE,
"WRITER" VARCHAR2(12) NOT NULL ENABLE,
"EMAIL" VARCHAR2(30) NOT NULL ENABLE,
"SUBJECT" VARCHAR2(50) NOT NULL ENABLE,
"PASS" VARCHAR2(10) NOT NULL ENABLE,
"READCOUNT" NUMBER(5, 0) DEFAULT 0 NOT NULL ENABLE,
"REF" NUMBER(5, 0) DEFAULT 0 NOT NULL ENABLE,
"STEP" NUMBER(3,0) DEFAULT 0 NOT NULL ENABLE,
"DEPTH" NUMBER(3, 0) DEFAULT 0 NOT NULL ENABLE,
"REGDATE" TIMESTAMP(6) DEFAULT SYSDATE NOT NULL ENABLE,
"CONTENT" VARCHAR2(4000) NOT NULL ENABLE,
"IP" VARCHAR2(20) NOT NULL ENABLE,
CONSTRAINT "BOARD_PK" PRIMARY KEY ("NUM") ENABLE
);
--SELECT * FROM TAB;


2) 시퀀스 생성
※주의사항 : 시퀀스를 작성할 때는 인용부호("")와 쉼표(,)를 쓰지 않는다.
CREATE SEQUENCE BOARD_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE
NOCYCLE;
--SELECT * FROM SEQ;
	*/
	
}
