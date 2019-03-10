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
public class RAttachment {

	private int attachmentNo;
	private int reviewNo;
	private String originalFileName;
	private String renamedFileName;
	private Date uploadDate;
	private int downloadCount ;
	private String status; //첨부파일 삭제여부

	
}
