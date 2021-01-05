/*right sidebar contents wrapper*/
"use strict";

$(document).ready(function(){
	var modal = document.getElementById('crtChat-modal')
	var crtChatBtn = document.getElementById('crtChatBtn');
	var crtChatCancelBtn = document.getElementById('crtChat-btn-cancel');
	var crtChatCreatedBtn = document.getElementById('crtChat-btn-created');
	var crtChatBackground = document.getElementById('crtChat-modal-background');
	var chatSearchBox = document.getElementById('chat-search-box');
	
	// +채팅방 생성하기 버튼 클릭시
	crtChatBtn.onclick = () => {
		$('#Selected-List').empty();
		$('#chat-search-box').val('');
		$('#crtChat-search-box').val('');
		modal.style.display = 'block';
		crtChatBackground.style.display = 'block';
		
		$.ajax(
			{
				type : "GET",
				url  : "chat/members",
				success : function(data){
					//console.log(data);
					userList(data);
				}
			}
		);
		
		//인원을 선택하지 않았을 경우 '채팅방 생성하기' 버튼 비활성화
		if($('#Selected-List').is(':empty')){
			$('.crtChat-btn-created').attr('class','crtChat-btn-created-not');
		}
		
	}
	
	// 채팅생성창에서 취소버튼을 눌렀을 떄
	crtChatCancelBtn.onclick = () => {
		modal.style.display = 'none';
		crtChatBackground.style.display = 'none';
		
	}
	
	// 채팅생성창에서 생성하기 버튼을 눌렀을 때
	crtChatCreatedBtn.onclick = () => {
		if(!$('#Selected-List').is(':empty')){
			modal.style.display = 'none';
			crtChatBackground.style.display = 'none';
			
			let div_length = $('#Selected-List').find('div').length;
			let user_array = [];
			for(let i=1; i <= div_length / 6; i++){
				let j = i * 6 - 2;
				let div = $('#Selected-List').find('div:eq('+j+')').text();
				user_array.push(div);
			}
			console.log('user_array');
			console.log(user_array);
			
			$.ajax(
					{
						type 		: "POST",
						url  		: "chat/members",
						traditional : true,
						data 		: {
							'user_array' : user_array
						},
						dataType	: "json",
						success 	: function(data){
							console.log(data);
							completeChattingRoom(data);
						},
						error		: function(request,status,error){
							alert(error);
						}
					}
			);
		}

		
	}
	
	
	window.onclick = (event) => {
		// 채팅방 생성창에서 blur된 화면을 클릭했을때
		if(event.target == crtChatBackground) {
			modal.style.display = 'none';
			crtChatBackground.style.display = 'none';
			
			// 채팅방리스트를 띄워주는 함수
			$.ajax(
				{
					type 		: "GET",
					url  		: "chat/roomlist",
					success 	: function(data){
						console.log(data);
						chattingRoomList(data);
					},
					error		: function(request,status,error){
						alert(error);
					}
				}
			);
		}
	}
	
	//채팅방 비동기 검색기능
	$('#chat-search-box').keyup( () => {
		$.ajax(
			{
				type : "post",
				url  : "chat/room",
				data : { 'searchKeyword' : $('#chat-search-box').val()},
				success : function(data){
					console.log(data);
					chattingRoomList(data);
				},
				error: function(request,status,error){
					alert(error);
				}
			}
		);
	});
	
	//채팅방 생성창 팀원 비동기 검색기능
	$('#crtChat-search-box').keyup( () => {
		//검색시 선택된 유저가 없으면
		if($('#Selected-List').html() == ''){
			$.ajax(
				{
					type : "GET",
					url  : "chat/members/search",
					data : { 'nickName' : $('#crtChat-search-box').val()},
					success : function(data){
						userList(data);
					},
					error: function(request,status,error){
						alert(error);
					}
				}
			);
		
		//검색시 선택된 유저가 한명이라도 있으면	
		}else{
			let div_length = $('#Selected-List').find('div').length;
			let user_array = [];
			for(let i=1; i <= div_length / 6; i++){
				let j = i * 6 - 2;
				let div = $('#Selected-List').find('div:eq('+j+')').text();
				user_array.push(div);
			}
			console.log('user_array');
			console.log(user_array);
			
			$.ajax(
				{
					type 		: "POST",
					url  		: "chat/members/search",
					data 		: {
						'nickName' : $('#crtChat-search-box').val(),
						'user_array' : user_array
					},
					traditional : true,
					success 	: function(data){
						console.log(data);
						userList(data);
					},
					error		: function(request,status,error){
						alert(error);
					}
				}
			);
		}

	});
	
	
});

