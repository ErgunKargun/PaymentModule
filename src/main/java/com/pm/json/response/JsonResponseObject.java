package com.pm.json.response;

public class JsonResponseObject {
	private String status = null;
	private Object result = null;
	
	public JsonResponseObject(String status, Object result) {
		super();
		this.status = status;
		this.result = result;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Object getResult() {
		return result;
	}

	public void setResult(Object result) {
		this.result = result;
	}

	@Override
	public String toString() {
		return "JsonResponseObject [status=" + status + ", result=" + result + "]";
	}

}
