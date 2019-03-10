package com.kh.god.seller.model.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.god.admin.model.vo.Ad;
import com.kh.god.member.model.vo.Review;
import com.kh.god.menu.exception.MenuException;
import com.kh.god.menu.model.vo.Menu;
import com.kh.god.seller.model.dao.SellerDao;
import com.kh.god.seller.model.vo.OrderInfo;
import com.kh.god.seller.model.vo.Seller;
import com.kh.god.storeInfo.exception.StoreInfoException;
import com.kh.god.storeInfo.model.vo.MenuAttachment;
import com.kh.god.storeInfo.model.vo.SAttachment;
import com.kh.god.storeInfo.model.vo.StoreInfo;


@Service
public class SellerServiceImpl implements SellerService {

	Logger logger = Logger.getLogger(getClass());

	@Autowired
	SellerDao sellerDao;
	
	@Override
	public Seller selectOneSeller(String sellerId) {
		return sellerDao.selectOneSeller(sellerId);
	}

	@Override
	@Transactional(rollbackFor=Exception.class)
	public int insertSeller(Seller s) {
		int result =  sellerDao.insertSeller(s);
		if(result > 0) {
			Map<String,String> chatId = new HashMap<>();
			chatId.put("sellerId", s.getSellerId());
			chatId.put("admin", "admin");
			result = sellerDao.createChatRoom(chatId);
		}
		return result;
	}
	
	@Override
	public List<StoreInfo> myStore(String sellerId) {
		List<StoreInfo> store = sellerDao.myStore(sellerId);
		return store;
	}

	@Override
	public int updatePwd(Seller s) {
		return sellerDao.updatePwd(s);
	}

	@Override
	public int updateSeller(Seller s) {
		return sellerDao.updateSeller(s);
	}
	
	@Override
	public List<Menu> myStoreMenu(String sellerId) {
		List<Menu> menu = sellerDao.myStoreMenu(sellerId);
		return menu;
	}

	@Override
	public List<Map<String, Object>> getStoreInfoBystoreNo(String storeNo) {
		List<Map<String, Object>> getStoreInfoBystoreNo = sellerDao.getStoreInfoBystoreNo(storeNo);
		return getStoreInfoBystoreNo;
	}

	@Override

	public List<MenuAttachment> getAttachment(String storeNo) {
		return sellerDao.getAttachment(storeNo);
	}

	@Override
	public List<Menu> selectMenuList(String storeNo) {
		
		return sellerDao.selectMenuList(storeNo);
	}

	public List<MenuAttachment> getthumbAttachment(String storeNo) {
		return sellerDao.getthumbAttachment(storeNo);
	}

	@Override
	public int oldThumbNail(String nowThumb) {
		return sellerDao.oldThumbNail(nowThumb);	
    }

	@Override
	public int changeThmbNail(String newThumb) {
		return sellerDao.changeThmbNail(newThumb);
	}

	@Override
	public int updateStoreInfo(Map<String, Object> map) {
		return sellerDao.updateStoreInfo(map);
	}
	
	@Override
	public int updateSoldout(Map<String, Object> map) {
		return sellerDao.updateSoldout(map);
	}
	
	@Override
	public List<StoreInfo> selectListStorInfo(String sellerId) {
		return sellerDao.selectListStorInfo(sellerId);
	}

	public List<OrderInfo> myStoreOrderInfo(String storeNo) {
		return sellerDao.myStoreOrderInfo(storeNo);
	}

	@Override
	public List<Map<String, Object>> orderList1(String storeNo) {
		return sellerDao.orderList1(storeNo);
	}

	@Override
	public List<Map<String, String>> adSelectAll(int cPage, int numPerPage,String storeNo) {
		return sellerDao.adSelectAll(cPage,numPerPage,storeNo);
	}

	@Override
	public List<Map<String, String>> adSelectNow(int cPage, int numPerPage,String storeNo) {
		return sellerDao.adSelectNow(cPage,numPerPage,storeNo);
	}

	@Override
	public List<Map<String, String>> adSelectPast(int cPage, int numPerPage,String storeNo) {
		return sellerDao.adSelectPast(cPage,numPerPage,storeNo);
	}

	@Override
	public int countAdAll(String storeNo) {
		return sellerDao.countAdAll(storeNo);
	}

	@Override
	public int countAdNow(String storeNo) {
		return sellerDao.countAdNow(storeNo);
	}

	@Override
	public int countAdPast(String storeNo) {
		return sellerDao.countAdPast(storeNo);
	}

	@Override
	public int adRequest(Ad ad) {
		return sellerDao.adRequest(ad);
	}
	
	public int receiveOrder(Map<String, Object> map) {
		return sellerDao.receiveOrder(map);
	}

	@Override
	public List<Map<String, Object>> orderList2(String storeNo) {
		return sellerDao.orderList2(storeNo);
	}

