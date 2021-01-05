	//google 로그아웃 함수
	function onLoad() {
		gapi.load('auth2', function() {
			gapi.auth2.init();
		});
	}

	//auth2 초기화 
	onLoad();

	//로그아웃 실행 
	function signOut() {
		let auth2 = gapi.auth2.getAuthInstance();
		auth2.signOut().then(function() {
			location.href = "logout.pie";
		});
	}