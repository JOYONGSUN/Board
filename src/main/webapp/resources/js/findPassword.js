$(document).ready(function(){
		//이메일 존재여부 체크 ajax 
		$('#emailCheck').click(function(){
			  $.ajax(
					 {  
						type : "post",
						url  : "searchEmail.pie",
						data : { email :$('#email').val()},
						async : false,
						success : function(data){
								if(data.user === null){
									alert("존재하지 않는 이메일 입니다.");
								}else{
									alert("입력하신 이메일로 인증번호를 전송하였습니다.");
									//이메일로 인증번호 전송
									  $.ajax(
											 {  
												type : "post",
												url  : "findPassword.pie",
												data : { email :$('#email').val()},
												async : false,
												success : function(data){
													console.log(data);
													//location.href = "pwdForgot_emailRequest.pie";
													
													//인증번호 텍스트 박스 만들기 
													let success = "<div class='pwdForgot-email-wrapper'><div class='pwdForgot-email-letter'>인증번호</div>"+
														"<input type='text' class='pwdForgot-email' id='certifyNum' name='email' placeholder='이메일에서 인증번호를 확인 후 입력해주세요.'>"+
														"<div class='pwdForgot-email-check'>"+"</div></div>";
													
													$("#email").attr("readonly", true);
													
													//인증번호 입력란 생성 
													$("#certify").append(success);
													
													//확인 버튼을 인증번호 확인 버튼으로 바꿈 
													$(".pwdForgot-btn-wrapper").children().remove();
													
													let certifyCheckBtn = "<input type = 'button' value ='인증번호 확인' class = 'pwdForgot-btn' id = 'certifyCheck'>";
													
													$(".pwdForgot-btn-wrapper").append(certifyCheckBtn);
													
												} 
											 } 
									       )  
								}
						} 
					 } 
			       )   
		});
		//인증번호 확인
		$(document).on('click', '#certifyCheck', function(){
				if($('#certifyNum').val() === ''){
						alert("인증번호를 입력해주세요.");
						return;
				}
			  $.ajax(
						 {  
							type : "post",
							url  : "certifyCheck.pie",
							data : { certifyNum :$('#certifyNum').val()},
							async : false,
							success : function(data){
									console.log(data);
									if(data === "success"){
										alert("인증 번호 확인 완료");
										location.href = "changePwdAfterCertify.pie?email="+$('#email').val();
										
									}else{
										alert("인증실패 !");
									}
							} 
						 } 
				       )   
		});
	});