package com.kh.god.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.god.member.model.dao.MemberDao;
import com.kh.god.member.model.vo.Member;
import com.kh.god.member.model.vo.RAttachment;
import com.kh.god.member.model.vo.Review;
import com.kh.god.member.model.vo.WebReview;
import com.kh.god.seller.model.vo.OrderInfo;
import com.kh.god.seller.model.vo.Seller;
import com.kh.god.storeInfo.model.vo.StoreInfo;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao memberDao;
		
	
	@Override
	public int insertMember(Member m) {
		return memberDao.insertMember(m);
	}


	@Override
	public Member selectOneMember(String memberId) {
		return memberDao.selectOneMember(memberId);
	}


	@Override
	public int updateMember(Member m) {
		return memberDao.updateMember(m);
	}


	@Override
	public int deleteMember(String memberId) {
		return memberDao.deleteMember(memberId);
	}


	@Override
	public int checkBookMark(Map<String, String> map) {		
		return memberDao.checkBookMark(map);
	}

	public int insertBookMark(Map<String, String> map) {
		return memberDao.insertBookMark(map);
	}


	@Override
	public double getDiscount(String eventNo) {
		return memberDao.getDiscount(eventNo);
	}
	
	public int deleteBookMark(Map<String, String> map) {
		return memberDao.deleteBookMark(map);
	}


	@Override
	public List<StoreInfo> bookMarkList(String memberId) {
		return memberDao.bookMarkList(memberId);
	}


	@Override
	public List<Map<String, String>> orderList(String memberId) {
		return memberDao.orderList(memberId);
	}


	@Override
	public int insertMemberReview(Review review) {	
		return memberDao.insertMemberReview(review);
	}

	
	@Override
	public Review selectOneReview(int orderNo) {
		return memberDao.selectOneReview(orderNo);
	}


	@Override
	public int insertRAttachment(RAttachment a) {
		return memberDao.insertRAttachment(a);
	}


	@Override
	public Member findId(String email) {
		return memberDao.findId(email);
	}

	public List<Review> reviewList(String memberId) {
		return memberDao.reviewList(memberId);
	}


	@Override
	public Seller sellerfindId(String email) {
		return memberDao.sellerfindId(email);	
	}

	@Override
	public List<RAttachment> selectRAttachmentList(int reviewNo) {
		return memberDao.selectRAttachmentList(reviewNo);
	}

	@Override
	public RAttachment selectOneRattachment(int reviewNo) {
		return memberDao.selectOneRattachment(reviewNo);
	}


	@Override
	public Seller selectOneSeller(String id) {
		return memberDao.selectOneSeller(id);
	}
	
	@Override
	public List<Map<String, String>> selectOrderMenuList(String orderNo) {
		return memberDao.selectOrderMenuList(orderNo);
	}


	@Override
	public int updateFindPwd(Seller s) {
		return memberDao.updateFindPwd(s);
	}


	@Override
	public int updateMemberFindPwd(Member m) {
		return memberDao.updateMemberFindPwd(m);
	}
	
	@Override
	public int deleteMemberReview(String reviewNo) {
		return memberDao.deleteMemberReview(reviewNo);
	}


	@Override
	public List<StoreInfo> selectAllstoreInfo() {
		
		return memberDao.selectAllstoreInfo();
	}

	@Override
	public List<Map<String, Object>> couponListBymemberId(Map<String, Object> map) {
		return memberDao.couponListBymemberId(map);
	}


	@Override
	public int insertWebReview(WebReview wr) {
		return memberDao.insertWebReview(wr);
	}


	@Override
	public List<WebReview> selectListWebReiveiw(int cPage, int numPerPage) {
		return memberDao.selectListWebReiveiw(cPage , numPerPage);
	}


	@Override
	public int selectWebReiveiwTotalContents() {
		return memberDao.selectWebReiveiwTotalContents();
	}






}
