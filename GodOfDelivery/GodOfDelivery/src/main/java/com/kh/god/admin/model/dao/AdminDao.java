package com.kh.god.admin.model.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.kh.god.admin.model.vo.Ad;
import com.kh.god.admin.model.vo.Coupon;
import com.kh.god.admin.model.vo.Event;
import com.kh.god.admin.model.vo.QnaBoard;
import com.kh.god.admin.model.vo.Report;
import com.kh.god.member.model.vo.Review;
import com.kh.god.seller.model.vo.OrderInfo;
import com.kh.god.seller.model.vo.Seller;
import com.kh.god.storeInfo.model.vo.SAttachment;
import com.kh.god.storeInfo.model.vo.StoreInfo;

public interface AdminDao {

	List<Map<String, String>> selectBoardList(int cPage, int numPerPage);

	int countBoardList();

	List<Map<String, String>> selectEventAllList(int cPage, int numPerPage);

	int countEventAllList();
	
	List<Map<String, String>> selectEventIngList(int cPage, int numPerPage);

	int countEventIngList();
	
	List<Map<String, String>> selectEventEndList(int cPage, int numPerPage);

	int countEventEndList();

	int getLastEventNo();

	int insertEvent(Event event);

	QnaBoard qnaBoardView(int boardNo);

	List<Map<String, String>> selectSellerAllList(int cPage, int numPerPage);

	int countSellerList();

	Event eventView(int eventNo);
	
	int changeSellerbFlagtoN(String sellerId);

	int changeSellerbFlagtoY(String sellerId);

	int insertAsking(QnaBoard board);

	List<Map<String, String>> selectQNAList(int cPage, int numPerPage, String boardWriter);

	int countQNAList(String boardWriter);

	List<QnaBoard> boardRefList();

	QnaBoard qnaBoardRefView(int boardNo);

	int countMemberList();

	List<Map<String, String>> selectMemberAllList(int cPage, int numPerPage);

	int deleteEvent(int eventNo);

	List<Map<String, String>> qnaControlList(int cPage, int numPerPage);

	int countQnaControlList();

	QnaBoard qnaAnswer(int boardNo);

	int insertAnswer(QnaBoard answer);

	List<Map<String, String>> selectSellerBL(int cPage, int numPerPage);

	int countSellerBL();

	int countMemberBL();

	List<Map<String, String>> selectMemberBL(int cPage, int numPerPage);

	int changeMemberbFlagtoN(String memberId);

	int changeMemberbFlagtoY(String memberId);

	List<Map<String, String>> selectAdList(int cPage, int numPerPage);

	int countAdList();
	
	List<Map<String, String>> selectAdingList(int cPage, int numPerPage);

	int countAdingList();
	
	List<Map<String, String>> selectAdedList(int cPage, int numPerPage);

	int countAdedList();

	StoreInfo adStoreView(String storeNo);

	Ad adStoreAdView(int adNo);

	int deleteAd(Map<String, String> map);

	int updateEvent(Event event);

	List<Map<String, String>> storePMSList(int cPage, int numPerPage);

	int countStorePMSList();

	List<Map<String, String>> storeList(int cPage, int numPerPage, Map<String, String> map);

	int countStoreList(Map<String, String> map);
	
	List<OrderInfo> timeChart();
	
	List<OrderInfo> chartByMonth(int year);
	
	List<OrderInfo> totalCostByMonthly();
	
	List<Ad> adCostByMonthly();
	
	List<Coupon> couponList(String memberId);
	
	int couponAmount(int eventNo);
	
	List<Map<String, String>> selectEventStoreList(int cPage, int numPerPage);

	int countEventStoreList();
//	---------------------------------------------------------

	StoreInfo storePMSView(String storeNo);

	List<Map<String, String>> storePMSAttaView(String storeNo);

	int storePMSOk(String storeNo);

	int storeReject(Map<String, String> map);

	int storePMSClose(String storeNo);

	int storePMSOpen(String storeNo);

	List<Event> carouselEvent();

	int couponDownload(Coupon coupon);

	List<Integer> chartByCategory();

	List<Integer> chartByWeek(Map<String, String> map);

	List<Integer> chartByCategoryAmount();

	List<Map<String, String>> reportList(int cPage, int numPerPage);

	int countReportList();

	Report reportView(int reportNo);

	Review reviewReportView(int reviewNo);

	int updateReviewReportFlagY(Map<String, String> map);

	int updateReportFlagR(String reportNo);

	StoreInfo storeReportStoreInfoView(String storeNo);

	Seller storeReportSellerView(String sellerId);

	int updateStoreReportFlagY(Map<String, String> map);

}
