package com.kh.god.storeInfo.model.vo;

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
public class MenuAttachment {
	private String menuCode;
	private String originalFileName;
	private String renamedFileName;
	private Date menuUploadDate;
	private String storeNo;
	private String status;
	private String thumbFlag;
}
