package com.kh.god.member.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.god.member.model.vo.Member;
import com.kh.god.member.model.vo.RAttachment;
import com.kh.god.member.model.vo.Review;
import com.kh.god.member.model.vo.WebReview;
import com.kh.god.seller.model.vo.OrderInfo;
import com.kh.god.seller.model.vo.Seller;
import com.kh.god.storeInfo.model.vo.StoreInfo;

public interface MemberDao {

	int insertMember(Member m);

	Member selectOneMember(String memberId);

	int updateMember(Member m);

	int deleteMember(String memberId);

	int checkBookMark(Map<String, String> map);

	List<Map<String, Object>> couponListBymemberId(Map<String, Object> map);

	double getDiscount(String eventNo);

	int insertBookMark(Map<String, String> map);

	int deleteBookMark(Map<String, String> map);

	List<StoreInfo> bookMarkList(String memberId);

	List<Map<String, String>> orderList(String memberId);

	int insertMemberReview(Review review);

	Review selectOneReview(int orderNo);

	int insertRAttachment(RAttachment a);

	Member findId(String email);

	Seller sellerfindId(String email);

	List<Review> reviewList(String memberId);

	List<RAttachment> selectRAttachmentList(int reviewNo);

	Seller selectOneSeller(String id);

	int updateFindPwd(Seller s);

	int updateMemberFindPwd(Member m);

	List<Map<String, String>> selectOrderMenuList(String orderNo);

	int deleteMemberReview(String reviewNo);

	List<StoreInfo> selectAllstoreInfo();

	RAttachment selectOneRattachment(int reviewNo);

	int insertWebReview(WebReview wr);

	List<WebReview> selectListWebReiveiw(int cPage, int numPerPage);

	int selectWebReiveiwTotalContents();


}