/*
파일명: projectSidebar.js 에서 ajax 성공 시 실행되는 함수
설명: 채팅방리스트를 비동기로 띄움
작성일: 2020-12-31
작성자: 도재구
*/
function chattingRoomList(data){
	"use strict";
	$('#chat-list').empty();
	let opr = "";
	$.each(data.chat_room_list,function(index,elem){
		//프로젝트 제목
		let chat_title = elem.chatting_room_name;
		let chat_title_substr = "";
		if(chat_title.length > 17){
			chat_title_substr = chat_title.substr(0,17) + "...";
		}else{
			chat_title_substr = chat_title;
		}
			
		opr += "<div id='chat-list-wrapper-"+elem.chatting_room_seq+"' class='chat-list-wrapper'>"+
					"<div class='chat-list-img'>"+
						"<i class='fas fa-th-large'></i>"+
					"</div>"+
					"<div class='chat-list-letter-wrapper'>"+
						"<div id='chat-list-letter-title-"+elem.chatting_room_seq+"' class='chat-list-letter-title'>"+chat_title_substr+"</div>"+
						"<div id='chat-list-letter-members-"+elem.chatting_room_seq+"' class='chat-list-letter-members'>"+data.nicknames[index]+"</div>"+
					"</div>"+
					"<div id='chat-list-update-"+elem.chatting_room_seq+"' class='chat-list-update'>"+
						"<i onclick='updateChatRoomName(this)' class='fas fa-pencil-alt'></i>"+
					"</div>"+
					"<div id='chat-list-cancel-"+elem.chatting_room_seq+"' class='chat-list-cancel'>"+
						"<i onclick='deleteChatRoom(this)' class='fas fa-times'></i>"+
					"</div>"+
				"</div>";
	});
	$('#chat-list').append(opr);
	

}

/*
파일명: projectMainChat.js
설명: 채팅방 생성시 채팅방리스트에 생성된 것을 반영하여 리스트에 띄움
작성일: 2020-12-31
작성자: 도재구
*/
function completeChattingRoom(data){
	"use strict";
	$('#chat-list').empty();
	let opr = "";
	$.each(data.chat_room_list,function(index,elem){
		//프로젝트 제목
		let chat_title = elem.chatting_room_name;
		let chat_title_substr = "";
		if(chat_title.length > 17){
			chat_title_substr = chat_title.substr(0,17) + "...";
		}else{
			chat_title_substr = chat_title;
		}

		opr += "<div id='chat-list-wrapper-"+elem.chatting_room_seq+"' class='chat-list-wrapper'>"+
					"<div class='chat-list-img'>"+
						"<i class='fas fa-th-large'></i>"+
					"</div>"+
					"<div id='chat-list-letter-wrapper-"+elem.chatting_room_seq+"' class='chat-list-letter-wrapper'>"+
						"<div id='chat-list-letter-title-"+elem.chatting_room_seq+"' class='chat-list-letter-title'>"+chat_title_substr+"</div>"+
						"<div id='chat-list-letter-members-"+elem.chatting_room_seq+"' class='chat-list-letter-members'>"+data.nicknames[index]+"</div>"+
					"</div>"+
					"<div id='chat-list-update-"+elem.chatting_room_seq+"' class='chat-list-update'>"+
						"<i onclick='updateChatRoomName(this)' class='fas fa-pencil-alt'></i>"+
					"</div>"+					
					"<div id='chat-list-cancel-"+elem.chatting_room_seq+"' class='chat-list-cancel'>"+
						"<i onclick='deleteChatRoom(this)' class='fas fa-times'></i>"+
					"</div>"+
				"</div>";
	});
	$('#chat-list').append(opr);
}

