package com.pm.model;

import java.io.Serializable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.pm.model.compositekey.RoleCompositeKey;

/**
 * 
 * @author Ergun
 * 
 */

@Entity
@Table(name = "role")
public class Role implements Serializable{

	private static final long serialVersionUID = 1L;	
	
	@EmbeddedId
    private RoleCompositeKey roleCompositeKey;	
	
	public Role() {
		super();
	}

	public Role(RoleCompositeKey roleCompositeKey) {
		super();
		this.roleCompositeKey = roleCompositeKey;
	}

	public RoleCompositeKey getRoleCompositeKey() {
		return roleCompositeKey;
	}

	public void setRoleCompositeKey(RoleCompositeKey roleCompositeKey) {
		this.roleCompositeKey = roleCompositeKey;
	}

	@Override
	public String toString() {
		return "Role [roleCompositeKey=" + roleCompositeKey + "]";
	}	
}
