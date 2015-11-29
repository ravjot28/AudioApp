package com.rav.audtioapp.action;

import java.util.ArrayList;
import java.util.List;

public class SaveAudio {

	List<String> array = new ArrayList<String>();

	public List<String> getArray() {
		return array;
	}

	public void setArray(List<String> array) {
		this.array = array;
	}

	public String execute() {
		System.out.println(array);

		return "success";
	}
}