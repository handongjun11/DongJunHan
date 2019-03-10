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
public class Seller {

	private String sellerId ;
	private String sellerName;
	private String email;
	private String phone;
	private Date enrollDate;
	private String delFlag;
	private String blackFlag;
	private String password;
	private String sessionKey;
	private String sessionLimit;
}
