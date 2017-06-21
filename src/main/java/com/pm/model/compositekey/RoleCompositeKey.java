package com.pm.model.compositekey;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class RoleCompositeKey implements Serializable{
	private static final long serialVersionUID = 6346751900265093464L;

	@Column(name = "tc")
    private String tc;

    @Column(name = "role")
    private String role;	    	   
    
	public RoleCompositeKey() {
		super();
	}

	public RoleCompositeKey(String tc, String role) {
		super();
		this.tc = tc;
		this.role = role;
	}

	public String getTc() {
		return tc;
	}

	public void setTc(String tc) {
		this.tc = tc;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "RoleCompositeKey [tc=" + tc + ", role=" + role + "]";
	}		
}