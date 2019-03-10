package com.kh.god.admin.model.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

@Repository
public class AdminDaoImpl implements AdminDao {
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, String>> selectBoardList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectBoardList",null,rowBounds);
	}

	@Override
	public int countBoardList() {
		return sqlSession.selectOne("admin.countBoardList");
	}

	@Override
	public List<Map<String, String>> selectEventAllList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectEventAllList",null,rowBounds);
	}

	@Override
	public int countEventAllList() {
		return sqlSession.selectOne("admin.countEventAllList");
	}
	
	@Override
	public List<Map<String, String>> selectEventIngList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectEventIngList",null,rowBounds);
	}

	@Override
	public int countEventIngList() {
		return sqlSession.selectOne("admin.countEventIngList");
	}
	
	@Override
	public List<Map<String, String>> selectEventEndList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectEventEndList",null,rowBounds);
	}

	@Override
	public int countEventEndList() {
		return sqlSession.selectOne("admin.countEventEndList");
	}

	@Override
	public int getLastEventNo() {
		return sqlSession.selectOne("admin.getLastEventNo");
	}

	@Override
	public int insertEvent(Event event) {
		return sqlSession.insert("admin.insertEvent",event);
	}

	@Override
	public QnaBoard qnaBoardView(int boardNo) {
		return sqlSession.selectOne("admin.qnaBoardView",boardNo);
	}

	@Override
	public List<Map<String, String>> selectSellerAllList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectSellerAllList",null,rowBounds);
	}

	@Override
	public int countSellerList() {
		return sqlSession.selectOne("admin.countSellerList");
	}

	@Override
	public Event eventView(int eventNo) {
		return sqlSession.selectOne("admin.eventView", eventNo);
	}
	
	public int changeSellerbFlagtoN(String sellerId) {
		return sqlSession.update("admin.changeSellerbFlagtoN",sellerId);
	}

	@Override
	public int changeSellerbFlagtoY(String sellerId) {
		return sqlSession.update("admin.changeSellerbFlagtoY",sellerId);
	}

	@Override
	public int insertAsking(QnaBoard board) {
		return sqlSession.insert("admin.insertAsking",board);
	}

	@Override
	public List<Map<String, String>> selectQNAList(int cPage, int numPerPage, String boardWriter) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectQNAList",boardWriter,rowBounds);
	}

	@Override
	public int countQNAList(String boardWriter) {
		return sqlSession.selectOne("admin.countQNAList",boardWriter);
	}

	@Override
	public List<QnaBoard> boardRefList() {
		return sqlSession.selectList("admin.boardRefList");
	}

	@Override
	public QnaBoard qnaBoardRefView(int boardNo) {
		return sqlSession.selectOne("admin.qnaBoardRefView",boardNo);
	}

	@Override
	public int countMemberList() {
		return sqlSession.selectOne("admin.countMemberList");
	}

	@Override
	public List<Map<String, String>> selectMemberAllList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectMemberAllList",null,rowBounds);
	}

	@Override
	public int deleteEvent(int eventNo) {
		return sqlSession.delete("admin.deleteEvent", eventNo);
	}

	@Override

	public List<Map<String, String>> qnaControlList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.qnaControlList",null,rowBounds);
	}

	@Override
	public int countQnaControlList() {
		return sqlSession.selectOne("admin.countQnaControlList");
	}

	@Override
	public QnaBoard qnaAnswer(int boardNo) {
		return sqlSession.selectOne("admin.qnaAnswer",boardNo);
	}

	@Override
	public int insertAnswer(QnaBoard answer) {
		return sqlSession.insert("admin.insertAnswer",answer);
	}

	@Override
	public List<Map<String, String>> selectSellerBL(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectSellerBL",null,rowBounds);
	}

	@Override
	public int countSellerBL() {
		return sqlSession.selectOne("admin.countSellerBL");
	}

	@Override
	public int countMemberBL() {
		return sqlSession.selectOne("admin.countMemberBL");
	}

	@Override
	public List<Map<String, String>> selectMemberBL(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectMemberBL",null,rowBounds);
	}

	@Override
	public int changeMemberbFlagtoN(String memberId) {
		return sqlSession.update("admin.changeMemberbFlagtoN",memberId);
	}

	@Override
	public int changeMemberbFlagtoY(String memberId) {
		return sqlSession.update("admin.changeMemberbFlagtoY",memberId);
	}

	@Override
	public List<Map<String, String>> selectAdList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectAdList",null,rowBounds);
	}

	@Override
	public int countAdList() {
		return sqlSession.selectOne("admin.countAdList");
	}
	
	@Override
	public List<Map<String, String>> selectAdingList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectAdingList",null,rowBounds);
	}

	@Override
	public int countAdingList() {
		return sqlSession.selectOne("admin.countAdingList");
	}
	
	@Override
	public List<Map<String, String>> selectAdedList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectAdedList",null,rowBounds);
	}

	@Override
	public int countAdedList() {
		return sqlSession.selectOne("admin.countAdedList");
	}

	@Override
	public StoreInfo adStoreView(String storeNo) {
		return sqlSession.selectOne("admin.adStoreView",storeNo);
	}

	@Override
	public Ad adStoreAdView(int adNo) {
		return sqlSession.selectOne("admin.adStoreAdView",adNo);
	}

	@Override
	public int deleteAd(Map<String, String> map) {
		return sqlSession.update("admin.deleteAd",map);
	}

	public int updateEvent(Event event) {
		return sqlSession.update("admin.updateEvent", event);
	}

	public List<Map<String, String>> storePMSList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectStorePMSList", null, rowBounds);
	}

	@Override
	public int countStorePMSList() {
		return sqlSession.selectOne("admin.countStorePMSList");
	}

	@Override
	public List<Map<String, String>> storeList(int cPage, int numPerPage, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectStoreList", map, rowBounds);
	}

	@Override
	public int countStoreList(Map<String, String> map) {
		return sqlSession.selectOne("admin.countStoreList", map);

	}
	
	@Override
	public int couponDownload(Coupon coupon) {
		return sqlSession.insert("admin.couponDownload",coupon);
	}
	
	@Override
	public int couponAmount(int eventNo) {
		return sqlSession.update("admin.couponAmount",eventNo);
	}
	
	@Override
	public List<OrderInfo> timeChart() {
		return sqlSession.selectList("admin.timeChart");
	}
	
	@Override
	public List<OrderInfo> chartByMonth(int year) {
		return sqlSession.selectList("admin.chartByMonth",year);
	}
	
	@Override
	public List<OrderInfo> totalCostByMonthly() {
		return sqlSession.selectList("admin.totalCostByMonthly");
	}
	
	@Override
	public List<Ad> adCostByMonthly() {
		return sqlSession.selectList("admin.adCostByMonthly");
	}
	
	@Override
	public List<Coupon> couponList(String memberId) {
		return sqlSession.selectList("admin.couponList",memberId);
	}
	
	@Override
	public List<Map<String, String>> selectEventStoreList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectEventStoreList",null,rowBounds);
	}

	@Override
	public int countEventStoreList() {
		return sqlSession.selectOne("admin.countEventStoreList");
	}
	
