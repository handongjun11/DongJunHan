package com.kh.god.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.god.member.model.vo.Member;
import com.kh.god.seller.model.vo.Seller;

/**
 *  !! 로그아웃이 되어야 접근가능
 * 	/member/memberEnroll.do 
 *  /seller/sellerEnroll.do
 *  요청시 로그인 여부를 검사하고, 
 *  이미 로그인 되어있다면, 
 *  common/msg.jsp 에서 경고메세지 출력
 * 
 */
public class LogOutCheckInterceptor extends HandlerInterceptorAdapter {

	Logger logger = Logger.getLogger(getClass());

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		
		Member memberLoggedIn = (Member) session.getAttribute("memberLoggedIn");
		Seller sellerLoggedIn = (Seller)session.getAttribute("sellerLoggedIn"); 

		String memberId = request.getParameter("memberId");
		
		//회원이 로그인 한 상태로 memberEnroll 이나 sellerEnroll 접근시 
		if(memberLoggedIn != null || sellerLoggedIn != null){ 
			
			request.setAttribute("msg", "올바른 접근이 아닙니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);				
		
			return false; 
		}
		

		
		
		return super.preHandle(request, response, handler); // 이 값은 항상 트루
	}

}

