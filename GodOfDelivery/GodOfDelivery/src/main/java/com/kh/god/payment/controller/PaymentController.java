package com.kh.god.payment.controller;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.RandomAccess;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.god.common.message.MessageSend;
import com.kh.god.member.model.service.MemberService;
import com.kh.god.member.model.vo.Member;
import com.kh.god.seller.model.service.SellerService;
import com.siot.IamportRestHttpClientJava.request.CancelData;
import com.siot.IamportRestHttpClientJava.response.IamportResponse;
import com.siot.IamportRestHttpClientJava.response.Payment;

@Controller
public class PaymentController {
	IamportClient client;
	
	@Autowired
	SellerService sellerService;
	@Autowired
	MemberService memberService;

	
	Logger logger = Logger.getLogger(getClass());

	
	public void setup() throws Exception {
		String api_key = "3227163481491035";
		String api_secret = "TLsxAneWAtIMa2g1cHYnLmXbnyZYJRBCD4aerpa2STO2W548M2wxptJM1ILLAnndryrSXCVPvJSrOXAA";

		client = new IamportClient(api_key, api_secret);
	}
	
	//비회원일 경우 : 결제 전 핸드폰인증	
	@RequestMapping("/guest/phoneCheck.do")
	@ResponseBody
	public String phoneCheck(@RequestParam("tel") String tel) {
		MessageSend ms = new MessageSend();
		String rndNo = ms.guestPhoneCheck(tel);
		return rndNo;
	}
	
	//결제준비페이지
	@RequestMapping("/payment/goPaymentPage.do")
	public String goPaymentPage(@RequestParam("storeName") String storeName,
			@RequestParam("storeNo") String storeNo,
			@RequestParam(value="memberId", required=false) String memberId
			,Model model) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("memberId",memberId);
	    map.put("storeNo",storeNo);

		List<Map<String,Object>> couponListBymemberId = null;
		Member memberInfo = null;
		
		if(!memberId.equals("")) {			
			couponListBymemberId = memberService.couponListBymemberId(map);
			memberInfo = memberService.selectOneMember(memberId);
			String memberPhone=memberInfo.getPhone();
			memberPhone = memberPhone.replaceAll("-", "");
			System.out.println(memberPhone);
			model.addAttribute("memberPhone",memberPhone);
		}
		
		model.addAttribute("storeName",storeName);
		model.addAttribute("storeNo",storeNo);
		model.addAttribute("couponList",couponListBymemberId);

	

		
		return "payment/paymentPreparations";
	}

	
	//결제완료시 -> 폼제출
	@RequestMapping("/payment/paymentEnd.do")
	public String paymentEnd(
			@RequestParam("storeNo") String storeNo,
			@RequestParam("paymentPrice") int totalPrice, //결제 가격
			@RequestParam("orginalPrice") int orginalPrice, //실제 가격
			@RequestParam("fixedAddress") String fixedAddress,
			@RequestParam("address") String address,
			@RequestParam("tel") String tel,
			@RequestParam("orderMenu") String orderMenu,
			@RequestParam(value="request", required=false) String request,
			@RequestParam(value="memberId", required=false) String memberId,
			@RequestParam("methodForController") String paymentMethod,
			@RequestParam(value="paymentId", required=false) String paymentId) {


		String noMemId = "";
		/* 비회원일시 */
		if(memberId.equals("")) {
			/* 비회원 아이디 생성 */
			Date date = new Date();
			SimpleDateFormat SimpleDateFormat = new SimpleDateFormat ("MMdd", Locale.KOREA );
			String fTime = SimpleDateFormat.format(date);
			
			Random rnd =new Random();
			StringBuffer buf =new StringBuffer();
			for(int i=0;i<5;i++){
			    if(rnd.nextBoolean()){
			        buf.append((char)((int)(rnd.nextInt(26))+97));
			    }else{
			        buf.append((rnd.nextInt(10))); 
			    }
			}
			noMemId = "guest_"+buf+"_"+fTime;
			logger.debug("비회원일시 Id생성=>"+noMemId);
		}

		/* 주문메뉴 */
		String[] list = orderMenu.split("/|:");
		System.out.println(Arrays.toString(list));
		
		address = fixedAddress+" "+address;
	    StringBuffer tel_ = new StringBuffer(tel);
	    tel_.insert(3, "-");
	    tel_.insert(8, "-");
	    tel = tel_.toString();
	    if(paymentMethod.equals("later_cash")) {
	    	paymentMethod="현금";
	    }else if(paymentMethod.equals("later_card")) {
	    	paymentMethod="카드";
	    }
	    
	    Map<String, Object> orderInfoMap = new HashMap<>();
	    Map<String, Object> orderMenuMap = new HashMap<>();
		orderInfoMap.put("storeNo", storeNo);
		orderInfoMap.put("totalPrice", totalPrice);
		orderInfoMap.put("orginalPrice", orginalPrice);
		orderInfoMap.put("address", address);
		orderInfoMap.put("phone",tel);	
		orderInfoMap.put("memberId",memberId.equals("")?noMemId:memberId);		
		orderInfoMap.put("request",!request.equals("")?request:"");
		orderInfoMap.put("paymentId",!paymentId.equals("")?paymentId:"");
		orderInfoMap.put("priceWay", paymentMethod.equals("now_card")?"Y":paymentMethod);

		
	    int orderInfo=sellerService.insertOrderInfo(orderInfoMap);
		System.out.println(orderInfo>0?"오더인포성공":"실패");

	    int orderMenu2 = 0;
	    String menuCode = "";
	    for(int i=0; i<list.length; i++) {	    	
	    	if(i==0 || i%2==0) {
	    		menuCode = list[i];
	    	}
	    	if(i%2!=0) {
	    		orderMenuMap.put("storeNo", storeNo);
	    		orderMenuMap.put("menuCode", menuCode);
	    		orderMenuMap.put("amount", list[i]);	    		
	    		orderMenu2 = sellerService.insertOrderMenu(orderMenuMap);
	    		System.out.println(orderMenu2>0?"오더메뉴성공":"실패");
	    	}
			
	    }
		return "payment/paymentEnd";
	}
	
	//결제취소
	@RequestMapping("/payment/paymentCancel.do")
	@ResponseBody
	public void testCancelPaymentByImpUid(@RequestParam("paymentId") String impUid,
			 @RequestParam("orderNoForCancel") int orderNo,
	         @RequestParam("reason") String reason,
	         @RequestParam(value="cancelReason", required=false) String cancelReason,
	         @RequestParam("memberPhoneForCancel") String memberPhoneForCancel,
	         @RequestParam("priceWay") String priceWay) throws Exception {
		setup();
		//이미 취소된 거래 imp_uid paymentId
		if(priceWay.equals("Y")) {
			CancelData cancel1 = new CancelData(impUid, true);
			IamportResponse<Payment> cancelpayment1 = client.cancelPayment(cancel1);
			System.out.println(cancelpayment1.getMessage());
		} 
		if(reason.equals("기타")) {
			reason = "기타:" + cancelReason;
		}
		MessageSend ms = new MessageSend();
		String flag = "cancel";
		ms.main(reason,memberPhoneForCancel,flag);

		int result = sellerService.cancelOrder(orderNo);	

	}
}
