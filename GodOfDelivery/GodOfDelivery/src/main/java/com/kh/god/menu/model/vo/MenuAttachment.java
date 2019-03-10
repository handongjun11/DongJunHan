package com.kh.god.menu.model.vo;

import java.io.Serializable;
import java.sql.Date;


public class MenuAttachment implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String menuCode;
	private String originalFileName;
	private String renamedFileName;
	private Date menuUploadDate;
	private String storeNo;
	private String status; // "y", "n"
	private String thumbFlag; // "y", "n"

	public MenuAttachment() {
		super();
	}

	public MenuAttachment(String menuCode, String originalFileName, String renamedFileName, Date menuUploadDate,
			String storeNo, String status, String thumbFlag) {
		super();
		this.menuCode = menuCode;
		this.originalFileName = originalFileName;
		this.renamedFileName = renamedFileName;
		this.menuUploadDate = menuUploadDate;
		this.storeNo = storeNo;
		this.status = status;
		this.thumbFlag = thumbFlag;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getRenamedFileName() {
		return renamedFileName;
	}

	public void setRenamedFileName(String renamedFileName) {
		this.renamedFileName = renamedFileName;
	}

	public Date getMenuUploadDate() {
		return menuUploadDate;
	}

	public void setMenuUploadDate(Date menuUploadDate) {
		this.menuUploadDate = menuUploadDate;
	}

	public String getStoreNo() {
		return storeNo;
	}

	public void setStoreNo(String storeNo) {
		this.storeNo = storeNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getThumbFlag() {
		return thumbFlag;
	}

	public void setThumbFlag(String thumbFlag) {
		this.thumbFlag = thumbFlag;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "MenuAttachment [menuCode=" + menuCode + ", originalFileName=" + originalFileName + ", renamedFileName="
				+ renamedFileName + ", menuUploadDate=" + menuUploadDate + ", storeNo=" + storeNo + ", status=" + status
				+ ", thumbFlag=" + thumbFlag + "]";
	}
	
	

	
}
