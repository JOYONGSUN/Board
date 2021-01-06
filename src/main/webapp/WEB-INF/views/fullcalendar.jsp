<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FullCalendar</title>
<!-- calendar를 위한 lib -->
<link rel="stylesheet" href="/resources/css/calendar.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/redmond/jquery-ui.css">
<link href='resources/fullcalendar/packages/core/main.css' rel='stylesheet' />
<link href='resources/fullcalendar/packages/daygrid/main.css' rel='stylesheet' />
<link href='resources/fullcalendar/packages/timegrid/main.css' rel='stylesheet' />
<link href='resources/fullcalendar/packages/list/main.css' rel='stylesheet' />
<script src='resources/fullcalendar/packages/core/main.js'></script>
<script src='resources/fullcalendar/packages/core/locales/ko.js'></script>
<script src='resources/fullcalendar/packages/interaction/main.js'></script>
<script src='resources/fullcalendar/packages/daygrid/main.js'></script>
<script src='resources/fullcalendar/packages/timegrid/main.js'></script>
<script src='resources/fullcalendar/packages/list/main.js'></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!--  -->
<script type="text/javascript">
var id;
var title;
var start;
var end;
var allDay;
var color;
var content;
var events=[];
 function editCalendar(info){
	id = info.event.id;
	start = info.event.start;
	end = info.event.end;
	if (info.event.allDay == true) {
		if(info.event.start !== info.event.end)
		endDate = moment(info.event.end).subtract(1, 'days')._d;
      }
	var msg;
	$.ajax({
		type:'POST',
		data:{
			id:id,
			start:start,
			end:end
			},
			datetype:'json',
			async:false,
			url:"calendarEdit.pie",
			success: function(data){				
				}
		})
	 }
	function deleteCalendar(info){			
		   	$.ajax({  
				type : "POST",
				url  : "calendarDelete.pie",
				data : {
						id:info.event.id
					},
				success : function(data){					
				}   
		});	
		}
	var eventsFeed = function(info, successCallback, failureCallback){
		$.ajax({  
			type : "GET",
			url  : "calendarList.pie",
			dataType:'json',
			success : function(data){				
			var fixedDate = data.map(function(array){
				 if (array.allDay === true && array.start !== array.end) {
			            array.end = moment(array.end).add(1, 'days'); // 이틀 이상 AllDay 일정인 경우 달력에 표기시 하루를 더해야 정상출력
				          }
		        array.end = moment(array.end).format('YYYY-MM-DD'+" "+'HH:mm')
		          return array;
				})
			successCallback(fixedDate);
			
			}
		 });		
}
		function editButton(){
			$('#titleView').attr("readonly",true);
			 $('#startDateView').attr("readonly",true);
			 $('#endDateView').attr("readonly",true);
			 $('#contentView').attr("readonly",true);
			 $('#allDayView').attr("disabled",true);
			 $('#eventColorView').attr("disabled",true);
			 $('#editCalendar').css("display","");
			 $('#okeditCalendar').css("display","none");
			 $('#okeditCalendarDiv').css("display","none");
			 $('#deleteCalendar').css("display","");
			/*  $("#startDateView, #endDateView").flatpickr({clickOpens:false});	 */
		     	$('#endDateView').val("")
               	$('#titleView').val("")
               	$('#contentView').val("")
			}
		function insertButton(){
           	$('#endDate').val("")
           	$('#title').val("")
           	$('#content').val("")
           	$('#eventColor').val("#D25565")	
			}
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'list','ui' ],
      themeSystem: 'jquery-ui',
      header: {
        left: 'prev,today,next',
        center: 'title',
        right: 'dayGridMonth,listMonth'

      },
      buttonText:{
		today: '오늘',
		month: '월',
		week: '주',
		day: '일',
		list: '주간 일정표'
          },
      selectable: true, //클릭 및 드래그 선택 기능
      selectMirror: true, //???
      navLinks: true, // can click day/week names to navigate views
      businessHours: true, // display business hours
      editable: true,
      eventLimit:true,
      forceEventDuration:true,
      minTime : '00:00:00',
      maxTime : '24:00:00',
      timeFormat : 'HH:mm',
      dayMaxEvents: true,
      locales:'ko',
 	 dateClick: function(info) {
        let today = new Date();
        let hours = today.getHours();
        let minutes =today.getMinutes();
        document.getElementById('calendarInsert_modal_contents').style.display='block'
       	document.getElementById('calendar_modal_background').style.display = 'block';
          $('#startDate').val(info.dateStr +" "+ hours+":"+ "00")
          $("#insertCancel").unbind('click');
          $('#insertCancel').click(function(){
        	  insertButton()			
        	  document.getElementById('calendar_modal_background').style.display = 'none';
				})
		$("#insertCalendar").unbind('click');		
		$('#insertCalendar').click(function(){
			 document.getElementById('calendar_modal_background').style.display = 'none';
			  if($("input:checkbox[name=allDay]").is(":checked") == true) {
				  allDay=true
				}else{
					allDay=false
					}
		  $.ajax({  
					type : "POST",
					url  : "calendarInsert.pie",
					data:{
						start:$('#startDate').val(),
						end:$('#endDate').val(),
						title:$('#title').val(),
						content:$('#content').val(),
						allDay:allDay,
						color:$('#eventColor').val()
						},
					success : function(data){	
						calendar.refetchEvents();
						insertButton()		
					}
			  })
						
			})		
        },
        eventDrop: function(info){
        	 swal({
       		  title: "일정을 변경하시겠습니까?",
       		  icon: "warning",
       		  buttons: true,
       		  dangerMode: true,
       		})
       		.then((willDelete) => {
       		  if (willDelete) {
       			var msg = editCalendar(info);
       		  } else {
       			  info.revert();
       		  }
       		});
            },
         eventResize:function(info){
        	 swal({
        		  title: "일정을 변경하시겠습니까?",
        		  icon: "warning",
        		  buttons: true,
        		  dangerMode: true,
        		})
        		.then((willDelete) => {
        		  if (willDelete) {
        			var msg = editCalendar(info);
        		  } else {
        			  info.revert();
        		  }
        		});

             },
             eventSources:[{
        events:eventsFeed
             }],
    eventClick: function(info){    		
				document.getElementById('calendarEdit_modal_contents').style.display='block'
				document.getElementById('calendar_modal_background').style.display = 'block';
					start = info.event.start;
					end = info.event.end;
					title = info.event.title;
					content = info.event.extendedProps.content;
					if(info.event.allDay === true){
						$("#allDayView").prop("checked", true)
						}else{
							$("#allDayView").prop("checked", false)
							}			
					$('#eventColorView').val(info.event.borderColor)
					if (info.event.allDay === true) {
						if(info.event.start !== info.event.end)
						end = moment(info.event.end).subtract(1, 'days')._d;
				      }
				$('#startDateView').val(moment(start).format('YYYY-MM-DD'+" "+'HH:mm'));
				$('#endDateView').val(moment(end).format('YYYY-MM-DD'+" "+'HH:mm'));
				$('#titleView').val(title);
				$('#contentView').val(content);
				$("#deleteCalendar").unbind('click');
				$('#deleteCalendar').click(function(){
					 swal({
				  		  title: "일정을 삭제하시겠습니까?",
				  		  icon: "warning",
				  		  buttons: true,
				  		  dangerMode: true,
				  		})
				  		.then((willDelete) => {
				  		  if (willDelete) {
				  			deleteCalendar(info)
				  		var event=calendar.getEventById(info.event.id);
				  			event.remove();
				  		  } else {
		
				  		  }
				  		});				
				})
				$("#editCalendar").unbind('click');
				$('#editCalendar').click(function(){
					console.log(info.event.id)
					swal("수정이 가능합니다");
					 $('#seqView').val(info.event.id)
					 $('#titleView').removeAttr("readonly");
					 $('#startDateView').removeAttr("readonly");
					 $('#endDateView').removeAttr("readonly");
					 $('#contentView').removeAttr("readonly");
					 $('#allDayView').removeAttr("disabled");
					 $('#eventColorView').removeAttr("disabled");
					 $('#editCalendar').css("display","none");
					 $('#okeditCalendarDiv').css("display","");
					 $('#okeditCalendar').css("display","");
					 $('#deleteCalendar').css("display","none");
					/*  $("#startDateView, #endDateView").flatpickr({enableTime: true,time_24hr: true, dateFormat: "Y-m-d H:i"},'disableMobile',false); */				
					})
					 $('#editCancel').click(function(){
						 document.getElementById('calendar_modal_background').style.display = 'none';
						 
						 editButton()
				})
				$("#okeditCalendar").unbind('click');	
				$('#okeditCalendar').click(function(){
					document.getElementById('calendar_modal_background').style.display = 'none';
					if($("input:checkbox[name=allDayView]").is(":checked") == true) {
						  allDay=true
						}else{
							allDay=false
							}
					console.log($('#seqView').val())
					  $.ajax({  
							type : "POST",
							url  : "calendarUpdate.pie",
							data:{
								id:$('#seqView').val(),
								start:$('#startDateView').val(),
								end:$('#endDateView').val(),
								title:$('#titleView').val(),
								content:$('#contentView').val(),
								allDay:allDay,
								color:$('#eventColorView').val()
								},
							success : function(data){
								console.log(data)
			                   	calendar.refetchEvents();
			                   	editButton()
			       
							}
					  })
					})
					 			
    }
    });

   calendar.render();
  });

