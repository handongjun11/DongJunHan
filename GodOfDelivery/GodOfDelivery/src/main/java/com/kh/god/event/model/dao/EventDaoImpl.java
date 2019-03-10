package com.kh.god.event.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.god.admin.model.vo.Event;

@Repository
public class EventDaoImpl implements EventDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public Event eventView(int eventNo) {
		return sqlSession.selectOne("event.eventView", eventNo);
	}
	
}
