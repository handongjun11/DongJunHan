package com.kh.god.event.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.god.admin.model.vo.Event;
import com.kh.god.event.model.dao.EventDao;

@Service
public class EventServiceImpl implements EventService {

	@Autowired
	EventDao eventDao;

	@Override
	public Event eventView(int eventNo) {
		return eventDao.eventView(eventNo);
	}
	
}
