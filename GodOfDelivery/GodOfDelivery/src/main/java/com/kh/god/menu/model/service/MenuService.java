package com.kh.god.menu.model.service;

import java.util.List;

import com.kh.god.menu.model.vo.Menu;
import com.kh.god.storeInfo.model.vo.StoreInfo;

public interface MenuService {


	List<Menu> menuList(String storeNo);

	List<StoreInfo> storeInfoList(String storeNo);

	int menuCount(String storeNo);

	Menu selectOneMenu(String menuCode);


}
