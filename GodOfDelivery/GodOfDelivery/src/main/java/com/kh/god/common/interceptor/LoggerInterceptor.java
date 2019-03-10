package com.kh.god.common.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.god.seller.model.vo.Seller;

public class LoggerInterceptor extends HandlerInterceptorAdapter {

	Logger logger = Logger.getLogger(getClass());

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(logger.isDebugEnabled()) {
			logger.debug("-------------------- Client Request --------------------");
			logger.debug(request.getRequestURI());
			logger.debug("--------------------------------------------------------");
		}
		return super.preHandle(request, response, handler);
	}

	//Controller 메소드 실행 후에 호출되는 메소드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		if(logger.isDebugEnabled()) {
			logger.debug("------------------------- view 단-------------------------");
		}
		
		/*
		 * HttpSession session = request.getSession();
		 * 
		 * ModelMap modelMap = modelAndView.getModelMap(); Seller seller =
		 * (Seller)modelMap.get("userVo");
		 * 
		 * if(seller !=null) { session.setAttribute("LOGIN", seller);
		 * 
		 * if(request.getParameter("userCookie") != null){ Cookie loginCookie = new
		 * Cookie("loginCookie", session.getId()); loginCookie.setPath("/");
		 * loginCookie.setMaxAge(60*60*24*7); response.addCookie(loginCookie); }
		 * 
		 * Object test = session.getAttribute("test"); response.sendRedirect("/");
		 * 
		 * }
		 */
		
		
		//super.postHandle(request, response, handler, modelAndView); 호출안해도되어서 날림
	}

	
	//
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		//돌려보내지면 일루옴...
		
		if(logger.isDebugEnabled()) {
			logger.debug("------------------------- END -------------------------");
		}
		
		super.afterCompletion(request, response, handler, ex);
	}
	
	
	
	
}
