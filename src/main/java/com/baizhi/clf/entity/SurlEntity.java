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
 * @Description: 店铺地址
 * @author onlineGenerator
 * @date 2018-08-21 08:59:20
 * @version V1.0
 * 
 */
public class SurlEntity implements java.io.Serializable {
	/** 主键 */
	private String id;
	/** 店铺地址 */
	private String url;
	/** 店铺状态 */
	private String status;
	/** 店长外键 */
	private String adminId;
	/** 中文店名 */
	private String name1;
	/** 德文店名 */

	private String name2;
	/** 最低包邮价格 */
	private Double minPrice;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getName1() {
		return name1;
	}

	public void setName1(String name1) {
		this.name1 = name1;
	}

	public String getName2() {
		return name2;
	}

	public void setName2(String name2) {
		this.name2 = name2;
	}

	public Double getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(Double minPrice) {
		this.minPrice = minPrice;
	}

}
