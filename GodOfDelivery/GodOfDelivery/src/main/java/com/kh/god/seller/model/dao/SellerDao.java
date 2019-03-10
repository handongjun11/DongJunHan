package com.kh.god.seller.model.dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.god.admin.model.vo.Ad;
import com.kh.god.member.model.vo.Review;
import com.kh.god.menu.model.vo.Menu;
import com.kh.god.seller.model.vo.OrderInfo;
import com.kh.god.seller.model.vo.Seller;
import com.kh.god.storeInfo.model.vo.MenuAttachment;
import com.kh.god.storeInfo.model.vo.StoreInfo;


public interface SellerDao {

	Seller selectOneSeller(String sellerId);
	
	int insertSeller(Seller s);
	
	List<StoreInfo> myStore(String sellerId);

	int updatePwd(Seller s);

	int updateSeller(Seller s);

	List<Menu> myStoreMenu(String sellerId);

	List<Map<String, Object>> getStoreInfoBystoreNo(String storeNo);

	List<MenuAttachment> getAttachment(String storeNo);

	List<MenuAttachment> getthumbAttachment(String storeNo);

	int oldThumbNail(String nowThumb);

	int changeThmbNail(String newThumb);

	int updateStoreInfo(Map<String, Object> map);

	List<StoreInfo> selectListStorInfo(String sellerId);

	List<OrderInfo> myStoreOrderInfo(String storeNo);

	List<Menu> selectMenuList(String storeNo);

	int updateSoldout(Map<String, Object> map);

	List<Map<String, Object>> orderList1(String storeNo);

	List<Map<String, String>> adSelectAll(int cPage, int numPerPage, String storeNo);

	List<Map<String, String>> adSelectNow(int cPage, int numPerPage, String storeNo);

	List<Map<String, String>> adSelectPast(int cPage, int numPerPage, String storeNo);

	int countAdNow(String storeNo);

	int countAdAll(String storeNo);

	int countAdPast(String storeNo);

	int adRequest(Ad ad);

	int receiveOrder(Map<String, Object> map);

	List<Map<String, Object>> orderList2(String storeNo);

	List<Map<String, Object>> orderList3(String storeNo);

	int deliveryEnd(int orderNo);

	int cancelOrder(int orderNo);

	int updateMenu(Map<String, Object> map);

	int deleteMenu(Map<String, Object> map);

	int insertOrder(Map<String, Object> map);

	int insertOrderInfo(Map<String, Object> orderInfoMap);

	int insertOrderMenu(Map<String, Object> orderMenuMap);

	List<Map<String, String>> totalSaleVolume(String sellerId,String type);

	int selectMenuNo(String storeNo);

	StoreInfo selectStoreInfo(String storeNo);

	List<Review> getReview1(String storeNo);

	List<Review> getReview2(String storeNo);


	List<Map<String,String>> chartByPeriod(Map<String, String> map);

	List<Map<String, String>> totalSaleVolume(Map<String,String> info);

	Map<String, String> getStoreName(Map<String, String> map);

	int insertMenu(Menu menu);

	int insertMenuAttachment(MenuAttachment a);

	int updateMenuAttachment(MenuAttachment a);
	
	//자동로그인 TEST	
	public void keepLogin(String sellerId, String sessionId,Date next) throws Exception;
		
	public Seller checkUserWithSessionKey(String sessionId);

	Seller login(Seller s);


	String selectSellerIdByStoreNo(String storeNo);

	Seller selectSellerBySellerId(String sellerId);

	int createChatRoom(Map<String, String> chatId);






}
