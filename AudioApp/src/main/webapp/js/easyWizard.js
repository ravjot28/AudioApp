$.fn.wizard = function(config) {
	if (!config) {
		config = {};
	}
	;
	var containerSelector = config.containerSelector || ".wizard-content";
	var stepSelector = config.stepSelector || ".wizard-step";
	var steps = $(this).find(containerSelector + " " + stepSelector);
	var stepCount = steps.size();
	var exitText = config.exit || 'Exit';
	var backText = config.back || 'Back';
	var nextText = config.next || 'Next';
	var finishText = config.finish || 'Submit';
	var isModal = config.isModal || true;
	var validateNext = config.validateNext || function() {
		return true;
	};
	var validateFinish = config.validateFinish || function() {
		return true;
	};

	var validateNext = function() {
		if (step == 1) {
			var age = $('#age').find(":selected").text();
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
					|| (!langyes && !langno)
					|| fluency == 'If not, how would you rate your fluency in English?'
					|| (!citizenYes && !citizenNo)
					|| canadaage == 'If no, at what age did you move to Canada?'
					|| emailAddress.length == 0 || yearsspent.length == 0
					|| mothertounge.length == 0) {
				return false;
			} else {
				var hv = $('#location').val();
				alert("Location Coordinates selected " + hv);
				return true;
			}
		}

	};
	// ////////////////////
	var step = 1;
	var container = $(this).find(containerSelector);
	steps.hide();
	$(steps[0]).show();
	if (isModal) {
		$(this)
				.on(
						'hidden.bs.modal',
						function() {
							step = 1;
							$(
									$(
											containerSelector
													+ " .wizard-steps-panel .step-number")
											.removeClass("done").removeClass(
													"doing")[0]).toggleClass(
									"doing");

							$($(containerSelector + " .wizard-step").hide()[0])
									.show();

							btnBack.hide();
							btnExit.show();
							btnFinish.hide();
							btnNext.show();

						});
	}
	;
	$(this).find(".wizard-steps-panel").remove();
	container.prepend('<div class="wizard-steps-panel steps-quantity-'
			+ stepCount + '"></div>');
	var stepsPanel = $(this).find(".wizard-steps-panel");
	for (s = 1; s <= stepCount; s++) {
		stepsPanel.append('<div class="step-number step-' + s
				+ '"><div class="number">' + s + '</div></div>');
	}
	$(this).find(".wizard-steps-panel .step-" + step).toggleClass("doing");
	// ////////////////////
	var contentForModal = "";
	if (isModal) {
		contentForModal = ' data-dismiss="modal"';
	}
	var btns = "";
	btns += '<button type="button" class="btn btn-default wizard-button-exit"'
			+ contentForModal + '>' + exitText + '</button>';
	btns += '<button type="button" class="btn btn-default wizard-button-back">'
			+ backText + '</button>';
	btns += '<button type="button" class="btn btn-default wizard-button-next">'
			+ nextText + '</button>';
	btns += '<button type="button" class="btn btn-primary wizard-button-finish" '
			+ contentForModal + '>' + finishText + '</button>';
	$(this).find(".wizard-buttons").html("");
	$(this).find(".wizard-buttons").append(btns);
	var btnExit = $(this).find(".wizard-button-exit");
	var btnBack = $(this).find(".wizard-button-back");
	var btnFinish = $(this).find(".wizard-button-finish");
	var btnNext = $(this).find(".wizard-button-next");

	btnNext.on("click", function() {
		alert(step);
		alert('calling validate');
		if (!validateNext(step, steps[step - 1])) {
			alert('validate returned false');
			return;
		}
		;
		$(container).find(".wizard-steps-panel .step-" + step).toggleClass(
				"doing").toggleClass("done");
		step++;
		steps.hide();
		$(steps[step - 1]).show();
		$(container).find(".wizard-steps-panel .step-" + step).toggleClass(
				"doing");
		if (step == stepCount) {
			btnFinish.show();
			btnNext.hide();
		}
		btnExit.hide();
		btnBack.show();
	});

	btnBack.on("click", function() {
		$(container).find(".wizard-steps-panel .step-" + step).toggleClass(
				"doing");
		step--;
		steps.hide();
		$(steps[step - 1]).show();
		$(container).find(".wizard-steps-panel .step-" + step).toggleClass(
				"doing").toggleClass("done");
		if (step == 1) {
			btnBack.hide();
			btnExit.show();
		}
		btnFinish.hide();
		btnNext.show();
	});

	btnFinish.on("click", function() {

		if (!validateFinish(step, steps[step - 1])) {

			$(container).find(".wizard-steps-panel .step-" + 1).toggleClass(
					"doing").toggleClass("done");
			$('#my').modal('show');
		}

		if (!!config.onfinish) {
			alert('config on finish inside');
			config.onfinish();
		}
	});

	btnBack.hide();
	btnFinish.hide();
	return this;
};
