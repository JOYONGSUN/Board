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
   		position: absolute;
   		display: none;
   		justify-content: center;
   		align-items: center;
   		top: 0%;
   		width: 100%;
   		height: 100%;
   		background-color: gray;
   		z-index: 100;
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
          <h1 class="h3 mb-2 text-gray-800">Board Register</h1>

          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h4 class="m-0 font-weight-bold text-primary">Register</h4>
            </div>
            <div class="card-body">
              	<form role="form" action="/board/register" method="post">
              		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
              		<div class="form-group">
              			<label>Title</label>
              			<input class="form-control" name="title">
              		</div>
              		<div class="form-group">
	              		<label>Content</label>
	              		<textarea class="form-control" rows="10" name="content"></textarea>
	              	</div>
	              	
	              	<div class="form-group">
						<label>Writer</label>
						<input class="form-control" name="writer" value='<sec:authentication property="principal.username"/>' readonly="readonly">
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


	           	<button type="submit" class="btn btn-primary btn-sm">등록</button>
	          	<button type="button" class="btn btn-primary btn-sm" onclick="location.href='/board/list'">취소</button>
              	</form>
            </div>
          </div>

        </div>
        <!-- /.container-fluid -->


<%@ include file="../includes/footer.jsp" %>


<script>
	$(document).ready(function(e){

		
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

		
		var formObj = $("form[role='form']");
		$("button[type='submit']").on("click", function(e) {
		    e.preventDefault();
		    console.log("submit clicked");
		    
		    // 추가
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
		});


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

		$(".uploadResult").on("click", "button", function(e){
			
			console.log("delete file");
			
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			
			var targetLi = $(this).closest("li");
			
			$.ajax({
				url: '/deleteFile',
				data: {fileName: targetFile, type: type},
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);  //추가
				},
				dataType: 'text',
				type: 'POST',
				success: function(result){
					alert(result);
					targetLi.remove();
				}
			});
		});	


		

	
	});





	</script>

