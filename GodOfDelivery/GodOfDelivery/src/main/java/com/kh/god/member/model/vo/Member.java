package com.kh.god.member.model.vo;

import java.sql.Date;
import java.util.Arrays;

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
public class Member {
	
	private String memberId;
	private String password;
	private String memberName;
	private String birth;
	private String email;
	private String address;
	private String phone;	
	private String gender;
	private String[] favorite;
	private String oldFile; //OLDFILE
	private String renamedFile; //RENAMEDFILE
	private int totalAmount;
	private String memberGrade;
	private Date enrollDate;
	private String blackFlag;
	private String delFlag;	
	
	

	
	

}