/*
파일명: projectMainChat.js
설명: 채팅방 리스트에서 채팅방을 삭제합니다.
작성일: 2020-12-31
작성자: 도재구
*/
function deleteChatRoom(me){
	"use strict";
	let div = $(me).closest('div');
	let div_attr = div.attr("id");
	let div_index = div_attr.lastIndexOf("-")+1;
	let div_substr = div_attr.substring(div_index);
	
	console.log("div_substr");
	console.log(div_substr);
	
	$('#chat-list-wrapper-'+div_substr).remove();
	
	$.ajax(
		{
			type 		: "DELETE",
			url  		: "chat/roomlist?chatting_room_seq="+div_substr,
			success 	: function(data){
				console.log(data);
			},
			error		: function(request,status,error){
				alert(error);
			}
		}
	);
}

/*
파일명: projectMainChat.js
설명: 채팅방 이름을 수정하기 위해 input태그를 띄워줍니다.
작성일: 2020-12-31
작성자: 도재구
*/
function updateChatRoomName(me){
	"use strict";
	//index 값 추출
	let div = $(me).closest('div');
	let div_attr = div.attr("id");
	let div_index = div_attr.lastIndexOf("-")+1;
	let div_substr = div_attr.substring(div_index);
	
	//프로젝트명 div, 아이콘 div 하위요소 비우기
	let chat_room_title = $('#chat-list-letter-title-'+div_substr);
	let chat_room_update = $('#chat-list-update-'+div_substr);
	
	//새로운 요소로 대체
	let input_tag = "<input id='chat-list-letter-title-input-"+div_substr+"' value='"+chat_room_title.html()+"' onfocus='this.select()' type='text' size=12>";
	let check_button = "<i id='fas-fa-check-"+div_substr+"' onclick='updateNameOk(this)' class='fas fa-check'></i>";
	
	chat_room_title.empty();
	chat_room_update.empty();
	chat_room_title.append(input_tag);
	chat_room_update.append(check_button);
	
	$('#chat-list-letter-title-input-'+div_substr).focus();
	
	//엔터치면 수정기능 적용합니다.
	$('#chat-list-letter-title-input-'+div_substr).keydown( (event) => {
		if (event.which == 13) {
			event.preventDefault();
			updateNameOk($('#fas-fa-check-'+div_substr));
		}
	});
}

/*
파일명: projectMainChat.js
설명: 채팅방 이름 수정을 적용합니다.
작성일: 2020-12-31
작성자: 도재구
*/
function updateNameOk(me){
	"use strict";
	let div = $(me).closest('div');
	let div_attr = div.attr("id");
	let div_index = div_attr.lastIndexOf("-")+1;
	let div_substr = div_attr.substring(div_index);

	let chat_room_input = $('#chat-list-letter-title-input-'+div_substr);
	let chat_room_title = $('#chat-list-letter-title-'+div_substr);
	
	console.log("chat_room_input.attr('value')");
	console.log(chat_room_input.attr("value"));
	
	//input 태그에 값이 입력되어 있으면 그 값으로 수정함
	if(chat_room_input.val() != ''){
		$.ajax(
			{
				type 		: "GET",
				url  		: "chat/room?chatting_room_seq="+div_substr+"&chatting_room_name="+chat_room_input.val(),
				success 	: function(data){
					console.log(data);
					selectedUserWhenUpdated(data);
				},
				error		: function(request,status,error){
					alert(error);
				}
			}
		);
		//input 태그 삭제
		chat_room_input.remove();
		//div title에 value값 넣기
		chat_room_title.append(chat_room_input.val());
		
	//input 태그에 아무 값도 입력하지 않으면
	}else{
		//input 태그 삭제
		chat_room_input.remove();
		//div title에 value값 넣기
		chat_room_title.append(chat_room_input.attr("value"));
	}
	
	//버튼 이미지
	$('#chat-list-update-'+div_substr).empty();
	//div 태그에 버튼 이미지 넣기
	let opr = "<i onclick='updateChatRoomName(this)' class='fas fa-pencil-alt'></i>";
	$('#chat-list-update-'+div_substr).append(opr);
	
}

