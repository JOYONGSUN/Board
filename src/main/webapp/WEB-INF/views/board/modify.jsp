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
</style>


        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">Board</h1>

          <!-- DataTales Example -->
          
          <!-- form 태그 추가 -->
         <form role="form" action="/board/modify" method="post">
			<input type="hidden" name="pageNum" value="${cri.pageNum}">
			<input type="hidden" name="amount" value="${cri.amount}"> 
			<input type="hidden" name="type" value="${cri.type}">
			<input type="hidden" name="keyword" value="${cri.keyword}">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />

  
	         
	          <div class="card shadow mb-4">
	            <div class="card-header py-3">
	              <h4 class="m-0 font-weight-bold text-primary">Modify</h4>
	            </div>
	            <div class="card-body">
	          		<div class="form-group">
	          			<label>Bno</label>
	          			<input class="form-control" value="${board.bno }" name="bno" readonly>
	          		</div>
	          		<div class="form-group">
	          			<label>Title</label>
	          			<input class="form-control" value="${board.title }" name="title">
	          		</div>
	          		<div class="form-group">
		           		<label>Content</label>
		           		<textarea class="form-control" rows="10" name="content">${board.content }</textarea>
		           	</div>
		           	<div class="form-group">
		           		<label>Writer</label>
		           		<input class="form-control" value="${board.writer }" name="writer" readonly>
		           	</div>
					           	
					           	
				<!-- 첨부파일 --------------------------------->
					<div class="row">
					   <div class="col-lg-12">
					      <div class="card shadow mb-4">
					         <div class="card-header py-3">
					            <h4 class="m-0 font-weight-bold text-primary">File Attach</h4>
					         </div>
					         <div class="card-body">
					            <div class="form-group uploadDiv">
					               <input type="file" name="uploadFile" multiple>
					            </div>
					            <div class="uploadResult">
					               <ul></ul>
					            </div>
					         </div>
					      </div>
					   </div>
					</div>
					<!-- 첨부파일 End -------------->	 

		<sec:authentication property='principal' var="pinfo"/>
			<sec:authorize access="isAuthenticated()">
				<c:if test="${pinfo.username eq board.writer }">
					<button type="submit" data-oper="modify" class="btn btn-primary btn-sm">
						Modify
					</button>
				</c:if>
			</sec:authorize>   	
			
			<sec:authentication property='principal' var="pinfo"/>
			<sec:authorize access="isAuthenticated()">
				<c:if test="${pinfo.username eq board.writer }">
					<button type="submit" data-oper="remove" class="btn btn-primary btn-sm">
						Remove
					</button>
				</c:if>
			</sec:authorize>         	
						
			<button type="submit" data-oper="list" class="btn btn-primary btn-sm">
				List
			</button>	
            	</div>
          	  </div>
         	</form>
        </div>
        <!-- /.container-fluid -->
      </div>
      <!-- End of Main Content -->

<%@ include file="../includes/footer.jsp" %>

