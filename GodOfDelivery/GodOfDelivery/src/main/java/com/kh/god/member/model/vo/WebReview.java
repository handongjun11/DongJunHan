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
public class WebReview {
	private int boardNo ;
	private String title;
	private String writer;
	private String content;
	private Date writeDate;
	private String rate;
}
