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
	var microm = null;
	var mp3 = null;

	var bag;
	var cot;
	var gang;
	var past;
	var spa;
	var band;
	var deck;
	var house;
	var pasta;
	var test;
	var boat;
	var duck;
	var how;
	var pool;
	var tie;
	var boot;
	var face;
	var kiss;
	var seat;
	var tight;
	var caught;
	var far;
	var pack;
	var sharp;
	var too;
	var recording_option_start;
	var recording_option_stop;

	$(document).ready(function() {
		google.maps.event.addDomListener(window, "load", initAutocomplete);
		/* microm = new Microm(); */
		$("body").show();
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

				$('#age').val('Select your birth year');
				$('#gender').val('Select your gender');
				$('#fluency').val(
						'If not, how would you rate your fluency in English?');
				$('#canadaage').val(
						'If no, at what age did you move to Canada?');

				$('#mothertounge').val('');
				$('#yearsspent').val('');
				$('#emailAddress').val('');

				$("#langyes").prop('checked', false);
				$("#langno").prop('checked', false);
				$("#citizenYes").prop('checked', false);
				$("#citizenNo").prop('checked', false);
				$("#location").val('');

				/*var age = $('#age').find(":selected").text();
				var gender = $('#gender').find(":selected").text();
				var langyes = $("#langyes").is(":checked");
				var langno = $("#langno").is(":checked");
				var mothertounge = $('#mothertounge').val();
				var fluency = $('#fluency').find(":selected").text();
				var citizenYes = $("#citizenYes").is(":checked");
				var citizenNo = $("#citizenNo").is(":checked");
				var canadaage = $('#canadaage').find(":selected").text();
				var yearsspent = $('#yearsspent').val();
				var emailAddress = $('#emailAddress').val();

				if (age == 'Select your birth year'
						|| gender == 'Select your gender'
						|| ((!langyes && !langno) && (langno && mothertounge.length == 0) )
						|| fluency == 'If not, how would you rate your fluency in English?'
						|| ((!citizenYes && !citizenNo) && (canadaage == 'If no, at what age did you move to Canada?'))
						|| emailAddress.length == 0 || yearsspent.length == 0) {
					return false;
				}*/

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
					<div id="agreement" class="wizard-step">
						<p>Thank you for your interest in being a part of our voice
							map. Before we get started recording your audio, please read the
							following information and answer the question related to consent.
							Once you click "Next", you will proceed to a brief questionnaire
							about you and then to the recording portion.</p>
						<p>
							<strong>Canadian Voices Map</strong> is an interactive digital
							map with structured audio samples from around the country. The
							goal of the project is to explore dialect diversity in Canadian
							English. Users can listen to samples, download audio files and
							contribute their own voices.
						</p>
						<p>On the following screens, you will be asked to answer some
							background questions about yourself and then to record yourself
							reading twenty different English words. The process should take
							less than ten minutes. There are no known risks to participation
							in the study; participation is voluntary, and you may decline to
							answer any questions you choose.</p>
						<p>The audio files you submit will be available through the
							website to any user, and these files will be linked to your
							background information. We are not collecting names and your data
							will therefore be anonymous and your confidentiality protected.
							However, given that your voice could be recognized by others, you
							should be aware that it may be possible for some users to
							identify your data. If your audio samples are displayed on the
							map and you later change your mind about your participation,
							please contact us and we will remove the data.</p>
						<p>
							Any questions about study participation may be directed to the
							Strathy Language Unit at strathy@queenus.ca. Any ethical concerns
							about the study may be directed to the Chair of the General
							Research Ethics Board at <a href="mailto:chair.GREB@queensu.ca">chair.GREB@queensu.ca</a>
							or 613-533-6081. This study has been granted clearance according
							to the recommended principles of Canadian ethics guidelines, and
							Queen's policies.
						</p>
						<p>By clicking "Next" below, you acknowledge the following:</p>
						<p>1. You have read and understand the above Letter of
							Information.</p>
						<p>2. You understand that the audio files and background
							information you submit will be available on a public website.</p>
					</div>
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



						<!-- <audio controls src="" id="audio"></audio> -->
						<div style="margin: 10px;">
							<p>Bag</p>
							<button name="bag" id="record">Start Recording</button>
							<button name="bag" id="stop">Stop</button>

						</div>

						<div style="margin: 10px;">
							<p>Cot</p>
							<button name="cot" id="record">Start Recording</button>
							<button name="cot" id="stop">Stop</button>
						</div>
						<div style="margin: 10px;">
							<p>Gang</p>
							<button name="gang" id="record">Start Recording</button>
							<button name="gang" id="stop">Stop</button>
						</div>

						<div style="margin: 10px;">
							<p>Past</p>
							<button name="past" id="record">Start Recording</button>
							<button name="past" id="stop">Stop</button>
						</div>
						<div style="margin: 10px;">
							<p>Spa</p>
							<button name="spa" id="record">Start Recording</button>
							<button name="spa" id="stop">Stop</button>
						</div>

						<div style="margin: 10px;">
							<p>Band</p>
							<button name="band" id="record">Start Recording</button>
							<button name="band" id="stop">Stop</button>
						</div>
						<div style="margin: 10px;">
							<p>Deck</p>
							<button name="deck" id="record">Start Recording</button>
							<button name="deck" id="stop">Stop</button>

						</div>

						<div style="margin: 10px;">
							<p>House</p>
							<button name="house" id="record">Start Recording</button>
							<button name="house" id="stop">Stop</button>
						</div>
						<div style="margin: 10px;">
							<p>Pasta</p>
							<button name="pasta" id="record">Start Recording</button>
							<button name="pasta" id="stop">Stop</button>

						</div>

						<div style="margin: 10px;">
							<p>Test</p>
							<button name="test" id="record">Start Recording</button>
							<button name="test" id="stop">Stop</button>
						</div>


						<div style="margin: 10px;">
							<p>Boat</p>
							<button name="boat" id="record">Start Recording</button>
							<button name="boat" id="stop">Stop</button>
						</div>
						<div style="margin: 10px;">
							<p>Duck</p>
							<button name="duck" id="record">Start Recording</button>
							<button name="duck" id="stop">Stop</button>

						</div>

						<div style="margin: 10px;">
							<p>How</p>
							<button name="how" id="record">Start Recording</button>
							<button name="how" id="stop">Stop</button>
						</div>
						<div style="margin: 10px;">
							<p>Pool</p>
							<button name="pool" id="record">Start Recording</button>
							<button name="pool" id="stop">Stop</button>

						</div>

						<div style="margin: 10px;">
							<p>Tie</p>
							<button name="tie" id="record">Start Recording</button>
							<button name="tie" id="stop">Stop</button>
						</div>
						<div style="margin: 10px;">
							<p>Boot</p>
							<button name="boot" id="record">Start Recording</button>
							<button name="boot" id="stop">Stop</button>

						</div>

						<div style="margin: 10px;">
							<p>Face</p>
							<button name="face" id="record">Start Recording</button>
							<button name="face" id="stop">Stop</button>
						</div>
						<div style="margin: 10px;">
							<p>Kiss</p>
							<button name="kiss" id="record">Start Recording</button>
							<button name="kiss" id="stop">Stop</button>

						</div>

						<div style="margin: 10px;">
							<p>Seat</p>
							<button name="seat" id="record">Start Recording</button>
							<button name="seat" id="stop">Stop</button>
						</div>
						<div style="margin: 10px;">
							<p>Tight</p>
							<button name="tight" id="record">Start Recording</button>
							<button name="tight" id="stop">Stop</button>

						</div>

						<div style="margin: 10px;">
							<p>Caught</p>
							<button name="caught" id="record">Start Recording</button>
							<button name="caught" id="stop">Stop</button>
						</div>
						<div style="margin: 10px;">
							<p>Far</p>
							<button name="far" id="record">Start Recording</button>
							<button name="far" id="stop">Stop</button>

						</div>

						<div style="margin: 10px;">
							<p>Pack</p>
							<button name="pack" id="record">Start Recording</button>
							<button name="pack" id="stop">Stop</button>
						</div>
						<div style="margin: 10px;">
							<p>Sharp</p>
							<button name="sharp" id="record">Start Recording</button>
							<button name="sharp" id="stop">Stop</button>

						</div>

						<div style="margin: 10px;">
							<p>Too</p>
							<button name="too" id="record">Start Recording</button>
							<button name="too" id="stop">Stop</button>
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