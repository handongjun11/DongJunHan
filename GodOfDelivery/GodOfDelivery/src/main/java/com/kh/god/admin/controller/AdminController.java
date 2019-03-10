package com.kh.god.admin.controller;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.god.admin.model.service.AdminService;
import com.kh.god.admin.model.vo.Ad;
import com.kh.god.admin.model.vo.Coupon;
import com.kh.god.admin.model.vo.Event;
import com.kh.god.admin.model.vo.QnaBoard;
import com.kh.god.admin.model.vo.Report;
import com.kh.god.common.util.Utils;
import com.kh.god.member.model.vo.Review;
import com.kh.god.seller.model.vo.OrderInfo;
import com.kh.god.seller.model.vo.Seller;
import com.kh.god.storeInfo.model.vo.StoreInfo;


@Controller
public class AdminController {
	Logger logger = Logger.getLogger(getClass());
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = "/index.do")
	public Model index(Model model) {
		
		//현재 진행중인 이벤트 목록 받아오기
		List<Event> eventList = adminService.carouselEvent();
		model.addAttribute("carouselEvent", eventList);
		
		
		model.addAttribute("index");
		return model;
	}
	
	@RequestMapping("/admin/qnaboard.do")
	public String selectBoardList(@RequestParam(value="cPage",defaultValue="1") int cPage, Model model) {
		
		int numPerPage = 10;
		
		List<Map<String,String>> list = adminService.selectBoardList(cPage,numPerPage);
		
		int totalContents = adminService.countBoardList();
		
		model.addAttribute("cPage",cPage);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("list",list);
		
		model.addAttribute("totalContents",totalContents);
		
		return "admin/boardList";
	}

	@RequestMapping("/admin/dashBoard.do")
	public void dashBoard(Model model) {
		int qnaCount = adminService.countQnaControlList();
		int storePMSCount = adminService.countStorePMSList();
		model.addAttribute("qnaCount",qnaCount);
		model.addAttribute("storePMSCount",storePMSCount);
	}

	@RequestMapping("/admin/eventForm.do")
	public void eventForm() {
	}
	
	@RequestMapping("/admin/eventList.do")
	public String eventList(@RequestParam(value="cPage",defaultValue="1") int cPage, Model model,@RequestParam(value="status",defaultValue="all") String status) {
		int numPerPage = 10;
		List<Map<String,String>> list =null; 
		int totalContents  = 0; 
		
		if(status.equals("all")){
			list = adminService.eventAllList(cPage,numPerPage);
			totalContents= adminService.countEventAllList();
		}else if(status.equals("ing")){
			list = adminService.eventIngList(cPage,numPerPage);
			totalContents= adminService.countEventIngList();
			
		}else if(status.equals("end")){
			list = adminService.eventEndList(cPage,numPerPage);
			totalContents= adminService.countEventEndList();
		}else if(status.equals("store")) {
			list = adminService.eventStoreList(cPage,numPerPage);
			totalContents = adminService.countEventStoreList();
		}
		
		model.addAttribute("cPage",cPage);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("totalContents",totalContents);
		model.addAttribute("list",list);
		model.addAttribute("status",status);
		return "admin/eventList";
	}
	
	@RequestMapping("/admin/insertEvent.do")
	public ModelAndView insertEvent(@RequestParam(name="eventTitle") String eventTitle,@RequestParam(name="amount") int amount,
									@RequestParam(name="startDate") Date startDate, @RequestParam(name="endDate") Date endDate,
									@RequestParam(name="discount") String discount,@RequestParam(name="upFile",required=false) MultipartFile[] upFiles, HttpServletRequest request, ModelAndView mav) {
	

			//file upload
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/event");
			
			int eventNo = adminService.getLastEventNo();
			
			String oSmall = upFiles[0].getOriginalFilename();
			String oBig = upFiles[1].getOriginalFilename();
			String rSmall = Utils.getRenamedEventFileName(oSmall,"s",eventNo);
			String rBig = Utils.getRenamedEventFileName(oBig,"b",eventNo);
			
			
			//실제 서버에 파일 저장
			try {
				upFiles[0].transferTo(new File(saveDirectory+"/"+rSmall));
				upFiles[1].transferTo(new File(saveDirectory+"/"+rBig));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
			Event event = new Event();
			event.setEventTitle(eventTitle);
			event.setDiscount(discount);
			event.setAmount(amount);
			event.setStartDate(startDate);
			event.setEndDate(endDate);
			event.setEventBig(rBig);
			event.setEventSmall(rSmall);
		
			int result = adminService.insertEvent(event);
			
			//view
			
			String msg = "";
			if(result>0) {
				msg="게시물 등록 성공";
			}else {
				msg = "게시물 등록 실패";
			}
			
			mav.addObject("msg",msg);
			mav.addObject("loc","/admin/eventList.do");
			mav.setViewName("common/msg");
		
		return mav;
			
	}
	
	@RequestMapping("/admin/boardView.do")
	public String qnaboardView(@RequestParam int boardNo, Model model) {
		QnaBoard b = adminService.qnaBoardView(boardNo);
		model.addAttribute("board",b);
		return "admin/boardView";
	}
	
	@RequestMapping("/admin/allMemberList.do")
	public String allMemberList() {
		return "/admin/allMemberList";
	}
	
	@RequestMapping("/admin/sellerList.do")
	public String selletList(@RequestParam(value="cPage",defaultValue="1") int cPage,Model model) {
		
		int numPerPage = 6;
		
		List<Map<String,String>> seller = adminService.selectSellerAllList(cPage,numPerPage);
		
		int totalContents = adminService.countSellerList();
		
		model.addAttribute("cPage",cPage);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("seller",seller);
		model.addAttribute("totalContents",totalContents);
		
		return "admin/sellerList";
		
	}
	
	@RequestMapping("/admin/eventView.do")
	public String eventView(@RequestParam(name="eventNo") int eventNo, Model model) {
		Event e = adminService.eventView(eventNo);
		model.addAttribute("event", e);
		return "admin/eventView";
	}
	
	@RequestMapping("/admin/sellerBlackList.do")
	public String SblackListChange(@RequestParam String sellerId, @RequestParam String bFlag, @RequestParam String page) {
		int result = 0;
		if((bFlag).equals("Y")) {
			result = adminService.changeSellerbFlagtoN(sellerId);
		}else {
			result = adminService.changeSellerbFlagtoY(sellerId);
		}
	
		if(page.equals("SList")) {
			return "redirect:/admin/sellerList.do";
		}else{
			return "redirect:/admin/sellerBList.do";
		}
	}
	
	@RequestMapping("/admin/memberBlackList.do")
	public String MblackListChange(@RequestParam String memberId, @RequestParam String bFlag, @RequestParam String page) {
		int result = 0;
		if((bFlag).equals("Y")) {
			result = adminService.changeMemberbFlagtoN(memberId);
		}else {
			result = adminService.changeMemberbFlagtoY(memberId);
		}
		
		if(page.equals("MList")) {
			return "redirect:/admin/memberList.do";
		}else {
			return "redirect:/admin/memberBList.do";
		}
	}
	
	@RequestMapping("/admin/askingList.do")
	public String askingList(@RequestParam(value="cPage",defaultValue="1") int cPage,@RequestParam(value="boardWriter") String boardWriter, Model model) {
		int numPerPage = 5;
		List<Map<String,String>> list = null;
		int totalContents = 0;
		
		list = adminService.selectQNAList(cPage,numPerPage,boardWriter);
		totalContents = adminService.countQNAList(boardWriter);
	
		List<QnaBoard> boardRefList = adminService.boardRefList();
		
		model.addAttribute("cPage",cPage);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("boardWriter",boardWriter);
		model.addAttribute("list",list);
		model.addAttribute("boardRefList",boardRefList);
		model.addAttribute("totalContents",totalContents);
		return "admin/askingList";
	}
	

	@RequestMapping("/admin/askingForm.do")
	public String askingForm(Model model, @RequestParam(value="boardWriter") String boardWriter) {
		
		model.addAttribute("boardWriter",boardWriter);
		
		return "admin/askingForm";
	}
	
	@RequestMapping("/admin/insertAsking.do")
	public ModelAndView insertAsking(@RequestParam(name="boardTitle") String boardTitle,@RequestParam(name="boardWriter") String boardWriter, @RequestParam(name="boardContent") String boardContent, ModelAndView mav) {
		QnaBoard board = new QnaBoard();
		board.setBoardTitle(boardTitle);
		board.setBoardWriter(boardWriter);
		board.setBoardContent(boardContent);
		
		int result = adminService.insertAsking(board);
		
		String msg = "";
		if(result>0) {
			msg="문의를 완료하였습니다!";
		}else {
			msg = "문의 실패ㅠ";
		}
		
		mav.addObject("msg",msg);
		mav.addObject("loc","/admin/askingList.do?boardWriter="+boardWriter);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("/admin/askingView.do")
	public String askingView(@RequestParam(name="boardNo") int boardNo, Model model) {
		QnaBoard b = adminService.qnaBoardView(boardNo);
		List<QnaBoard> boardRefList = adminService.boardRefList();
		model.addAttribute("board",b);
		model.addAttribute("boardRefList",boardRefList);
		return "admin/askingView";
	}
	
	@RequestMapping("/admin/answeringView.do")
	public String asnweringView(@RequestParam(name="boardNo") int boardNo,@RequestParam(name="boardRef") int boardRef, Model model) {
		QnaBoard b = adminService.qnaBoardView(boardRef);
		QnaBoard bRef = adminService.qnaBoardRefView(boardNo);
		logger.debug(b);
		logger.debug(bRef);
		
		model.addAttribute("board",b);
		model.addAttribute("boardRef",bRef);
		return "admin/answeringView";
	}
	
	@RequestMapping("/admin/memberList.do")
	public String memberList(@RequestParam(value="cPage",defaultValue="1") int cPage,Model model) {
		
		int numPerPage = 6;
		
		List<Map<String,String>> member = adminService.selectMemberAllList(cPage,numPerPage);
		
		int totalContents = adminService.countMemberList();
		
		model.addAttribute("cPage",cPage);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("member",member);
		model.addAttribute("totalContents",totalContents);
		
		return "admin/memberList";
	}

	@RequestMapping("/admin/eventFileDownload.do")
	public void fileDownload(@RequestParam String fileName, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		
		//파일 입출력 준비
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/event");
		
		//입력 스트림
		File f = new File(saveDirectory+"/"+fileName);
		FileInputStream fis = new FileInputStream(f);
		BufferedInputStream bis = new BufferedInputStream(fis);
		
		//출력스트림
		ServletOutputStream sos = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(sos);
		
		//전송할 파일명작성
		String resFileName = "";
		
		//요청브라우저에 따른 분기를 처리
		boolean isMSIE = request.getHeader("user-agent").indexOf("MSIE") != -1 //요청브라우저를 가져오는 key
						|| request.getHeader("user-agent").indexOf("Trident") != -1; //IE10 이전(MSIE), 이후(Trident)
		if(isMSIE) {
			//utf-8인코딩처리를 명시적으로 해줌
			resFileName = URLEncoder.encode(fileName, "UTF-8");
			//+로 처리된 공백을 다시 한 번 %20(공백의미)로 치환
			resFileName = resFileName.replaceAll("\\+", "%20");
		}else {
			resFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); //톰캣 기본 인코딩타입			
		}
		
		//파일전송
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename="+resFileName);
		
		//파일쓰기
		int read = -1;
		while((read=bis.read()) != -1) {
			bos.write(read);
		}
		bos.close();
		bis.close();
	}
	
	@RequestMapping("/admin/deleteEvent.do")
	public ModelAndView deleteEvent(@RequestParam("eventNo") int eventNo, HttpServletRequest request, ModelAndView mav){
		
		Event e = adminService.eventView(eventNo);
		int result = adminService.deleteEvent(eventNo);

		String loc = "/admin/eventList.do";
		String msg = "";
		
		if(result>0) {
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/event");
			File eventSmall = new File(saveDirectory+"/"+e.getEventSmall());
			File eventBig = new File(saveDirectory+"/"+e.getEventBig());
			System.out.println(eventSmall+"/"+eventBig);
			eventSmall.delete();
			eventBig.delete();
			msg = "이벤트 삭제 성공";
		}
		else {
			msg = "이벤트 삭제 실패";
		}
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		return mav;
	}
	

	@RequestMapping("/admin/qnaControl.do")
	public String qnaControl(Model model,@RequestParam(value="cPage",defaultValue="1") int cPage) {
		
		int numPerPage = 6;
		
		List<Map<String,String>> list = adminService.qnaControlList(cPage,numPerPage);
		int totalContents = adminService.countQnaControlList();
		
		
		model.addAttribute("cPage",cPage);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("list",list);
		model.addAttribute("totalContents",totalContents);
		
		return "admin/qnaControl";
	}
	
	@RequestMapping("/admin/qnaAnswer.do")
	public String qnaControl(@RequestParam(name="boardNo") int boardNo, Model model) {
		
		QnaBoard list = adminService.qnaAnswer(boardNo);
		model.addAttribute("board",list);
		
		return "admin/qnaAnswer";
	}
	
	@RequestMapping("/admin/insertAnswer.do")
	public String insertAnswer(@RequestParam(name="boardNo") int boardNo, @RequestParam(name="answerTitle") String answerTitle, @RequestParam(name="boardWriter") String boardWriter, @RequestParam(name="answerContent") String answerContent, Model model) {
		QnaBoard answer = new QnaBoard();
		answer.setBoardTitle(answerTitle);
		answer.setBoardContent(answerContent);
		answer.setBoardWriter(boardWriter);
		answer.setBoardRef(boardNo);
		answer.setCategory("answer");
		answer.setBoardLevel(2);
		
		int result = adminService.insertAnswer(answer);
		
		return "redirect:/admin/qnaControl.do";
	}
	
	@RequestMapping("/admin/sellerBList.do")
	public String selectSellerBL(@RequestParam(value="cPage",defaultValue="1") int cPage, Model model) {
	
		int numPerPage = 6;
		List<Map<String,String>> seller = adminService.selectSellerBL(cPage, numPerPage);
		int totalContents = adminService.countSellerBL();

		model.addAttribute("list",seller);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("cPage",cPage);
		model.addAttribute("totalContents",totalContents);
		
		 return "admin/sellerBList";
	}
	
	@RequestMapping("/admin/memberBList.do")
	public String selectMemberBL(@RequestParam(value="cPage",defaultValue="1") int cPage, Model model) {
		
		int numPerPage = 6;
		List<Map<String,String>> member = adminService.selectMemberBL(cPage, numPerPage);
		int totalContents = adminService.countMemberBL();

		model.addAttribute("list",member);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("cPage",cPage);
		model.addAttribute("totalContents",totalContents);
		
		 return "admin/memberBList";
	}
	
	@RequestMapping("/admin/adControl.do")
	public String adControl(@RequestParam(value="cPage",defaultValue="1") int cPage, @RequestParam(value="status",defaultValue="all") String status, Model model) {
		
		int numPerPage = 6;
		List<Map<String,String>> adList = null;
		int totalContents = 0;
		if(status.equals("all")) {
			adList = adminService.selectAdList(cPage,numPerPage);
			totalContents = adminService.countAdList();
		}else if(status.equals("ading")) {
			adList = adminService.selectAdingList(cPage,numPerPage);
			totalContents = adminService.countAdingList();
			
		}else if(status.equals("aded")) {
			adList = adminService.selectAdedList(cPage,numPerPage);
			totalContents = adminService.countAdedList();
			
		}
		
		model.addAttribute("adList",adList);
		model.addAttribute("status",status);
		model.addAttribute("cPage",cPage);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("totalContents",totalContents);
		
		return "admin/adControl";
	}
	
	@RequestMapping("/admin/adStoreView.do")
	public String adStoreView(@RequestParam(name="storeNo") String storeNo, @RequestParam(name="adNo") int adNo, Model model ) {
		StoreInfo store = adminService.adStoreView(storeNo);
		Ad ad = adminService.adStoreAdView(adNo);
		model.addAttribute("store",store);
		model.addAttribute("ad",ad);
		return "admin/adStoreView";
	}
	
	@RequestMapping("/admin/deleteAd.do")
	public String deleteAd(@RequestParam(name="adNo") String adNo, @RequestParam(name="storeNo") String storeNo) {
		Map<String,String> map = new HashMap<>();
		map.put("adNo",adNo);
		map.put("storeNo",storeNo);
		int result = adminService.deleteAd(map);
		
		return "redirect:/admin/adControl.do";
	}

	@RequestMapping("/admin/updateEvent.do")
	public String updateEvent(@RequestParam("eventNo") int eventNo, Model model){
		Event e = adminService.eventView(eventNo);
		model.addAttribute("event", e);
		return "admin/eventUpdate";
	}
	
	@RequestMapping("/admin/updateEventEnd.do")
	public ModelAndView updateEvent(@RequestParam(name="eventNo") int eventNo, @RequestParam(name="eventTitle") String eventTitle,
			@RequestParam(name="amount") int amount, @RequestParam(name="startDate") Date startDate, @RequestParam(name="endDate") Date endDate,
			@RequestParam(name="discount") String discount, @RequestParam(name="eventSmall") String eventSmall, @RequestParam(name="eventBig") String eventBig,
			@RequestParam(name="upFile",required=false) MultipartFile[] upFiles, HttpServletRequest request, ModelAndView mav) {

		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/event");
		String rSmall = eventSmall;
		String rBig = eventBig;
		
		if(!upFiles[0].getOriginalFilename().equals("")) {
			String oSmall = upFiles[0].getOriginalFilename();
			rSmall = Utils.getRenamedEventFileName(oSmall,"s",eventNo);
			try {
				upFiles[0].transferTo(new File(saveDirectory+"/"+rSmall));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}	
		}
		
		if(!upFiles[1].getOriginalFilename().equals("")) {
			String oBig = upFiles[1].getOriginalFilename();
			rBig = Utils.getRenamedEventFileName(oBig,"b",eventNo);
			try {
				upFiles[1].transferTo(new File(saveDirectory+"/"+rBig));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}

		Event event = new Event();
		event.setEventNo(eventNo);
		event.setEventTitle(eventTitle);
		event.setDiscount(discount);
		event.setAmount(amount);
		event.setStartDate(startDate);
		event.setEndDate(endDate);
		event.setEventBig(rBig);
		event.setEventSmall(rSmall);
		
		int result = adminService.updateEvent(event);
		
		//view
		
		String msg = "";
		if(result>0) {
			msg="이벤트 수정 성공";
		}else {
			msg = "이벤트 수정 실패";
		}
		
		mav.addObject("msg",msg);
		mav.addObject("loc","/admin/eventView.do?eventNo="+eventNo);
		mav.setViewName("common/msg");
		
		return mav;

	}
	
	@RequestMapping("/admin/storePMSList.do")
	public String storePMSList(@RequestParam(value="cPage", defaultValue="1") int cPage, Model model) {
		
		int numPerPage = 10;
		List<Map<String,String>> list = adminService.storePMSList(cPage, numPerPage);
		int totalContents = adminService.countStorePMSList();
		
		model.addAttribute("cPage",cPage);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("totalContents",totalContents);
		model.addAttribute("list",list);
		
		return "/admin/storePMSList";
	}
	
	@RequestMapping("/admin/storeList.do")
	public String storeList(Model model, @RequestParam(value="cPage", defaultValue="1") int cPage,
										 @RequestParam(value="searchType", defaultValue="") String searchType,
										 @RequestParam(value="searchKeyword", defaultValue="") String searchKeyword) {
		
		int numPerPage = 10;
		Map<String,String> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchKeyword", searchKeyword);
		
//		List<Map<String,String>> list = adminService.storeList(cPage, numPerPage);
		List<Map<String,String>> list = adminService.storeList(cPage, numPerPage, map);
		int totalContents = adminService.countStoreList(map);
		
		model.addAttribute("cPage",cPage);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("totalContents",totalContents);
		model.addAttribute("list",list);
		
		return "/admin/storeList";
	}
	
	@RequestMapping("/admin/coupon.do")
	public String couponDown(@RequestParam(name="memberId") String memberId, @RequestParam(name="eventNo") int eventNo,Model model) {
		
		Event event = adminService.eventView(eventNo);
		List<Coupon> check = adminService.couponList(memberId);
		String msg="";
		String view = "common/msg";
		String loc = "";
		int duplication = 0;
		Coupon coupon = new Coupon();
		int result = 0;
		logger.debug(check);
		for(int i = 0; i< check.size(); i++ ){
			Coupon element = check.get(i);
			if((element.getEventNo())== eventNo) {
				duplication = 1 ;
			}
		}
		
		if(duplication > 0) {
			msg = "이미 다운 받은 쿠폰입니다.";
			loc = "/event/eventView.do?eventNo="+eventNo;
		}else if(duplication == 0) {
			if(event.getAmount() > 0) {
				coupon.setEventNo(event.getEventNo());
				coupon.setMemberId(memberId);
				coupon.setStartDate(event.getStartDate());
				coupon.setEndDate(event.getEndDate());
				int result1 = adminService.couponDownload(coupon);
				int result2 = adminService.couponAmount(eventNo);
				result = result1 + result2;
				if(result > 1) {
					loc = "/event/eventView.do?eventNo="+eventNo;
					msg = "다운이 완료되었습니다.";
				}else {
					loc = "/event/eventView.do?eventNo="+eventNo;
					msg = "쿠폰을 다운받을 수 없습니다.";
				}
			}else if(event.getAmount() <=0) {
				loc = "/event/eventView.do?eventNo="+eventNo;
				msg = "쿠폰이 모두 소진되었습니다ㅠㅠㅠ";
			}
		}
		
//		mav.addObject("loc",loc);
//		mav.addObject("msg",msg);
//		mav.setViewName("view");
		model.addAttribute("msg",msg);
		model.addAttribute("loc",loc);
		
		return "common/msg";
	}
	
	@RequestMapping("/admin/timeChart.do")
	@ResponseBody
	public Map<String, Object> timeChart(@RequestParam(name="month") String month) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<OrderInfo> list = null;
		if(month.equals("now")) {
			list = adminService.timeChart();
		}
		map.put("list", list);
		return map;
	}
	@RequestMapping("/admin/chartByMonth.do")
	@ResponseBody
	public Map<String, Object> chartByMoneth(@RequestParam(name="year") int year) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<OrderInfo> list = adminService.chartByMonth(year);
		map.put("list", list);
		return map;
	}
	
	@RequestMapping("/admin/totalCostByMonthly.do")
	@ResponseBody
	public Map<String, Object> totalCostByMonthly() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<OrderInfo> list = adminService.totalCostByMonthly();
		map.put("list", list);
		return map;
	}
	
	@RequestMapping("/admin/adCostByMonthly.do")
	@ResponseBody
	public Map<String,Object> adCostByMonthly(){
		Map<String, Object> map = new HashMap<String, Object>();
		List<Ad> list = adminService.adCostByMonthly();
		map.put("list", list);
		return map;
	}
	
