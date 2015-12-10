package com.rav.audtioapp.action;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.rav.audtioapp.dto.AudioRequestApprovalDTO;
import com.rav.audtioapp.service.AudioRequestApprovalService;

public class AudioRequestApprovalAction {
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
		AudioRequestApprovalDTO dto = getDTO(array.get(0));
		System.out.println(dto.getId() + " " + dto.getStatus());

		jsonString = AudioRequestApprovalService.getInstance().processRequest(dto);//"Got " + dto.getId() + " " + dto.getStatus();
		return "success";
	}

	private AudioRequestApprovalDTO getDTO(String data) {
		AudioRequestApprovalDTO dto = new AudioRequestApprovalDTO();

		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(data);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		dto.setId(getValue(obj, "id"));
		dto.setStatus(getValue(obj, "status"));

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
