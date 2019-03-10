package com.kh.god.storeInfo.model.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.god.admin.model.vo.Report;
import com.kh.god.member.model.vo.Review;
import com.kh.god.storeInfo.exception.StoreInfoException;
import com.kh.god.storeInfo.model.dao.StoreInfoDao;
import com.kh.god.storeInfo.model.vo.SAttachment;
import com.kh.god.storeInfo.model.vo.StoreInfo;

@Service
public class StoreInfoServiceImpl implements StoreInfoService {
	
	Logger logger = Logger.getLogger(getClass());
	
	@Autowired
	StoreInfoDao storeInfoDao;

	@Override
	public List<Map<String, String>> selectStoreInfoList(int cPage, int numPerPage, int categoryNo) {
		return storeInfoDao.selectStoreInfoList(cPage, numPerPage, categoryNo);
	}

	@Override
	public int selectStoreInfoTotalContents(int categoryNo) {
		return storeInfoDao.selectStoreInfoTotalContents(categoryNo);
	}

	@Override
	public int addStore(StoreInfo s, List<SAttachment> attachList) {
		int result = 0 ;
		String storeNo = "" ;
		
		result = storeInfoDao.addStore(s);
		storeNo = s.getStoreNo();
		logger.debug("사업자번호호호호호호호호호호혹"+storeNo);
		
		if(result == 0 ) {
			throw new StoreInfoException("사업장 등록 오류!");
		}
		
		if(attachList.size() > 0) {
			for(SAttachment a : attachList) {
				a.setStoreNo(storeNo);
				result = storeInfoDao.insertAttachment(a);
				if(result == 0) {
					throw new StoreInfoException("첨부파일 등록 오류!");
				}				
			}
		}
		
		
		return result;
		
	}

	@Override
	public StoreInfo selectOnebyStoreNo(String storeNo) {
		return storeInfoDao.selectOnebyStoreNo(storeNo);
	}

	@Override
	public List<Map<String, String>> selectAttchMentLsit(String storeNo) {
		return storeInfoDao.selectAttchMentLsit(storeNo);
	}

	@Override
	public int deleteFile1(String filename) {
		return storeInfoDao.deleteFile1(filename);
	}

	@Override
	public int updateStore(StoreInfo s, List<SAttachment> attachList) {
		int result = 0 ;
		String storeNo = "" ;
		
		result = storeInfoDao.updateStore(s);
		storeNo = s.getStoreNo();
		logger.debug("사업자번호호호호호호호호호호혹"+storeNo);
		
		if(result == 0 ) {
			throw new StoreInfoException("사업장 등록 오류!");
		}
		
		if(attachList.size() > 0) {
			for(SAttachment a : attachList) {
				a.setStoreNo(storeNo);
				result = storeInfoDao.insertAttachment(a);
				if(result == 0) {
					throw new StoreInfoException("첨부파일 등록 오류!");
				}
				
			}
		
	}
		return result;
	}

	@Override
	public int closedStore(String storeNo) {
		return storeInfoDao.closedStore(storeNo);
	}

	@Override
	public List<Review> reviewList(String storeNo) {
		return storeInfoDao.reviewList(storeNo);
	}

	@Override
	public int insertReport(Report r) {
		return storeInfoDao.insertReport(r);
	}
	
	
}