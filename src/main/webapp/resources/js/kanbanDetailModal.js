/*
파일명: checkList.js
설명: 칸반 카드 상세페이지 내 구현될 체크리스트 jqery&js
작성일: 2021-01-04 ~ 
작성자: 문지연
*/

$(document).ready(function(){
	
	const details = document.getElementById("detailsModal");

	//get card Title in Modal
	$(document).on("click", ".cardContent", function(e) {
		e.preventDefault();
		$('.modal_card_seq').attr("value",$(this).data().cardSeq);
		$('.cardTitleMo').text($(this).context.innerText);
		details.style.display = "block";
	});

	//close Modal
	$(document).on("click", ".closeModal", function(e) {
		e.preventDefault();
		details.style.display = "none";
	});

	window.onclick = function(e) {
		if (e.target == details) {
			details.style.display = "none";
		}
	}

	//open edit card Title form in Modal
	$(document).on("click", ".cardTitleMo", function(e) {
		e.preventDefault();
		let cardTitleForm = $(this).parent().children("#cardTitleForm");
		$(this).hide();
		cardTitleForm.children("#cardTitleInput").attr("placeholder", $(this).html());
		cardTitleForm.show();
		cardTitleForm.focus();
	});
	
	//edit card Title in Modal
	$(document).on("submit",".cardTitleForm",function(e){
		e.preventDefault();
		let editedCardTitle = $(this).parents().children().children("#cardTitleInput").val();
		let modal_card_seq = $(this).parents().children().children('.modal_card_seq').attr('value');

		let cardOb = new Object();
		cardOb.card_seq = modal_card_seq;
		cardOb.card_name = editedCardTitle;

		let card = JSON.stringify(cardOb);
		if (editedCardTitle.length > 0) {
			$.ajax({
				type: "post",
				url: "editKanbanCardTitle.pie",
				contentType: "application/json; charset=UTF-8",
				dataType: "json",
				async: false,
				data: card,
				success: function(data) {
					console.log(data);
				}
			});
			$('.cardTitleMo').text(editedCardTitle);
			$("[data-card-seq="+modal_card_seq+"]").text(editedCardTitle);
			$('.cardTitleForm').hide();
			$('.cardTitleMo').show();
		}
	});
	
	/*CheckList in Modal*/
	$('#add-todo').click(function() {
		const lastSibling = $('#checkListFrom > .todo-wrap:last-of-type > input').attr('id');
		const newId = Number(lastSibling) + 1;
	
		$(this).before('<span class="editing todo-wrap"><input type="checkbox" id="' +
			newId + '"/><label for="' + newId +
			'" class="todo"><i class="fa fa-check"></i><input type="text" class="input-todo" id="input-todo' +
			newId + '"/></label></div>');
		$('#input-todo' + newId + '').parent().parent().animate({
			height: "40px"
		}, 200)
		$('#input-todo' + newId + '').focus();
	
		$('#input-todo' + newId + '').enterKey(function() {
			$(this).trigger('enterEvent');
		})
	
		$('#input-todo' + newId + '').on('blur enterEvent', function() {
			const todoTitle = $('#input-todo' + newId + '').val();
			const todoTitleLength = todoTitle.length;
			if (todoTitleLength > 0) {
				$(this).before(todoTitle);
				$(this).parent().parent().removeClass('editing');
				$(this).parent().after('<span class="delete-item" title="remove"><i class="fa fa-times-circle"></i></span>');
				$(this).remove();
				$('.delete-item').click(function() {
					var parentItem = $(this).parent();
					parentItem.animate({
						left: "-30%",
						height: 0,
						opacity: 0
					}, 200);
					setTimeout(function() { $(parentItem).remove(); }, 1000);
				});
			}
			else {
				$('.editing').animate({
					height: '0px'
				}, 200);
				setTimeout(function() {
					$('.editing').remove()
				}, 400)
			}
		})
	
	});
	
	/*Remove CheckList in Modal*/
	$('.delete-item').click(function() {
		var parentItem = $(this).parent();
		parentItem.animate({
			left: "-30%",
			height: 0,
			opacity: 0
		}, 200);
		setTimeout(function() { $(parentItem).remove(); }, 1000);
	});
	
	/*Enter Key Event Handler*/
	$.fn.enterKey = function(fnc) {
		return this.each(function() {
			$(this).keypress(function(ev) {
				var keycode = (ev.keyCode ? ev.keyCode : ev.which);
				if (keycode == '13') {
					fnc.call(this, ev);
				}
			})
		})
	}
});