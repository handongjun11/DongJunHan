package com.kh.god.common.interceptor;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.util.WebUtils;

import com.kh.god.common.websocket.WebSocketHandler;
import com.kh.god.seller.controller.SellerController;
import com.kh.god.seller.model.service.SellerService;
import com.kh.god.seller.model.vo.Seller;


/**
 *  !! 로그인이 되었고, 당사자여야지 접근가능
 *  /seller/sellerView.do
	seller/sellerUpdate.do
 *  요청시 로그인 여부를 검사하고, 로그인 하지 않았다면, common/msg.jsp 에서 경고메세지 출력
 * 
 */


public class SellerLoginCheckInterceptor extends HandlerInterceptorAdapter {

	Logger logger = Logger.getLogger(getClass());
	
	@Inject
	private SellerService sellerService;
	//private Map<String,WebSocketSession> memberSession;
	private Map<String,String> loginSession;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
//		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@333333333333333333kdfkldaklfdsdflj;al;fsdak333333");
		
		// 로그인한 사람 값
//		HttpSession sessions = request.getSession();		
//		Seller sellerLoggedIn = (Seller)sessions.getAttribute("sellerLoggedIn"); 

//		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@333333333333333333333333");
		//session객체를 가져옴
		HttpSession session = request.getSession();
		//login 처리를 담당하는 사용자 저보를 담고 있는 객체를 가져옴
		Object obj = session.getAttribute("sellerLoggedIn");
//		logger.debug("alkdfkaj!@!E!@$!#$"+obj);
		
		if(obj == null) { //로그인된 세션이 없는경우 
			//우리가 만들어 논 쿠키를 꺼내온다. 
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if(loginCookie != null) {
				logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@akjdfjaodjfijaidf"+loginCookie.getValue());
			}
			if(loginCookie != null) { //쿠키가 존재하는 경우(이전에 로그인될때 생성된 쿠키가 존재한다는 것.)
				loginSession = SellerController.getInstance().getLoginSession();
				//loginCookie의 값을 꺼내오고 -> 즉 , 저장해논 세션 ID를 꺼내오고
				String sessionId = loginCookie.getValue();
				 // 세션Id를 checkUserWithSessionKey에 전달해 이전에 로그인한적이 있는지 체크하는 메서드를 거쳐서
                // 유효시간이 > now() 인 즉 아직 유효시간이 지나지 않으면서 해당 sessionId 정보를 가지고 있는 사용자 정보를 반환한다.
                Seller userVO = sellerService.checkUserWithSessionKey(sessionId);
               // logger.debug("null아님");
             //  logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@44444444444444444444444444"+userVO);
                if(userVO != null) { //그런 사용자가 있다면
                	//로그인 되어있는 중복사용자 막기위함.
                	String sellerId = userVO.getSellerId();
                	Set<String> keyValue = loginSession.keySet();
                	logger.debug("keyValue : "+keyValue);
                	Iterator<String> iterator = keyValue.iterator();
                	while(iterator.hasNext()) {
                		String loginId = iterator.next();
//					logger.debug("로그인 되어있는 아이디!"+ loginId);
                		if(sellerId.equals(loginId)) {
                			response.sendRedirect("/god/seller/askDuplicationLogin.do?sellerId="+userVO.getSellerId());
                			return false;
                		}
                	}
                	
                	//웹소켓에서 쓰기위한것.
                	session.setAttribute("loginId",userVO.getSellerId());
                	//세션을 생성 시켜 준다. 
                	session.setAttribute("login", userVO);
                	session.setAttribute("sellerLoggedIn", userVO);
//                	System.out.println("@@@@@@@@@@@@@@@@@@"+userVO);
//                	logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@5555555555555555555555555");
            		return true;
                }
			}
			
			//이제 아래는 로그인이 안되잇고 쿠키고 존재하지 않는 경우니까 다시 폼으로 돌려보내면 된다. 
			//로그인이 안되어 잇는 상태임으로 로그인 폼으로 다시 돌려 보냄. (redirect)
			//response.sendRedirect("/spring");
			//return false; //더이상 컨트롤러 요청으로 가지 않도록  false로 반환함.
			
		}
//		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@66666666666666666666666");
		//prehandler의 return은 컨트롤러 요청으로 uri로 가도 되냐 안되냐를 허가하는 의미임.
		//따라서 true로하면 컨트롤러 uri로 가게됨.
		return true;
	}

	
	 // 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
//   @Override
//   public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//           ModelAndView modelAndView) throws Exception {
//	   
//	   HttpSession session = request.getSession();
//		//login 처리를 담당하는 사용자 저보를 담고 있는 객체를 가져옴
//		Object obj = session.getAttribute("sellerLoggedIn");
//       // TODO Auto-generated method stub
//       super.postHandle(request, response, handler, modelAndView);
//   }
}
