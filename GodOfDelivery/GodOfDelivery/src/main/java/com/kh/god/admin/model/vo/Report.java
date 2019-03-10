package com.kh.god.admin.model.vo;


import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Report {
	private int reportNo;
	private String category;
	private int reviewNo;
	private String storeNo;
	private String reportDetails;
	private String reportFlag;
}
