<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<div id="far fa-folder-open" class="right-sidebar-file">
		<!-- drag and drop image -->
		<div class="file-top-wrapper">
			<div class="file-top-icon-wrapper">
				<i class="fas fa-folder-plus file-top-icon"></i>
				<div class="file-top-icon-letter">
					Drag and Drop
				</div>			
			</div>
		</div>
		
		<!-- file search -->
		<div class="file-search-wrapper">
			<div class="file-search-item-wrapper">
				<div class="file-search-item-letter">기간별 검색</div>
				<form action="#">
					<select name="#" id="#" class="custom-file-select">
						<option value="#">전체</option>
						<option value="#">1일</option>
						<option value="#">1주일</option>
						<option value="#">1달</option>
						<option value="#">1년</option>
					</select>
				</form>
			</div>
			<div class="file-search-item-wrapper">
				<div class="file-search-item-letter">파일명 검색</div>
				<form action="#">
					<select name="#" id="#" class="custom-file-select">
						<option value="#">전체</option>
						<option value="#">?</option>
						<option value="#">??</option>
						<option value="#">???</option>
					</select>
				</form>
			</div>
			<div class="file-search-item-wrapper">
				<div class="file-search-item-letter">확장자명 검색</div>
				<form action="#">
					<select name="#" id="#" class="custom-file-select">
						<option value="#">전체</option>
						<option value="#">xlsx</option>
						<option value="#">pdf</option>
						<option value="#">ppt</option>
					</select>
				</form>
			</div>
		</div>

		
		<!-- file list -->
		<div class="file-list-wrapper">
			<div class="file-list-img">
				<img src="/resources/img/icon/excel.png">
			</div>
			<div class="file-list-letter-wrapper">
				<div class="file-list-letter-title">정산서.xlsx</div>
				<div class="file-list-letter-contents">
					<span>도재구</span>&nbsp;&nbsp;|&nbsp;&nbsp;
					<span>500kb</span>&nbsp;&nbsp;|&nbsp;&nbsp;
					<span>2021.1.1</span>
				</div>
			</div>
			<div class="file-list-cancel">
				<i class="fas fa-times"></i>
			</div>
		</div>
		
		<div class="file-list-wrapper">
			<div class="file-list-img">
				<img src="/resources/img/icon/ppt.png">
			</div>
			<div class="file-list-letter-wrapper">
				<div class="file-list-letter-title">프로젝트 보고서.ppt</div>
				<div class="file-list-letter-contents">
					<span>변재홍</span>&nbsp;&nbsp;|&nbsp;&nbsp;
					<span>500kb</span>&nbsp;&nbsp;|&nbsp;&nbsp;
					<span>2021.1.1</span>
				</div>
			</div>
			<div class="file-list-cancel">
				<i class="fas fa-times"></i>
			</div>
		</div>
		
		<div class="file-list-wrapper">
			<div class="file-list-img">
				<img src="/resources/img/icon/pdf.png">
			</div>
			<div class="file-list-letter-wrapper">
				<div class="file-list-letter-title">최종피티.pdf</div>
				<div class="file-list-letter-contents">
					<span>신동연</span>&nbsp;&nbsp;|&nbsp;&nbsp;
					<span>500kb</span>&nbsp;&nbsp;|&nbsp;&nbsp;
					<span>2021.1.1</span>
				</div>
			</div>
			<div class="file-list-cancel">
				<i class="fas fa-times"></i>
			</div>
		</div>
	</div>
</body>
</html>