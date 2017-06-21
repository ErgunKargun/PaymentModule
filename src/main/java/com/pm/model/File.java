package com.pm.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 
 * @author Ergun
 *
 */

@Entity
@Table(name = "file")
public class File implements Serializable {

	private static final long serialVersionUID = 1L;

	private String serialId;
	private String date;
	private String adminEmail;
	private String content;

	public File(String date, String adminEmail, String content) {
		super();
		this.date = date;
		this.adminEmail = adminEmail;
		this.content = content;
	}

	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid2")
	public String getSerialId() {
		return serialId;
	}

	public void setSerialId(String serialId) {
		this.serialId = serialId;
	}

	public String getString() {
		return date;
	}

	public void setString(String date) {
		this.date = date;
	}

	public String getAdminEmail() {
		return adminEmail;
	}

	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}

	@Lob
	@Column(length=1000000000)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
