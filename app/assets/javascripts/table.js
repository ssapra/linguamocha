
function select_all() {
    var cells = document.getElementsByClassName("time");
	for (var c in cells){
		cells[c].style.backgroundColor = "rgb(83, 181, 106)";
	}
};

function deselect_all() {
    var cells = document.getElementsByClassName("time");
	for (var c in cells){
		cells[c].style.backgroundColor = "rgb(171, 171, 171)";
	}
};

function change_color(e)
{
	var obj = document.getElementById(e.id);
	// if (obj. != "modified"){
		
		if (obj.style.backgroundColor == "" || obj.style.backgroundColor == "rgb(171, 171, 171)"){
			obj.style.backgroundColor = "rgb(83, 181, 106)";
		}
		else{
			obj.style.backgroundColor = "rgb(171, 171, 171)";
		}
	// }
}



$(function() {

	var mouseDown = 0;
	var clicking = false;

	$('td.time').on("mousedown",function(){
      $(change_color(this));
      mouseDown = 1;
    });
    
    $('td.time').on("mouseup",function(){
    	mouseDown = 0;
    	clicking = false;
		var cells = document.getElementsByClassName("time");
		for (var c in cells){
			cells[c].className = "time";
		}
    });

    $('td.time').on("mouseover", function(){
		if (mouseDown == 1){
			change_color(this);
		}
	});

	$('.check').on('click',function(){
		var options = []
		$('td.time').each(function() {
			if (this.style.backgroundColor == "rgb(83, 181, 106)"){
				var id = this.id
				var day = id.split("_")[1]
				var option = [$('tr')[0].childNodes[2*(day-1)].innerHTML, this.innerHTML];
				options.push(option);
			}
		});
		alert(options);
	});	
});