$(document).ready(function(){
	/* $("#startDate, #endDate").flatpickr({enableTime: true,time_24hr: true, dateFormat: "Y-m-d H:i"}); */	
window.onclick = function(event) {
	if(event.target == document.getElementById('calendar_modal_background')) {
		editButton();
		insertButton();
		document.getElementById('calendar_modal_background').style.display = 'none';
		document.getElementById('calendarEdit_modal_contents').style.display= 'none';
		document.getElementById('calendarInsert_modal_contents').style.display = 'none';
	}
}    
});
</script>
<style>
/* 	body{
		font-size: initial;
		line-height: initial;
	} */
  #calendar {
    max-width: 900px;
    margin: 0 auto;
    margin-top: 1%;
	background-color: rgba( 255, 255, 255, 0.8 );	 
   	border-radius: 5px;
   	box-shadow: 0px 0px 20px rgba( 255, 255, 255, 0.8 );
  }
  .fc-right {
  	position: relative;
  	top: -2px;
  }
   .fc-today{
   background:rgba( 255, 255, 255, 0.5 )! important;
}
.fc-unthemed .fc-today {
  background:rgba( 255, 255, 255, 0.5 )! important;
}
.fc-unthemed td.fc-today {
  background:rgba( 255, 255, 255, 0.5 )! important;
}
</style>
</head>
<body>

