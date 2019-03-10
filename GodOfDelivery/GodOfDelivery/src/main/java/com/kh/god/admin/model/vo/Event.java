package com.kh.god.admin.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Event {
	
	private int eventNo;
	private String eventTitle;
	private String discount;
	private String eventBig;
	private Date startDate;
	private Date endDate;
	private int amount;
	private String eventSmall;

}
