$(document).ready(function(){
	var modal_background = document.getElementById('userEdit_modal_background');
	var modal_userEdit = document.getElementById('userEdit_modal_contents');
	var modal_pwdCheck = document.getElementById('userEdit_pwdCheck_modal_contents');
	var modal_withdrawal = document.getElementById('userEdit_withdrawal_modal_contents');
	let create_new_pie_modal =  document.getElementById('create_new_pie_modal'); 
	let invite_new_pie_modal =  document.getElementById('invite_new_pie_modal'); 
	
	$('#createNewPIE').click(function(){
		modal_background.style.display = 'block';
		create_new_pie_modal.style.display= 'block';
	});
		
	$(document).on("click", ".inviteBtn", function(e) {
		modal_background.style.display = 'block';
		invite_new_pie_modal.style.display= 'block';
	});
	
	$('#user_edit').click(function(){
		modal_background.style.display = 'block';
		modal_userEdit.style.display= 'block';
	});
	
	$('#userEdit_main_withdrawal_btn').click(function(){
		modal_userEdit.style.display = 'none';
		modal_pwdCheck.style.display = 'block';
	});
	
	$('#userEdit_withdrawal_complete_btn').click(function(){
		modal_pwdCheck.style.display = 'none';
		modal_withdrawal.style.display = 'block';
	});
	
	window.onclick = function(event) {
		if(event.target == modal_background) {
			modal_background.style.display = 'none';
			modal_userEdit.style.display= 'none';
			modal_pwdCheck.style.display = 'none';
			modal_withdrawal.style.display = 'none';
			create_new_pie_modal.style.display = 'none';
			invite_new_pie_modal.style.display = 'none';
			$("#userList").empty();
			$("#userName").val('');
		}
	}
	

	$.ajax(
		{  
		   type : "post",
		   url  : "getPieList.pie?userEmail="+$("#userEmail").val(),
		   contentType: "application/json; charset=UTF-8",
		   dataType : "json",
		   async : false,
		   success : function(data){
		   console.log($("#userEmail").val());
		   
		   //console.log(data.pieList);
		   
		   let userEmail = $("#userEmail").val();
		   
		   $.each(data.pieList, function(index, item){ 
		   		if(userEmail === item.leader_email){
		   			let wholePie = makePie(item.project_seq, item.project_name, item.leader_email);
		   			console.log(item.project_seq);
		   			$("#pie-list").append(wholePie);
		   		}else{
		   			let wholePie = makePieNoneInvite(item.project_seq, item.project_name, item.leader_email);
		   			console.log(item.project_seq);
		   			$("#pie-list").append(wholePie);
		   		}
		   
		   		
		   });

		   
		   
		function makePie(project_seq, project_name, leader_email){
				let pie = "<div class='main-list-project-wrapper'>"+
					"<div class='main-list-project-left-info'>"+
						"<div class='main-list-project-logo-wrapper'>"+
							"<img src='/resources/img/pie_logo.png' class='project-logo'>"+
						"</div>"+
						"<div class='main-list-project-letter'>"+
							"<div class='main-list-project-letter1'>"+project_name+"</div>"+
							"<div class='main-list-project-letter3'>빅파이 : "+leader_email+"</div>"+
						"</div>"+
					"</div>"+
					"<div class='main-list-project-right-btn-wrapper'>"+
						"<button class='main-list-project-right-btn1 inviteBtn'>초대</button>"+
						"<a href = 'goToMain.pie?projectNum="+project_seq+"'><button class='main-list-project-right-btn2'>PIE로 가기</button></a>"+
					"</div>"+
				"</div>";
				
			return pie;	
		}    
		
			function makePieNoneInvite(project_seq, project_name, leader_email){
				let pie = "<div class='main-list-project-wrapper'>"+
					"<div class='main-list-project-left-info'>"+
						"<div class='main-list-project-logo-wrapper'>"+
							"<img src='/resources/img/pie_logo.png' class='project-logo'>"+
						"</div>"+
						"<div class='main-list-project-letter'>"+
							"<div class='main-list-project-letter1'>"+project_name+"</div>"+
							"<div class='main-list-project-letter3'>빅파이 : "+leader_email+"</div>"+
						"</div>"+
					"</div>"+
					"<div class='main-list-project-right-btn-wrapper'>"+
						"<a href = 'goToMain.pie?projectNum="+project_seq+"'><button class='main-list-project-right-btn2'>PIE로 가기</button></a>"+
					"</div>"+
				"</div>";
				
			return pie;	
		}    
		   
	
		   		
		   }
		} 
	  )  
	  
	  	function inviteUser(userEmail){
	  	let users = "<li class='userList-wrapper'>" +
					"<div class='userList-email'>" +
					userEmail + 
					"</div>" +
					"<div class='userList-btn'>" +
					"<i class='fas fa-times'></i>" +
					"</div></li>"
	  	return users;
	  	}
	  
	  	//사용자 초대하기 버튼 클릭 
		$(document).on("click", ".userInviteBtn", function(e) {
		console.log($("#userName").val());
		let users = inviteUser($("#userName").val());
		$("#userList").append(users);
		});
	
	
	
	
});