<div id="calendar"> </div>
<div id="calendar_modal_background"></div>
 <!-- The Modal -->
 <div id="calendarInsert_modal_contents" class="calendar-contents-wrapper">
		<!-- userEdit title -->
		<div class="calendar-title">
			일정 등록
		</div>
		<!-- userEdit password -->
		<div class="calendar-outer-wrapper">
				<!-- 비밀번호 입력 -->
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						allDay
						<input class="" type="checkbox" id="allDay" name="allDay"/>
					</div>					
				</div>
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						일정명
					</div>
					<input type="text" class="calendar-input" id="title" name="title">
				</div>
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						시작일
					</div>
					<input type="text" class="calendar-input" id="startDate" name="start">
				</div>
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						종료일
					</div>
					<input type="text" class="calendar-input" id="endDate" name="end">
				</div>
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						내용
					</div>
					<input type="text" class="calendar-input" id="content" name="content">
				</div>
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						색상
					</div>
					<select class="calendar-input" name="color" id="eventColor">
             	<option value="#D25565" style="color:#D25565;" >빨간색</option>
	             <option value="#9775fa" style="color:#9775fa;" >보라색</option>
	             <option value="#ffa94d" style="color:#ffa94d;" >주황색</option>
	             <option value="#74c0fc" style="color:#74c0fc;" >파란색</option>
	             <option value="#f06595" style="color:#f06595;" >핑크색</option>
	             <option value="#63e6be" style="color:#63e6be;" >연두색</option>
	             <option value="#a9e34b" style="color:#a9e34b;" >초록색</option>
	             <option value="#4d638c" style="color:#4d638c;" >남색</option>
	             <option value="#495057" style="color:#495057;" >검정색</option>
            	</select>
				</div>
				
				  
		</div>
		
		<!-- x버튼 -->
		<div class="calendar-main-withdrawal-wrapper">
			<span id='insertCancel' class="calendar-main-withdrawal-btn"onclick="document.getElementById('calendarInsert_modal_contents').style.display='none'">&times;</span>
		</div>
		
		<!-- calendarEdit btn -->
		<div class="calendar-btn-wrapper">
			<button class="calendar-btn" id="insertCalendar" 
			onclick="document.getElementById('calendarInsert_modal_contents').style.display='none'" >등록</button>
		</div>
	</div>

