package kr.or.bit.dto;

import lombok.Data;
import java.sql.Date;

@Data
public class article {
	private int  level;
	private int articleNO;
	private int parentNO;
	private String title;
	private String content;
	private String imageFileName;
	private String id;
	private Date  writeDate;
	private int imageFileNO;
	private Date regDate;
}