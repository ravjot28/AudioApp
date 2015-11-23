function restore() {
	$("#record, #live").removeClass("disabled");
	$(".one").addClass("disabled");
	Fr.voice.stop();
}
$(document)
		.ready(
				function() {
					$(document).on(
							"click",
							"#record:not(.disabled)",
							function() {
								recording_option_start = this.name;
								elem = $(this);
								Fr.voice.record($("#live").is(":checked"),
										function() {
											elem.addClass("disabled");
											$("#live").addClass("disabled");
											$(".one").removeClass("disabled");
										});
							});

					$(document).on("click", "#stop:not(.disabled)", function() {
						recording_option_stop = this.name;
						if (recording_option_stop == recording_option_start) {
							recording_option = recording_option_stop;
							Fr.voice.export(function(url) {
								if (recording_option == "bag") {
									bag = url;
								} else if (recording_option == "cot") {
									cot = url;
								} else if (recording_option == "gang") {
									gang = url;
								} else if (recording_option == "past") {
									past = url;
								} else if (recording_option == "spa") {
									spa = url;
								} else if (recording_option == "band") {
									band = url;
								} else if (recording_option == "deck") {
									deck = url;
								} else if (recording_option == "house") {
									house = url;
								} else if (recording_option == "pasta") {
									pasta = url;
								} else if (recording_option == "test") {
									test = url;
								} else if (recording_option == "boat") {
									boat = url;
								} else if (recording_option == "duck") {
									duck = url;
								} else if (recording_option == "how") {
									how = url;
								} else if (recording_option == "pool") {
									pool = url;
								} else if (recording_option == "tie") {
									tie = url;
								} else if (recording_option == "boot") {
									boot = url;
								} else if (recording_option == "face") {
									face = url;
								} else if (recording_option == "kiss") {
									kiss = url;
								} else if (recording_option == "seat") {
									seat = url;
								} else if (recording_option == "tight") {
									tight = url;
								} else if (recording_option == "caught") {
									caught = url;
								} else if (recording_option == "far") {
									far = url;
								} else if (recording_option == "pack") {
									pack = url;
								} else if (recording_option == "sharp") {
									sharp = url;
								} else if (recording_option == "too") {
									too = url;
								}
								console.log("Here is the base64 URL : " + url);
							}, "base64");
							restore();
						}
					});

					$(document).on("click", "#play:not(.disabled)", function() {
						Fr.voice.export(function(url) {
							$("#audio").attr("src", url);
							$("#audio")[0].play();
						}, "URL");
						restore();
					});

					$(document)
							.on(
									"click",
									"#download:not(.disabled)",
									function() {
										Fr.voice
												.export(
														function(url) {
															$("<a href='"
																	+ url
																	+ "' download='MyRecording.wav'></a>")[0]
																	.click();
														}, "URL");
										restore();
									});

					$(document).on(
							"click",
							"#base64:not(.disabled)",
							function() {
								Fr.voice.export(function(url) {
									console.log("Here is the base64 URL : "
											+ url);
									alert("Check the web console for the URL");

									$("<a href='" + url
											+ "' target='_blank'></a>")[0]
											.click();
								}, "base64");
								restore();
							});

					$(document)
							.on(
									"click",
									"#mp3:not(.disabled)",
									function() {
										alert("The conversion to MP3 will take some time (even 10 minutes), so please wait....");
										Fr.voice
												.export(
														function(url) {
															console
																	.log("Here is the MP3 URL : "
																			+ url);
															alert("Check the web console for the URL");

															$("<a href='"
																	+ url
																	+ "' target='_blank'></a>")[0]
																	.click();
														}, "mp3");
										restore();
									});
				});
