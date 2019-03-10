package com.kh.god.menu.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.god.member.model.service.MemberService;
import com.kh.god.member.model.vo.Member;
import com.kh.god.member.model.vo.RAttachment;
import com.kh.god.member.model.vo.Review;
import com.kh.god.menu.model.service.MenuService;
import com.kh.god.menu.model.vo.Menu;
import com.kh.god.storeInfo.model.service.StoreInfoService;
import com.kh.god.storeInfo.model.vo.StoreInfo;

@Controller
public class MenuController {

	Logger logger = Logger.getLogger(getClass());

	@Autowired
	MenuService menuService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	StoreInfoService storeInfoService;

	@RequestMapping("/menu/menuList.do")
	public String menuList(@RequestParam(value = "storeNo") String storeNo, 
							Model model, HttpSession session) {
		
		/*
		 * /menu/menuList.do?storeNo=${list.storeNo }"
		 */		
		 Member memberLoggedIn = null;
		 memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		
		if(logger.isDebugEnabled()) {
			logger.debug("매장 메뉴 페이지");
		}
		
		List<Menu> menuList = menuService.menuList(storeNo);
		List<StoreInfo> storeInfo = menuService.storeInfoList(storeNo);		
		int menuTotalCount = menuService.menuCount(storeNo);
		
		//1. 리뷰리스트를 꺼내고
		List<Review> reviewList = storeInfoService.reviewList(storeNo);
		
		//2. 리뷰 첨부파일을 담을 리스트를 선언한다. 
		List<RAttachment> attachList = new ArrayList<>();
		
		if(reviewList != null) {			
			//리스트를 돌면서 reviewNo가 일치하는 첨부파일을 꺼내서 리스트에 담는다
			for(Review r : reviewList) {	
				
				List<RAttachment> tempList = memberService.selectRAttachmentList(r.getReviewNo());			
				for(RAttachment ra : tempList) {
					attachList.add(ra);
				}
				
			}			
		}
		
		
		int checkedBookMark = 0;
		
		if( memberLoggedIn != null) {
			Map<String, String> map = new HashMap<>();
			map.put("memberId", memberLoggedIn.getMemberId());
			map.put("storeNo", storeNo);
			checkedBookMark = memberService.checkBookMark(map);			
		}	
		
		model.addAttribute("menuTotalCount",menuTotalCount);
		model.addAttribute("menuList",menuList);
		model.addAttribute("storeInfo",storeInfo);
		
		model.addAttribute("reviewList",reviewList);//매장 후기리스트
		model.addAttribute("attachList", attachList); // 후기 첨부파일 리스트
		
		logger.debug(attachList);
		
		model.addAttribute("checkedBookMark",checkedBookMark); //북마크여부
		
		
		return "storeInfo/MenuListByStore";	
	}
	
	
	@RequestMapping("/menu/selecOneMenu.do")
	@ResponseBody
	public Menu selectOneMenu(@RequestParam String menuCode) {
		Menu menu = null;
		
		menu = menuService.selectOneMenu(menuCode);
		logger.debug("Menu = " + menu);
		
		
		return menu;
	}
	
	
	
	

}
