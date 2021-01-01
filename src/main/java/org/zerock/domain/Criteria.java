package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@ToString
@Setter
@Getter
public class Criteria {

  private int pageNum;
  private int amount;
  private String type;  // 변수 추가
  private String keyword;  // 변수 추가

  public Criteria() {
    this(1, 10);
  }

  public Criteria(int pageNum, int amount) {
    this.pageNum = pageNum;
    this.amount = amount;
  }
  
  // 추가
  public String[] getTypeArr() {
    return type == null? new String[] {}: type.split("");
  }

  public String getListLink() {
	  UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
              // 필요한 패러미터를 쉽게 추가
			  .queryParam("pageNum", this.pageNum)
			  .queryParam("amount", this.getAmount())
			  .queryParam("type", this.getType())
			  .queryParam("keyword", this.getKeyword());
	  
	  return builder.toUriString();
  }

  
  
  


}