package com.kh.god.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.kh.god.common.email.SendEmail;
import com.kh.god.common.message.MessageSend;
import com.kh.god.common.util.Utils;
import com.kh.god.common.websocket.WebSocketHandler;
import com.kh.god.member.model.service.MemberService;
import com.kh.god.member.model.vo.Member;
import com.kh.god.member.model.vo.RAttachment;
import com.kh.god.member.model.vo.Review;
import com.kh.god.member.model.vo.WebReview;
import com.kh.god.seller.model.service.SellerService;
import com.kh.god.seller.model.vo.Seller;
import com.kh.god.storeInfo.model.vo.StoreInfo;



/*******************final 프로젝트 *******************/
@Controller
@SessionAttributes(value = {"memberLoggedIn"}) //value = 문자열 배열로 여러개 넣을수도잇음!
public class MemberController {
	private Map<String,WebSocketSession> memberSession ;
	Logger logger = Logger.getLogger(getClass());
	
	//DI : 스프링은 빈을 관리시, 기본적으로 싱글턴을 처리한다.
	@Autowired
	MemberService memberService;
	@Autowired
	SellerService sellerService;
	//bean 하나 더 가져오기
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder; 
	
	/** 회원 가입페이지 이동 : memberEnroll */
	@RequestMapping("/member/memberEnroll.do")
	public String memberEnroll() {	

		if(logger.isDebugEnabled()) { //지금 디버그 모드라면 
			logger.debug("회원등록'페이지' 요청"); //다음을 실행해라 (성능변화가 없음)			
		}
		return "/member/memberEnroll";	// 
	}	
	
