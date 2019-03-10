package com.kh.god.seller.model.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.god.admin.model.vo.Ad;
import com.kh.god.member.model.vo.Review;
import com.kh.god.menu.model.vo.Menu;
import com.kh.god.seller.model.vo.OrderInfo;
import com.kh.god.seller.model.vo.Seller;
import com.kh.god.storeInfo.model.vo.MenuAttachment;
import com.kh.god.storeInfo.model.vo.StoreInfo;


@Repository
public class SellerDaoImpl implements SellerDao {
	Logger logger = Logger.getLogger(getClass());
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public Seller selectOneSeller(String sellerId) {
		Seller s = sqlSession.selectOne("seller.selectOneSeller", sellerId);
		return s;
	}

	@Override
	public int insertSeller(Seller s) {
		return sqlSession.insert("seller.insertSeller", s);
	}

	@Override
	public List<StoreInfo> myStore(String sellerId) {
		return sqlSession.selectList("storeInfo.getMyStore", sellerId);
	}

	@Override
	public int updatePwd(Seller s) {
		return sqlSession.update("seller.updatePwd" , s );
	}

	@Override
	public int updateSeller(Seller s) {
		return sqlSession.update("seller.updateSeller" , s);
	}
	
	@Override
	public List<Menu> myStoreMenu(String sellerId) {
		return sqlSession.selectList("storeInfo.myStoreMenu", sellerId);
	}

	@Override
	public List<Map<String, Object>> getStoreInfoBystoreNo(String storeNo) {
		return sqlSession.selectList("storeInfo.storeInfoList", storeNo);
	}

	@Override
	public List<MenuAttachment> getAttachment(String storeNo) {
		return sqlSession.selectList("storeInfo.getAttachment",storeNo);
	}

	@Override
	public List<Menu> selectMenuList(String storeNo) {
		return sqlSession.selectList("storeInfo.selectMenuList", storeNo);
	}
	
	@Override
	public List<MenuAttachment> getthumbAttachment(String storeNo) {
		return sqlSession.selectList("storeInfo.getthumbAttachment",storeNo);
	}

	@Override
	public int oldThumbNail(String nowThumb) {
		return sqlSession.update("storeInfo.oldThumbNail",nowThumb);
	}

	@Override
	public int changeThmbNail(String newThumb) {
		return sqlSession.update("storeInfo.changeThmbNail",newThumb);
	}

	@Override
	public int updateStoreInfo(Map<String, Object> map) {
		return sqlSession.update("storeInfo.updateStoreInfo",map);
	}

	@Override
	public int updateSoldout(Map<String, Object> map) {
		return sqlSession.update("storeInfo.updateSoldout", map);
	}
	
	@Override
	public List<StoreInfo> selectListStorInfo(String sellerId) {
		return sqlSession.selectList("storeInfo.selectListStorInfo" , sellerId);
	}
	
	@Override
	public List<OrderInfo> myStoreOrderInfo(String storeNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storeInfo.myStoreOrderInfo",storeNo);
	}

	@Override
	public List<Map<String, Object>> orderList1(String storeNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storeInfo.orderList1",storeNo);
	}

