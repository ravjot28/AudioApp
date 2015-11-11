<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="/struts-jquery-tags" prefix="sj"%>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">

<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

<link rel="stylesheet" href="CSS/easyWizard.css">
<script src="js/easyWizard.js"></script>

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="CSS/style.css" type="text/css"
	media="screen">
<link rel="stylesheet" href="/CSS/footer.css" type="text/css"
	media="screen">
<script src="js/recorder.js"></script>
<script src="js/Fr.voice.js"></script>
<script src="js/record.js"></script>

<script type="text/javascript">
	var clicked = "false";
	var map;
	var event;
	$(document).ready(function() {
		$("#my").wizard();

		$('.dropdown-menu').find('form').click(function(e) {
			e.stopPropagation();
		});

		$('#myModal').on('show', function() {
			var link = $(this).data('link'), agreeBtn = $(this).find('.agree');
		});

		$('#btnYes').click(function() {
			accept = "true";
			$('#myModal').modal("hide");

		});

		/* 		var btnFinish = $(this).find(".wizard-button-finish");
		 */
		$('#my').on('hidden.bs.modal', function() {
			clicked = "false";
		});

		/* btnFinish.on("click", function() {
			var hv = $('#location').val();
			alert("Location Coordinates selected " + hv);
		}); */

	});

	function initAutocomplete() {
		map = new google.maps.Map(document.getElementById('map'), {
			center : {
				lat : 45.4,
				lng : -75.7
			},
			zoom : 10,
			mapTypeId : google.maps.MapTypeId.ROADMAP,
			streetViewControl : false
		});

		google.maps.event.addListener(map, 'click', function(event1) {
			if (clicked == "false") {
				event = event1;
				$("#location").val(event.latLng);
				$('#my').modal('show');
				clicked = "true";
			}
			//document.getElementById("location").innerHTML = event1.latLng;
			/* var audioForm = '<audio controls src="" id="audio"></audio>'
					+ '<div style="margin: 10px;">'
					+ '<a class="button" id="record">Start Recording</a>'
					+ '<a class="button disabled one" id="stop">Reset</a>'
					+ '<a class="button disabled one" id="play">Play</a> '
					+ '<a class="button disabled one" id="base64">Submit</a>'
					+ '</div>';

			create_marker(event.latLng, 'Record Sound',
					audioForm, true, true, true,
					"https://lit-journey-6254.herokuapp.com/icons/pin.png"); */

		});

		var input = document.getElementById('pac-input');
		var searchBox = new google.maps.places.SearchBox(input);
		map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

		map.addListener('bounds_changed', function() {
			searchBox.setBounds(map.getBounds());
		});

		searchBox.addListener('places_changed', function() {
			var places = searchBox.getPlaces();

			if (places.length == 0) {
				return;
			}

			var bounds = new google.maps.LatLngBounds();
			places.forEach(function(place) {
				if (place.geometry.viewport) {
					bounds.union(place.geometry.viewport);
				} else {
					bounds.extend(place.geometry.location);
				}
			});
			map.fitBounds(bounds);
		});
	}

	//############### Save Marker Function ##############
	function save_marker(Marker, mName, mAddress, mType, replaceWin) {
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
					error : function(xhr, ajaxOptions, thrownError) {
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
			var mLatLang = Marker.getPosition().toUrlValue(); //get marker position
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
				error : function(xhr, ajaxOptions, thrownError) {
					alert(thrownError); //throw any errors
				}
			});
		}
	}

	function create_marker(MapPos, MapTitle, MapDesc, InfoOpenDefault,
			DragAble, Removable, iconPath) {
		//new marker
		var marker = new google.maps.Marker({
			position : MapPos,
			map : map,
			draggable : DragAble,
			animation : google.maps.Animation.DROP,
			title : "Hello World!",
			icon : iconPath
		});

		var contentString = $('<div class="marker-info-win">'
				+ '<div class="marker-inner-win"><span class="info-content">'
				+ '<h1 class="marker-heading">' + MapTitle + '</h1>' + MapDesc
				+ '</span>' + '</div></div>');

		var infowindow = new google.maps.InfoWindow();
		infowindow.setContent(contentString[0]);

		google.maps.event.addListener(marker, 'click', function() {
			infowindow.open(map, marker);
		});

		if (InfoOpenDefault) {
			infowindow.open(map, marker);
		}
	}
</script>

