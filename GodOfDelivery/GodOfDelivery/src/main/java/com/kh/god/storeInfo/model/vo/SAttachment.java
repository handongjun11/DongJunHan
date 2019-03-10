package com.kh.god.storeInfo.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SAttachment {
	private int attachmentNo;
	private String storeNo;
	private String originalFileName;
	private String renamedFileName;
	private Date uploadDate;
	private int downloadCount ;
	private String status; //첨부파일 삭제여부
	
}
