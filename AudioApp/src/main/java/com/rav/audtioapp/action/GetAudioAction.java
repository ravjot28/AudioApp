package com.rav.audtioapp.action;

import com.rav.audtioapp.service.GetAudioService;

public class GetAudioAction {

	private String jsonString;
	
	
	public String getUnapprovedAudios() {
		System.out.println("In getAudio");
		jsonString = GetAudioService.getInstance().processRequest("Unapproved");
		return "success";
	}
	
	
	public String getApprovedAudios() {
		System.out.println("In getAudio");
		jsonString = GetAudioService.getInstance().processRequest("Approved");
		return "success";
	}

	public String getJsonString() {
		return jsonString;
	}

	public void setJsonString(String jsonString) {
		this.jsonString = jsonString;
	}

}
