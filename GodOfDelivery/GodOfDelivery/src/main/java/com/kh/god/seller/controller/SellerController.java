package com.kh.god.seller.controller;


import java.sql.Date;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.util.WebUtils;

import com.kh.god.common.message.MessageSend;
import com.kh.god.common.util.Utils;
import com.kh.god.common.websocket.WebSocketHandler;
import com.kh.god.member.model.vo.Review;
import com.kh.god.admin.model.vo.Ad;
import com.kh.god.menu.exception.MenuException;
import com.kh.god.menu.model.vo.Menu;
import com.kh.god.seller.model.service.SellerService;
import com.kh.god.seller.model.vo.LoginDTO;
import com.kh.god.seller.model.vo.Seller;
import com.kh.god.storeInfo.model.vo.MenuAttachment;
import com.kh.god.storeInfo.model.vo.StoreInfo;




@Controller
@SessionAttributes(value = {"sellerLoggedIn"})
public class SellerController {

	private Map<String,WebSocketSession> memberSession;
	private static Map<String,String> loginSession;

	Logger logger = Logger.getLogger(getClass());
	private SellerController() {
		loginSession = new HashMap<>();
	}
	//싱글톤 방식을쓰는데 LazyHolder이디엄을 사용.
	public static SellerController getInstance() {
		return LazyHolder.INSTANCE;
	}
	private static class LazyHolder{
		private static final SellerController INSTANCE = new SellerController();
	}
//	웹소켓에서 강제 로그아웃 시킬때 필요.
	public Map<String,String> getLoginSession() {
		return loginSession;
	}
	@Autowired
	SellerService sellerService;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("/seller/sellerEnroll.do")
	public String sellerEnroll() {
		
		return "seller/sellerEnroll";
	}
	
	@RequestMapping("seller/checkIdDuplicate.do")
	@ResponseBody
	public Map<String, Object> checkIdDuplicate(@RequestParam("sellerId") String sellerId ) {
		logger.debug("ID중복체크 : "+ sellerId);
		Map<String , Object> map = new HashMap<>();
		Seller s = sellerService.selectOneSeller(sellerId);
		//logger.debug("seller"+ s);
		boolean isUsable = s == null ? true:false;
		
		map.put("isUsable", isUsable) ;
		
		return map; 
	}
	
