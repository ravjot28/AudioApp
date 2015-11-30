package com.rav.audtioapp.action;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.rav.audtioapp.dto.SaveAudioDTO;
import com.rav.audtioapp.service.SaveAudioService;

public class SaveAudio {
	private String jsonString;
	List<String> array = new ArrayList<String>();

	public List<String> getArray() {
		return array;
	}

	public void setArray(List<String> array) {
		this.array = array;
	}

	public String execute() {
		// System.out.println(array);
		String id = SaveAudioService.getInstance().processRequest(getDTO(array.get(0)));
		jsonString = "[\"id\":" + id + "]";
		jsonString = id;
		return "success";
	}

	private SaveAudioDTO getDTO(String data) {
		SaveAudioDTO dto = new SaveAudioDTO();

		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(data);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		dto.setAtWhatAge(getValue(obj, "atWhatAge"));
		dto.setBag(getValue(obj, "bag"));
		dto.setBand(getValue(obj, "band"));
		dto.setBirthYear(getValue(obj, "birthYear"));
		dto.setBoat(getValue(obj, "boat"));
		dto.setBoot(getValue(obj, "boot"));
		dto.setBornInCanada(getValue(obj, "bornInCanada"));
		dto.setCaught(getValue(obj, "caught"));
		dto.setCot(getValue(obj, "cot"));
		dto.setDeck(getValue(obj, "deck"));
		dto.setDuck(getValue(obj, "duck"));
		dto.setEmailAddress(getValue(obj, "emailAddress"));
		dto.setFace(getValue(obj, "face"));
		dto.setFar(getValue(obj, "far"));
		dto.setGang(getValue(obj, "gang"));
		dto.setGender(getValue(obj, "gender"));
		dto.setHouse(getValue(obj, "house"));
		dto.setHow(getValue(obj, "how"));
		dto.setKiss(getValue(obj, "kiss"));
		dto.setLocation(getValue(obj, "location"));
		dto.setMotherTounge(getValue(obj, "motherToungeData"));
		dto.setPack(getValue(obj, "pack"));
		dto.setPast(getValue(obj, "past"));
		dto.setPasta(getValue(obj, "pasta"));
		dto.setPool(getValue(obj, "pool"));
		dto.setRateFluency(getValue(obj, "rateFluency"));
		dto.setSeat(getValue(obj, "seat"));
		dto.setSharp(getValue(obj, "sharp"));
		dto.setSpa(getValue(obj, "spa"));
		dto.setTest(getValue(obj, "test"));
		dto.setTie(getValue(obj, "tie"));
		dto.setTight(getValue(obj, "tight"));
		dto.setToo(getValue(obj, "too"));
		dto.setTown(getValue(obj, "town"));

		return dto;
	}

	private String getValue(JSONObject obj, String key) {
		String value = null;
		try {
			value = (String) obj.get(key);
		} catch (Exception e) {

		}
		return value;
	}

	public String getJsonString() {
		return jsonString;
	}

	public void setJsonString(String jsonString) {
		this.jsonString = jsonString;
	}

}