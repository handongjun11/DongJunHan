package com.kh.god.seller.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OrderInfo {
	private int orderNo;
	private String memberId;
	private String storeNo;
	private int totalPrice;
	private String cancelFlag;
	private Date orderTime;
	private String deliveryFlag;
	private Date deliveryEnd;
	private int originalPrice;
	private String priceWay;
	private String receiveFlag;
	private String request;
	private String delivertTime;
	private String paymentId;
}
