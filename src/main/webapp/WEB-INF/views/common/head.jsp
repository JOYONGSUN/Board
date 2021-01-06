<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<title>PIE</title>

<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">

<!-- Font-Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">

<!-- StyleSheets -->
<link rel="stylesheet" type="text/css" href="/resources/css/commonStyle.css">
<link rel="stylesheet" type="text/css" href="/resources/css/mainTopStyle.css">

<!-- sweetAlert1,2 CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<!-- Jquery CDN -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<!-- ------------------------------------------------------------------ -->
<div id="socketAlert" class="alert alert-success" role="alert" style="display:none;"></div>
<script>
	var socket = null; //전역변수 선언
	$(document).ready(function(){
		connectWS();
		});
	function connectWS(){
		var ws = new WebSocket("ws://localhost:8090/websocket/echo/websocket");
		socket = ws;
		ws.open = function(message){
			console.log(message)
			}
		ws.onmessage = function(event){
			$("#socketAlert").text(event.data);
			$("#socketAlert").css("display","block");
			};
		ws.onclose = function(event){
			console.log("Server Close")
			};
		ws.onerror = function(event){
			console.log("Server Error");
			}
		}
</script>	