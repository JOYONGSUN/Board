<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <script src="https://www.gstatic.com/firebasejs/7.2/firebase.js"></script>
    </head>
    <body>
        파이어베이스 실시간으로 웹페이지 연동하기 </br>
        Firebase + Realtime + Web 
        <p id="demo">A Paragraph.</p>
        <pre id="object"></pre>
        <button type="button" onclick="myFunction()">데이터 쓰기</button>
        <script>
            //파이어베이스에 등록한 앱에 CDN클릭 후 해당정보 가져와서 삽입
            var firebaseConfig = {
                apiKey: "",
                authDomain: "fir-pie-572bb.firebaseapp.com",
                databaseURL: "https://fir-pie-572bb-default-rtdb.firebaseio.com/",
                projectId: "fir-pie-572bb",
                storageBucket: "fir-pie-572bb.appspot.com",
                messagingSenderId: "989496843824",
                appId: "1:989496843824:web:fe585c787d49c41dfe57f5",
                measurementId: "G-M4C2JG0HQ6"
            };
            // Initialize Firebase
            firebase.initializeApp(firebaseConfig);
            firebase.analytics();
            
            // firebase에서 읽기
            var demo = document.getElementById("demo");
            var preObject = document.getElementById("object");
            var dbRef = firebase.database().ref().child("Demo");
            //dbRef.on('value',snap => demo.innerHTML = snap.val());
            
            let chatRef = firebase.database().ref().child("chat");
 
			let Ob2 = new Object();
			Ob2.tr = "tr";
			Ob2.ttr = "ttrr";
			
			
			let Ob = new Object();
			Ob.test = "test";
			Ob.test2 = "test2";
			Ob.test3 = Ob2;
			
        </script>
        <script>
            function myFunction() {
                document.getElementById("demo").innerHTML = "쓰기를 완료";
                alert("쓰기 완료");
                
                firebase.database().ref('chat').update({
                    testtestㅅㄷㄴ123123:"asdasdas12123123123233123123daaaaaaaaaaaaaaa"                
                });
                firebase.database().ref('test').update({
                    test: "tesㅁㄴㅇㅁㄴㅇㅁㄴ",
                    testtestㅅㄷㄴ: 11,
                    testtestㅅㄷㄴ: 11                      
                });
               let a = JSON.stringify(chatRef);
                console.log(a);

                
                dbRef.on('value',snap => {
    				console.log(snap.val());
                });
            }
        </script>
    </body>
</html>