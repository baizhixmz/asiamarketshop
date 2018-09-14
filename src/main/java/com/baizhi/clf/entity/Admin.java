package com.baizhi.clf.entity;

/**
 * Created by Administrator on 2018/3/23.
 */
public class Admin {

	private String id;
	private String password;
	private String username;
	private String mobilePhone;
	private String email;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "Admin [id=" + id + ", password=" + password + ", username="
				+ username + ", mobilePhone=" + mobilePhone + ", email="
				+ email + "]";
	}
	
	
	
}
