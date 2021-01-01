<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<%@ include file="../includes/header.jsp" %>

<style>
   .uploadResult {
       width: 100%;
   }

   .uploadResult ul {
       display: flex;
       flex-flow: row;
       justify-content: center;
       align-items: center;
       padding: 0;
   }

   .uploadResult ul li {
       list-style: none;
       padding: 10px;
   }

   .uploadResult ul li img {
       width: 100px;
   }
   
   .uploadResult ul li span {color: dimgray;}
   
   .bigPictureWrapper {
        cursor: pointer;
   		position: fixed;
   		display: none;
   		justify-content: center;
   		align-items: center;
   		top: 0%;
   		width: 100%;
   		height: 100%;
   		z-index: 100;
   		background-color: rgba(0,0,0,0.8);
   }
   .bigPicture {
   		position: relative;
   		display: flex;
   		justify-content: center;
   		align-items: center;
   }
   .bigPicture img {width: 600px;}
</style>



  <!-- Begin Page Content -->
  <div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Board</h1>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
      <div class="card-header py-3">
        <h4 class="m-0 font-weight-bold text-primary">Read</h4>
      </div>
      <div class="card-body">
    		<div class="form-group">
    			<label>Bno</label>
    			<input class="form-control" value="${board.bno }" name="bno" readonly="readonly">
    		</div>
    		<div class="form-group">
    			<label>Title</label>
    			<input class="form-control" value="${board.title }" name="title" readonly>
    		</div>
    		<div class="form-group">
      		<label>Content</label>
      		<textarea class="form-control" rows="10" name="content" readonly>${board.content }</textarea>
      	</div>
      	<div class="form-group">
      		<label>Writer</label>
      		<input class="form-control" value="${board.writer }" name="writer" readonly>
      	</div>

	    <%-- <a data-oper="modify" class="btn btn-primary btn-sm" href="/board/modify?bno=${board.bno }">Modify</a>
	    <a data-oper="list" class="btn btn-primary btn-sm" href="/board/list">List</a> --%>

      <!-- 첨부파일 --------------------------------->
      <div class="row">
      	<div class="col-lg-12">
      		<div class="card shadow mb-4">
      			<div class="card-header py-3">
      				<h4 class="m-0 font-weight-bold text-primary">File Attach</h4>
      			</div>
      			<div class="card-body">
      				<div class="uploadResult">
      					<ul></ul>
      				</div>
      			</div>
      		</div>
      	</div>
      </div>
      <!-- 첨부파일 End -------------->	  

 <form id='operForm' action="/board/modify" method="get">
	<input type="hidden" id="bno" name="bno" value="${board.bno}">
	<input type="hidden" name="pageNum" value="${cri.pageNum}">
	<input type="hidden" name="amount" value="${cri.amount}"> 
	<input type="hidden" name="type" value="${cri.type}"> 
	<input type="hidden" name="keyword" value="${cri.keyword}">
	<input type="hidden" name="writer" value="${board.writer}">

	<sec:authentication property='principal' var="pinfo"/>
	<sec:authorize access="isAuthenticated()">
		<c:if test="${pinfo.username eq board.writer }">
			<button data-oper="modify" class="btn btn-primary btn-sm">Modify</button>
		</c:if>
	</sec:authorize>	

	<button data-oper="list" class="btn btn-primary btn-sm">List</button>
</form>
      </div>
    </div>




		<!-- Modal ---------------------------------------------------->
		<div class="modal" id="myModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">REPLY MODAL</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
			      <div class="form-group">
			      	<label>Reply</label>
			      	<input class="form-control" name="reply" value="New Reply!!!">
			      </div>
			      <div class="form-group">
			      	<label>Replyer</label>
			      	<input class="form-control" name="replyer" value="Replyer" readonly>
			      </div>
			      <div class="form-group">
			      	<label>Reply Date</label>
			      	<input class="form-control" name="replyDate" value=''>
			      </div>  
		      </div>          
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
		        <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
		        <button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
		        <button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- Modal 끝 ------------------>

		<!-- 댓글처리 ----------------------------------------------------->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<i class="fa fa-comments fa-fw"></i> Reply
				<sec:authentication property='principal' var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
					<button id="addReplyBtn" class="btn btn-primary btn-sm float-right">New Reply</button>
				</sec:authorize>				  
			</div>
			<div class="card-body">
				<ul class="chat list-group"></ul>
			</div>
			
			<div class="card-footer"></div>
			
		</div>
		<!-- 댓글처리 끝 ------------------>   

  </div>
  <!-- /.container-fluid -->
</div>
<!-- End of Main Content -->


<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
</div>


