<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Audio App</title>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js"></script>


<script type="text/javascript">
$(document).ready(function() {
	var mapCenter = new google.maps.LatLng(47.6145, -122.3418); //Google map Coordinates
	var map;
	map_initialize(); // load map
	function map_initialize(){
	    //Google map option
	    var googleMapOptions = 
	    { 
	    	center:new google.maps.LatLng(56,-96),
	        //center: mapCenter, // map center
	        zoom: 10, //zoom level, 0 = earth view to higher value
	        panControl: true, //enable pan Control
	        zoomControl: true, //enable zoom control
	        zoomControlOptions: {
	        style: google.maps.ZoomControlStyle.SMALL //zoom control size
	        },
	        scaleControl: true, // enable scale control
	        mapTypeId: google.maps.MapTypeId.ROADMAP // google map type
	    };
	    map = new google.maps.Map(document.getElementById("google_map"), googleMapOptions); 
	    
	    //##### drop a new marker on right click ######
	    google.maps.event.addListener(map, 'rightclick', function(event) {      
	        var marker = new google.maps.Marker({
	            position: event.latLng, //map Coordinates where user right clicked
	            map: map,
	            draggable:true, //set marker draggable 
	            animation: google.maps.Animation.DROP, //bounce animation
	            title:"Hello World!",
	            icon: "https://lit-journey-6254.herokuapp.com/icons/pin.png" //custom pin icon
	        });
	        
	        //Content structure of info Window for the Markers
	        var contentString = $('<div class="marker-info-win">'+
	        '<div class="marker-inner-win"><span class="info-content">'+
	        '<h1 class="marker-heading">New Marker</h1>'+
	        'This is a new marker infoWindow'+ 
	        '</span>'+
	        '<br /><button name="remove-marker" class="remove-marker" title="Remove Marker">Remove Marker</button></div></div>');
	            
	        //Create an infoWindow
	        var infowindow = new google.maps.InfoWindow();
	        
	        //set the content of infoWindow
	        infowindow.setContent(contentString[0]);
	        
	        //add click listner to marker which will open infoWindow         
	        google.maps.event.addListener(marker, 'click', function() {
	                infowindow.open(map,marker); // click on marker opens info window 
	        });
	        

	        //###### remove marker #########/
	        var removeBtn   = contentString.find('button.remove-marker')[0];
	        google.maps.event.addDomListener(removeBtn, "click", function(event) {
	            marker.setMap(null);
	        });
	    });
	}
	});
</script>

<style type="text/css">
#google_map {
	width: 90%;
	height: 500px;
	margin-top: 0px;
	margin-left: auto;
	margin-right: auto;
}

h1.heading {
	text-align: center;
	font: 18px Georgia, "Times New Roman", Times, serif;
}
</style>

</head>
<body>

	<h1 class="heading">Audio App Map</h1>
	<div align="center">Right Click to Drop a New Marker</div>
	<div id="google_map"></div>

</body>
</html>