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
       
  	$.ajax({
        url: "/allskills",
        dataType:'json',
 		type: 'GET',
	    success: function(data){
			$(".skill").autocomplete({
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
	
	$("input#request_date").datepicker();
	$('input#request_start_time').timepicker({ 'step': 15 });
	$('input#request_end_time').timepicker({ 'step': 15 });
  	
});




