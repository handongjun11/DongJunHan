package com.kh.god.menu.model.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Menu {
	private String menuCode;
	private int categoryNo;
	private String menuName;
	private int menuPrice;
	private String storeNo;
	private int amount = 1;
	private String soldoutFlag;
	private int menuNo;
	private String renamedFileName;
	private String delFlag;
	
	

}
