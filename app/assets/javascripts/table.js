
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
		
		if (obj.style.backgroundColor == "" || obj.style.backgroundColor == "rgb(171, 171, 171)"){
			obj.style.backgroundColor = "rgb(83, 181, 106)";
		}
		else{
			obj.style.backgroundColor = "rgb(171, 171, 171)";
		}
}



$(function() {

	var mouseDown = 0;
	var clicking = false;
	var matching_id = -1;

	$('#receiver_table td.time').on("mousedown",function(){
      $(change_color(this));
      mouseDown = 1;
    });

    $('#sender_table td.time').on("mousedown",function(){
       $('td.time').each(function() {
       		if (this.style.backgroundColor == "yellow"){
       			this.style.backgroundColor = "rgb(83, 181, 106)";
       		}
		});

      if (this.style.backgroundColor == "rgb(83, 181, 106)"){
      	mouseDown = 1;
      	console.log(this.id.split("_")[1]);
      	matching_id = this.id.split("_")[1];
      	this.style.backgroundColor = "yellow";	
      }
    });

    $('#sender_table td.time').on("mouseover", function(){
		if (mouseDown == 1 && this.style.backgroundColor == "rgb(83, 181, 106)"){
			var id = this.id.split("_")[1];
			if(matching_id == id ){
				this.style.backgroundColor = "yellow";	
			}
			else{
				matching_id = -1;
			}
		}
		if(this.style.backgroundColor == ""){
			matching_id = -1;
		}
	});


    
    $('td.time').on("mouseup",function(){
    	mouseDown = 0;
    	clicking = false;
    	matching_id = -1;
		// var cells = document.getElementsByClassName("time");
		// for (var c in cells){
		// 	cells[c].className = "time";
		// }
    });

    $('#receiver_table td.time').on("mouseover", function(){
		if (mouseDown == 1){
			change_color(this);
		}
	});

	$('input.request').on('click',function(){
		var options = []
		$('td.time').each(function() {
			if (this.style.backgroundColor == "rgb(83, 181, 106)"){
				var id = this.id
				var day = id.split("_")[1]
				var option = []
				option.push([$('tr')[0].childNodes[2*(day-1)].id, this.id.split("_")[0], "|"]);
				options.push(option);
			}
		});
		$('<input type="hidden" name="times" value="' + options + '">').appendTo('div.times');
	});	

	$(document).ready(function(){

		if($('table.times').length > 0){

			var id = $('form')[1].action.split("/").pop();
			$.ajax({
			    url: "/loadtimes",
		        dataType:'json',
		        data: {'request_id': id},
		 		type: 'GET',
			    success: function(data){
					var keys = Object.keys(data);
					var d = new Date();
					var day = d.getDate();
					var month = d.getMonth();
					var year = d.getFullYear();
					var date = new Date(year,month,day);
					$.each(keys, function(key, value) {
						split = value.split("/");
						var n_day = split[1];
						var n_month = split[0] - 1;
						var n_year = split[2];
						var n_date = new Date(n_year,n_month,n_day);
						var change = (n_date - date)/(24*60*60*1000);

						$.each(data[value], function(key, v) {
							var o = v + "_" + (change+1);
							var obj = document.getElementById(o);
							obj.style.backgroundColor = "rgb(83, 181, 106)";
						});
			        });
			    },
			    error: function(){
			        alert('error');
			    }
			});
			return false;
		}
	});

	$('input.btn').on('click',function(){
		var times = [];
		var date_id;
		$('td.time').each(function() {
			if (this.style.backgroundColor == "yellow"){
				date_id = this.id.split("_")[1];
				times.push(this.innerHTML);
			}
		});
		var date = $('tr')[0].childNodes[2*(date_id-1)].id;
		var length = times.length;
		$('<input type="hidden" name="start_time" value="' + times[0] + '">').appendTo('div.hidden_fields');
		$('<input type="hidden" name="end_time" value="' + times[length-1] + '">').appendTo('div.hidden_fields');
		$('<input type="hidden" name="date" value="' + date + '">').appendTo('div.hidden_fields');
	});

});	