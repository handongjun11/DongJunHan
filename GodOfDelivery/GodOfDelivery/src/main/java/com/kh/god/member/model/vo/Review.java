package com.kh.god.member.model.vo;

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
public class Review {
	
	private int reviewNo;
	private String storeNo;
	private int orderNo;
	private String title;
	private String writer;
	private String content;
	private int rate;
	private int good;
	private int hate;
	private Date rDate;
	private String delFlag;
	private int commentLevel; 
	private int reviewRef;
	
	public Date getrDate() {
		return rDate;
	}
	public void setrDate(Date rDate) {
		this.rDate = rDate;
	}   
	
	
	
	
}
