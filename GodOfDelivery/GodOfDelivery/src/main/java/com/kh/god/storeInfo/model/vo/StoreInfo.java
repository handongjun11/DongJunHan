package com.kh.god.storeInfo.model.vo;

import java.io.Serializable;

public class StoreInfo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String storeNo;			// 사업자번호 PK
	private String storeName;		// 상호명
	private String storeTel;		// 매장 전화번호
	private String storeAddress;	// 매장 주소
	private String storeGrade;		// 매장 등급
	private int categoryNo;			// 카테고리 코드
	private String storeIntro;		// 매장 설명
	private String personalDay;		// 휴무일
	private String operatingHours;	// 영업 시간
	private String pmsFlag;			// 관리자 허가 여부
	private String closeFlag;		// 매장 폐업 여부
	private int deliveryMinPrice;	// 최소 배달 금액
	private String sellerId;		// 사업자가입 ID
	private String rejectInfo;		// 가게 신청 거절 사유
	
	public StoreInfo() {
		super();
	}

	public StoreInfo(String storeNo, String storeName, String storeTel, String storeAddress, String storeGrade,
			int categoryNo, String storeIntro, String personalDay, String operatingHours, String pmsFlag,
			String closeFlag, int deliveryMinPrice, String sellerId, String rejectInfo) {
		super();
		this.storeNo = storeNo;
		this.storeName = storeName;
		this.storeTel = storeTel;
		this.storeAddress = storeAddress;
		this.storeGrade = storeGrade;
		this.categoryNo = categoryNo;
		this.storeIntro = storeIntro;
		this.personalDay = personalDay;
		this.operatingHours = operatingHours;
		this.pmsFlag = pmsFlag;
		this.closeFlag = closeFlag;
		this.deliveryMinPrice = deliveryMinPrice;
		this.sellerId = sellerId;
		this.rejectInfo = rejectInfo;
	}

	public String getStoreNo() {
		return storeNo;
	}

	public void setStoreNo(String storeNo) {
		this.storeNo = storeNo;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getStoreTel() {
		return storeTel;
	}

	public void setStoreTel(String storeTel) {
		this.storeTel = storeTel;
	}

	public String getStoreAddress() {
		return storeAddress;
	}

	public void setStoreAddress(String storeAddress) {
		this.storeAddress = storeAddress;
	}

	public String getStoreGrade() {
		return storeGrade;
	}

	public void setStoreGrade(String storeGrade) {
		this.storeGrade = storeGrade;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getStoreIntro() {
		return storeIntro;
	}

	public void setStoreIntro(String storeIntro) {
		this.storeIntro = storeIntro;
	}

	public String getPersonalDay() {
		return personalDay;
	}

	public void setPersonalDay(String personalDay) {
		this.personalDay = personalDay;
	}

	public String getOperatingHours() {
		return operatingHours;
	}

	public void setOperatingHours(String operatingHours) {
		this.operatingHours = operatingHours;
	}

	public String getPmsFlag() {
		return pmsFlag;
	}

	public void setPmsFlag(String pmsFlag) {
		this.pmsFlag = pmsFlag;
	}

	public String getCloseFlag() {
		return closeFlag;
	}

	public void setCloseFlag(String closeFlag) {
		this.closeFlag = closeFlag;
	}

	public int getDeliveryMinPrice() {
		return deliveryMinPrice;
	}

	public void setDeliveryMinPrice(int deliveryMinPrice) {
		this.deliveryMinPrice = deliveryMinPrice;
	}

	public String getSellerId() {
		return sellerId;
	}

	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getRejectInfo() {
		return rejectInfo;
	}

	public void setRejectInfo(String rejectInfo) {
		this.rejectInfo = rejectInfo;
	}

	@Override
	public String toString() {
		return "StoreInfo [storeNo=" + storeNo + ", storeName=" + storeName + ", storeTel=" + storeTel
				+ ", storeAddress=" + storeAddress + ", storeGrade=" + storeGrade + ", categoryNo=" + categoryNo
				+ ", storeIntro=" + storeIntro + ", personalDay=" + personalDay + ", operatingHours=" + operatingHours
				+ ", pmsFlag=" + pmsFlag + ", closeFlag=" + closeFlag + ", deliveryMinPrice=" + deliveryMinPrice
				+ ", sellerId=" + sellerId + ", rejectInfo=" + rejectInfo + "]";
	}

}