	@Override
	public List<Map<String, String>> adSelectAll(int cPage, int numPerPage, String storeNo) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("storeInfo.adSelectAll",storeNo,rowBounds);
	}

	@Override
	public List<Map<String, String>> adSelectNow(int cPage, int numPerPage, String storeNo) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("storeInfo.adSelectNow",storeNo,rowBounds);
	}

	@Override
	public List<Map<String, String>> adSelectPast(int cPage, int numPerPage, String storeNo) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("storeInfo.adSelectPast",storeNo,rowBounds);
	}

	@Override
	public int countAdNow(String storeNo) {
		return sqlSession.selectOne("storeInfo.countAdNow",storeNo);
	}

	@Override
	public int countAdAll(String storeNo) {
		return sqlSession.selectOne("storeInfo.countAdAll",storeNo);
	}

	@Override
	public int countAdPast(String storeNo) {
		return sqlSession.selectOne("storeInfo.countAdPast",storeNo);
	}

	@Override
	public int adRequest(Ad ad) {
		return sqlSession.insert("storeInfo.adRequest",ad);
	}

	public int receiveOrder(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.update("storeInfo.receiveOrder",map);
	}

	@Override
	public List<Map<String, Object>> orderList2(String storeNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storeInfo.orderList2",storeNo);
	}

	@Override
	public List<Map<String, Object>> orderList3(String storeNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("storeInfo.orderList3",storeNo);
	}

	@Override
	public int deliveryEnd(int orderNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("storeInfo.deliveryEnd",orderNo);
	}

	@Override
	public int cancelOrder(int orderNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("storeInfo.cancelOrder",orderNo);
	}

	public int updateMenu(Map<String, Object> map) {
		return sqlSession.update("menu.updateMenu", map);
	}

	@Override
	public int deleteMenu(Map<String, Object> map) {
		return sqlSession.update("menu.deleteMenu", map);
	}

	@Override
	public int insertOrder(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.insert("seller.insertOrder",map);
	}

	@Override
	public int insertOrderInfo(Map<String, Object> orderInfoMap) {
		// TODO Auto-generated method stub
		return sqlSession.insert("seller.insertOrderInfo",orderInfoMap);
	}

	@Override
	public int insertOrderMenu(Map<String, Object> orderMenuMap) {
		// TODO Auto-generated method stub
		return sqlSession.insert("seller.insertOrderMenu",orderMenuMap);
	}

	public List<Map<String, String>> totalSaleVolume(String sellerId,String type) {
		List<Map<String,String>> resultList = null;
		switch(type) {
		case "today" : resultList = new ArrayList<>();resultList = sqlSession.selectList("seller.totalSaleVolumeofToday", sellerId); break;
		case "week" : resultList = new ArrayList<>(); resultList = sqlSession.selectList("seller.totalSaleVolumeofWeek", sellerId); break;
		case "month" : resultList = new ArrayList<>(); resultList = sqlSession.selectList("seller.totalSaleVolumeofMonth", sellerId); break;
		case "3month" : resultList = new ArrayList<>(); resultList = sqlSession.selectList("seller.totalSaleVolumeof3Month", sellerId); break;
		}
		
		return resultList;
	}

	public int selectMenuNo(String storeNo) {
		List<Menu> menuList = sqlSession.selectList("menu.selectMenuNo", storeNo);
		int menuNo = 0;

		try {

			if (menuList == null) {
				menuNo = 0;
			} else {

				menuNo = menuList.get(menuList.size() - 1).getMenuNo();
			}

		} catch (IndexOutOfBoundsException e) {

		}
		
		return menuNo;
	}

	@Override
	public StoreInfo selectStoreInfo(String storeNo) {
		return sqlSession.selectOne("storeInfo.selectOnebyStoreNo", storeNo);
	}

	@Override
	public int insertMenu(Menu menu) {
		return sqlSession.insert("menu.insertMenu", menu);
	}

	@Override
	public int insertMenuAttachment(MenuAttachment a) {
		System.out.println("########################### insert a => " + a);
		return sqlSession.insert("menu.insertMenuAttachment", a );
	}
	
	@Override
	public int updateMenuAttachment(MenuAttachment a) {
		System.out.println("########################### update a => " + a);
		return sqlSession.update("menu.updateMenuAttachment", a );
	}
	//기간별 통계내는 부분(일반 판매량,(회원/비회원)판매량)
	@Override
	public List<Map<String,String>> chartByPeriod(Map<String, String> map) {
		int startMonth = Integer.parseInt(map.get("startDate").substring(5,7));
		int endMonth = Integer.parseInt(map.get("endDate").substring(5,7));
		int subMonth = endMonth-startMonth;
		List<Map<String,String>> resultList = null;
		switch(map.get("type")) {
		case "saleVolume" :
		if(subMonth == 0) { //3달인지 1달인지 거르기 위한 분기문. 3달이면 시작 달과 끝 달이 다르므로 0이 아닌점을 이용.
			resultList = new ArrayList<>();
			resultList = sqlSession.selectList("seller.chartByPeriod", map);
		}else {
			endMonth = endMonth == 12 ? 1:endMonth+1;//오라클에서 달로만 계산하려니 마지막달은 1일 00시까지라 그 다음달 1일 00시까지 하고 view단에서 거름.
			map.put("startDate",map.get("startDate").substring(0,7));
			map.put("endDate",map.get("endDate").substring(0,4)+"/"+endMonth);
			logger.debug("시작 날짜 : "+map.get("startDate"));
			logger.debug("끝 날짜 : "+map.get("endDate"));
			resultList = new ArrayList<>();
			resultList = sqlSession.selectList("seller.chartBy3Month",map);
		} break;
		case "saleVolumeOfMember" :  
			if(subMonth == 0) { //3달인지 1달인지 거르기 위한 분기문. 3달이면 시작 달과 끝 달이 다르므로 0이 아닌점을 이용.
				resultList = new ArrayList<>();
				resultList = sqlSession.selectList("seller.byMemberChartPeriod", map);
			}else {
				endMonth = endMonth == 12 ? 1:endMonth+1;//오라클에서 달로만 계산하려니 마지막달은 1일 00시까지라 그 다음달 1일 00시까지 하고 view단에서 거름.
				map.put("startDate",map.get("startDate").substring(0,7));
				map.put("endDate",map.get("endDate").substring(0,4)+"/"+endMonth);
				logger.debug("시작 날짜 : "+map.get("startDate"));
				logger.debug("끝 날짜 : "+map.get("endDate"));
				resultList = new ArrayList<>();
				resultList = sqlSession.selectList("seller.byMemberChart3Month",map);
			}
			break;
		}
		
		return resultList;
	}

	@Override
	public List<Map<String, String>> totalSaleVolume(Map<String,String> info) {
		List<Map<String,String>> map = sqlSession.selectList("seller.chartOfToday", info);
		logger.debug(map);
		return map;
	}

	@Override
	public Map<String, String> getStoreName(Map<String, String> map) {
		return sqlSession.selectOne("seller.getStoreName", map);
	}

	@Override
	public List<Review> getReview1(String storeNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("seller.getReview1", storeNo);
	}

	@Override
	public List<Review> getReview2(String storeNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("seller.getReview2", storeNo);
	}

	//자동로그인 TEST
	@Override
	public void keepLogin(String sellerId, String sessionId, Date next) throws Exception{
			
			Map<String, Object> paramMap =new HashMap<String, Object>();
			paramMap.put("sellerId", sellerId);
			paramMap.put("sessionId", sessionId);
			paramMap.put("next", next);
			  // Mapper.xml로 데이터를 전달할 때 한 객체밖에 전달 못함으로 map으로 묶어서 보내줌 단... 주의할 점은
	        // Mapper.xml 안에서 #{} 이 안에 지정한 이름이랑 같아야함.. 자동으로 매핑될 수 있도록
	        // 아래가 수행되면서, 사용자 테이블에 세션id와 유효시간이 저장됨
			sqlSession.insert("seller.keepLogin", paramMap);
	}
		

	
	@Override
	public String selectSellerIdByStoreNo(String storeNo) {
		return sqlSession.selectOne("seller.selectSellerIdByStoreNo", storeNo);
	}


	@Override
	public Seller checkUserWithSessionKey(String sessionId){
	        // 유효시간이 남아있고(>now()) 전달받은 세션 id와 일치하는 사용자 정보를 꺼낸다.
		return sqlSession.selectOne("seller.checkUserWithSessionKey", sessionId);
	}

	@Override
	public Seller login(Seller s) {
		return sqlSession.selectOne("seller.login" , s);
	}

	@Override
	public Seller selectSellerBySellerId(String sellerId) {
		return sqlSession.selectOne("seller.selectSellerBySellerId",sellerId);
	}

	@Override
	public int createChatRoom(Map<String, String> chatId) {
		return sqlSession.insert("seller.createChatRoom", chatId);
	}
}
