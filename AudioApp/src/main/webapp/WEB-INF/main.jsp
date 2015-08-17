<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Audio App</title>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js"></script>
<script src="js/recorder.js"></script>
<script src="js/Fr.voice.js"></script>
<script src="js/jquery.js"></script>
<script src="js/record.js"></script>

<style>
.button {
	display: inline-block;
	vertical-align: middle;
	margin: 0px 5px;
	padding: 5px 12px;
	cursor: pointer;
	outline: none;
	font-size: 13px;
	text-decoration: none !important;
	text-align: center;
	color: #fff;
	background-color: #4D90FE;
	background-image: linear-gradient(top, #4D90FE, #4787ED);
	background-image: -ms-linear-gradient(top, #4D90FE, #4787ED);
	background-image: -o-linear-gradient(top, #4D90FE, #4787ED);
	background-image: linear-gradient(top, #4D90FE, #4787ED);
	border: 1px solid #4787ED;
	box-shadow: 0 1px 3px #BFBFBF;
}

a.button {
	color: #fff;
}

.button:hover {
	box-shadow: inset 0px 1px 1px #8C8C8C;
}

.button.disabled {
	box-shadow: none;
	opacity: 0.7;
}
</style>
<link rel="stylesheet" href="CSS/footer.css" type="text/css"
	media="screen">

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var mapCenter = new google.maps.LatLng(56, -46); //Google map Coordinates
						var map;

						map_initialize(); // initialize google map

						//############### Google Map Initialize ##############
						function map_initialize() {
							var googleMapOptions = {
								center : mapCenter,
								zoom : 17, //zoom level, 0 = earth view to higher value
								panControl : true, //enable pan Control
								zoomControl : true, //enable zoom control
								zoomControlOptions : {
									style : google.maps.ZoomControlStyle.SMALL
								//zoom control size
								},
								scaleControl : true, // enable scale control
								mapTypeId : google.maps.MapTypeId.ROADMAP
							// google map type
							};

							map = new google.maps.Map(document
									.getElementById("google_map"),
									googleMapOptions);

							//Load Markers from the XML File, Check (map_process.php)
							/* $.get("getmap.action", function (data) {
								alert($(data).find("marker"));
								  $(data).find("marker").each(function () {
							         //Get user input values for the marker from the form
							          var name      = $(this).attr('name');
							          var address   = '<p>'+ $(this).attr('address') +'</p>';
							          var type      = $(this).attr('type');
							          var point     = new google.maps.LatLng(parseFloat($(this).attr('lat')),parseFloat($(this).attr('lng')));

							          //call create_marker() function for xml loaded maker
							          create_marker(point, name, address, false, false, false, "https://lit-journey-6254.herokuapp.com/icons/pin.png");
							    });
							});  */

							//drop a new marker on right click
							google.maps.event
									.addListener(
											map,
											'rightclick',
											function(event) {
												//Edit form to be displayed with new marker
												var EditForm = '<p><div class="marker-edit">'
														+ '<form action="savemap.action" method="POST" name="SaveMarker" id="SaveMarker">'
														+ '<label for="pName"><span>Place Name :</span><input type="text" name="pName" class="save-name" placeholder="Enter Title" maxlength="40" /></label>'
														+ '<label for="pDesc"><span>Description :</span><textarea name="pDesc" class="save-desc" placeholder="Enter Address" maxlength="150"></textarea></label>'
														+ '<label for="pType"><span>Type :</span> <select name="pType" class="save-type"><option value="restaurant">Rastaurant</option><option value="bar">Bar</option>'
														+ '<option value="house">House</option></select></label>'
														+ '</form>'
														+ '</div></p><button name="save-marker" class="save-marker">Save Marker Details</button>';
												var audioForm = '<audio controls src="" id="audio"></audio>'
														+ '<div style="margin: 10px;">'
														+ '<a class="button" id="record">Record</a> <a'
													+ 'class="button disabled one" id="stop">Reset</a> <a'
													+ 'class="button disabled one" id="play">Play</a> <a'
													+ 'class="button disabled one" id="download">Download</a> <a'
													+ 'class="button disabled one" id="base64">Base64 URL</a> <a'
													+ 'class="button disabled one" id="mp3">MP3 URL</a>'
														+ '</div>'
														+ '<input class="button" type="checkbox" id="live" />'
														+ '<label for="live">Live Output</label>';
												//call create_marker() function
												create_marker(event.latLng,
														'Record Sound',
														audioForm, true, true,
														true,
														"https://lit-journey-6254.herokuapp.com/icons/pin.png");
											});
						}

						//############### Save Marker Function ##############
						function save_marker(Marker, mName, mAddress, mType,
								replaceWin) {
							//Save new marker using jQuery Ajax
							var mLatLang = Marker.getPosition().toUrlValue(); //get marker position
							var myData = {
								name : mName,
								address : mAddress,
								latlang : mLatLang,
								type : mType
							}; //post variables
							console.log(replaceWin);
							$
									.ajax({
										type : "POST",
										url : "map.action",
										data : myData,
										success : function(data) {
											replaceWin.html(data); //replace info window with new html
											Marker.setDraggable(false); //set marker to fixed
											Marker
													.setIcon('https://lit-journey-6254.herokuapp.com/icons/pin.png'); //replace icon
										},
										error : function(xhr, ajaxOptions,
												thrownError) {
											alert(thrownError); //throw any errors
										}
									});
						}

						//############### Remove Marker Function ##############
						function remove_marker(Marker) {
							/* determine whether marker is draggable 
							new markers are draggable and saved markers are fixed */
							if (Marker.getDraggable()) {
								Marker.setMap(null); //just remove new marker
							} else {
								//Remove saved marker from DB and map using jQuery Ajax
								var mLatLang = Marker.getPosition()
										.toUrlValue(); //get marker position
								var myData = {
									del : 'true',
									latlang : mLatLang
								}; //post variables
								$.ajax({
									type : "POST",
									url : "map.action",
									data : myData,
									success : function(data) {
										Marker.setMap(null);
										alert(data);
									},
									error : function(xhr, ajaxOptions,
											thrownError) {
										alert(thrownError); //throw any errors
									}
								});
							}
						}

						//############### Create Marker Function ##############
						function create_marker(MapPos, MapTitle, MapDesc,
								InfoOpenDefault, DragAble, Removable, iconPath) {
							//new marker
							var marker = new google.maps.Marker({
								position : MapPos,
								map : map,
								draggable : DragAble,
								animation : google.maps.Animation.DROP,
								title : "Hello World!",
								icon : iconPath
							});

							//Content structure of info Window for the Markers
							var contentString = $('<div class="marker-info-win">'
									+ '<div class="marker-inner-win"><span class="info-content">'
									+ '<h1 class="marker-heading">'
									+ MapTitle
									+ '</h1>'
									+ MapDesc
									+ '</span><button name="remove-marker" class="remove-marker" title="Remove Marker">Remove Marker</button>'
									+ '</div></div>');

							//Create an infoWindow
							var infowindow = new google.maps.InfoWindow();
							//set the content of infoWindow
							infowindow.setContent(contentString[0]);

							//Find remove button in infoWindow
							var removeBtn = contentString
									.find('button.remove-marker')[0];

							//Find save button in infoWindow
							var saveBtn = contentString
									.find('button.save-marker')[0];

							//add click listner to remove marker button
							google.maps.event.addDomListener(removeBtn,
									"click", function(event) {
										//call remove_marker function to remove the marker from the map
										remove_marker(marker);
									});

							if (typeof saveBtn !== 'undefined') //continue only when save button is present
							{
								//add click listner to save marker button
								google.maps.event
										.addDomListener(
												saveBtn,
												"click",
												function(event) {
													var mReplace = contentString
															.find('span.info-content'); //html to be replaced after success
													var mName = contentString
															.find('input.save-name')[0].value; //name input field value
													var mDesc = contentString
															.find('textarea.save-desc')[0].value; //description input field value
													var mType = contentString
															.find('select.save-type')[0].value; //type of marker

													if (mName == ''
															|| mDesc == '') {
														alert("Please enter Name and Description!");
													} else {
														//call save_marker function and save the marker details
														save_marker(marker,
																mName, mDesc,
																mType, mReplace);
													}
												});
							}

							//add click listner to save marker button        
							google.maps.event.addListener(marker, 'click',
									function() {
										infowindow.open(map, marker); // click on marker opens info window 
									});

							if (InfoOpenDefault) //whether info window should be open by default
							{
								infowindow.open(map, marker);
							}
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
	<%@include file="../footer.html"%>
</body>
</html>