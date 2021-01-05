package kr.or.bit.dto;

import java.util.ArrayList;

import lombok.Data;

@Data
public class list {
	
	private int list_order_num; //리스트 순서 번호  
	private int list_seq; //리스트 고유 번호 
	private String list_name;
	private ArrayList<card> cardList;
}
