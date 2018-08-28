package com.baizhi.clf.entity;

import java.math.BigDecimal;
import java.util.Date;



@SuppressWarnings("serial")
public class SuserEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**cookieID*/
	private java.lang.String cookieid;
	/**手机号*/
	private java.lang.String phone;
	/**收货地址*/
	private java.lang.String address;
	/**收货人*/
	private java.lang.String name;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键
	 */

	public java.lang.String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  主键
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  cookieID
	 */

	public java.lang.String getCookieid(){
		return this.cookieid;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  cookieID
	 */
	public void setCookieid(java.lang.String cookieid){
		this.cookieid = cookieid;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  手机号
	 */

	public java.lang.String getPhone(){
		return this.phone;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  手机号
	 */
	public void setPhone(java.lang.String phone){
		this.phone = phone;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  收货地址
	 */

	public java.lang.String getAddress(){
		return this.address;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  收货地址
	 */
	public void setAddress(java.lang.String address){
		this.address = address;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  收货人
	 */

	public java.lang.String getName(){
		return this.name;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  收货人
	 */
	public void setName(java.lang.String name){
		this.name = name;
	}

	@Override
	public String toString() {
		return "SuserEntity [id=" + id + ", cookieid=" + cookieid + ", phone="
				+ phone + ", address=" + address + ", name=" + name + "]";
	}
	
}