<div id="calendarEdit_modal_contents" class="calendar-contents-wrapper">
		<!-- userEdit title -->
		<div class="calendar-title">
			일정 수정
		</div>
		<!-- userEdit password -->
		<div class="calendar-outer-wrapper">
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						allDay
						<input class="" type="checkbox" id="allDayView" name="allDayView" disabled />
					</div>					
				</div>
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						일정명
					</div>
					<input type="text" class="calendar-input" id="titleView" name="title" readonly/>
				</div>
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						시작일
					</div>
					<input type="text" class="calendar-input" id="startDateView" name="start" readonly/>
				</div>
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						종료일
					</div>
					<input type="text" class="calendar-input" id="endDateView" name="end" readonly/>
				</div>
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						내용
					</div>
					<input type="text" class="calendar-input" id="contentView" name="content" readonly/>
				</div>
				<div class="calendar-inner-wrapper">
					<div class="calendar-letter">
						색상
					</div>
					<select class="calendar-input" name="color" id="eventColorView" disabled >
             			 <option value="#D25565" style="color:#D25565;" >빨간색</option>
			             <option value="#9775fa" style="color:#9775fa;" >보라색</option>
			             <option value="#ffa94d" style="color:#ffa94d;" >주황색</option>
			             <option value="#74c0fc" style="color:#74c0fc;" >파란색</option>
			             <option value="#f06595" style="color:#f06595;" >핑크색</option>
			             <option value="#63e6be" style="color:#63e6be;" >연두색</option>
			             <option value="#a9e34b" style="color:#a9e34b;" >초록색</option>
			             <option value="#4d638c" style="color:#4d638c;" >남색</option>
			             <option value="#495057" style="color:#495057;" >검정색</option>
		            </select>
				</div>
				<input type="text" name="id" id="seqView" hidden/>
		</div>
		
		<!-- x버튼 -->
		<div class="calendar-main-withdrawal-wrapper">
<!-- 			<button id="editCancel" class="calendar-main-withdrawal-btn"
			onclick="document.getElementById('calendarEdit_modal_contents').style.display='none'">X</button> -->
			<span id='editCancel' class="calendar-main-withdrawal-btn"onclick="document.getElementById('calendarEdit_modal_contents').style.display='none'">&times;</span>
		</div>
		
		<!-- calendarEdit btn -->
		<div class="calendar-btn-wrapper">
			<button class="calendar-btn" id="editCalendar">수정</button>
		</div>
		<div class="calendar-btn-wrapper" id="okeditCalendarDiv"style="display:none;">
			<button class="calendar-btn" id="okeditCalendar"
			onclick="document.getElementById('calendarEdit_modal_contents').style.display='none'" style="display:none;">완료</button>
		</div>
	</div>
<!-- ------------------------------------------------------------ -->
<input id="btnSend" value="Send" type="button">
<input type="text" id="msg" value="테스트" class="form.control">
<script>
	$(document).ready(function(){
		$("#btnSend").on("click",function(evt){
			evt.preventDefault();
			if(socket.readyState != 1) return;
			let msg =$("#msg").val();
			socket.send(msg) //소켓에 입력된 메시지를 보낸다
		})
		})
</script>	
</body>
</html>