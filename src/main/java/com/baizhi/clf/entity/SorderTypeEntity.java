package com.baizhi.clf.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.lang.String;
import java.lang.Double;
import java.lang.Integer;
import java.math.BigDecimal;
import javax.xml.soap.Text;
import java.sql.Blob;

/**   
 * @Title: Entity
 * @Description: 订单类型
 * @author onlineGenerator
 * @date 2018-08-27 18:08:37
 * @version V1.0   
 *
 */
@SuppressWarnings("serial")
public class SorderTypeEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**订单编号*/
	private java.lang.String orderNum;
	/**收件人*/
	private java.lang.String name;
	/**联系电话*/
	private java.lang.String phone;
	/**收货地址*/
	private java.lang.String address;
	/**取货时间*/
	private java.lang.String qtime;
	
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
	 *@return: java.lang.String  订单编号
	 */

	public java.lang.String getOrderNum(){
		return this.orderNum;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  订单编号
	 */
	public void setOrderNum(java.lang.String orderNum){
		this.orderNum = orderNum;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  收件人
	 */

	public java.lang.String getName(){
		return this.name;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  收件人
	 */
	public void setName(java.lang.String name){
		this.name = name;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  联系电话
	 */

	public java.lang.String getPhone(){
		return this.phone;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  联系电话
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
	 *@return: java.lang.String  取货时间
	 */

	public java.lang.String getQtime(){
		return this.qtime;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  取货时间
	 */
	public void setQtime(java.lang.String qtime){
		this.qtime = qtime;
	}

	@Override
	public String toString() {
		return "SorderTypeEntity [id=" + id + ", orderNum=" + orderNum
				+ ", name=" + name + ", phone=" + phone + ", address="
				+ address + ", qtime=" + qtime + "]";
	}
	
	
}
