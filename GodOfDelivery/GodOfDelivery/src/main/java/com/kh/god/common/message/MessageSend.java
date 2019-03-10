package com.kh.god.common.message;

import java.util.HashMap;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;


/**
 * @class ExampleSend
 * @brief This sample code demonstrate how to send sms through CoolSMS Rest API PHP
 */
public class MessageSend {
public static void main(String howLongChecked, String memberPhone,String flag) {
	     
		//flag=receive 일 경우 howLongChecked => 얼마나 걸릴지
	    //flag=cancel 일 경우 howLongChecked => 취소 사유

	
		memberPhone = memberPhone.replaceAll("-", "");
	
		String api_key = "NCSVKGTPW3QU8AIA"; 
		String api_secret ="DTUEHVLPZ1QRMFMUAL3XOPT7TELFSFRA"; 
		Message coolsms = new Message(api_key,api_secret);
		
		HashMap<String, String> params = new HashMap<String, String>();
		if(flag.equals("receive")) {
			params.put("to", memberPhone); 
			params.put("from", "01084345390");
			params.put("type", "SMS"); 
			params.put("text", "주문이 접수되었습니다 배달예정시간은"+howLongChecked+"입니다:) 주문해주셔서 감사합니다");
			params.put("app_version", "test app 1.2"); // application name and version
		}else if(flag.equals("cancel")) {
			params.put("to", memberPhone); 
			params.put("from", "01084345390");
			params.put("type", "SMS"); 
			params.put("text", "주문접수가 취소되었습니다.취소 사유는 "+howLongChecked);
			params.put("app_version", "test app 1.2"); // application name and version
		}
		// 4 params(to, from, type, text) are mandatory. must be filled
		
		
		try { 
			JSONObject obj = (JSONObject) coolsms.send(params);
		    System.out.println(obj.toString()); 
		    } catch (CoolsmsException e) {
		    System.out.println(e.getMessage()); 
		    System.out.println(e.getCode()); 
		}
		
  }
	public static void findPwd(String password, String memberPhone) {
		
		//flag=receive 일 경우 howLongChecked => 얼마나 걸릴지
		//flag=cancel 일 경우 howLongChecked => 취소 사유
		
		System.out.println("@@@@여기 메세지 샌드부분"+ password);
		System.out.println("@@@@여기 메세지 샌드부분"+memberPhone);
		if(memberPhone.contains("-")) {
			memberPhone = memberPhone.replaceAll("-", "");
			System.out.println("@@치환후 번호"+memberPhone);		
		}
		
		String api_key = "NCSVKGTPW3QU8AIA"; 
		String api_secret ="DTUEHVLPZ1QRMFMUAL3XOPT7TELFSFRA"; 
		Message coolsms = new Message(api_key,api_secret);
		
		HashMap<String, String> params = new HashMap<String, String>();
		
			params.put("to", memberPhone); 
			params.put("from", "01084345390");
			params.put("type", "SMS"); 
			params.put("text", "임시 비밀번호는 "+password+"입니다. 로그인 후 비밀번호를 바꾸시길 바랍니다.");
			params.put("app_version", "test app 1.2"); // application name and version
		
		// 4 params(to, from, type, text) are mandatory. must be filled
		
		
		try { 
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString()); 
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage()); 
			System.out.println(e.getCode()); 
		}
		
	}
	
	public static String guestPhoneCheck(String memberPhone) {
		String api_key = "NCSVKGTPW3QU8AIA"; 
		String api_secret ="DTUEHVLPZ1QRMFMUAL3XOPT7TELFSFRA"; 
		Message coolsms = new Message(api_key,api_secret);
		
		//인증번호
		int randomint = (int)(Math.random() * 1000000) + 1; 
		String randomString = Integer.toString(randomint);
		System.out.println("randomint=>"+randomint);
		
		/*HashMap<String, String> params = new HashMap<String, String>();
		
			params.put("to", memberPhone); 
			params.put("from", "01084345390");
			params.put("type", "SMS"); 
			params.put("text", "[배달의 신]인증번호는 ["+randomint+"]입니다. 정확히 입력해주세요.");
			params.put("app_version", "test app 1.2"); // application name and version
		
		// 4 params(to, from, type, text) are mandatory. must be filled
		
		
		try { 
			JSONObject obj = (JSONObject) coolsms.send(params);
		    System.out.println(obj.toString()); 
		    } catch (CoolsmsException e) {
		    System.out.println(e.getMessage()); 
		    System.out.println(e.getCode()); 
		}*/
		
		return randomString;
	}
}