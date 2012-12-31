// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-custom	
//= require jquery_nested_form
//= require timepicker

$(function() {
    
	$(document).on("focus",".skill", function() {
		$.ajax({
		    url: "/allskills",
	        dataType:'json',
	 		type: 'GET',
		    success: function(data){
				$(".skill").autocomplete({
					minLength: 2,
					source: function( request, response ) {
					    	var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( request.term ), "i" );
			            	response( $.grep( data, function( item ){
			                	return matcher.test( item );
			            	}) );
			        	}	
			    });
		    },
		    error: function(){
		        alert('error');
		    }
		});
	});
	
	$(document).on("focus",".interest", function() {
		$.ajax({
		    url: "/allskills",
	        dataType:'json',
	 		type: 'GET',
		    success: function(data){
				$(".interest").autocomplete({
					minLength: 2,
					source: function( request, response ) {
					    	var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( request.term ), "i" );
			            	response( $.grep( data, function( item ){
			                	return matcher.test( item );
			            	}) );
			        	}	
			    });
		    },
		    error: function(){
		        alert('error');
		    }
		});
	});
	
	$("a.find").on("click", function() {
		var loc = [];
		var values = [];
		$.ajax({
		    url: "/nearby",
	        dataType:'json',
			data: {'current_location': $("input#find").val()},
	 		type: 'GET',
		    success: function(data){
				$.each(data, function(key, value) {
					loc.push(value.address);
					values.push(value.name);
	        	});
	
				$('div.locations').html('');
				$.each(loc,function(i,o){
					$('<input type="radio" name=location value="' + o + '">' + values[i] +": " + '<br />').appendTo('div.locations');
					$('<p>' + o + '</p><br />').appendTo('div.locations');
				});
		    },
		    error: function(){
		        alert('error');
		    }
		});
		
		$.ajax({
		    url: "/mycoordinates",
	        dataType:'json',
			data: {'current_location': $("input#find").val()},
	 		type: 'GET',
		    success: function(data){
				var latitude = data.latitude;
				var longitude = data.longitude;
				var mapOptions = {
				    zoom: 8,
				    center: new google.maps.LatLng(latitude, longitude),
				    mapTypeId: google.maps.MapTypeId.ROADMAP
				}
				var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
						// alert(document.getElementById("map_canvas"));
						
				var myLatlng = new google.maps.LatLng(latitude,longitude);
				
				var marker = new google.maps.Marker({
				    position: myLatlng
				});
				
				var label = new Label({
				    map: map
			    });

				marker.setMap(map);
				
				label.set('zIndex', 1234);
	            label.bindTo('position', marker, 'position');
	            label.set('text', "A");
		    },
		    error: function(){
		        alert('error');
		    }
		});
		
			
	});
	
	
	$("input#request_date").datepicker();
	$('input#request_start_time').timepicker({ 'step': 15 });
	$('input#request_end_time').timepicker({ 'step': 15 });
  	
	// function initialize(){
	// 		var mapOptions = {
	// 		    zoom: 8,
	// 		    center: new google.maps.LatLng(latitude, longitude),
	// 		    mapTypeId: google.maps.MapTypeId.ROADMAP
	// 		}
	// 		var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
	// 	}
	
	function loadScript(){
		var script = document.createElement("script");
		script.type = "text/javascript";
	    script.src = "http://maps.googleapis.com/maps/api/js?key=AIzaSyDFXdzd98ckgjQL-ix-2GedGRVvGl9ef-U&sensor=true";
		document.body.appendChild(script);
	}
	
	// window.onload = loadScript;

});