<script
	src="https://maps.googleapis.com/maps/api/js?libraries=places&callback=initAutocomplete"
	async defer></script>

<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

#map {
	width: 100%;
	height: 80%;
	margin-top: 0px;
	margin-left: auto;
	margin-right: auto;
}

.controls {
	margin-top: 10px;
	border: 1px solid transparent;
	border-radius: 2px 0 0 2px;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	height: 32px;
	outline: none;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}

#pac-input {
	background-color: #fff;
	font-family: Roboto;
	font-size: 15px;
	font-weight: 300;
	margin-left: 12px;
	padding: 0 11px 0 13px;
	text-overflow: ellipsis;
	width: 300px;
}

#pac-input:focus {
	border-color: #4d90fe;
}

.pac-container {
	font-family: Roboto;
}

#type-selector {
	color: #fff;
	background-color: #4d90fe;
	padding: 5px 11px 0px 11px;
}

#type-selector label {
	font-family: Roboto;
	font-size: 13px;
	font-weight: 300;
}
</style>

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
<title>Strathy Language</title>
<style>
#target {
	width: 345px;
}
</style>
</head>
<body>

	<div class="modal fade" id="my" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Add Audio</h4>
				</div>
				<div class="modal-body wizard-content">
					<div id="location" class="wizard-step">
						<input type="hidden" id="location" name="location" />
						<p>
							<select class="form-control" id="age">
								<option selected="selected">Select your birth year</option>
								<option>before 1915</option>
								<script>
									for (i = 1916; i < 1998; i++) {
										document.write('<option>' + i
												+ '</option>');
									}
								</script>
								<option>After 1997</option>
							</select>
						</p>

						<p>
							<select class="form-control" id="gender">
								<option selected="selected">Select your gender</option>
								<option>Male</option>
								<option>Female</option>
								<option>Other</option>
								<option>Prefer not to disclose</option>
							</select>
						</p>


						<p>Do you consider English your mother tongue (the language
							you learned first as a child and still use/understand)?</p>
						<label class="radio-inline"> <input id="langyes"
							type="radio" name="optradio">Yes
						</label> <label class="radio-inline"> <input id="langno"
							type="radio" name="optradio">No
						</label>


						<p>
							<label for="comment">If not, what is your mother tongue?
							</label> <input type="text" class="form-control" id="mothertounge">
						</p>

						<p>
							<select class="form-control" id="fluency">
								<option selected="selected">How would you rate your
									fluency in English?</option>
								<option>native speaker</option>
								<option>highly fluent</option>
								<option>intermediate level of fluency</option>
								<option>beginner</option>
							</select>
						</p>

						<p>Were you born in Canada?</p>
						<label class="radio-inline"> <input type="radio"
							name="citizenYes">Yes
						</label> <label class="radio-inline"> <input type="radio"
							name="citizenNo">No
						</label>

						<p>
							<select class="form-control" id="canadaage">
								<option selected="selected">If no, at what age did you
									move to Canada?</option>
								<option>I have never lived in Canada</option>
								<option>before age 5</option>
								<option>between 5 and 12</option>
								<option>between 13 and 20</option>
								<option>age 21 or older</option>
							</select>
						</p>

						<p>
							<label for="comment">List the town and province where you
								spent the majority of your years age 5-18. </label> <input type="text"
								class="form-control" id="yearsspent">
						</p>

						<p>
							<label for="comment">Is there an email address where we
								can contact you about your participation if necessary? </label> <input
								type="text" class="form-control" id="emailAddress">
						</p>

					</div>
					<div class="wizard-step">
						<audio controls src="" id="audio"></audio>
						<div style="margin: 10px;">
							<a class="button" id="record">Start Recording</a> <a
								class="button disabled one" id="stop">Reset</a> <a
								class="button disabled one" id="play">Play</a> <a
								class="button disabled one" id="base64">Submit</a>
						</div>

						<div style="margin: 10px;">
							<a class="button" id="record">Start Recording</a> <a
								class="button disabled one" id="stop">Reset</a> <a
								class="button disabled one" id="play">Play</a> <a
								class="button disabled one" id="base64">Submit</a>
						</div>

						<div style="margin: 10px;">
							<a class="button" id="record">Start Recording</a> <a
								class="button disabled one" id="stop">Reset</a> <a
								class="button disabled one" id="play">Play</a> <a
								class="button disabled one" id="base64">Submit</a>
						</div>
					</div>
					<div class="wizard-step">Do you want to submit the details?</div>
				</div>
				<div class="modal-footer wizard-buttons">
					<!-- The wizard button will be inserted here. -->
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Modal Header</h4>
				</div>
				<div class="modal-body">
					<p>Sed ut perspiciatis unde omnis iste natus error sit
						voluptatem accusantium doloremque laudantium, totam rem aperiam,
						eaque ipsa quae ab illo inventore veritatis et quasi architecto
						beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia
						voluptas sit aspernatur aut odit aut fugit, sed quia cor magni
						dolores eos qui ratione voluptatem sequi nesciunt. Neque porro
						quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur,
						adipisci velit,</p>
					<p>Do you want to agree?</p>
				</div>
				<div class="modal-footer">
					<button href="#" id="btnYes" class="btn agree">Yes</button>
					<button href="#" data-dismiss="modal" aria-hidden="true"
						class="btn secondary">No</button>
				</div>
			</div>

		</div>
	</div>

	<!-- <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-header">
			<a href="#" data-dismiss="modal" aria-hidden="true" class="close">×</a>
			<h3>Agree</h3>
		</div>
		<div class="modal-body">
			<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem
				accusantium doloremque laudantium, totam rem aperiam, eaque ipsa
				quae ab illo inventore veritatis et quasi architecto beatae vitae
				dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit
				aspernatur aut odit aut fugit, sed quia cor magni dolores eos qui
				ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui
				dolorem ipsum quia dolor sit amet, consectetur, adipisci velit,</p>
			<p>Do you want to agree?</p>
		</div>
		<div class="modal-footer">
			<a href="#" id="btnYes" class="btn agree">Yes</a> <a href="#"
				data-dismiss="modal" aria-hidden="true" class="btn secondary">No</a>
		</div>
	</div> -->

	<s:if
		test="hasFieldErrors() || hasActionMessages() || hasActionErrors()">

		<div style="visibility: hidden">
			<sj:dialog id="ErrorDialog" title=" " modal="true" width="500"
				resizable="false"
				buttons="{
        'Ok':function() {
        $(this).dialog('close');
        }
        }">
				<h6>
					<s:actionerror />
					<s:fielderror />
					<s:actionmessage />
				</h6>
			</sj:dialog>
		</div>

	</s:if>

	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<nav class="navbar navbar-default" role="navigation"> <!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="welcome.jsp">Strathy Language</a>
				</div>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#" data-toggle="modal"
							data-target="#login-modal">Sign Up</a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">Sign in <b class="caret"></b></a>
							<ul class="dropdown-menu"
								style="padding: 15px; min-width: 250px;">
								<li>
									<div class="row">
										<div class="col-md-12">
											<form class="form" role="form" method="post"
												action="login.action" accept-charset="UTF-8" id="login-nav">
												<div class="form-group">
													<label class="sr-only" for="exampleInputEmail2">User
														Name</label> <input type="text" id="userName" name="userName"
														class="form-control" id="exampleInputEmail2"
														placeholder="User Name" required>
												</div>
												<div class="form-group">
													<label class="sr-only" for="exampleInputPassword2">Password</label>
													<input type="password" class="form-control" id="password"
														name="password" placeholder="Password" required>
												</div>
												<div class="form-group">
													<button type="submit" class="btn btn-success btn-block">Sign
														in</button>
												</div>
											</form>
										</div>
									</div>
								</li>
							</ul></li>
					</ul>
				</div>
				<!-- /.navbar-collapse --> </nav>
			</div>
		</div>
	</div>


	<div class="modal fade" id="login-modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog">
			<div class="loginmodal-container">
				<h1>Sign Up</h1>
				<br>
				<s:form action="register" method="post">
					<input type="text" id="emailAddress" name="emailAddress"
						placeholder="Email Address">
					<input type="text" id="userName" name="userName"
						placeholder="User Name">
					<input type="password" id="password" name="password"
						placeholder="Password">
					<input type="password" id="repassword" name="repassword"
						placeholder="Re enter the Password">
					<input type="submit" name="login" class="login loginmodal-submit"
						value="Sign Up">
				</s:form>
			</div>
		</div>
	</div>
	<div align="center">Right Click to Drop a New Marker</div>

	<input id="pac-input" class="controls" type="text"
		placeholder="Search Box">
	<div id="map"></div>
	<%@include file="/footer.html"%>
</body>
</html>