//	---------------------------------------------------------
	
	@RequestMapping("/admin/storePMSView.do")
	public String storePMSView(@RequestParam(name="storeNo") String storeNo, Model model) {
		StoreInfo si = adminService.storePMSView(storeNo);
		List<Map<String, String>> sa = adminService.storePMSAttaView(storeNo);
		
		model.addAttribute("store", si);
		model.addAttribute("atta", sa);
		
		return "admin/storePMSView";
	}
	
	@RequestMapping("/admin/storeView.do")
	public String storeView(@RequestParam(name="storeNo") String storeNo, Model model) {
		StoreInfo si = adminService.storePMSView(storeNo);
		List<Map<String, String>> sa = adminService.storePMSAttaView(storeNo);
		
		model.addAttribute("store", si);
		model.addAttribute("atta", sa);
		
		return "admin/storeView";
	}
	
	@RequestMapping("/admin/storePMSfileDownload.do")
	public void storePMSFileDownload(@RequestParam String rName, @RequestParam String oName, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		
		//파일 입출력 준비
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/seller");
		
		//입력 스트림
		File f = new File(saveDirectory+"/"+rName);
		FileInputStream fis = new FileInputStream(f);
		BufferedInputStream bis = new BufferedInputStream(fis);
		
		//출력스트림
		ServletOutputStream sos = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(sos);
		
		//전송할 파일명작성
		String resFileName = "";
		
		//요청브라우저에 따른 분기를 처리
		boolean isMSIE = request.getHeader("user-agent").indexOf("MSIE") != -1 //요청브라우저를 가져오는 key
						|| request.getHeader("user-agent").indexOf("Trident") != -1; //IE10 이전(MSIE), 이후(Trident)
		if(isMSIE) {
			//utf-8인코딩처리를 명시적으로 해줌
			resFileName = URLEncoder.encode(oName, "UTF-8");
			//+로 처리된 공백을 다시 한 번 %20(공백의미)로 치환
			resFileName = resFileName.replaceAll("\\+", "%20");
		}else {
			resFileName = new String(oName.getBytes("UTF-8"), "ISO-8859-1"); //톰캣 기본 인코딩타입			
		}
		
		//파일전송
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename="+resFileName);
		
		//파일쓰기
		int read = -1;
		while((read=bis.read()) != -1) {
			bos.write(read);
		}
		bos.close();
		bis.close();
	}
	
	@RequestMapping("/admin/storePMSOk.do")
	public ModelAndView storePMSOk(@RequestParam(name="storeNo") String storeNo, ModelAndView mav) {
		int result = adminService.storePMSOk(storeNo);
		
		String msg = "";
		if(result>0) {
			msg="가게 신청 허가 완료";
		}else {
			msg = "가게 신청 허가 실패";
		}
		
		mav.addObject("msg",msg);
		mav.addObject("loc","/admin/storePMSList.do");
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("/admin/storePMSReject")
	public ModelAndView storePMSX(@RequestParam(name="storeNo") String storeNo, @RequestParam(name="rejectInfo") String rejectInfo, ModelAndView mav) {
		Map<String,String> map = new HashMap<>();
		map.put("storeNo", storeNo);
		map.put("rejectInfo", rejectInfo);
		int result = adminService.storePMSReject(map);
		
		String msg = "";
		if(result>0) {
			msg="가게 신청 거절 완료";
		}else {
			msg = "가게 신청 거절 실패";
		}
		
		mav.addObject("msg",msg);
		mav.addObject("loc","/admin/storePMSList.do");
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("/admin/storePMSClose")
	public ModelAndView storePMSClose(@RequestParam(name="storeNo") String storeNo, ModelAndView mav) {
		int result = adminService.storePMSClose(storeNo);
		
		String msg = "";
		if(result>0) {
			msg="가게 영업 중지 완료";
		}else {
			msg = "가게 영업 중지 실패";
		}
		
		mav.addObject("msg",msg);
		mav.addObject("loc","/admin/storeView.do?storeNo="+storeNo);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("/admin/storePMSOpen")
	public ModelAndView storePMSOpen(@RequestParam(name="storeNo") String storeNo, ModelAndView mav) {
		int result = adminService.storePMSOpen(storeNo);
		
		String msg = "";
		if(result>0) {
			msg="가게 영업 중지 해제 완료";
		}else {
			msg = "가게 영업 중지 해제 실패";
		}
		
		mav.addObject("msg",msg);
		mav.addObject("loc","/admin/storeView.do?storeNo="+storeNo);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("admin/chart.do")
	public Model chart(Model model) {
		List<Integer> chartByCategory = adminService.chartByCategory(); 
		model.addAttribute("chartByCategoryList", chartByCategory);
		model.addAttribute("admin/chart");
		return model;
	}
	
	@ResponseBody
	@RequestMapping("admin/chartByWeek.do")
	public Map<String, Object> chartByWeek(@RequestParam(name="weeklyStartDate") String weeklyStartDate, @RequestParam(name="weeklyEndDate") String weeklyEndDate) {
		Map<String, String> map = new HashMap<>();
		map.put("weeklyStartDate", weeklyStartDate);
		map.put("weeklyEndDate", weeklyEndDate);
		List<Integer> chartByWeek = adminService.chartByWeek(map);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("chartByWeekList", chartByWeek);
		return returnMap;
	}
	
	@ResponseBody
	@RequestMapping("admin/chartByCategoryAmount.do")
	public Map<String, Object> chartByCategoryAmount(){
		Map<String, Object> map = new HashMap<String, Object>();
		List<Integer> chartByCategoryAmount = adminService.chartByCategoryAmount();
		map.put("chartByCategoryAmountList", chartByCategoryAmount);
		return map;
	}
	
	@RequestMapping("admin/reportList.do")
	public String reportList(@RequestParam(value="cPage", defaultValue="1") int cPage, Model model) {
		
		int numPerPage = 10;
		List<Map<String,String>> list = adminService.reportList(cPage, numPerPage);
		int totalContents = adminService.countReportList();
		
		model.addAttribute("cPage",cPage);
		model.addAttribute("numPerPage",numPerPage);
		model.addAttribute("totalContents",totalContents);
		model.addAttribute("list",list);

		return "admin/reportList";
	}
	
	@RequestMapping("admin/reviewReportView.do")
	public String reviewReportView(@RequestParam("reportNo") int reportNo, @RequestParam("reviewNo") int reviewNo, Model model) {
		
		Report report = adminService.reportView(reportNo);
		Review review = adminService.reviewReportView(reviewNo);
				
		model.addAttribute("report", report);
		model.addAttribute("review", review);
		
		return "admin/reviewReportView";
	}
	
	@RequestMapping("admin/updateReviewReportFlagY.do")
	public ModelAndView updateReviewReportFlagY(@RequestParam("reportNo") String reportNo, @RequestParam("reviewNo") String reviewNo, @RequestParam("memberId") String memberId, ModelAndView mav) {
		
		Map<String,String> map = new HashMap<>();
		map.put("reportNo", reportNo);
		map.put("reviewNo", reviewNo);
		map.put("memberId", memberId);
		int result = adminService.updateReviewReportFlagY(map);	

		mav.addObject("msg", "블랙리스트 등록 완료");
		mav.addObject("loc", "/admin/reportList.do");
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("admin/updateReportFlagR.do")
	public ModelAndView updateReportFlagR(@RequestParam("reportNo") String reportNo, ModelAndView mav) {
		
		int result = adminService.updateReportFlagR(reportNo);
		
		String msg = "";
		if(result>0) {
			msg="신고 거절 완료";
		}else {
			msg = "신고 거절 실패";
		}
		
		mav.addObject("msg",msg);
		mav.addObject("loc","/admin/reportList.do");
		mav.setViewName("common/msg");
		
		return mav;

	}
	
	@RequestMapping("admin/storeReportView.do")
	public String storeReportView(@RequestParam("reportNo") int reportNo, @RequestParam("storeNo") String storeNo, Model model) {
		
		Report report = adminService.reportView(reportNo);
		StoreInfo store = adminService.storeReportStoreInfoView(storeNo);
		
		String sellerId = store.getSellerId(); 
		Seller seller = adminService.storeReportSellerView(sellerId);
		
		model.addAttribute("report", report);
		model.addAttribute("store", store);
		model.addAttribute("seller", seller);
		
		return "admin/storeReportView";
	}
	
	@RequestMapping("admin/updateStoreReportFlagY.do")
	public ModelAndView updateStoreReportFlagY(@RequestParam("reportNo") String reportNo, @RequestParam("storeNo") String storeNo, @RequestParam("sellerId") String sellerId, ModelAndView mav) {
		
		Map<String,String> map = new HashMap<>();
		map.put("reportNo", reportNo);
		map.put("storeNo", storeNo);
		map.put("sellerId", sellerId);
		int result = adminService.updateStoreReportFlagY(map);	

		mav.addObject("msg", "블랙리스트 등록 완료");
		mav.addObject("loc", "/admin/reportList.do");
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	
}