<script>
$(document).ready(function() {

	(function(){
		var bno = "${board.bno}";
		$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
			console.log(arr);
			
			var str="";
			
			$(arr).each(function(i,attach) {
				if (attach.fileType) {
					var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
					str += "<li style='cursor:pointer' data-path='"+attach.uploadPath+"'";
					str += " data-uuid='"+attach.uuid+"' data-fileName='"+attach.fileName+"'data-type='"+attach.fileType+"'>";
					str += "<span> " + attach.fileName + " </span>";
					str += " <button type='button' data-file='"+fileCallPath+"' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button>"
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
					str += " <button type='button' data-file='"+fileCallPath+"' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button>"
					str += " <div>";
					str += "<img src='/resources/img/attachment.png'></a>";
					str += "</div>";
					str += "</li>";
				}
			});
			
			$(".uploadResult ul").html(str);
		});
	})();

	
	var formObj = $("form");

	$('button').on("click", function(e){
	   
	   e.preventDefault();  //전송을 막음
	   var operation = $(this).data("oper");
	   console.log(operation);
	   
	   if (operation === 'remove') {
	      formObj.attr("action", "/board/remove");
	   } else if (operation === 'list') {
	      /* move to list */
	      /* location.href = "/board/list"; */
	      
	      formObj.attr("action","/board/list").attr("method","get");
	      
	      var pageNumTag = $("input[name='pageNum']").clone();
	      var amountTag = $("input[name='amount']").clone();
	      var keywordTag = $("input[name='keyword']").clone();
	      var typeTag = $("input[name='type']").clone();
	      
	      formObj.empty();
	      
	      formObj.append(pageNumTag);
	      formObj.append(amountTag);
	      formObj.append(keywordTag);
	      formObj.append(typeTag);

	     // 추가
	   } else if (operation === 'modify') {
	      console.log("submit clicked");
	      
	      var str = "";
	      
	      $(".uploadResult ul li").each(function(i,obj){
	         var jobj = $(obj);
	         console.dir(jobj);
	         
	         str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
	         str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
	         str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
	         str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
	      });
	      formObj.append(str).submit();
	   }

	   formObj.submit();  //폼 전송
	});


	  $(".uploadResult").on("click", "button", function(e){
		   console.log("delete file");
		   if (confirm("Remove this file?")) {
		      var targetLi = $(this).closest("li");
		      targetLi.remove();
		   }
		}); 

	  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");  //정규식
	  var maxSize = 5242880;  //5MB

	  function checkExtension(fileName, fileSize) {
	     if (fileSize >= maxSize) {
	        alert("파일 사이즈 초과");
	        return false;
	     }
	     
	     if (regex.test(fileName)) {
	        alert("해당 종류의 파일은 업로드할 수 없습니다.");
	        return false;
	     }
	     return true;
	  }


	  var csrfHeaderName = "${_csrf.headerName}";
	  var csrfTokenValue = "${_csrf.token}";

	  $("input[type='file']").change(function(e){
	  	var formData = new FormData(); 
	  	var inputFile = $("input[name='uploadFile']");
	  	var files = inputFile[0].files;

	  	for (var i = 0; i < files.length; i++) {
	  		if (!checkExtension(files[i].name, files[i].size)) {
	  			return false;
	  		}
	  		formData.append("uploadFile", files[i]);
	  	}
	  	
	  	
	  	$.ajax({
	  		url: '/uploadAjaxAction',
	  		processData: false,
	  		contentType: false,
	  		beforeSend: function(xhr){
	  			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);  //추가
	  		},
	  		data: formData,
	  		type: 'POST',
	  		dataType: 'json',  
	  		success: function(result){
	  			console.log(result); 
	  			showUploadResult(result); 
	  		}
	  	});
	  });



	  function showUploadResult(uploadResultArr) {
	     
	     if (!uploadResultArr || uploadResultArr.length == 0) {return;}
	     
	     var uploadUL = $(".uploadResult ul");
	     var str="";
	     
	     $(uploadResultArr).each(function(i,obj) {
	        if (obj.image) {
	           var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
	           str += "<li data-path='"+obj.uploadPath+"'";
	           str += " data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'data-type='"+obj.image+"'";
	           str += " ><div>";
	           str += "<span> " + obj.fileName + " </span>";
	           str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
	           str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
	           str += "<img src='/display?fileName=" + fileCallPath + "'>";
	           str += "</div>";
	           str += "</li>";
	        } else {
	           var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
	           var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
	           str += "<li data-path='"+obj.uploadPath+"'";
	           str += " data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'data-type='"+obj.image+"'";
	           str += " ><div>";
	           str += "<span> " + obj.fileName + " </span>";
	           str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
	           str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
	           str += "<img src='/resources/img/attachment.png'></a>";
	           str += "</div>";
	           str += "</li>";
	        }
	     });
	     
	     uploadUL.append(str);
	  }
	  

});
</script>