	@RequestMapping("/seller/sellerEnrollEnd.do")
	public String insertSeller(Seller s , Model model) {
		//logger.debug("sellerinsert"+ s);
		System.out.println("암호화전 :"+s.getPassword());
		
		String temp = s.getPassword();
		s.setPassword(bcryptPasswordEncoder.encode(temp));
		
		int result = sellerService.insertSeller(s);
		
		String loc = "/";
		String msg = "";
		String view = "";
		System.out.println(result>0?"등록성공":"등록실패");
		
		if(result>0) msg="회원가입성공";
        else msg="회원가입실패!";
       
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	@RequestMapping(value = "/seller/sellerLogin.do" ,method = RequestMethod.POST)
	public String SellerLogin( HttpServletResponse response ,@RequestParam String memberId , @RequestParam String password, 
			@RequestParam("autologin") String autologin,HttpSession session) {
		
		
		logger.debug("$#@$@#$@#$@#$"+autologin);
		String returnURL = "";
		logger.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1111"+ session.getAttribute("sellerLoggedIn"));
//		Member member = null ;
		if(session.getAttribute("sellerLoggedIn") != null) {
			//기존에 login이란 세션값이 존재한다면
//			Seller login = (Member)session.getAttribute("login");
//			member = sellerService.login(login);
			session.removeAttribute("sellerLoggedIn"); //기존값을 제거해준다.
			
		}
		logger.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!222"+ session.getAttribute("sellerLoggedIn"));
		
		String loc = "/";
	      String msg = "";
	      String view = "common/msg";
		
		Seller s = sellerService.selectOneSeller(memberId);
		

	     //현재 채팅방의 안읽은 메세지의 갯수를 로그인할때 가져옴.
	     boolean loginFlag = true;
	     
	     if (s == null || s.getDelFlag().equals("Y")) {//로그인실패

	         msg = "아이디가 존재하지 않습니다.";
	         loc = "/";
	         returnURL = "redirect:/"; // 로그인 폼으로 다시 가도록 함
	         
	      } else { //로그인 검사 
	         // 비밀번호 비교

	    	  memberSession = WebSocketHandler.getInstance().getUserList();
	    	  Set<String> keyValue = loginSession.keySet();
				logger.debug("keyValue : "+keyValue);
				Iterator<String> iterator = keyValue.iterator();
				while(iterator.hasNext()) {
					String loginId = iterator.next();
					logger.debug("로그인 되어있는 아이디!"+ loginId);
					if(s.getSellerId().equals(loginId)) {
						msg = "이미 로그인한 아이디가 있습니다.";
						loc="/";
						loginFlag = false;
					}
				}
	    	  

		if(loginFlag == true) {
	         if (bcryptPasswordEncoder.matches(password, s.getPassword())) { // 로그인 성공
	        	 
		         //사이드바
		            List<StoreInfo> store = sellerService.myStore(memberId);
		            session.setAttribute("storeSideBar", store);
		            
	        	 session.setAttribute("loginId",s.getSellerId());
		         //세션관리
//		         loginSession.put(session.getId(),session);
		         //자동로그인 설정부분
	        	 Seller s2 = sellerService.selectOneSeller(memberId);
	        	 session.setAttribute("sellerLoggedIn" ,s);
	        	 //dto설정
	        	 LoginDTO dto = new LoginDTO();
	     		 dto.setUid(memberId);
	     		 dto.setUpw(s2.getPassword());
	     		 if(autologin.equals("no")) {
	    			dto.setUseCookie(false);	
	    		 }else {
	    			dto.setUseCookie(true);
	    		 }
	     		 /*[세션추가되는부분]*/
	     		 //1.로그인이 성공되면 
	     		 loginSession.put(s.getSellerId(),session.getId());
	     		 logger.debug("로그인 시 : "+loginSession);
	     		 if(dto.isUseCookie()) {
	     			 //쿠키사용한다고 체크되어 있으면
	     			 //쿠키를 생성 및 현재 로그인 되어있을때의 세션 id를 쿠키에 저장한다. 
	     			 Cookie cookie = new Cookie("loginCookie" , session.getId());
	     			  //쿠키를 찾을 경로를 컨텍스트 경로로 변경해 줌.
	     			 cookie.setPath("/");
	     			 int amount = 60*60*24*7;
	     			 cookie.setMaxAge(amount); //단위는 (초)임으로 7일정도로 유효시간을 서정해줌.
	     			 //쿠키적용해줌
	     			 response.addCookie(cookie);
	     			 
	     			 //currentTimeMills()가 1/100초 단위임으로 1000곱해서 더해야함.
	     			Date sessionLimit = new Date(System.currentTimeMillis() + (1000*amount));
	     		// 현재 세션 id와 유효시간을 사용자 테이블에 저장한다.
	                try {
						sellerService.keepLogin(s2.getSellerId(), session.getId(), sessionLimit);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	                logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@111111111111111111111");

	     			 
	     		 }
	         } else { //로그인 실패
	            //비밀번호 불일치 
	        	 msg = "비밀번호를 잘못 입력하셨습니다.";
		            loc = "/";
	        	 returnURL = "redirect:/"; // 로그인 폼으로 다시 가도록 함
	         }
		      }
	      }
		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2222222222222222222222222");
		return "redirect:/" ;
		
	}
//	@RequestMapping(value = "/seller/sellerLogin.do" ,method = RequestMethod.POST)
//	public ModelAndView SellerLogin(@RequestParam String memberId , @RequestParam String password, 
//			ModelAndView mav , HttpSession session) {
//		
//		
//		/* @RequestParam(name="autoLogin") String autoLogin , */
//		/*
//		 * if(session.getAttribute("LOGIN") != null) { session.removeAttribute("LOGIN");
//		 * //기존에 LOGIN세션값 존재하면 제거 }
//		 */
//		
//		
//		
//		
//		
//		//logger.debug("@@@@@@@22autoLogin"+ autoLogin);
//		
//		
//		memberSession = WebSocketHandler.getInstance().getUserList();
//		List<WebSocketSession> web = WebSocketHandler.getInstance().getSessionList();
//		
//		if(logger.isDebugEnabled())
//			logger.debug("로그인 요청!");
//		
//		//로그인 성공시 Seller 반환
//		Seller s = sellerService.selectOneSeller(memberId);
//		
//		String loc = "/";
//		String msg = "";
//		String view = "common/msg";
//		
//		boolean loginFlag = true;
//		
//		if (s == null || s.getDelFlag().equals("Y")) {
//			
//			msg = "아이디가 존재하지 않습니다.";
//			loc = "/";
//			
//		} else {//로그인 성공시 
//			
//			//  dto.setPassword(password);
//			
//			// if(dto.isUseCookie()) {
//			
//			//}
//			
//			Set<String> keyValue = memberSession.keySet();
//			logger.debug("keyValue : "+keyValue);
//			Iterator<String> iterator = keyValue.iterator();
//			while(iterator.hasNext()) {
//				String loginId = iterator.next();
//				logger.debug("로그인 되어있는 아이디!"+ loginId);
//				if(s.getSellerId().equals(loginId)) {
//					msg = "이미 로그인한 아이디가 있습니다.";
//					loc="/";
//					loginFlag = false;
//				}
//				
//			}
////				WebSocketHandler.getInstance().setUserList(s.getSellerId(),webSession);
//			// 비밀번호 비교
//			if(loginFlag == true) {
//				if (bcryptPasswordEncoder.matches(password, s.getPassword())) {
//					// 비밀번호 일치했을시 세션 상태 유지
//					mav.addObject("sellerLoggedIn", s);
//					session.setAttribute("login",s.getSellerId());
//					
//					//사이드바
//					List<StoreInfo> store = sellerService.myStore(memberId);
//					
//					session.setAttribute("storeSideBar", store);
//					
//					view = "redirect:/";
//					
//				} else {
//					msg = "비밀번호를 잘못 입력하셨습니다.";
//					loc = "/";
//				}
//			}
//		}
//		
//		mav.addObject("loc", loc);
//		mav.addObject("msg", msg);
//		mav.setViewName(view);
//		
//		return mav;
//		
//	}
	
	@RequestMapping("/seller/sellerLogout.do")
	public String logout(SessionStatus sessionStatus,@RequestParam String sellerId,HttpSession session,HttpServletRequest request, HttpServletResponse response)
{
//		session.setAttribute("sellerLoggedIn",null);
//		session.removeAttribute("sellerLoggedIn");
		if(logger.isDebugEnabled())
			logger.debug("로그아웃 요청!"); 
		
	      
	      if(!sessionStatus.isComplete()) {
	         sessionStatus.setComplete();
	      }
	      
	      
	     // session.setAttribute("sellerLoggedIn",null);
//	      loginSession.remove(session.getId());
	      Object obj = session.getAttribute("sellerLoggedIn");
	        if ( obj != null ){
	            Seller vo = (Seller)obj;
	            // null이 아닐 경우 제거
	          //session.removeAttribute("sellerLoggedIn");
	            session.removeAttribute("sellerLoggedIn");
	            session.invalidate(); // 세션 전체를 날려버림
	            loginSession.remove(sellerId);
	            logger.debug("로그아웃시 : "+loginSession);
	            //쿠키를 가져와보고
	            Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
	            if ( loginCookie != null ){
	                // null이 아니면 존재하면!
	                loginCookie.setPath("/");
	                // 쿠키는 없앨 때 유효시간을 0으로 설정하는 것 !!! invalidate같은거 없음.
	                loginCookie.setMaxAge(0);
	                // 쿠키 설정을 적용한다.
	                response.addCookie(loginCookie);
	                 
	                // 사용자 테이블에서도 유효기간을 현재시간으로 다시 세팅해줘야함.
	                Date date = new Date(System.currentTimeMillis());
	                try {
						sellerService.keepLogin(vo.getSellerId(), "none", date);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	            }
	        }
	      
	            return "redirect:/";
	 }
	
	@RequestMapping("/seller/sellerView.do")
	public String sellerView(HttpSession session , Model model) {
		
		Seller sellerLoggedIn = (Seller)session.getAttribute("sellerLoggedIn");
		
		Seller s = sellerService.selectOneSeller(sellerLoggedIn.getSellerId());
	
		//System.out.println("@@@@@@@@@"+ s.getPhone());
		List<StoreInfo> si = sellerService.selectListStorInfo(sellerLoggedIn.getSellerId());
		logger.debug("@@@@@@@@@@@@@" + si);
		
		model.addAttribute("s", s);
		model.addAttribute("si", si);
				
		return "seller/sellerView";
	}
		
	//내 가게 
	@RequestMapping("/seller/goMyStore.do")
	public String goMyStore(@RequestParam("sellerId") String sellerId, Model model) {
		
		if(logger.isDebugEnabled()) {
			logger.debug("내 가게 보기 요청!"); 
		}
		
		List<StoreInfo> store = sellerService.myStore(sellerId);
		List<Map<String,String>> saleVolume = sellerService.totalSaleVolume(sellerId,"today");
		logger.debug("오늘자 판매량ㅇ ::"+saleVolume);
//		List<Menu> menu = sellerService.myStoreMenu(sellerId);
		
//		System.out.println("메뉴 나오라" + menu);
		
		//메뉴 뽑기
		//페이지바 만들기
		model.addAttribute("store", store);
//		model.addAttribute("menu", menu);
		model.addAttribute("saleVolume",saleVolume);
		return "seller/goMyStore";

	}
	
	@RequestMapping(value = "/seller/checkPresentPwd.do" , method = RequestMethod.POST)
	@ResponseBody
	public Map<String , Object> checkPresentPwd(HttpSession session , @RequestParam("password") String password , Model model) {
		logger.debug("password"+password);
		
		Map<String, Object> map = new HashMap<>();
		
		Seller sellerLoggedIn = (Seller)session.getAttribute("sellerLoggedIn");
		
		Seller s = sellerService.selectOneSeller(sellerLoggedIn.getSellerId());
		
		String msg = "";
		int result = 0 ;
		
		if(s == null) {
			
			msg = "비밀번호를 다시 확인해 주십시오.";
			
		}else {
			
			if(bcryptPasswordEncoder.matches(password, s.getPassword())) {
				
				msg = "비밀번호 확인 완료";
				result = 1;
			}else {
				msg = "비밀번호가 일치 하지 않습니다.";
			}
			
		}
		
		map.put("result" , result);
		map.put("msg" , msg);
		
		//logger.debug("여기까지는 왔냐?"+ map);
		
		return map;
	}
	
	@RequestMapping(value = "/seller/sellerUpdate.do" )
	public String sellerUpdate(HttpSession session , Model model , Seller seller) {
		
		logger.debug("!!!!!!!!!!!!!!!!!!!!"+seller);
		
		int result = sellerService.updateSeller(seller);
		
		Seller sellerLoggedIn = (Seller)session.getAttribute("sellerLoggedIn");
		Seller s = sellerService.selectOneSeller(sellerLoggedIn.getSellerId());
		
		String loc = "/seller/sellerView.do";
		String msg = "";
		
		
		if(result>0) {
			msg ="수정 성공";
			
		}else{
			msg ="수정 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);
		
	
		
		return "common/msg";
	}
	
	@RequestMapping(value ="/seller/updatePwd.do" , method = RequestMethod.POST )
	@ResponseBody
	public Map<String, Object> updatePwd(Seller seller, HttpSession session ) {
		
		Seller sellerLoggedIn = (Seller)session.getAttribute("sellerLoggedIn");
		
		String password = seller.getPassword();
		Map<String, Object> map = new HashMap<>();
		String temp = password;
		
		password = bcryptPasswordEncoder.encode(temp);
		seller.setSellerId(sellerLoggedIn.getSellerId());
		seller.setPassword(password);
		
		int result = sellerService.updatePwd(seller);
		String msg = "";
		
		if(result > 0) {
			msg ="비밀번호 변경 성공";
		}else {
			msg ="비밀번호 변경 실패";
		}
		
		map.put("msg", msg);
		
		return map;
	}

	@RequestMapping(value = "/seller/goMyStoreOrder.do" )
	public String goMyStoreOrder(@RequestParam("storeNo") String storeNo,Model model) {
		System.out.println("@@storeNo=>>>>>"+storeNo);
		//접수대기 오더리스트
		List<Map<String, Object>> orderList1 = sellerService.orderList1(storeNo);
		//접수진행 오더리스트
		List<Map<String, Object>> orderList2 = sellerService.orderList2(storeNo);
		//배달완료 오더리스트
		List<Map<String, Object>> orderList3 = sellerService.orderList3(storeNo);

		model.addAttribute("orderList1",orderList1);
		model.addAttribute("orderList2",orderList2);
		model.addAttribute("orderList3",orderList3);

		
		return "seller/MyStoreOrder";
	}
	
	

	
    @RequestMapping("/seller/goUpdateMyStore.do")
    public String goUpdateMyStore(@RequestParam("storeNo") String storeNo, Model model) {
    	//' ' 제거 
    	storeNo = storeNo.replace("'", "");
  
    	List<Map<String, Object>> store = sellerService.getStoreInfoBystoreNo(storeNo);   
    	List<MenuAttachment> attachment = sellerService.getAttachment(storeNo);
    	List<MenuAttachment> thumbAttachment = sellerService.getthumbAttachment(storeNo);
    	model.addAttribute("store", store);
    	model.addAttribute("attachment", attachment);
    	model.addAttribute("thumbAttachment", thumbAttachment);

    	return "seller/updateMyStoreInfo";
    }

    //내 가게 정보수정
    @RequestMapping("/seller/updateStoreInfo.do")
    public String updateStore(
    		@RequestParam(name="operatingHours" , required = false) String operatingHours,
    		@RequestParam(name="locationStartNum" , required = false) String locationStartNum,
    		@RequestParam(name="tel1" , required = false) String tel1,
    		@RequestParam(name="tel2" , required = false) String tel2,
    		@RequestParam(name="address1" , required = false) String address1,
    		@RequestParam(name="address2" , required = false) String address2,
    		@RequestParam(name="personalday" , required = false) String personalday,
    		@RequestParam(name="nowThumb" , required = false) String nowThumb,
    		@RequestParam(name="newThumb" , required = false) String newThumb,
    		@RequestParam(name="storeNo", required = false) String storeNo,
    		Model model
	
    		) {

    	String storeTel = locationStartNum+"-"+tel1+"-"+tel2;
    	String storeAddress = "";
    	if(!address2.equals("")) {
    		storeAddress = address1+" "+address2;
    	} else {
    		storeAddress = address1;
    	}
    	
		Map<String , Object> map = new HashMap<>();
		map.put("storeNo",storeNo);
		map.put("operatingHours",operatingHours);
		map.put("storeTel",storeTel);
		map.put("storeAddress",storeAddress);
		map.put("personalday",personalday);

    	//업데이트
    	int result = sellerService.updateStoreInfo(map);
		String msg = "";

    	if(result>0) {
    		msg="수정이 완료되었습니다";
    	} else {
    		msg="수정실패";
    	}
    	
    	if(!nowThumb.equals(newThumb)) {
    		//썸네일을 바꾼 경우
    		//전에 했던 썸네일 Flag=N으로 업데이트 
    		int oldThumbNail = sellerService.oldThumbNail(nowThumb);
    		//뉴 썸네일 Flag=Y로 업데이트
    		int changeThmbNail = sellerService.changeThmbNail(newThumb);
    	}
    	
    	System.out.println("storeNo=>"+storeNo);

    	return "redirect:/seller/goUpdateMyStore.do?storeNo="+storeNo;

    }
    
	@RequestMapping("/seller/myStoreMenu.do")
	public String myStoreMenu(@RequestParam("storeNo") String storeNo, 
							  @RequestParam("sellerId") String sellerId, Model model) {
		if(logger.isDebugEnabled()) {
			logger.debug("myStoreMenu() 요청!"); 
		}
		
		logger.debug("☆★☆★☆★☆★☆★사업자 번호 왔냐? " + storeNo);
		
		// 메뉴리스트
		List<Menu> menu = sellerService.selectMenuList(storeNo);
		StoreInfo storeInfo = sellerService.selectStoreInfo(storeNo);
		String view = "";
		String msg = "접근 권한이 없습니다.";

		if (!sellerId.equals(storeInfo.getSellerId())) {

			String loc = "/";
			view = "common/msg";
			model.addAttribute("loc", loc);
			model.addAttribute("msg", msg);

		} else {

			logger.debug("☆★☆★☆★☆★☆★메뉴 왔냐? " + menu);

			model.addAttribute("menu", menu);
			model.addAttribute("storeNo", storeNo);
			model.addAttribute("categoryNo", storeInfo.getCategoryNo());

			logger.debug("☆★☆★☆★☆★☆★카테고리 번호 왔냐? " + storeInfo.getCategoryNo());
			view = "/seller/myStoreMenu";
		}

		return view;
	}
	
	@RequestMapping("/seller/goUpdateMenu.do")
	public ModelAndView updateSoldOut(@RequestParam("menuCode") String menuCode,
									  @RequestParam("storeNo") String storeNo,
									  @RequestParam("soldoutFlag") String soldoutFlag,
									  ModelAndView mav,
									  HttpSession session) {
		if (logger.isDebugEnabled()) {
			logger.debug("updateSoldOut() 요청!");
		}
		
		
		Seller sellerLoggedIn = (Seller) session.getAttribute("sellerLoggedIn");
		String sellerId = sellerLoggedIn.getSellerId();
		
		logger.debug("셀러셀러셀러셀러셀러==============" + sellerId);
		
		logger.debug("☆★☆★☆★☆★☆★메뉴코드 왔냐? " + menuCode);
		logger.debug("☆★☆★☆★☆★☆★사업자번호 왔냐? " + storeNo);
		logger.debug("☆★☆★☆★☆★☆★품절여부 왔냐? " + soldoutFlag);
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("menuCode", menuCode);
		map.put("soldoutFlag", soldoutFlag);
		
		int result = sellerService.updateSoldout(map);

		String loc = "/";
		String msg = "";
		String view = "common/msg";

		if (result > 0) {
			msg = "품절 변경 성공";
			loc = "/seller/myStoreMenu.do?storeNo=" + storeNo + "&sellerId=" + sellerId;
		} else {
			msg = "품절 변경 실패";
			loc = "/seller/myStoreMenu.do?storeNo=" + storeNo + "$sellerId=" + sellerId;
		}

		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.addObject("map", map);
		mav.setViewName(view);

		return mav;
	}
	

	@RequestMapping("/seller/myAd.do")
	public String myAd(@RequestParam(value="cPage",defaultValue="1") int cPage,@RequestParam(name="storeNo") String storeNo, Model model, @RequestParam(value="status",defaultValue="all") String status) {
		int numPerPage = 5;
		int totalContents = 0;
		List<Map<String,String>> list = null;
		if(status.equals("all")) {
			list = sellerService.adSelectAll(cPage,numPerPage,storeNo);
			totalContents = sellerService.countAdAll(storeNo);
		}else if(status.equals("now")) {
			list = sellerService.adSelectNow(cPage,numPerPage,storeNo);
			totalContents = sellerService.countAdNow(storeNo);
			logger.debug("wwwww");
		}else if(status.equals("past")) {
			list = sellerService.adSelectPast(cPage,numPerPage,storeNo);
			totalContents = sellerService.countAdPast(storeNo);
		}
		
		model.addAttribute("storeNo",storeNo);
		model.addAttribute("cPage",cPage);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("totalContents",totalContents);
		model.addAttribute("list",list);
		model.addAttribute("status",status);
		
		return "seller/myAd";
		
	}
	
	@RequestMapping("/seller/adRequest.do")
	public String adRequest(@RequestParam(name="storeNo") String storeNo,@RequestParam(name="cost") int cost) {
		Ad ad = new Ad();
		ad.setStoreNo(storeNo);
		ad.setPrice(cost);
		if(cost==50000) {
			ad.setStoreGrade("A");
		}else {
			ad.setStoreGrade("B");
		}
		int result = sellerService.adRequest(ad);
		
		return "redirect:/seller/myAd.do?storeNo="+storeNo;
	}
	

	//주문접수 
	@RequestMapping("/seller/receiveOrder.do")
	public String receiveOrder(@RequestParam("orderNoForReceive") int orderNo,
			@RequestParam String howLongChecked,
			@RequestParam String memberPhone) {
		System.out.println(memberPhone);
		MessageSend ms = new MessageSend();
		String flag = "receive";
		ms.main(howLongChecked,memberPhone,flag);

		Map<String,Object> map = new HashMap<>();
		map.put("orderNo",orderNo);
		map.put("howLongChecked",howLongChecked);

		int result = sellerService.receiveOrder(map);
		System.out.println(result>0?"접수완료":"실패");
		
		return "redirect:/";
	}

	//배달완료
	@RequestMapping("/seller/deliveryEnd.do")
	@ResponseBody
	public Map<String, Object> deliveryEnd(@RequestParam("orderNo") int orderNo,
			@RequestParam("storeNo") String storeNo) {
		int result = sellerService.deliveryEnd(orderNo);
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> orderList2 = sellerService.orderList2(storeNo);

		System.out.println(result>0?"배달완료":"실패");
		map.put("orderList2", orderList2);

		return map;
	}
	

//	@RequestMapping("/seller/updateMenu.do")
//	public ModelAndView updateMenu(@RequestParam("menuCode") String menuCode,
//								   @RequestParam("menuName") String menuName, 
//								   @RequestParam("menuPrice") int menuPrice,
//								   @RequestParam("storeNo") String storeNo,
//								   @RequestParam(name="upFile" , required=false) MultipartFile[] upFiles, 
//								   HttpServletRequest request,
//								   ModelAndView mav) {
//		if (logger.isDebugEnabled()) {
//			logger.debug("updateMenu() 요청!");
//		}
//
//		logger.debug("fileName = " + upFiles[0].getOriginalFilename());
//		logger.debug("size = " + upFiles[0].getSize());
//		
//		logger.debug("☆★☆★☆★☆★☆★메뉴코드 왔냐? " + menuCode);
//		logger.debug("☆★☆★☆★☆★☆★메뉴이름 왔냐? " + menuName);
//		logger.debug("☆★☆★☆★☆★☆★메뉴가격 왔냐? " + menuPrice);
//		logger.debug("☆★☆★☆★☆★☆★사업자번호 왔냐? " + storeNo);
//		logger.debug("☆★☆★☆★☆★☆★첨부파일 왔냐? " + upFiles);
//
//		Map<String, Object> map = new HashMap<>();
//		map.put("menuCode", menuCode);
//		map.put("menuName", menuName);
//		map.put("menuPrice", menuPrice);
//		map.put("storeNo", storeNo);
//		map.put("upFiles", upFiles);
//
//		int result = sellerService.updateMenu(map);
//
//		String loc = "/";
//		String msg = "";
//		String view = "common/msg";
//
//		if (result > 0) {
//			msg = "메뉴 수정 성공!";
//			loc = "/seller/myStoreMenu.do?storeNo=" + storeNo;
//		} else {
//			msg = "메뉴 수정 실패!";
//			loc = "/seller/myStoreMenu.do?storeNo=" + storeNo;
//		}
//
//		mav.addObject("loc", loc);
//		mav.addObject("msg", msg);
//		mav.addObject("map", map);
//		mav.setViewName(view);
//
//		return mav;
//
//	}
	
	@RequestMapping("/seller/updateMenu.do")
	public ModelAndView updateMenu(@RequestParam(value="menuCode", required = false) String menuCode,
								   @RequestParam(value="menuName", required = false) String menuName, 
								   @RequestParam(value="menuPrice", required = false) int menuPrice,
								   @RequestParam(value="storeNo", required = false) String storeNo,
								   @RequestParam(name="upFile" , required=false) MultipartFile[] upFiles, 
								   HttpServletRequest request,
								   HttpSession session,
								   ModelAndView mav) {
		if (logger.isDebugEnabled()) {
			logger.debug("updateMenu() 요청!");
		}
		
		Seller sellerLoggedIn = (Seller) session.getAttribute("sellerLoggedIn");
		String sellerId = sellerLoggedIn.getSellerId();
		
		//logger.debug("fileName = " + upFiles[0].getOriginalFilename());
		//logger.debug("size = " + upFiles[0].getSize());
		
		logger.debug("☆★☆★☆★☆★☆★메뉴코드 왔냐? " + menuCode);
		logger.debug("☆★☆★☆★☆★☆★메뉴이름 왔냐? " + menuName);
		logger.debug("☆★☆★☆★☆★☆★메뉴가격 왔냐? " + menuPrice);
		logger.debug("☆★☆★☆★☆★☆★사업자번호 왔냐? " + storeNo);
		logger.debug("☆★☆★☆★☆★☆★첨부파일 왔냐? " + upFiles);
		
		
		String loc = "/";
		String msg = "";
		String view = "common/msg";
		
		List<MenuAttachment> menuAttachList = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		MenuAttachment attach = new MenuAttachment();
		
		try {
			// 1. 파일업로드 (실제경로를 얻어내는 방법은 세션-서블릿-리얼패스)
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/menu");

			logger.debug("saveDirectory = " + saveDirectory);

			
			// MultipartFile 처리
			for (MultipartFile f : upFiles) {
				if (!f.isEmpty()) {
					// 사용자가 업로드한 파일명 구하기
					String originalFileName = f.getOriginalFilename();

					// 서버저장용 파일명
					String renamedFileName = Utils.getRenamedFileName(originalFileName);
					logger.debug("renamedFileName = " + renamedFileName);

					// 실제서버에 파일저장
					try {
						f.transferTo(new File(saveDirectory + "/" + renamedFileName));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}

					// 첨부파일객체 생성. 리스트 추가
					attach.setOriginalFileName(originalFileName);
					attach.setRenamedFileName(renamedFileName);
					menuAttachList.add(attach);
					
					logger.debug("-_-_-_-_-_- menuAttachList -_-_-_-_-_- " + menuAttachList);
					
					
				}
			}
			
			map.put("menuCode", menuCode);
			map.put("menuName", menuName);
			map.put("menuPrice", menuPrice);
			map.put("storeNo", storeNo);
			map.put("upFiles", upFiles);
			map.put("menuAttachList", menuAttachList);
			
			// 2. 업무로직
			int result = sellerService.updateMenu(map);
			
			if (result > 0) {
				msg = "메뉴 수정 성공!";
				loc = "/seller/myStoreMenu.do?storeNo=" + storeNo + "&sellerId=" + sellerId;
			} else {
				msg = "메뉴 수정 실패!";
				loc = "/seller/myStoreMenu.do?storeNo=" + storeNo + "&sellerId=" + sellerId;
			}

		} catch (Exception e) {
			logger.error("메뉴 수정 에러", e);
			throw new MenuException("메뉴 수정 에러", e);
		}
		
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.addObject("map", map);
		mav.setViewName(view);
		
		return mav;
		
	}
	
	@RequestMapping("/seller/deleteMenu.do")
	public String deleteMenu(String menuCode, String storeNo, HttpSession session) {
		if (logger.isDebugEnabled()) {
			logger.debug("deleteMenu() 요청!");
		}
		
		Seller sellerLoggedIn = (Seller) session.getAttribute("sellerLoggedIn");
		String sellerId = sellerLoggedIn.getSellerId();
		
		logger.debug("☆★☆★☆★☆★☆★메뉴코드 왔냐? " + menuCode);
		logger.debug("☆★☆★☆★☆★☆★사업자번호 왔냐? " + storeNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("menuCode", menuCode);
		map.put("storeNo", storeNo);
		
		int result = sellerService.deleteMenu(map);
		
		String loc = "/";
		String msg = "";
		String view = "common/msg";

		if (result > 0) {
			msg = "메뉴 삭제 성공!";
			loc = "redirect:/seller/myStoreMenu.do?storeNo="+ storeNo + "&sellerId=" + sellerId;
		} else {
			msg = "메뉴 삭제 실패!";
			loc = "redirect:/seller/myStoreMenu.do?storeNo="+ storeNo + "&sellerId=" + sellerId;
		}
		
		return loc;
	}
	
	@RequestMapping("seller/insertMenu.do")
	public String insertMenu(Menu menu,
							 @RequestParam(name = "menuOptions") String menuOptions,
							 @RequestParam(name = "upFile", required = false) MultipartFile[] upFiles,
							 HttpServletRequest request,
							 HttpSession session,
							 Model model) {
		if (logger.isDebugEnabled()) {
			logger.debug("insertMenu() 요청!");
		}
		
		Seller sellerLoggedIn = (Seller) session.getAttribute("sellerLoggedIn");
		String sellerId = sellerLoggedIn.getSellerId();

		logger.debug("fileName = " + upFiles[0].getOriginalFilename());
		logger.debug("size = " + upFiles[0].getSize());
		
		String loc = "/";
		String msg = "";
		String view = "common/msg";

		try {
			// 1. 파일업로드 (실제경로를 얻어내는 방법은 세션-서블릿-리얼패스)
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/menu");

			logger.debug("saveDirectory = " + saveDirectory);

			List<MenuAttachment> menuAttachList = new ArrayList<>();
			
			MenuAttachment attach = new MenuAttachment();
			// MultipartFile 처리
			for (MultipartFile f : upFiles) {
				if (!f.isEmpty()) {
					// 사용자가 업로드한 파일명 구하기
					String originalFileName = f.getOriginalFilename();

					// 서버저장용 파일명
					String renamedFileName = Utils.getRenamedFileName(originalFileName);
					logger.debug("renamedFileName = " + renamedFileName);

					// 실제서버에 파일저장
					try {
						f.transferTo(new File(saveDirectory + "/" + renamedFileName));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}

					// 첨부파일객체 생성. 리스트 추가
					
					attach.setOriginalFileName(originalFileName);
					attach.setRenamedFileName(renamedFileName);
					
				}
			}

			// 2. 업무로직
			int menuNo = sellerService.selectMenuNo(menu.getStoreNo());
			String menuCode = "";

			if (menuNo == 0) {
				logger.debug("☆★☆★☆★☆★☆★메뉴넘버 있냐? " + menuNo);
				menuNo = 1;
				logger.debug("☆★☆★☆★☆★☆★메뉴넘버 몇이냐? " + menuNo);
			}

			else {
				++menuNo;
				logger.debug("☆★☆★☆★☆★☆★메뉴넘버가 있다면 몇이냐? " + menuNo);

			}

			menuCode = menu.getStoreNo() + menuOptions + menuNo;
			menu.setMenuCode(menuCode);
			menu.setMenuNo(menuNo);
			
			attach.setMenuCode(menuCode);
			menuAttachList.add(attach);
			
			logger.debug("menuAttachList ---------- " + menuAttachList);
			
			// 2-1. 업무로직
			int result = sellerService.insertMenu(menu, menuAttachList);

			if (result > 0) {
				msg = "메뉴 추가 성공!";
			} else {
				msg = "메뉴 추가 실패!";
			}

			
		} catch (Exception e) {
			logger.error("메뉴 등록 에러", e);
			throw new MenuException("메뉴 등록 에러", e);
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);
		model.addAttribute("view", view);

		return "redirect:/seller/myStoreMenu.do?storeNo=" + menu.getStoreNo() + "&sellerId=" + sellerId;
	}
	
	/**
     * 종합 보기에서 저번주의 매장 판매량을 가지고 온다.
     * @param sellerId
     * @return
     */
    @ResponseBody
    @RequestMapping("/chart/totalSaleVolume.do")
    public List<Map<String,String>> totalSaleVolume(@RequestParam String sellerId,@RequestParam String type){
    	logger.debug("totalSaleVolumeofWeek Method Param : "+sellerId+" : "+type);
    	List<Map<String,String>> saleVolume = sellerService.totalSaleVolume(sellerId,type);
    	logger.debug(saleVolume);
    	return saleVolume;
    }

    
	/* 리뷰관리로 들어가기 */
    @RequestMapping("/seller/goSellerReview.do")
    public String goSellerReview(@RequestParam("storeNo") String storeNo,Model model) {
    	System.out.println(storeNo);
    	//댓글 가져오기
    	List<Review> review1 = sellerService.getReview1(storeNo);
    	//답댓글 가져오기
    	List<Review> review2 = sellerService.getReview2(storeNo);

    	model.addAttribute("review1", review1);
    	model.addAttribute("review2", review2);

    	return "seller/sellerReview";
    }
    @RequestMapping(value = "/seller/myStoreChart.do" )
	public String myStoreChart(@RequestParam("storeNo") String storeNo,@RequestParam("sellerId") String sellerId ,Model model) {
		//logger.debug("통계 페이지 넘어가기 전에 : "+storeNo+ " : " +sellerId);
		Map<String,String> info = new HashMap<>();
		info.put("storeNo",storeNo);
		info.put("sellerId",sellerId);
		info.put("type","today");
		List<Map<String,String>> saleVolume = sellerService.totalSaleVolume(info);
		logger.debug("오늘 자 판매량 데이터 : "+saleVolume);
		model.addAttribute("saleVolume",saleVolume);
		model.addAttribute("storeNo",storeNo);


		
		return "seller/myChart";
	}
    @ResponseBody
	@RequestMapping("seller/chartByPeriod.do")
	public List<Map<String, String>> chartByPeriod(@RequestParam(name="startDate") String startDate, @RequestParam(name="endDate") String endDate, 
												   @RequestParam(name="storeNo") String storeNo, @RequestParam(name="type") String type) {
		logger.debug("시작날짜 : " +startDate+" , 끝 날짜 : "+endDate+", 타입 : "+type);
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeNo",storeNo);
		map.put("type",type);
		List<Map<String,String>> chartByWeek = sellerService.chartByPeriod(map);
		logger.debug(chartByWeek);
		
		return chartByWeek;
	}
    
    @RequestMapping("/seller/askDuplicationLogin.do")
    public ModelAndView askDuplicationLogin(@RequestParam(name="sellerId") String sellerId,ModelAndView mav,HttpServletResponse response) {
    	logger.debug("중복 검사를 하는 컨트롤러!");
    	Seller seller = new Seller();
    	seller.setSellerId(sellerId);
    	
    		LoginDTO dto = new LoginDTO();
        	dto.setUseCookie(true);
        	if(dto.isUseCookie()) {
    			 //쿠키사용한다고 체크되어 있으면
    			 //쿠키를 생성 및 현재 로그인 되어있을때의 세션 id를 쿠키에 저장한다. 
        		 logger.debug(loginSession.get(sellerId));
    			 Cookie cookie = new Cookie("loginCookie" , loginSession.get(sellerId));
    			  //쿠키를 찾을 경로를 컨텍스트 경로로 변경해 줌.
    			 cookie.setPath("/");
    			 int amount = 60*60*24*7;
    			 cookie.setMaxAge(amount); //단위는 (초)임으로 7일정도로 유효시간을 서정해줌.
    			 //쿠키적용해줌
    			 response.addCookie(cookie);
    		 } //end of if dto.isUseCookie
    	
    	mav.addObject("seller",seller);
    	mav.setViewName("common/duplicationLoginMsg");
    	return mav;
    }
    
    @RequestMapping("/seller/goIndexPage.do")
    public String goIndexPage() {
    	return "index";
    }
    
    //웹소켓클래스에서 강제 로그아웃시키기위해  현재 로그인되어있는 세션을 찾기위해 세션ID값 및 VO객체를 가져옴.
    public Seller selectSellerBySellerId(String sellerId) {
    	return sellerService.selectSellerBySellerId(sellerId);
    }
}