//	---------------------------------------------------------

	@Override
	public StoreInfo storePMSView(String storeNo) {
		return sqlSession.selectOne("admin.storePMSView", storeNo);
	}

	@Override
	public List<Map<String, String>> storePMSAttaView(String storeNo) {
		return sqlSession.selectList("admin.storePMSAttaView", storeNo);
	}

	@Override
	public int storePMSOk(String storeNo) {
		return sqlSession.update("admin.storePMSOk", storeNo);
	}

	@Override
	public int storeReject(Map<String, String> map) {
		return sqlSession.update("admin.storePMSReject", map);
	}
	
	@Override
	public int storePMSClose(String storeNo) {
		return sqlSession.update("admin.storePMSClose", storeNo);
	}

	@Override
	public int storePMSOpen(String storeNo) {
		return sqlSession.update("admin.storePMSOpen", storeNo);
	}

	@Override
	public List<Event> carouselEvent() {
		return sqlSession.selectList("admin.carouselEvent");
	}

	@Override
	public List<Integer> chartByCategory() {
		return sqlSession.selectList("admin.chartByCategory");
	}

	@Override
	public List<Integer> chartByWeek(Map<String, String> map) {
		return sqlSession.selectList("admin.chartByWeek", map);
	}

	@Override
	public List<Integer> chartByCategoryAmount() {
		return sqlSession.selectList("admin.chartByCategoryAmount");
	}

	@Override
	public List<Map<String, String>> reportList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("admin.selectReportList",null,rowBounds);
	}

	@Override
	public int countReportList() {
		return sqlSession.selectOne("admin.countReportList");
	}

	@Override
	public Report reportView(int reportNo) {
		return sqlSession.selectOne("admin.reportView", reportNo);
	}

	@Override
	public Review reviewReportView(int reviewNo) {
		return sqlSession.selectOne("admin.reviewReportView", reviewNo);
	}

	@Override
	public int updateReviewReportFlagY(Map<String, String> map) {
		return sqlSession.update("admin.updateReviewReportFlagY", map);
	}

	@Override
	public int updateReportFlagR(String reportNo) {
		return sqlSession.update("admin.updateReportFlagR", reportNo);
	}

	@Override
	public StoreInfo storeReportStoreInfoView(String storeNo) {
		return sqlSession.selectOne("admin.storeReportStoreInfoView", storeNo);
	}

	@Override
	public Seller storeReportSellerView(String sellerId) {
		return sqlSession.selectOne("admin.storeReportSellerView", sellerId);
	}

	@Override
	public int updateStoreReportFlagY(Map<String, String> map) {
		return sqlSession.update("admin.updateStoreReportFlagY", map);
	}
}
