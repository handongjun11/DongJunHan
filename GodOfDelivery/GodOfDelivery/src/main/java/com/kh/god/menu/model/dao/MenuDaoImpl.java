package com.kh.god.menu.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.god.menu.model.vo.Menu;
import com.kh.god.storeInfo.model.vo.StoreInfo;

@Repository
public class MenuDaoImpl implements MenuDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Menu> menuList(String storeNo) {
		return sqlSession.selectList("storeInfo.menuList", storeNo);
	}

	@Override
	public List<StoreInfo> storeInfoList(String storeNo) {
		return sqlSession.selectList("storeInfo.storeInfoList", storeNo);
	}

	@Override
	public int menuCount(String storeNo) {
		int menuCount = sqlSession.selectOne("storeInfo.menuCount", storeNo);
		return menuCount;
	}

	@Override
	public Menu selectOneMenu(String menuCode) {
		Menu menu = sqlSession.selectOne("storeInfo.selectOneMenu",menuCode);
		return menu;
	}
	

}
