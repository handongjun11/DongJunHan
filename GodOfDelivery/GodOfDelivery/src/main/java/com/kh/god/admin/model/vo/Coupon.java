package com.kh.god.admin.model.vo;

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
public class Coupon {
	private String varchar2;
	private int eventNo;
	private String memberId;
	private Date startDate;
	private Date endDate;

}
