package com.kh.god.log4j;

import org.apache.log4j.Logger;

/**
* %c : 카테고리명(logger이름)을 표시
	* 카테고리명이 a.b.c일때, %c{2}는 b.c를 출력
* %C : 클래스명을 표시함.	
	* 풀 클래스 명이 com.kh.logger일때, %C{2}는 kh.logger를 출력
* %d : 로그 시간을 출력한다. java.text.SimpleDateFormat에서 적절한 출력 포맷을 지정할 수 있다. 
	* %d{HH:mm:ss, SSS}
	* %d{yyyy MMM dd HH:mm:ss, SSS}
	* %d{ABSOLUTE} 
	* %d{DATE} 
	* %d{ISO8601}
* %F : 파일명을 출력. 로그시 수행한 메소드, 라인번호가 함께 출력된다.
* %l : 로깅이 발생한 caller의 위치정보. 자바파일명:라인번호(링크제공) 
* %L : 라인 번호만 출력한다(링크없음)
* %m : 로그로 전달된 메시지를 출력한다.
* %M : 로그를 수행한 메소드명을 출력한다. 
* %n : 플랫폼 종속적인 개행문자가 출력. rn 또는 n
* %p : 로그 이벤트명등의 priority 가 출력(debug, info, warn, error, fatal )
* %r : 로그 처리시간 (milliseconds)
* %t : 로그이벤트가 발생된 쓰레드의 이름을 출력
* %% : % 표시를 출력. escaping
* %r : 어플리케이션 시작 이후 부터 로깅이 발생한 시점의 시간(milliseconds)
* %X : 로깅이 발생한 thread와 관련된 MDC(mapped diagnostic context)를 출력합니다. %X{key} 형태.
 *
 */
public class Log4jTest {

	private Logger logger = Logger.getLogger(Log4jTest.class);
	
	public static void main(String[] args) {	
		new Log4jTest().test();
	
	}
	
	public void test() {
		//1. 아주 심각 한 에러
		//logger.fatal("Fatal 로그"); 
		 
		//2. 요청 처리중 에러가 발생할 경우 
		logger.error("Error 로그!"); 
		//value="[%d{yyyy-MM-dd HH:mm:ss}] %-5p:[%L]- %m%n   || 이렇게 주면
		//[2019-01-29 16:19:43] ERROR:[41]- Error로그!        || 이렇게 찍힘
		
		//3. 프로그램 실행에는 당장 문제가 없지만 문제 소지가 있음
		logger.warn("Warn 로그!");
		
		//4. 상태변경과 같은 정보성 메세지
		logger.info("Info 로그!");
		
		//5. 개발 모드
		logger.debug("Debug 로그!"); //log4j.xml 에서 level value = "debug" 로 해두면 얘가 찍힘
		
		//6. 디버그 레벵르 좀더 세분화하여 관리하기 위한 레벨
		logger.trace("Trace 로그!");
	}

}
