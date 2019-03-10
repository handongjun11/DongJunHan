package com.kh.god.event.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.god.admin.model.vo.Event;
import com.kh.god.event.model.service.EventService;

@Controller
public class EventController {
	
	Logger logger = Logger.getLogger(getClass());
	
	@Autowired
	EventService eventService;
	
	@RequestMapping("event/eventView.do")
	public String eventView(@RequestParam int eventNo, Model model) {
		Event e = eventService.eventView(eventNo);
		model.addAttribute("event", e);
		return "event/eventView";
	}
	
	
}
