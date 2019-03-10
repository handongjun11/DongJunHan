package com.kh.god.storeInfo.model.service;

import java.util.List;
import java.util.Map;

import com.kh.god.admin.model.vo.Report;
import com.kh.god.member.model.vo.Review;
import com.kh.god.storeInfo.model.vo.SAttachment;
import com.kh.god.storeInfo.model.vo.StoreInfo;

public interface StoreInfoService {

	int selectStoreInfoTotalContents(int categoryNo);

	List<Map<String, String>> selectStoreInfoList(int cPage, int numPerPage, int categoryNo);

	int addStore(StoreInfo s, List<SAttachment> attachList);

	StoreInfo selectOnebyStoreNo(String storeNo);

	List<Map<String, String>> selectAttchMentLsit(String storeNo);

	int deleteFile1(String filename);

	int updateStore(StoreInfo s, List<SAttachment> attachList);

	int closedStore(String storeNo);

	List<Review> reviewList(String storeNo);

	int insertReport(Report r);

	

}