	@Override
	public List<Map<String, Object>> orderList3(String storeNo) {
		return sellerDao.orderList3(storeNo);
	}

	@Override
	public int deliveryEnd(int orderNo) {
		return sellerDao.deliveryEnd(orderNo);
	}

	@Override
	public int cancelOrder(int orderNo) {
		return sellerDao.cancelOrder(orderNo);
	} 
	
	public int updateMenu(Map<String, Object> map) {
		int result = 0;
		String menuCode = "";

		result = sellerDao.updateMenu(map);
		menuCode = (String) map.get("menuCode");
		logger.debug("메뉴 코드 = " + menuCode);

		if (result == 0) {
			throw new MenuException("메뉴 수정 실패!");
		}

		List<MenuAttachment> menuAttachList = (List<MenuAttachment>) map.get("menuAttachList");

		if (menuAttachList.size() > 0) {
			for (MenuAttachment a : menuAttachList) {
				a.setMenuCode(menuCode);
				result = sellerDao.updateMenuAttachment(a);
				if (result == 0) {
					throw new MenuException("메뉴사진파일 수정 오류!");
				}

			}
		}

		return result;
	}
	
	@Override
	public int deleteMenu(Map<String, Object> map) {
		return sellerDao.deleteMenu(map);
	}

	@Override
	public int insertOrder(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sellerDao.insertOrder(map);
	}

	@Override
	public int insertOrderInfo(Map<String, Object> orderInfoMap) {
		// TODO Auto-generated method stub
		return sellerDao.insertOrderInfo(orderInfoMap);
	}

	@Override
	public int insertOrderMenu(Map<String, Object> orderMenuMap) {
		// TODO Auto-generated method stub
		return sellerDao.insertOrderMenu(orderMenuMap);
	}

	//종합 보기에서  저번주의 판매량을 가져온다.
	@Override
	public List<Map<String, String>> totalSaleVolume(String sellerId,String type) {
		return sellerDao.totalSaleVolume(sellerId,type);
	}	


	@Override
	public int selectMenuNo(String storeNo) {
		return sellerDao.selectMenuNo(storeNo);
	}

	@Override
	public StoreInfo selectStoreInfo(String storeNo) {
		return sellerDao.selectStoreInfo(storeNo);
	}

	@Override
	public int insertMenu(Menu menu, List<MenuAttachment> menuAttachList) {
		int result = 0;
		String storeNo = "";
		
		result = sellerDao.insertMenu(menu);
		storeNo = menu.getStoreNo();
		logger.debug("사업자 번호 = " + storeNo);
		
		if (result == 0) {
			throw new MenuException("메뉴 등록 실패!");
		}
		
		if(menuAttachList.size() > 0) {
			for(MenuAttachment a : menuAttachList) {
				a.setStoreNo(storeNo);
				result = sellerDao.insertMenuAttachment(a);
				if(result == 0) {
					throw new MenuException("메뉴사진파일 등록 오류!");
				}
				
			}
		}
		
		return result;
	}
	@Transactional
	@Override
	public List<Map<String, String>> totalSaleVolume(Map<String,String> info) {
		Map<String,String> storeName = sellerDao.getStoreName(info);
		logger.debug("판매자의 가게 이름? : "+storeName);
		List<Map<String,String>> week = null;
		week = sellerDao.totalSaleVolume(info);
		logger.debug("데이터가 있나요? : "+week);
		if(week.size() == 0) {
			storeName.put("originalPrice","noData");
			week.add(storeName);
			logger.debug("데이터 없을 때 : "+week);
		}
		return week;
	}

	@Override
	public List<Map<String,String>> chartByPeriod(Map<String, String> map) {
		return sellerDao.chartByPeriod(map);
	}

	@Override
	public List<Review> getReview1(String storeNo) {
		// TODO Auto-generated method stub
		return sellerDao.getReview1(storeNo);
	}

	@Override
	public List<Review> getReview2(String storeNo) {
		// TODO Auto-generated method stub
		return sellerDao.getReview2(storeNo);
	}
	
	//자동로그인 TEST
	@Override
	public void keepLogin(String sellerId, String sessionId ,Date next) throws Exception{
		sellerDao.keepLogin(sellerId, sessionId, next);
	}
	
	@Override
	public Seller checkUserWithSessionKey(String sessionId){
		
		return sellerDao.checkUserWithSessionKey(sessionId);
	}

	@Override
	public Seller login(Seller s) {
		return sellerDao.login(s);
	}

	@Override
	public String selectSellerIdByStoreNo(String storeNo) {
		return sellerDao.selectSellerIdByStoreNo(storeNo);
	}

	@Override
	public Seller selectSellerBySellerId(String sellerId) {
		return sellerDao.selectSellerBySellerId(sellerId);
	
	}





	
}
