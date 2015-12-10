package com.rav.audtioapp.action;

import com.rav.audtioapp.service.GetAudioService;

public class GetAudioAction {

	private String jsonString;

	public String execute() {
		// System.out.println(array);
		System.out.println("In getAudio");
		jsonString = GetAudioService.getInstance().processRequest();
		return "success";
	}

	public String getJsonString() {
		return jsonString;
	}

	public void setJsonString(String jsonString) {
		this.jsonString = jsonString;
	}

}
