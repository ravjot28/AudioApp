package com.rav.audtioapp.service;

import com.rav.audtioapp.dao.SaveAudioDAO;
import com.rav.audtioapp.dto.SaveAudioDTO;

public class SaveAudioService {
	private static SaveAudioService obj;

	private SaveAudioService() {

	}

	public static SaveAudioService getInstance() {
		synchronized (SaveAudioService.class) {
			if (obj == null) {
				obj = new SaveAudioService();
			}
			return obj;
		}
	}

	public synchronized String processRequest(SaveAudioDTO dto) {
		SaveAudioDAO dao = new SaveAudioDAO();
		int id = dao.insertNewAudio(dto);
		return "STRATHY-" + id;
	}

}