	/** 회원 가입 : insertMember */
	@RequestMapping("/member/memberEnrollEnd.do")
	public ModelAndView insertMember(Member m, @RequestParam (name="upFile",required = false) MultipartFile upFiles,	
							   		 HttpServletRequest request, ModelAndView mav) {
		
		logger.debug("회원등록 요청");		
		logger.debug("fileName= "+ upFiles.getOriginalFilename());
		
		try {
			//1. 파일 업로드
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/member");
			logger.debug(saveDirectory);
			
			//2. multipartFile 처리
			if(!upFiles.isEmpty()) {
				//파일명 (업로드용) 
				String oldFile = upFiles.getOriginalFilename();
				m.setOldFile(oldFile);

				//파일명(서버저장용)
				String renamedFile = Utils.getRenamedFileName(oldFile);
				m.setRenamedFile(renamedFile);
				
	    		//실제 파일 저장
	    		try {
	    			upFiles.transferTo(new File(saveDirectory+"/"+renamedFile));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
	    		    		
			}       
			
			//BCrypt 방식 암호화
	        String temp = m.getPassword();	        
	        m.setPassword(bCryptPasswordEncoder.encode(temp));
	       
	        
	     
	        //회원가입 진행
	        int result = memberService.insertMember(m);
	        String loc="/"; 
	        String msg ="";
	        String view = "common/msg";
	        
			if(result>0) {
				msg = "회원가입성공"; 
				loc = "/member/memberView.do?memberId="+m.getMemberId(); 				
			}else {
				msg="회원가입실패!";
			}

			mav.addObject("loc", loc);
			mav.addObject("msg", msg);
			mav.setViewName(view);
			 
		}catch(Exception e) {
	    	logger.error("게시물 등록 에러", e);
	    }
        
        return mav;
     }
	
	/** 회원 정보 수정 : memberUpdate */
	@RequestMapping("/member/memberUpdate.do")
	public ModelAndView memberUpdate(Member m, @RequestParam (name="upFile",required = false) MultipartFile upFiles,	
	   		 						 HttpServletRequest request, ModelAndView mav) {	
		if(logger.isDebugEnabled()) { 
			logger.debug("회원정보 업데이트 요청"); 	
			logger.debug(m);
			logger.debug(m.getRenamedFile());		
		}
		
		try {
			//1. 파일 업로드
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/member");
			
			//2. multipartFile 처리
			if(!upFiles.isEmpty()) {
				//파일명 (업로드용) 
				String oldFile = upFiles.getOriginalFilename();
				m.setOldFile(oldFile);

				//파일명(서버저장용)
				String renamedFile = Utils.getRenamedFileName(oldFile);
				m.setRenamedFile(renamedFile);
				
	    		//실제 파일 저장
	    		try {
	    			upFiles.transferTo(new File(saveDirectory+"/"+renamedFile));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
	    		    		
			}       
			
		//BCrypt 방식 암호화
		String temp = m.getPassword();
		System.out.println("password-----------------------------"+temp);
		if(temp.length() != 0) {
			m.setPassword(bCryptPasswordEncoder.encode(temp));
		}
	 
		 int result = memberService.updateMember(m);
		
		 String loc = "/";
	     String msg = ""; 
	     String view = "common/msg"; 
	     
	     if(result>0) {
	    	 msg = "회원정보 수정완료";
	    	 loc = "/member/memberView.do?memberId="+m.getMemberId();	    	 
	     }
	     else {
	    	 msg = "회원정보 수정실패";
	     }
	     
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.setViewName(view);
			 
		}catch(Exception e) {
	    	logger.error("게시물 등록 에러", e);
	    }
     
		return mav;
	}

	/** 회원 정보 삭제 : memberDelte */
	@RequestMapping("/member/memberDelete.do")
	public ModelAndView memberDelete(@RequestParam String memberId, ModelAndView mav) {
		if(logger.isDebugEnabled()) { 
			logger.debug(memberId+"회원의 '회원삭제' 요청"); 					
		}		
		
		int result = memberService.deleteMember(memberId);
		
		String loc="/"; 
		String msg ="";
		String view = "common/msg";
		       
		if(result>0) {
			msg = "회원삭제성공"; 
						
		}else {
			msg="회원삭제실패!";
			loc = "/member/memberView.do?memberId="+memberId; 	
		}

		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.setViewName(view);
		
				
		return mav; 		
	}
	
	/** 회원 정보 조회 : memberView */
	@RequestMapping("/member/memberView.do")
	public String memberView(@RequestParam String memberId, Model model) {	
		if(logger.isDebugEnabled()) { 
			logger.debug(memberId+"회원의 '회원정보' 페이지 요청"); 					
		}		
		Member m = memberService.selectOneMember(memberId);
		
		model.addAttribute("m", m);
		
		String view = "member/memberView";
				
		return view; 
	}
	

	/** 주문 내역 조회 : orderList */
	@RequestMapping("/member/orderList.do")
	public String orderList(@RequestParam String memberId, Model model) {	
	
		//맵으로 받는다(join 하므로)
		List<Map<String,String>> orderList = memberService.orderList(memberId);
	
		model.addAttribute("orderList", orderList);
		
		String view = "member/memberOrder";
		return view; 
				
	}

	
	
	/** 리뷰 내역 조회 : reviewList */
	@RequestMapping("/member/reviewList.do")
	public String reviewList(@RequestParam String memberId, Model model) {	
		
		//1. 리뷰리스트를 꺼내고
		List<Review> reviewList = memberService.reviewList(memberId);
	
		//2. 리뷰 첨부파일을 담을 리스트를 선언한다. 
		List<RAttachment> attachList = new ArrayList<>();
		
		if(reviewList != null) {			
			//리스트를 돌면서 reviewNo가 일치하는 첨부파일을 꺼내서 리스트에 담는다
			for(Review r : reviewList) {	
				
				List<RAttachment> tempList = memberService.selectRAttachmentList(r.getReviewNo());			
				for(RAttachment ra : tempList) {
					attachList.add(ra);
				}
				
			}			
		}
				
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("attachList", attachList);
		
		logger.debug(attachList);
		
		String view = "member/memberReview";
		return view; 				
	}

	
	
	/** 리뷰작성 페이지 이동: memberReviewEnroll */
	@RequestMapping("/member/memberReviewEnroll.do")
	public String memberReviewEnroll(@RequestParam(name="orderNo") String orderNo,
									 @RequestParam(name="storeNo") String storeNo,
									 @RequestParam(name="writer") String writer, Model model) {	

		if(logger.isDebugEnabled()) { //지금 디버그 모드라면 
			logger.debug("회원 리뷰작성'페이지' 요청"); //다음을 실행해라 (성능변화가 없음)		
			logger.debug("리뷰페이지의 : "+storeNo);
		}
		
		List<Map<String,String>> orderMenuList = memberService.selectOrderMenuList(orderNo);
		//리뷰 작성할 가게 사장님 아이디 구해오기(알람용)
		String sellerId = sellerService.selectSellerIdByStoreNo(storeNo);
		logger.debug(sellerId);
		
		model.addAttribute("sellerId", sellerId);
		model.addAttribute("orderNo", orderNo);
		model.addAttribute("orderMenuList", orderMenuList);	
		model.addAttribute("storeNo", storeNo);
		model.addAttribute("writer", writer);
		
		return "/member/memberReviewEnroll"; 
	}
	
	/** 리뷰등록 : memberReviewEnrollEnd */
	@RequestMapping("/member/memberReviewEnrollEnd.do")
	public ModelAndView insertMemberReview(Review review, 
										   @RequestParam (name="upFile",required = false) MultipartFile[] upFiles,	
	   		 							   HttpServletRequest request, ModelAndView mav) {
		
		logger.debug("리뷰등록 요청");		
		
		try {
		//1. 파일 업로드
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/review");
		logger.debug(saveDirectory);
		
		List<RAttachment> attachList = new ArrayList<>();
		
		//2. multipartFile 처리
		for(MultipartFile f : upFiles) {
			
			if(!f.isEmpty()) {
				
				//파일명(업로드)
				String originalFileName = f.getOriginalFilename();				
				//파일명(서버저장용)
				String renamedFileName = Utils.getRenamedFileName(originalFileName);
				
				logger.debug("renamedFileName="+renamedFileName);
				
				//실제 서버에 파일 저장
				try {
					f.transferTo(new File(saveDirectory+"/"+renamedFileName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				//첨부파일객체 생성 . 리스트 추가 
				RAttachment attach = new RAttachment();
				attach.setOriginalFileName(originalFileName);
				attach.setRenamedFileName(renamedFileName);
				attachList.add(attach);			
			}// end of if
		} // end of forEach
		
		
		String loc="/"; 
		String msg ="";
		String view = "common/msg";		
		
		//리뷰등록 진행 : storeNo 안들어가는중
		int result = memberService.insertMemberReview(review); //리뷰등록
		logger.debug(review.getOrderNo());
		
		//리뷰 등록 후 해당 리뷰의 reviewNo 구해오기
		if(result > 0) {
			review = memberService.selectOneReview(review.getOrderNo());		
		}else {
			msg = "리뷰 등록 실패"; 
		}
			
		//포문 돌려서 진행
		int attachResult = 0;
		for(RAttachment a : attachList) {
			a.setReviewNo(review.getReviewNo());
			attachResult += memberService.insertRAttachment(a);//사진 등록
		}
		
		
		logger.debug("첨부파일 갯수"+attachList.size());
		logger.debug("성공한 첨부파일 등록 결과값"+attachResult);
		
		if(result>0) {
			msg = "리뷰 등록 성공";
			loc = "/member/reviewList.do?memberId="+review.getWriter(); 				
		}else{
			msg = "리뷰 등록 실패"; 
		}
		
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.setViewName(view);
		
		}catch(Exception e) {
			logger.error("게시물 등록 에러", e);
		}
		
		return mav;
	}

	/** 리뷰 삭제 페이지 : */
	@RequestMapping("/member/memberReviewDelete.do")
	public ModelAndView deleteMemberReview(@RequestParam(name="reviewNo") String reviewNo,
										   @RequestParam(name="writer") String writer, ModelAndView mav) {
		
		logger.debug("리뷰삭제 요청");		

		//리뷰등록 진행 : storeNo 안들어가는중
		int result = memberService.deleteMemberReview(reviewNo); //리뷰등록
		
		
		String loc="/"; 
		String msg ="";
		String view = "common/msg";		
	
		if(result>0) {
			msg = "리뷰 삭제 성공";
			loc = "/member/reviewList.do?memberId="+writer;				
		}else{
			msg = "리뷰 삭제 실패"; 
		}
		
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.setViewName(view);
		

		return mav;
	}
	
	/** 즐겨찾는 매장 조회 : bookMarkList */
	@RequestMapping("/member/bookMarkList.do")
	public String bookMarkList(@RequestParam String memberId, Model model) {	
	
		List<StoreInfo> bookmarkList = memberService.bookMarkList(memberId);
		
		model.addAttribute("bookmarkList", bookmarkList);
		
		String view = "member/memberBookMark";
				
		return view; 
	}
	

	/** 일반회원 로그인 : memberLogin */
	@RequestMapping(value = "/member/memberLogin.do", method = RequestMethod.POST)
    public ModelAndView memberLogin(@RequestParam String memberId, @RequestParam String password,
                              ModelAndView mav, HttpSession session) {
	memberSession = WebSocketHandler.getInstance().getUserList();
	List<WebSocketSession> web = WebSocketHandler.getInstance().getSessionList();
      if(logger.isDebugEnabled()) {
         logger.debug("회원 로그인 요청");
      }
        Member m = memberService.selectOneMember(memberId);
        
        String msg = "";
        String loc = "/";
        String view = "/common/msg";
        boolean loginFlag = true;
        //로그인 처리
        if(m == null) {
            msg = "아이디가 존재하지 않습니다.";
        }else {
        	Set<String> keyValue = memberSession.keySet();
			logger.debug("keyValue : "+keyValue);
			Iterator<String> iterator = keyValue.iterator();
			while(iterator.hasNext()) {
				String loginId = iterator.next();
				logger.debug("로그인 되어있는 아이디!"+ loginId+", 로그인을 요청한 아이디 : "+ m.getMemberId());
				if(m.getMemberId().equals(loginId)) {					
					msg = "이미 로그인한 아이디가 있습니다.";
					loc="/";
					loginFlag = false;
				}				
			}
            //비밀번호 비교
           if(loginFlag == true) {
            if(bCryptPasswordEncoder.matches(password, m.getPassword())) {
                mav.addObject("memberLoggedIn",m);
                session.setAttribute("loginId",m.getMemberId());
                view = "redirect:/";
            }else {
            	msg = "비밀번호를 잘못 입력하셨습니다.";
            } 
           }
        }
        
        mav.addObject("loc", loc);
        mav.addObject("msg", msg);
        mav.setViewName(view);
        
        return mav;
    }

	/** 일반회원 로그아웃 : memberLogout */
	@RequestMapping("/member/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus,@RequestParam String memberId,HttpSession session) {

		if(logger.isDebugEnabled()) {
			logger.debug("로그아웃 요청");			
		}
		memberSession = WebSocketHandler.getInstance().getUserList();
		
		session.setAttribute("loginId",null);
		//session.setAttribute("memberLoggedIn",null);
		//session.setAttribute() 로 로그인 했다면 session.invalidate() 로 무효화
		//session.invalidate();
		
		WebSocketHandler.getInstance().getUserList().remove(memberId);

		//@sessionAttribute 로 로그인 했다면, sessionStatus.setComplete() 로 무효화
		if(!sessionStatus.isComplete()) sessionStatus.setComplete();

		return "redirect:/";
	}

	/** 일반회원 아이디 중복체크 : checkIdDuplicate(지금 안쓰고 있음) */
	 @RequestMapping("/member/checkIdDuplicate.do")
	 @ResponseBody
	 public Map<String,Object> checkIdDuplicate(@RequestParam("memberId") String memberId) {
	 //처리된 값을 받아둘 model 객체 선ㅇ너
	 
		 logger.debug("ID중복체크 : "+memberId); 
		 Map<String,Object>map = new HashMap<>();
		 
		 Member m = memberService.selectOneMember(memberId); 
		 boolean isUsable = m == null? true:false;
		 
		 map.put("isUsable", isUsable);
	 
		 return map; //BeanNameViewResolver에 의해 처리될 bean 객체 
	 
	 }
	 
	 @RequestMapping("/member/getDiscount.do")
	 @ResponseBody
	 public Map<String,Object> getDiscount(@RequestParam("eventNo") String eventNo,
			 @RequestParam("price") int price) {
	 //처리된 값을 받아둘 model 객체 선ㅇ너
	 
		 logger.debug("이벤트넘 : "+eventNo);
		 logger.debug("결제가격 : "+price); 

		 Map<String,Object>map = new HashMap<>();
		 double discount = memberService.getDiscount(eventNo); 
		 if(discount<1) {
			 price = (int) (price*discount);
		 } else {
			 price = (int) (price-discount);
		 }

		 map.put("totalPrice", price);

		 return map; //BeanNameViewResolver에 의해 처리될 bean 객체 
	 
	 }

	 
	 /** 일반회원 북마크 관리 : checkBookMark */
	 @RequestMapping("/member/checkBookMark.do")
	 @ResponseBody
	 public int checkBookMark(@RequestParam("memberId") String memberId, 
			 				  @RequestParam("storeNo") String storeNo, @RequestParam("value") int value){
		 
		 int result = 0;
		 int checkedBookMark = 0; //북마크 되어있는지 여부
		 
		 Map<String, String> map = new HashMap<>();
		 map.put("memberId", memberId);
		 map.put("storeNo", storeNo);
		 
		 System.out.println("--------------------------------------");
		 System.out.println(map);
		 
		 if(value == 0) { //value = 0 > insertBookMark
			 result = memberService.insertBookMark(map);
		 }else { //value = 1 > deleteBookMark
			 result = memberService.deleteBookMark(map);
		 }
		 
		 if(result <0) { //error! insert/delete 전부 실행한됨
			 
		 }else {
			 checkedBookMark = memberService.checkBookMark(map);
		 }
		 
		 return checkedBookMark;
	 }
	 
	 //지역별 검색
	 @RequestMapping("/member/searchByLoaction")
	 public String searchByLoaction(@RequestParam("location") String location , Model model) {
		// String[] locationArr = location.split(" ");
		// location = locationArr[0] + locationArr[1];
		 //logger.info("@@@@@@@@@@@@@@@@@@@@@@@2location"+location);
		 //List<StoreInfo> searchByLoaction = memberService.searchByLoaction(location);
		 List<StoreInfo> storeInfoAll = memberService.selectAllstoreInfo();
		 
		 logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@List" + storeInfoAll);
		 logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@Location" + location);
		 
		 model.addAttribute("location" , location);
		 model.addAttribute("storeInfoList" , storeInfoAll);
		 
		 return "storeInfo/searchByLocation";
	 }

	 @RequestMapping("/member/findId.do")
	 @ResponseBody
	 public Map<String, Object> findId(@RequestParam("email") String email){
		 Map<String, Object> map = new HashMap<>();
		 
		 Member m = memberService.findId(email) ;
		 String msg = "아이디가 이메일로 발송 되었습니다.";
		 
		 if(m == null) {
			 Seller s = memberService.sellerfindId(email);	
			 if(s == null) {
				 msg = "등록된 이메일이 없습니다.";
			 }else {
				msg = "아이디가 이메일로 발송 되었습니다.";
				
				new SendEmail().mailSending(s.getEmail() , s.getSellerName() , s.getSellerId());
			 }
		 }else {
			 
			new SendEmail().mailSending(m.getEmail() , m.getMemberName() , m.getMemberId());
		 }
		
		 map.put("msg" , msg);
		 
		 
		 return map;
	 }
	 
	
	  @RequestMapping(value="/member/findPwd.do" ,method = RequestMethod.POST )
	  @ResponseBody 
	  public Map<String, Object> findPwd(@RequestParam("id") String id , @RequestParam("phone") String phone){
		  Map<String, Object> map = new HashMap<>();
		  
		  Member m = memberService.selectOneMember(id) ;
		  String userPhone="";
		  String msg = "임시비밀번호가 핸드폰으로 발송 되었습니다.";
		  boolean phoneEquals ;
		  String rndPwd ;
		  int result ;
		  String temp ;
			 
			 if(m == null) {
				 
				 Seller s = memberService.selectOneSeller(id);
				 if(s == null) {
					 msg = "등록된 아이디가 없습니다.";
				 }else {
					 //셀러 핸드폰으로 임시 번호 발송 및 데이터 업데이트
					 userPhone = s.getPhone();
					 if(userPhone.contains("-")) {
							userPhone = userPhone.replaceAll("-", "");
							phoneEquals = userPhone.equals(phone);
							
							if(phoneEquals == true) {
								rndPwd = new Utils().getRandomPassword(10);
								temp = (bCryptPasswordEncoder.encode(rndPwd)) ;
								s.setPassword(temp);
								logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2"+rndPwd);
								logger.debug("$$$$$$$$$$$$$$$$$$$$$$$$"+temp);
								result = memberService.updateFindPwd(s);
								new MessageSend().findPwd(rndPwd , s.getPhone());
								
							}else {
								msg ="핸드폰 번호가 등록된 정보와 일치하지 않습니다.";
							}
							
						}
				 }
				 
			 }else {
				 	//멤버 헨드폰으로 임시 번호 발송 및 데이터 업데이트 
				 userPhone = m.getPhone();
				 if(userPhone.contains("-")) {
						userPhone = userPhone.replaceAll("-", "");
						phoneEquals = userPhone.equals(phone);
						
						if(phoneEquals == true) {
							rndPwd = new Utils().getRandomPassword(10);
							temp = (bCryptPasswordEncoder.encode(rndPwd)) ;
							m.setPassword(temp);
							logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2"+rndPwd);
							logger.debug("$$$$$$$$$$$$$$$$$$$$$$$$"+temp);
							result = memberService.updateMemberFindPwd(m);
							new MessageSend().findPwd(rndPwd , m.getPhone());
							
						}else {
							msg ="핸드폰 번호가 등록된 정보와 일치하지 않습니다.";
						}
						
					}
				 
			 }
			 map.put("msg" , msg);
		  
		  return map ;
		  
	  }
	  
	  @RequestMapping(value="/member/webreview.do")
	  public String webReview(Model model ,@RequestParam(value = "cPage", defaultValue = "1") int cPage ) {
		  
		  	

			int numPerPage = 6;
			
			// 1. 게시글리스트 (페이징 적용된 것)
			System.out.println(cPage);
			List<WebReview> wr = memberService.selectListWebReiveiw(cPage, numPerPage);

			// 2. 전체컨텐츠수
			int totalContents = memberService.selectWebReiveiwTotalContents();
		  
		  
		
		  
			 model.addAttribute("cPage", cPage);
			 model.addAttribute("numPerPage", numPerPage);
			 model.addAttribute("totalContents", totalContents);
			 model.addAttribute("wr" , wr);
		  
		  
		  return "/member/webReview";
	  }
	  
	
	  @RequestMapping(value="/member/webreviewform.do") 
	  public String webReviewForm() {
	  
	  return "/member/webReviewForm"; 
	  }
	  
	  @RequestMapping(value="/member/webreviewformEnd.do" ,  method = RequestMethod.POST) 
	  public String webReviewFormEnd(WebReview wr , Model model , @RequestParam("star") String star) {
		  
		  
		  star = star.substring(0,1);
		  
		  wr.setRate(star);
		  
		  int result = memberService.insertWebReview(wr);
		  
		  String msg = "";
		  String loc = "/member/webreview.do";
		  String view = "/common/msg";
		  if(result > 0) {
			  msg = "후기가 등록되었습니다. 감사합니다.";
		  }else {
			  msg ="후기 등록 실패";
		  }
		  model.addAttribute("loc" , loc);
		  model.addAttribute("msg" , msg);
		  
		  
		  return view; 
	  }
	
	  
	  
	  
	  
	  
	  
	
}



