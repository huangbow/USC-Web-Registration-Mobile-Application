package org.usc.webregistration.pojo;

public class ServerResponse {
	int statusCode;
	Object responseObject;
	String message;
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public int getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}
	public Object getResponseObject() {
		return responseObject;
	}
	public void setResponseObject(Object responseObject) {
		this.responseObject = responseObject;
	}
	public ServerResponse(int statusCode, Object responseObject, String message) {
		super();
		this.statusCode = statusCode;
		this.responseObject = responseObject;
		this.message=message;
	}
	public ServerResponse() {
		super();
	}
	
}
