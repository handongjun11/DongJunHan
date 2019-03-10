package com.kh.god.storeInfo.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.god.admin.model.vo.Report;
import com.kh.god.member.model.vo.Review;
import com.kh.god.storeInfo.model.vo.SAttachment;
import com.kh.god.storeInfo.model.vo.StoreInfo;

@Repository
public class StoreInfoDaoImpl implements StoreInfoDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<Map<String, String>> selectStoreInfoList(int cPage, int numPerPage, int categoryNo) {
		RowBounds rowBounds = new RowBounds((cPage-1) * numPerPage, numPerPage);
		return sqlSession.selectList("storeInfo.selectStoreInfoList", categoryNo, rowBounds);
	}

	@Override
	public int selectStoreInfoTotalContents(int categoryNo) {
		return sqlSession.selectOne("storeInfo.selectStoreInfoTotalContents", categoryNo);
	}

	@Override
	public int addStore(StoreInfo s) {
		return sqlSession.insert("storeInfo.addStore" , s);
	}

	@Override
	public int insertAttachment(SAttachment a ) {
		return sqlSession.insert("storeInfo.insertAttachment" , a );
	}

	@Override
	public StoreInfo selectOnebyStoreNo(String storeNo) {
		return sqlSession.selectOne("storeInfo.selectOnebyStoreNo" , storeNo);
	}

	@Override
	public List<Map<String, String>> selectAttchMentLsit(String storeNo) {
		return sqlSession.selectList("storeInfo.selectAttchMentLsit" , storeNo);
	}

	@Override
	public int deleteFile1(String filename) {
		return sqlSession.update("storeInfo.deleteFile1" , filename);
	}

	@Override
	public int updateStore(StoreInfo s) {
		return sqlSession.update("storeInfo.updateStore" , s);
	}

	@Override
	public int closedStore(String storeNo) {
		return sqlSession.update("storeInfo.closedStore", storeNo);
	}

	@Override
	public List<Review> reviewList(String storeNo) {
		List<Review> reviewList = sqlSession.selectList("storeInfo.reviewList",storeNo);
		return reviewList;
	}

	@Override
	public int insertReport(Report r) {
		return sqlSession.insert("storeInfo.insertReport" , r);
	}


	

	

}
