package org.usc.webregistration.pojo;

import java.util.HashMap;

public class School {
	private String name;
	private HashMap<String,String> departments;
	public School() {
		super();
	}
	public School(String name) {
		super();
		this.name = name;
		this.departments=new HashMap<String,String>();
	}
	public void addDept(String code, String name){
		this.departments.put(code, name);
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public HashMap<String, String> getDepartments() {
		return departments;
	}
	public void setDepartments(HashMap<String, String> schools) {
		this.departments = schools;
	}
	
	
}