function selectedUserWhenUpdated(data){
	"use strict";
	let chat_member_tag = data.chat_member;
	//$.each(data,function(index,elem){
	//	chat_member_tag += "#" + elem.nickName;
	//}
	if(chat_member_tag.length > 27){
		chat_member_tag = chat_member_tag.substr(0,27) + "...";
	}
	console.log("chat_member_tag");
	console.log(chat_member_tag);

	console.log($('#chat-list-letter-members-'+data.chatting_room_seq));
	
	$('#chat-list-letter-members-'+data.chatting_room_seq).val(chat_member_tag);
	
	
}


/*
파일명: projectMainChat.js
설명: 채팅방 생성시 유저리스트를 DB에서 갖고옵니다
작성일: 2020-12-30
작성자: 도재구
*/
function userList(data){
	"use strict";
	$('#Chatting-UserList').empty();
	let opr = "";
	$.each(data,function(index,user){
		opr += "<div id='crtChat-select-users-wrapper-"+index+"' class='crtChat-select-users-wrapper'>"+
					"<div class='crtChat-select-user-wrapper'>"+
						"<div class='crtChat-select-user-subWrapper'>"+
							"<div class='crtChat-select-user-pic'>"+
								"<i class='fas fa-user'></i>"+					
							"</div>"+
							"<div class='crtChat-select-user-letters-wrapper'>"+
								"<div id='crtChat-select-user-name-"+index+"' class='crtChat-select-user-name'>"+
									user.nickName+
								"</div>"+
								"<div id='crtChat-select-user-email-"+index+"' class='crtChat-select-user-email'>"+
									user.email+
								"</div>"+
							"</div>"+
						"</div>"+
						"<div id='crtChat-select-user-btn-"+index+"' class='crtChat-select-user-btn'>"+
							"<i onclick='selectUser(this)' class='fas fa-plus'></i>"+
						"</div>"+
					"</div>"+
				"</div>";
	});
	$('#Chatting-UserList').append(opr);
};

/*
파일명: projectMainChat.js
설명: 유저리스트 중에서 + 버튼을 눌렀을 때 실행되는 함수
작성일: 2020-12-30
작성자: 도재구
*/
function selectUser(me){
	"use strict";
	//버튼을 누른 대상 USER의 index값 추출 'div_substr'
	let div = $(me).closest('div');
	let div_index = div.attr("id").lastIndexOf("-")+1;
	let div_substr = div.attr("id").substring(div_index);

	//버튼을 누른 대상 USER의 이름과 이메일 값 추출
	let nick_name = $('#crtChat-select-user-name-'+div_substr).html();
	let email = $('#crtChat-select-user-email-'+div_substr).html();
	
	console.log("email");
	console.log(email);
	
	let div_length = $('#Chatting-UserList').find('div').length;
	console.log(div_length);
	let user_array = [];
	for(let i=1; i <= div_length / 8; i++){
		let j = i * 8 - 2;
		let div = $('#Chatting-UserList').find('div:eq('+j+')').text();
		if(email != div){
			user_array.push(div);
		}
	}
	
	console.log('user_array');
	console.log(user_array);
	
	//버튼을 누른 대상 USER를 선택리스트에 옮기기
	let opr = "";
	opr +=	"<div id='crtChat-selected-user-wrapper-"+div_substr+"' class='crtChat-selected-user-wrapper'>"+
				"<div class='crtChat-selected-user-pic'>"+
					"<i class='fas fa-user'></i>"+	
				"</div>"+
				"<div class='crtChat-selected-user-letter-wrapper'>"+
					"<div id='crtChat-selected-user-letter-name-"+div_substr+"' class='crtChat-selected-user-letter-name'>"+
						nick_name+
					"</div>"+
					"<div id='crtChat-selected-user-letter-email-"+div_substr+"' class='crtChat-selected-user-letter-email' hidden>"+
						email+
					"</div>"+
					"<div id='crtChat-selected-user-letter-x-"+div_substr+"' class='crtChat-selected-user-letter-x'>"+
						"<i onclick='selectedClose(this)' class='fas fa-times'></i>"+
					"</div>"+
				"</div>"+
			"</div>";
					
	$('#Selected-List').append(opr);
	/*$('#Selected-List').css("display","block");
	$('#Selectedlist-Subject').css("display","block");*/
	//+버튼을 눌렀을시 Chatting-UserList에서 해당 유저 비우기
	$('#crtChat-select-users-wrapper-'+div_substr).remove();
	$('.crtChat-btn-created-not').attr('class','crtChat-btn-created');

	
}

