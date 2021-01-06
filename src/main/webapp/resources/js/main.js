$(document).ready(function() {
	let modal_background = document.getElementById('userEdit_modal_background');
	let modal_userEdit = document.getElementById('userEdit_modal_contents');
	let modal_pwdCheck = document.getElementById('userEdit_pwdCheck_modal_contents');
	let modal_withdrawal = document.getElementById('userEdit_withdrawal_modal_contents');
	let create_new_pie_modal = document.getElementById('create_new_pie_modal');
	let invite_new_pie_modal = document.getElementById('invite_new_pie_modal');

	$('#createNewPIE').click(function() {
		modal_background.style.display = 'block';
		create_new_pie_modal.style.display = 'block';
	});

	$(document).on("click", ".inviteBtn", function(e) {
		modal_background.style.display = 'block';
		invite_new_pie_modal.style.display = 'block';
		projectNum = Number($(this).attr("data-project-seq"));
		fromWho = $(this).attr("data-leader-email");
		fromProjectName = $(this).attr("data-project-name");
		console.log("this");
		console.log(projectNum);
		console.log(fromWho);
		console.log(fromProjectName);
	});

	$('#user_edit').click(function() {
		modal_background.style.display = 'block';
		modal_userEdit.style.display = 'block';
	});

	$('#userEdit_main_withdrawal_btn').click(function() {
		modal_userEdit.style.display = 'none';
		modal_pwdCheck.style.display = 'block';
	});

	$('#userEdit_withdrawal_complete_btn').click(function() {
		modal_pwdCheck.style.display = 'none';
		modal_withdrawal.style.display = 'block';
	});

	window.onclick = function(event) {
		if (event.target == modal_background) {
			modal_background.style.display = 'none';
			modal_userEdit.style.display = 'none';
			modal_pwdCheck.style.display = 'none';
			modal_withdrawal.style.display = 'none';
			create_new_pie_modal.style.display = 'none';
			invite_new_pie_modal.style.display = 'none';
			$("#userList").empty();
			$("#userName").val('');
		}
	}
			function makePie(project_seq, project_name, leader_email) {
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
						"<button class='main-list-project-right-btn1 inviteBtn' data-project-seq ='"+project_seq+
						"'data-leader-email='"+leader_email+"'data-project-name='"+project_name+"'>초대</button>"+
						"<a href = 'goToMain.pie?projectNum="+project_seq+"'><button class='main-list-project-right-btn2'>PIE로 가기</button></a>"+
						"</div>"+
						"</div>";
					return pie;
				}

				function makePieNoneInvite(project_seq, project_name, leader_email) {
					let pie = "<div class='main-list-project-wrapper'>" +
						"<div class='main-list-project-left-info'>" +
						"<div class='main-list-project-logo-wrapper'>" +
						"<img src='/resources/img/pie_logo.png' class='project-logo'>" +
						"</div>" +
						"<div class='main-list-project-letter'>" +
						"<div class='main-list-project-letter1'>" + project_name + "</div>" +
						"<div class='main-list-project-letter3'>빅파이 : " + leader_email + "</div>" +
						"</div>" +
						"</div>" +
						"<div class='main-list-project-right-btn-wrapper'>" +
						"<a href = 'goToMain.pie?projectNum=" + project_seq + "'><button class='main-list-project-right-btn2'>PIE로 가기</button></a>" +
						"</div>" +
						"</div>";
					return pie;
				}


	$.ajax(
		{
			type: "post",
			url: "getPieList.pie?userEmail=" + $("#userEmail").val(),
			contentType: "application/json; charset=UTF-8",
			dataType: "json",
			async: false,
			success: function(data) {
				console.log($("#userEmail").val());

				//console.log(data.pieList);

				let userEmail = $("#userEmail").val();

				$.each(data.pieList, function(index, item) {
					//본인이 빅파이 일시 초대 버튼 있는 프로젝트 
					if (userEmail === item.leader_email) {
						let wholePie = makePie(item.project_seq, item.project_name, item.leader_email);
						console.log(item.project_seq);
						$("#pie-list").append(wholePie);
					//아닐 시 초대버튼 없는 프로젝트
					} else {
						let wholePie = makePieNoneInvite(item.project_seq, item.project_name, item.leader_email);
						console.log(item.project_seq);
						$("#pie-list").append(wholePie);
					}
				});
			}
		}
	)

	//초대할 사용자 
	function inviteUser(userEmail){
	let users = "<li class='userList-wrapper'>" +
		"<div class='userList-email'>" +
		userEmail +
		"</div>" +
		"<div class='userList-btn'>" +
		"<i class='fas fa-times'></i>" +
		"</div></li>";
	return users;
}
	
	let pies = new Array();


//사용자 초대하기 버튼 클릭 
$(document).on("click", ".userInviteBtn", function(e) {
	console.log($("#userName").val());
	let users = inviteUser($("#userName").val());
	
	//본인을 초대하려고 할 시 
	if ($("#userName").val() === $("#userEmail").val()) {
		alert("본인은 초대할 수 없습니다.");
		$("#userName").val("");
		$("#userName").focus();
		//그 외 
	} else {
		//이메일 형식이 맞으면 통과 
		if (isEmail($("#userName").val())) {
			//중복으로 초대하려고 할 시 
			if (pies.includes($("#userName").val())) {
				alert("초대는 한번이면 충분하죠 ^_^");
				//통과 
			} else {
				$("#userList").append(users);
				pies.push($("#userName").val());
				console.log(pies);
			}
			//이메일 형식이 틀리면 alert 		
		} else {
			alert("잘못된 이메일입니다.");
			$("#userName").val("");
			$("#userName").focus();
		}
	}

})

let projectNum = null;
let fromWho = null;
let fromProjectName = null;


//최종초대 버튼 누르기
$(document).on("click", "#invite-submit", function(e) {
	console.log(pies);
	console.log("최종초대");

	//아무도 입력 안 했는데 초대하려고 할 시
	if (pies.length === 0) {
		alert("초대할 사람을 알려주세요.");
	} else {
		//json을 java컨트롤러가 받을 수 있는 string으로 변환 		
		//let finalPie = JSON.stringify(pies);
		//let finalProjectNum = JSON.stringify(projectNum);
		
		let dataOb = new Object();
		
		dataOb.finalPie = pies;
		dataOb.finalProjectNum = projectNum;
		dataOb.finalFromWho = fromWho;
		dataOb.finalFromProjectName = fromProjectName;
		let data = JSON.stringify(dataOb);
		
		console.log("data");
		$.ajax(
			{
				method: "post",
				url: "invitePIE.pie",
				contentType: "application/json; charset=UTF-8",
				traditional : true,
				dataType: "json",
				data : data,
				async: false,
				success: function(data) {
					let suc = data.data;
					if(suc==='success'){
						modal_background.style.display = 'none';
						invite_new_pie_modal.style.display = 'none';
						$("#userList").empty();
						$("#userName").val('');
						alert("초대가 완료되었습니다!");
					}else{
						
					}
				}
			}
		)
	}
});

//사용자 초대 목록 삭제 버튼
$(document).on("click", ".userList-btn", function(e) {
	//삭제한 이메일 
	let deletedEmail = $(this).prev()[0].innerText;
	console.log(deletedEmail);

	//화면상의 리스트 삭제 
	$(this).parent().remove();
	let deletedNum = pies.indexOf(deletedEmail);

	//Array에 값을 지움 
	pies.splice(deletedNum);
	console.log(pies);
});


//이메일 정규표현식
//이메일 형식이면 통과 글자수 제한없음
function isEmail(asValue) {
	let regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	return regExp.test(asValue);
}
});