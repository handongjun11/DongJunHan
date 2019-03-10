package com.kh.god.common.aop;


import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;
import org.springframework.util.StopWatch.TaskInfo;


/**
 * web.xml 
 * aspect-context.xml
 * 에서 하던걸
 * annotation 을 선언하여 클래스 안에서 바로 설정할 수 잇음
 *
 */

@Component // 빈으로 자동 등록
@Aspect //aspect으로 자동 등록 
public class LoggerAspect2 {

	 Logger logger = Logger.getLogger(getClass());
	 
	 @Pointcut("execution(* com.kh.god.memo..*(..))") 
	 public void pointCutForAll() {}
	 
	 
	 @Around("pointCutForAll()") //위에서 선언한 Pointcut의 메소드 명을 안에 언급
	 public Object loggerAdvice(ProceedingJoinPoint joinPoint) throws Throwable{

		 Signature signature = joinPoint.getSignature();	 
		 String type = signature.getDeclaringTypeName(); //클래스를 가져온다
		 String methodName = signature.getName();

		 String comp = "";
		 if(type.indexOf("Controller") > -1 ) {
			 comp = "Controller \t: ";
		 }else if(type.indexOf("Service") > -1 ) {
			 comp = "Service \t: ";
		 }else if(type.indexOf("Dao") > -1 ) {
			 comp = "Dao \t: ";
		 }
		 
		 logger.debug("[Before]"+comp+type+"."+methodName+"()"); 	 
		 
		 Object obj = joinPoint.proceed();
		 
		 logger.debug("[After]"+comp+type+"."+methodName+"()"); 
		 

		 return obj;
	 }
	 
}
