package com.kh.god.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

/**
 * @실습문제: inserMemo메소드의 실행시간을 구하시오.
 * 
 *
 */
@Component
@Aspect
public class AroundAdviceAspect {
	Logger logger = LoggerFactory.getLogger(AroundAdviceAspect.class);
	
	@Pointcut("execution(* com.kh.god.memo..*Controller.insert*(..))")
	private void pointcut(){}
	
	@Around("pointcut()")
	public Object aroundAdvice(ProceedingJoinPoint joinPoint) throws Throwable{
		String methodName = joinPoint.getSignature().getName();
		
		//org.springframework.util.StopWatch
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();
		
		//Object org.aspectj.lang.ProceedingJoinPoint.proceed() throws Throwable
		Object obj = joinPoint.proceed();
		
		stopWatch.stop();
		logger.debug(methodName + "() 소요시간 : " + stopWatch.getTotalTimeMillis() + "(ms)초");
		
		return obj;
	}
}
