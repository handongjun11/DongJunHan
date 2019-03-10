package com.kh.god.menu.model.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.god.menu.model.dao.MenuDao;
import com.kh.god.menu.model.vo.Menu;
import com.kh.god.storeInfo.model.vo.StoreInfo;

@Service
public class MenuServiceImpl implements MenuService {
	Logger logger = Logger.getLogger(getClass());

	@Autowired
	MenuDao menuDao;	
	@Override
	public List<Menu> menuList(String storeNo) {
		List<Menu> menuList = menuDao.menuList(storeNo);
		return menuList;
	}
	@Override
	public List<StoreInfo> storeInfoList(String storeNo) {
		List<StoreInfo> storeInfoList = menuDao.storeInfoList(storeNo);
		return storeInfoList;
	}
	@Override
	public int menuCount(String storeNo) {
		int menuCount = menuDao.menuCount(storeNo);
		return menuCount;
	}
	@Override
	public Menu selectOneMenu(String menuCode) {
		Menu menu = menuDao.selectOneMenu(menuCode);
		return menu;
	}


}
