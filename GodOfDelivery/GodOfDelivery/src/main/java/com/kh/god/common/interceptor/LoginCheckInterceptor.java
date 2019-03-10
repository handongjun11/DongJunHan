package com.kh.god.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.god.member.model.vo.Member;
import com.kh.god.seller.model.vo.Seller;

/**
 *  !! 로그인이 되었고, 당사자여야지 접근가능
 *  /member/memberView.do" 
 *  /member/memberUpdate.do"
 *  요청시 로그인 여부를 검사하고, 로그인 하지 않았다면, common/msg.jsp 에서 경고메세지 출력
 * 
 */
public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	Logger logger = Logger.getLogger(getClass());

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 주소창의 아이디값
		String memberId = request.getParameter("memberId");
		String sellerId = request.getParameter("sellerId");
		String storeNo = request.getParameter("storeNo");
		logger.debug("♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨memberId = " + memberId);
		logger.debug("♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨sellerId = " + sellerId);
		logger.debug("♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨storeNo = " + storeNo);
		

		// 로그인한 사람 값
		HttpSession session = request.getSession();
		Member memberLoggedIn = (Member) session.getAttribute("memberLoggedIn");

		Seller sellerLoggedIn = (Seller) session.getAttribute("sellerLoggedIn");

		// 일반회원이 로그인을 안한 상태거나
		// 다른 아이디로 memberView나 memberUpdate에 접근하거나
		if (memberId != null || sellerId == null) {
			if (sellerLoggedIn == null) {
				if (memberLoggedIn != null) { // 일반 회원으로 로그인은 했지만,

					if (!memberId.equals(memberLoggedIn.getMemberId())) { // 주소와 다른경우
						logger.debug("memberId = " + memberId + " 세션memberId = " + memberLoggedIn.getMemberId());
						request.setAttribute("msg", "올바른 접근이 아닙니다");
						request.setAttribute("loc", "/");
						request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);

						return false;
					}

				} else { // memberLoggedIn == null 로그인도 안한 경우
					request.setAttribute("msg", "로그인 후 진행하세요");
					request.setAttribute("loc", "/");
					request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
					return false;
				}
			}
		} else {

			if (memberLoggedIn == null) {
				if (sellerLoggedIn != null) { // 일반 회원으로 로그인은 했지만,

					if (!sellerId.equals(sellerLoggedIn.getSellerId())) { // 주소와
																			// 다른경우
						logger.debug("sellerId = " + sellerId + " 세션sellerId = " + sellerLoggedIn.getSellerId());
						request.setAttribute("msg", "올바른 접근이 아닙니다");
						request.setAttribute("loc", "/");
						request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);

						return false;
					}

				} else { // memberLoggedIn == null 로그인도 안한 경우
					request.setAttribute("msg", "로그인 후 진행하세요");
					request.setAttribute("loc", "/");
					request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
					return false;
				}
			}
		}
		

		

		return super.preHandle(request, response, handler); // 이 값은 항상 트루
	}

}

