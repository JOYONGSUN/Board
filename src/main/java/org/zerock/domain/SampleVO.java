package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor  //모든 속성을 사용하는 생성자를 위함
@NoArgsConstructor  //비어있는 생성자를 만듬
public class SampleVO {

  private Integer mno;
  private String firstName;
  private String lastName;

}
