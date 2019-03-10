package com.kh.god.common.aop;

import java.util.Map;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.kh.god.member.model.vo.Member;
import com.kh.god.seller.model.vo.Seller;

@Component
@Aspect
public class LoginLoggerAdvice {
	
	Logger logger = Logger.getLogger(getClass());
					
	@AfterReturning(pointcut = "execution(* com.kh.god.member..*Controller.*Login(..))", //MemberLogin()메소드가 잡힐 예정.. 
					returning = "returnObj") //pointcut 과 returning 속성 두개를 전달
	public void advice(JoinPoint joinPoint, Object returnObj) {
	
		ModelAndView mav = (ModelAndView) returnObj;
		Map<String,Object> map = mav.getModel();

		if(map.containsKey("memberLoggedIn")) {
			Member m = (Member) map.get("memberLoggedIn");			
			logger.info("["+m.getMemberId()+"] 로그인");			
		}
	}
	
//	@AfterReturning(pointcut = "execution(* com.kh.god.seller..*Controller.*Login(..))" , returning="returnObj")
//	public void advice2(JoinPoint joinPoint , Object returnObj) {
//		ModelAndView mav = (ModelAndView)returnObj;
//		Map<String,Object> map = mav.getModel();
//		//로그인에 성공했다면 , 여기 이 모델에 memberLoggedIn이 담겨있다. 
//		if(map.containsKey("sellerLoggedIn")) {
//			//있다면
//			Seller s = (Seller)map.get("sellerLoggedIn");
//			logger.info("["+s.getSellerId()+"]이 로그인함.");
//		}
//	}
	
}
