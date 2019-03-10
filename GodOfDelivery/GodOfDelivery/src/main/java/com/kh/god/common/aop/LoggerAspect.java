package com.kh.god.common.aop;


import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;

public class LoggerAspect {

	 Logger logger = Logger.getLogger(getClass());
	
	
	 /**
	  * Around Advice : 주요 업무 앞뒤에서 실행되는 애 
	  * joinPoint를 인자로 받아서  
	  * joinPoint.proceed() 를 리턴
	  * 
	  * handler 메소드 호출하기 직전
	  * 
	  * [before]
	  * controller 메소드 실행되기 전
	  * service 메소드 실행되기 전
	  * dao 메소드 실행되기 전
	  * 
	  * [after]
	  * dao 리턴 되고 나서 
	  * service 리턴되고 나서
	  * controller 리턴되고 나서
	  * 
	  * 
	  */
	 
	 public Object loggerAdvice(ProceedingJoinPoint joinPoint) throws Throwable{
		//시그니쳐 가져오기 : 실제 실행될 메소드의 클래스를 담고 있음
		 Signature signature = joinPoint.getSignature();
		 //logger.debug("signature = "+signature);
		 //signature = ModelAndView com.kh.spring.memo.controller.MemoController.memo(ModelAndView)
		 
		 String type = signature.getDeclaringTypeName(); //클래스를 가져온다
		 String methodName = signature.getName();
		 
		 //logger.debug("type = "+type); 
		 //type = com.kh.spring.memo.controller.MemoController
		 //logger.debug("methodName = "+methodName);
		 //methodName = memo
		 
		 String comp = "";
		 if(type.indexOf("Controller") > -1 ) { //type.indexOf("Controller") 클래스명에 Controller 가 들어가니 (-1 보다 크다 : 들어간다) 
			 comp = "Controller \t: ";
		 }else if(type.indexOf("Service") > -1 ) {
			 comp = "Service \t: ";
		 }else if(type.indexOf("Dao") > -1 ) {
			 comp = "Dao \t: ";
		 }
		 
		 logger.debug("[Before]"+comp+type+"."+methodName+"()"); // controller > service > dao 순으로 찍힘 	 
		 
		 Object obj = joinPoint.proceed();
		 
		 logger.debug("[After]"+comp+type+"."+methodName+"()"); // dao > service > controller 순으로 찍힘(역순)
		 
		 return obj;
	 }
	 
}
