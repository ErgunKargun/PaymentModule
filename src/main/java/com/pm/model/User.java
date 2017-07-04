package com.pm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * 
 * @author Ergun
 *
 */

@Entity
@Table(name = "user", uniqueConstraints = {@UniqueConstraint(columnNames = {"stripe","email"})})
public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	private String tc;
	private String name;
	private String surname;
	private String email;
	private String countryCode = "90";
	private String phoneNumber;
	private String adminEmail;
	private String enabled = "1";
	private Date created;
	private Date updated;
	
	private String stripe;

	public User() {

	}

	public User(String tc, String name, String surname, String email, String phoneNumber, String adminEmail) {
		super();
		this.tc = tc;
		this.name = name;
		this.surname = surname;
		this.email = email;
		this.countryCode = "90";
		this.phoneNumber = phoneNumber;
		this.adminEmail = adminEmail;
		this.enabled = "1";
		this.created = new Date();
	}

	@Id
	@Size(min = 11, max = 11)
	@Digits(integer = 11, fraction = 0)
	@NotEmpty
	public String getTc() {
		return tc;
	}

	public void setTc(String tc) {
		this.tc = tc;
	}

	@NotEmpty
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@NotEmpty
	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	@Email
	@NotEmpty
	@Column(unique=true)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@NotEmpty
	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	@Size(min = 10, max = 10)
	@Digits(integer = 10, fraction = 0)
	@NotEmpty
	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	@Email
	@NotEmpty
	public String getAdminEmail() {
		return adminEmail;
	}

	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}

	@NotEmpty
	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	protected void onUpdate() {
		updated = new Date();
	}

	public Date getCreated() {
		return created;
	}
	
	public void setCreated(Date created) {
		this.created = created;
		if (created == null)
			this.created = new Date();
	}

	public Date getUpdated() {
		return updated;
	}

	public void setUpdated(Date updated) {
		this.updated = updated;
		if (updated == null)
			this.updated = new Date();
	}

	@Override
	public String toString() {
		return "User [tc=" + tc + ", name=" + name + ", surname=" + surname + ", email=" + email + ", countryCode="
				+ countryCode + ", phoneNumber=" + phoneNumber + ", adminEmail=" + adminEmail + ", enabled=" + enabled
				+ ", created=" + created + ", updated=" + updated + "]";
	}

	@Column(unique=true)
	public String getStripe() {
		return stripe;
	}

	public void setStripe(String stripe) {
		this.stripe = stripe;
	}
}
