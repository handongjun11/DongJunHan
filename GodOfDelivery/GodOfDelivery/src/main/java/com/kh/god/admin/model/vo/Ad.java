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
public class Ad {
	
	private int adNo;
	private String storeNo;
	private int price;
	private String storeGrade;
	private Date startDate;
	private Date endDate;
	

}
