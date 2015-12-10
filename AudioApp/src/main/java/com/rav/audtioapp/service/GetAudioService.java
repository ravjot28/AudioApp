package com.rav.audtioapp.service;

import java.util.List;

import com.rav.audtioapp.dao.GetAudioDAO;

public class GetAudioService {
	private static GetAudioService obj;

	private GetAudioService() {

	}

	public static GetAudioService getInstance() {
		synchronized (GetAudioService.class) {
			if (obj == null) {
				obj = new GetAudioService();
			}
			return obj;
		}
	}

	public String processRequest(String audioFilter) {
		String result = "";
		List<String> data = null;
		System.out.println("Get audio request for "+audioFilter);
		if(audioFilter.equals("Unapproved"))
			data = new GetAudioDAO().getUnApprovedAudio();
		
		if(audioFilter.equals("Approved"))
			data = new GetAudioDAO().getApprovedAudio();

		for (String d : data) {
			result += d + "{}";
		}

		return result;
	}

}