<%@ include file="../includes/footer.jsp" %>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script> 
$(document).ready(function() {
	
	$(".uploadResult").on("click", "li", function(e){
		console.log("view image");
		var liObj = $(this);
		var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));

		if (liObj.data("type")) {
			showImage(path.replace(new RegExp(/\\/g), "/"));
		} else {
			//download
			self.location = "/download?fileName=" + path
		}
	});
	
	function showImage(fileCallPath){
		/* alert(fileCallPath); */
		$(".bigPictureWrapper").css("display","flex").show();
		$(".bigPicture")
			.html("<img src='/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%', height:'100%'}, 1000);
	}

    //﻿ 원본 이미지 창 닫기
    $(".bigPictureWrapper").on("click", function(e){
        $(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
        setTimeout(function(){
            $(".bigPictureWrapper").hide();
        }, 1000);
    });

    
		// 익명함수 정의함과 동시에 호출
    (function(){
        var bno = "${board.bno}";
        $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
            console.log(arr);
            
            /* -- 추가 ----------------------------------------- */
            var str="";
            
    		$(arr).each(function(i,attach) {
    			if (attach.fileType) {
    				var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
    				str += "<li style='cursor:pointer' data-path='"+attach.uploadPath+"'";
    				str += " data-uuid='"+attach.uuid+"' data-fileName='"+attach.fileName+"'data-type='"+attach.fileType+"'>";
    				str += " <div>";
    				str += "<img src='/display?fileName=" + fileCallPath + "'>";
    				str += "</div>";
    				str += "</li>";
    			} else {
    				var fileCallPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
    				var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
    				str += "<li style='cursor:pointer' data-path='"+attach.uploadPath+"'";
    				str += " data-uuid='"+attach.uuid+"' data-fileName='"+attach.fileName+"'data-type='"+attach.fileType+"'>";
    				str += "<span> " + attach.fileName + " </span>";
    				str += " <div>";
    				str += "<img src='/resources/img/attachment.png'></a>";
    				str += "</div>";
    				str += "</li>";
    			}
    		});
            $(".uploadResult ul").html(str);
        });
    })();

		
		/* -- 댓글 페이징 추가 ---------------------------------- */
		var pageNum = 1;
		var replyPageFooter = $(".card-footer");  //댓글 페이징 출력 부분
		
		function showReplyPage(replyCnt) {
			var endNum = Math.ceil(pageNum / 10.0) * 10;  //끝 페이지
			var startNum = endNum - 9;  //시작 페이지
			
			var prev = startNum != 1;  //이전 페이지 유무, flag(시작페이지가 1이 아니면 true)
			var next = false;  //다음 페이지 유무, flag
			
			// 보정: 실제 댓글수가 endNum*10 보다 작으면 endNum 을 실제 끝페이지로 변경
			if (endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			// 실제 댓글수가 endNum*10 보다 크면 next 는 true
			if (endNum * 10 < replyCnt) {
				next = true;
			}
			
			var str = "<ul class='pagination float-right'>";
			
			if (prev) {
				str += "<li class='page-item'>";
				str += "	<a class='page-link' href='"+(startNum -1)+"'>";
				str += 			Previous;
				str += "	</a>";
				str += "</li>";
			}

			// 현재 페이지 번호와 같으면 active 붙임
			for (var i = startNum; i <= endNum; i++) {
				var active = pageNum == i ? "active" : "";
				
				str += "<li class='page-item "+active+" '>";
				str += "	<a class='page-link' href='"+i+"'>";
				str += 			i;
				str += "	</a>";
				str += "</li>";
			}
			
			if (next) {
				str += "<li class='page-item'>";
				str += "	<a class='page-link' href='"+(endNum +1)+"'>";
				str += 			Next;
				str += "	</a>";
				str += "</li>";
			}
			
			str += "</ul></div>";
			
			console.log(str);
			
			replyPageFooter.html(str);
		}
		/* -- 댓글 페이징 End-------------- */
		
		var bnoValue = "${board.bno}";  // 추가
		var replyUL = $(".chat");  //댓글 목록 ul

		showList(1);  //파라미터가 없는 경우 댓글 목록을 1페이지로 설정

		function showList(page) {
			replyService.getList({bno:bnoValue, page:page||1}, function(replyCnt, list){

				if (page == -1) {
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}

				var str="";
				
				if (list == null || list.length == 0) {
					replyUL.html("");
					return;
				}
				for (var i = 0, len = list.length||0; i < len; i++) {
					console.log(list[i]);
					str+="<li class = 'list-group-item' style='cursor:pointer' data-rno='"+list[i].rno+"'>";
					str+="	<div>";
					str+="		<div class = 'header'>";
					str+="			<strong class = 'text-primary'>";
					str+=					list[i].replyer;
					str+="			</strong>";
					str+="			<small class='float-right text-muted'>";
					str+=					replyService.displayTime(list[i].replyDate);
					str+="			</small>";
					str+="		</div>";
					str+="		<p>" + list[i].reply + "</p>";
					str+="	</div>";
					str+="</li>";
				}
				replyUL.html(str);

				showReplyPage(replyCnt);

								
			});
		}

		
		/* -- Modal 추가 -------------------------- */
		var modal = $("#myModal");  //모달창
		var modalInputReply = modal.find("input[name='reply']");  //댓글내용
		var modalInputReplyer = modal.find("input[name='replyer']");  //작성자
		var modalInputReplyDate = modal.find("input[name='replyDate']");  //작성일
		
		var modalModBtn = $("#modalModBtn");  //수정버튼
		var modalRemoveBtn = $("#modalRemoveBtn");  //삭제버튼
		var modalRegisterBtn = $("#modalRegisterBtn");  //등록버튼

		/* -- 추가 -- */
		var replyer = null;  //댓글 작성자를 변수로 설정
		<sec:authorize access = "isAuthenticated()">
			replyer = '<sec:authentication property="principal.username"/>';
		</sec:authorize>
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		/* -- 추가 끝 -- */


		
		// new reply 버튼 클릭시 모달창 띄우기
		$("#addReplyBtn").on("click", function(e) {
			modal.find("input").val("");  //입력 항목 초기화
			modal.find("input[name='replyer']").val(replyer);
			modalInputReplyDate.closest("div").hide();  //날짜 숨기기
			modal.find("button[id != 'modalCloseBtn']").hide();  //닫기버튼만 보이기
			
			modalRegisterBtn.show();  //register 버튼 보이기
			$("#myModal").modal("show");  //modal 창 보이기
		});
		/* -- Modal End -------- */

		//댓글 조회 클릭 이벤트 처리 
		$(".chat").on("click", "li", function(e){
		  
			var rno = $(this).data("rno");  //댓글번호
			
			replyService.get(rno, function(reply){
		  
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
					.attr("readonly","readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id !='modalCloseBtn']").hide();
				modalModBtn.show();  //수정버튼 보이기
				modalRemoveBtn.show();  //삭제버튼 보이기
				
				$("#myModal").modal("show");  //모달창 띄우기
				  
		 	});
		});
		
		replyPageFooter.on("click","li a", function(e) {
			e.preventDefault();  // <a>태그의 기본동작을 제한
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			
			console.log("targetPageNum: " + targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		});
		
		// 모든 ajax 전송 시, 토큰값 전달
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});

		
		/* Register 버튼 클릭 시 댓글 등록 */
		modalRegisterBtn.on("click", function(e){
			var reply = {
					reply: modalInputReply.val(),
					replyer: modalInputReplyer.val(),
					bno: bnoValue
			};

			replyService.add(reply, function(result){
				alert(result);
				modal.find("input").val("");  
				modal.modal("hide"); 
				//showList(1);
				showList(-1);  //추가
			});
		});

		/* 댓글 등록 End */
		
		/* -- 댓글 목록  -------------------------- */
		replyService.getList({bno:bnoValue, page:1}, function(list){
			for (var i = 0, len = list.length||0; i < len; i++) {
				console.log(list[i]);
			}
		});
		/* -- 댓글 목록  End ----- */

		
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list")
			operForm.submit();
		});


		//댓글 수정
		modalModBtn.on("click", function(e)	{
			
			var originalReplyer = modalInputReplyer.val();
			
			var reply = {
					rno: modal.data("rno"), 
					reply: modalInputReply.val(),
					replyer: originalReplyer					
			};
			
			if (!replyer) {
				alert("로그인 후 수정이 가능합니다.");
				$("#myModal").modal("hide");
				return;
			}
			
			console.log("Original Replyer: " + originalReplyer);  //댓글의 원래 작성자
			
			if (replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 수정이 가능합니다.");
				$("#myModal").modal("hide");
				return;
			}
			
			replyService.update(reply, function(result) {
				alert(result);
				$("#myModal").modal("hide");
				showList(pageNum);
			});
		});
		

		//댓글 삭제
		modalRemoveBtn.on("click", function(e) {
			
			var rno = modal.data("rno");
			
			console.log("RNO: " + rno);
			console.log("REPLYER: " + replyer);
			
			if (!replyer) {
				alert("로그인 후 삭제가 가능합니다.");
				$("#myModal").modal("hide");
				return;
			}
			
			var originalReplyer = modalInputReplyer.val();
			console.log("Original Replyer: " + originalReplyer);  //댓글의 원래 작성자
			
			if (replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 삭제가 가능합니다.");
				$("#myModal").modal("hide");
				return;
			}
			
			replyService.remove(rno, originalReplyer, function(result) {
				alert(result);
				$("#myModal").modal("hide");
				showList(pageNum);
			});
		});

		

	});
</script>

<script> 
	$(document).ready(function() {
		
		// 익명함수 정의함과 동시에 호출
		(function(){
			var bno = "${board.bno}";
			$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
				console.log(arr);
			});
		})();


		});


</script>