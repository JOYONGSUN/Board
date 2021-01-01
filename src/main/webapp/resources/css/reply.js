console.log("Reply Module......");


var replyService = (function(){
	/*등록처리*/
	function add(reply, callback, error){
		console.log("add reply.......");
		
		$.ajax({
			type: 'post',
			url: '/replies/new',
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}

	
	/*날짜형식 출력함수*/
	function displayTime(timeValue) {

		var today = new Date();

		var gap = today.getTime() - timeValue;

		var dateObj = new Date(timeValue);
		var str = "";

		if (gap < (1000 * 60 * 60 * 24)) {

			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');

		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;  // getMonth() is zero-based
			var dd = dateObj.getDate();

			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
		}
	};
	
    /*조회처리*/
	function get(rno, callback, error) {

		$.get("/replies/" + rno + ".json", function(result) {

			if (callback) {
				callback(result);
			}

		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}
	
	/*목록처리*/
	function getList(param, callback, error) {
		var bno = param.bno;  //글 번호
		var page = param.page || 1;  //페이지 번호
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
			function(data) {
				if (callback) {
					callback(data.replyCnt, data.list);  //추가 (댓글수와 목록을 가져옴)
				}
			}).fail(function(xhr, status, err) {
				if (error) {
					error();
				}
			});
	}
	
	
	function update(reply, callback, error) {

		console.log("RNO: " + reply.rno);

		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	

	
	function remove(rno, replyer, callback, error) {  //수정
		$.ajax({
			type: 'delete',
			url: '/replies/' + rno,

			//추가
			data: JSON.stringify({rno:rno, replyer:replyer}),
			contentType: "application/json; charset=utf-8",
			
			success: function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	
	
	return {
		add : add,
		getList : getList,
		displayTime : displayTime,
		get : get,
		update : update,
		remove : remove
	};

	
})();
