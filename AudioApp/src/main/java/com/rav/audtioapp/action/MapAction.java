package com.rav.audtioapp.action;

public class MapAction {
	private String name;
	private String address;
	private String latlang;
	private String type;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLatlang() {
		return latlang;
	}

	public void setLatlang(String latlang) {
		this.latlang = latlang;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String execute() {
		System.out.println("Input parameters are :" + name + " " + " " + address + " " + latlang + " " + type);
		return "success";
	}

}