/*
파일명: projectMainChat.js
설명: 선택된 리스트 중에서 취소 버튼을 눌렀을 때 실행되는 함수
작성일: 2020-12-30
작성자: 도재구
*/
function selectedClose(me){
	"use strict";
	//span 태그의 전체 html 정보
	let div = $(me).closest('div');
	//selected list에서 해당 유저 삭제
	let email = div.prev().html();
	console.log(div.parent('div').parent('div'));
	div.parent('div').parent('div').remove();
	//$('#crtChat-selected-user-wrapper-'+close_substr).remove();

	//selected list에 유저가 아무도 없을 때 display none
	//let close_attr_class = $('.crtChat-selected-user-letter-wrapper').attr("class");
	/*if(close_attr_class === undefined){
		$('#Selected-List').css("display","none");
		$('#Selectedlist-Subject').css("display","none");
	}*/

	//$('#crtChat-select-users-wrapper-'+close_substr).css("display","block");
	
	console.log("email");
	console.log(email);
	
	if($('#Selected-List').html() != ''){
		
		let div_length = $('#Selected-List').find('div').length;
		let user_array = [];
		for(let i=1; i <= div_length / 6; i++){
			let j = i * 6 - 2;
			let div = $('#Selected-List').find('div:eq('+j+')').text();
			if(email != div){
				user_array.push(div);
			}
		}
		console.log('user_array');
		console.log(user_array);
		
		$.ajax(
			{
				type 		: "POST",
				url  		: "chat/members/search",
				data 		: {
					'nickName' : $('#crtChat-search-box').val(),
					'user_array' : user_array
				},
				traditional : true,
				async		: false,
				success 	: function(data){
					console.log(data);
					userList(data);
				},
				error		: function(request,status,error){
					alert(error);
				}
			}
		);
		
		$.ajax(
			{
				type 		: "GET",
				url  		: "chat/members/close",
				data 		: {
					'nickName' : $('#crtChat-search-box').val(),
					'user_array' : user_array
				},
				traditional : true,
				async		: false,
				success 	: function(data){
					console.log(data);
					selectedUserList(data);
				},
				error		: function(request,status,error){
					alert(error);
				}
			}
		);
		
	}else{
		$.ajax(
			{
				type : "GET",
				url  : "chat/members/search",
				data : { 'nickName' : $('#crtChat-search-box').val()},
				success : function(data){
					userList(data);
				},
				error: function(request,status,error){
					alert(error);
				}
			}
		);
		
	}
	
	if($('#Selected-List').is(':empty')){
		$('.crtChat-btn-created').attr('class','crtChat-btn-created-not');
	}


}

function selectedUserList(data){
	"use strict";
	$('#Selected-List').empty();
	let opr = "";
	$.each(data,function(index,user){
		opr +=	"<div class='crtChat-selected-user-wrapper'>"+
					"<div class='crtChat-selected-user-pic'>"+
						"<i class='fas fa-user'></i>"+	
					"</div>"+
					"<div class='crtChat-selected-user-letter-wrapper'>"+
						"<div class='crtChat-selected-user-letter-name'>"+
							user.nickName+
						"</div>"+
						"<div class='crtChat-selected-user-letter-email' hidden>"+
							user.email+
						"</div>"+
						"<div class='crtChat-selected-user-letter-x'>"+
							"<i onclick='selectedClose(this)' class='fas fa-times'></i>"+
						"</div>"+
					"</div>"+
				"</div>";
	});
	$('#Selected-List').append(opr);
};
/*//right sidebar contents wrapper*/