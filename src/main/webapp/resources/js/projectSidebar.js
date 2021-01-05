/*right sidebar contents wrapper*/
$(document).ready(function(){
	let btnClassName;
	let tmpBtnClassName = 'fas fa-star';
	let wrapper = document.getElementById('right-sidebar-contents-wrapper');	
	
	/*kanban & calendar 아이콘 클릭 시 다른 창 display: none */
	$('#sidebar-kanban').click(function(){
		wrapper.className = 'right-sidebar-contents-wrapper-hidden';
		document.getElementById(tmpBtnClassName).style.display = 'none';
	});
	$('#sidebar-calendar').click(function(){
		wrapper.className = 'right-sidebar-contents-wrapper-hidden';
		document.getElementById(tmpBtnClassName).style.display = 'none';
	});
	
	/*아이콘 클릭 시 해당 창으로 이동*/
	$('#sidebar-star').click(function(){
		btnClassName = $(this)[0].className;
		sidebarToggle();
	});
	$('#sidebar-bell').click(function(){
		btnClassName = $(this)[0].className;
		sidebarToggle();
	});
	$('#sidebar-file').click(function(){
		btnClassName = $(this)[0].className;
		sidebarToggle();
	});
	$('#sidebar-chat').click(function(){
		btnClassName = $(this)[0].className;
		sidebarToggle();
		
		//채팅방 목록 가져오기
		if(wrapper.className === 'right-sidebar-contents-wrapper-display'){
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
		
		//채팅방 - 검색 입력 내용 초기화
		if(wrapper.className === 'right-sidebar-contents-wrapper-hidden'){
			$('#chat-search-box').val('');
		}
	});
	$('#sidebar-users').click(function(){
		btnClassName = $(this)[0].className;
		sidebarToggle();
	});
	
	function sidebarToggle(){
		let contentDiv = document.getElementById(btnClassName);
		if(wrapper.className === 'right-sidebar-contents-wrapper-hidden'){
			wrapper.className = 'right-sidebar-contents-wrapper-display';
			document.getElementById(tmpBtnClassName).style.display = 'none';
			contentDiv.style.display = 'block';
			tmpBtnClassName = btnClassName;
		} else {
			if(btnClassName === tmpBtnClassName){
				wrapper.className = 'right-sidebar-contents-wrapper-hidden';
				contentDiv.style.display = 'none';
			} else{ //이전에 클릭한 버튼과 일치하지 않을 때
				contentDiv.style.display  = 'block';
				document.getElementById(tmpBtnClassName).style.display = 'none';
				tmpBtnClassName = btnClassName;
				
				//채팅방 - 검색 입력 내용 초기화
				$('#chat-search-box').val('');
			}		
		}
	};
});


/*//right sidebar contents wrapper*/