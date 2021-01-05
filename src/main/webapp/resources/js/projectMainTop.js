/*right sidebar contents wrapper*/
window.onload = function(){

}

function collapseSidebar(){
	let sidebar = document.getElementById('sidebar');
	let contents = document.getElementById('right-sidebar-contents-wrapper');
	
	sidebar.style.width = (sidebar.style.width == '0px') ? '62px' : '0px';
	contents.style.display = (contents.style.display == 'none') ? 'block' : 'none';	
}
/*//right sidebar contents wrapper*/