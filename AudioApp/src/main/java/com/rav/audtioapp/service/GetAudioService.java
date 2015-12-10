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

	public String processRequest() {
		String result = "";
		List<String> data = new GetAudioDAO().getAllAudio();

		for (String d : data) {
			result += d + "{}";
		}

		return result;
	}

}
