package com.pm.model;

import org.springframework.web.multipart.MultipartFile;

public class FileBucket {
	
	private MultipartFile multipartFile;		
	
	public FileBucket() {
		super();
	}

	public FileBucket(MultipartFile multipartFile) {
		super();
		this.multipartFile = multipartFile;
	}

	public MultipartFile getMultipartFile() {
		return multipartFile;
	}

	public void setMultipartFile(MultipartFile multipartFile) {
		this.multipartFile = multipartFile;
	}
}
