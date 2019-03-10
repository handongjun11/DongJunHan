package com.kh.god.storeInfo.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.god.admin.model.vo.Report;
import com.kh.god.common.util.Utils;
import com.kh.god.storeInfo.model.service.StoreInfoService;
import com.kh.god.storeInfo.model.vo.SAttachment;
import com.kh.god.storeInfo.model.vo.StoreInfo;



@Controller
public class StoreInfoController {
	
	Logger logger = Logger.getLogger(getClass());
		
	private static WebDriver driver;
	String Title = null ;
	String URL = null;
	String alertText  = "";
	
	public static void setUp(String loc) throws Exception {
		System.setProperty("webdriver.chrome.driver", loc); 
	
	     ChromeOptions options = new ChromeOptions();
	     options.addArguments("headless");
	        try {
	            driver = new ChromeDriver(options);
	          //  driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
	            driver.get("https://teht.hometax.go.kr/websquare/websquare.html?w2xPath=/ui/ab/a/a/UTEABAAA13.xml");
	            
	        } catch (Exception e) {
	            return;
	        }
	}
	
	@Autowired
	StoreInfoService storeInfoService;
	
	@RequestMapping("/storeInfo/storeInfoList.do")
	public ModelAndView storeInfoList(@RequestParam(value = "cPage", defaultValue = "1") int cPage, 
								  @RequestParam(value = "categoryNo") int categoryNo, 
								  ModelAndView mav) {
		
		System.out.println("categoryNo = " + categoryNo);
		
		if(logger.isDebugEnabled()) {
			logger.debug("매장 목록페이지");
		}
		
		int numPerPage = 6;
		
		// 업무로직
		// 1. 게시글리스트 (페이징 적용된 것)
		System.out.println(cPage);
		List<Map<String, String>> list = storeInfoService.selectStoreInfoList(cPage, numPerPage, categoryNo);

		// 2. 전체컨텐츠수
		int totalContents = storeInfoService.selectStoreInfoTotalContents(categoryNo);
		
		mav.addObject("list", list);
		mav.addObject("categoryNo", categoryNo);
		mav.addObject("cPage", cPage);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("totalContents", totalContents);

		mav.setViewName("storeInfo/storeInfoList");

		return mav;
	}
	
	@RequestMapping(value = "/storeinfo/checkBrno.do" ,  method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkBrno( @RequestParam(value="brno") String no, HttpServletRequest request) throws Exception {

		Map<String, Object> map = new HashMap<>();
		logger.debug("@@@@@@@@@@@brno"+ no);
		String brno = no ;

//		String loc = request.getSession().getServletContext().getRealPath("/WEB-INF/lib/chromedriver.exe"); //for Windows
		String loc = "/usr/lib/chromium-browser/chromedriver"; //for Linux

		
	//1.jsp에서 사업자 번호를 스트링에 담기.
		setUp(loc);
		
		
		//사업자번호 입력 
		driver.findElement(By.id("bsno")).click();
		driver.findElement(By.id("bsno")).sendKeys(brno);
		driver.findElement(By.id("bsno")).click();
		driver.findElement(By.id("trigger5")).click();
		
		//System.out.println("클릭됐니 ");
		Thread.sleep(2000); 
		String storeNo ="";
		String info = driver.findElement(By.id("grid2_body_tbody")).getText();
		logger.debug("@@@@@@@@@@@@@@@@info"+info);
		
		
		
		try {
			storeNo = info.substring(0,12 );
			info = info.substring(13, 16);
		if(info.equals("폐업자")) {
			map.put("operate" , "0" ); 
			map.put("msg" , "폐업자입니다.");
		}else if(info.equals("사업을")){
			map.put("operate" , "0" ); 
			map.put("msg" , "사업을 하지 않고 있습니다.");
		}
		else {
			map.put("operate" , "1" ); 
			map.put("msg" , "확인이 완료되었습니다.");
			map.put("storeNo", storeNo);
		}
		}catch(StringIndexOutOfBoundsException e) {
			map.put("msg" , "새로고침 후 다시 이용해주세요." ); 
		
		}
		System.out.println("info"+ info);

	 driver.close();
		
	 return map;
		
		} 
	
	@RequestMapping(value="/storeInfo/addStore.do" , method=RequestMethod.POST)
	public String addStore(StoreInfo s , @RequestParam(name="upFile" , required=false) MultipartFile[] upFiles, HttpServletRequest request , Model model) {
		logger.debug("storeTel="+s.getStoreTel());
		logger.debug("fileName1="+ upFiles[0].getOriginalFilename());
		logger.debug("size1="+upFiles[0].getSize());
		logger.debug("fileName2="+ upFiles[1].getOriginalFilename());
		logger.debug("size2="+upFiles[1].getSize());
		
		String loc = "/seller/sellerView.do";
		String msg = "";
		try {
			
			//1.파일업로드
			//실제 경로 절대경로를 받아와야함.
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/seller");
			logger.debug(saveDirectory);
			
			//첨부파일을 저장할 객체 
			//여러개라고 가정하고 List
			List<SAttachment> attachList = new ArrayList<>();
			
			//MultipartFile 처리 로직
			for( MultipartFile f : upFiles ) {
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
					SAttachment attach = new SAttachment();
					attach.setOriginalFileName(originalFileName);
					attach.setRenamedFileName(renamedFileName);
					attachList.add(attach);
				}//if끝
			}//forEach 끝 
			//2.업무로직
			int result = storeInfoService.addStore(s , attachList);
			//3.뷰단처리
			
			if(result >0) {
				msg ="게시물 등록 성공!";
				
			}else {
				msg="게시물 등록 실패!";
			}
			
			//mav.addObject("msg", msg);
			//mav.addObject("loc", loc);
			//mav.setViewName("common/msg");  //jsp경로
			}catch(Exception e) {
				logger.error("게시물 등록 에러 " , e);
				//throw new BoardException("게시물 등록 에러", e);
			}
		
			model.addAttribute("msg", msg);
			model.addAttribute("loc", loc);
		
		return "common/msg";

		
		}
	
	@RequestMapping("/storeInfo/storeInfoView.do")
	public String storeInfoView(@RequestParam("storeNo") String storeNo, 
								@RequestParam("sellerId") String sellerId, Model model) {
		
		StoreInfo si  = storeInfoService.selectOnebyStoreNo(storeNo);
		List<Map<String, String>> attachmentList = null ;
		
		String loc = "/seller/sellerView.do";
		String msg = "";
		String view = "storeInfo/storeInfoView";
		if(sellerId.equals(si.getSellerId()) && storeNo.equals(si.getStoreNo())) {
		if(si != null ) {
			attachmentList = storeInfoService.selectAttchMentLsit(storeNo);
			
			if(attachmentList == null) {
				msg = "내용을 불러 올 수 없습니다.";
				view ="common/msg";
			}else{
				
			}
		}
		
		model.addAttribute("storeInfo" , si);
		model.addAttribute("attachmentList" , attachmentList);
		} else {
			
			msg = "접근 권한이 없습니다.";
		}
		return view;
	}
	
	@RequestMapping("/storeInfo/UpdateStore.do")
	public String updateStore(StoreInfo s , @RequestParam(name="upFile" , required=false) MultipartFile[] upFiles, HttpServletRequest request ,
		@RequestParam(name="oldfile" , required=false) String[] oldfile, 	@RequestParam(name="oldfile1" , required=false) String[] oldfile1	, Model model) {
		
		logger.debug("storeTel="+s.getStoreTel());
		logger.debug("fileName1="+ upFiles[0].getOriginalFilename());
		logger.debug("size1="+upFiles[0].getSize());
		logger.debug("fileName2="+ upFiles[1].getOriginalFilename());
		logger.debug("size2="+upFiles[1].getSize());
		//logger.debug("!!!!!!!!!!!!!"+ oldfile[0]);
		
		
		
		String loc = "/storeInfo/storeInfoView.do?storeNo="+s.getStoreNo()+"&sellerId="+s.getSellerId();
		String msg = "";
		try {
			
			//1.파일업로드
			//실제 경로 절대경로를 받아와야함.
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/seller");
			logger.debug(saveDirectory);
			
			//첨부파일을 저장할 객체 
			//여러개라고 가정하고 List
			List<SAttachment> attachList = new ArrayList<>();
			
			//MultipartFile 처리 로직
			for( MultipartFile f : upFiles ) {
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
					SAttachment attach = new SAttachment();
					attach.setOriginalFileName(originalFileName);
					attach.setRenamedFileName(renamedFileName);
					attachList.add(attach);
				}//if끝
			}//forEach 끝 
			//2.업무로직
			int result = storeInfoService.updateStore(s , attachList);
			//3.뷰단처리
			
			 if(result >0) { msg ="수정 성공!";
			  
			  }else { msg="수정 실패!"; }
			
			
			//mav.addObject("msg", msg);
			//mav.addObject("loc", loc);
			//mav.setViewName("common/msg");  //jsp경로
			}catch(Exception e) {
				logger.error("게시물 등록 에러 " , e);
				//throw new BoardException("게시물 등록 에러", e);
			}
		
			model.addAttribute("msg", msg);
			model.addAttribute("loc", loc);
		
		return "common/msg";

		
		}
	 
    @RequestMapping("/storeinfo/deletefile1.do")
    @ResponseBody
    public Map<String, Object> deleteFile1 (@RequestParam ( name="filename", required=false) String filename ) {
    	logger.debug("@@@@@@@@@@@@@@@@@@@@filename"+filename);
    	
    	 Map<String, Object> map = new HashMap<>();
    	int result = storeInfoService.deleteFile1(filename);
    	
    	
    	String msg = "";
    	if(result >0) {
    		msg = "첨부파일 삭제 완료 ";
    	}else {
    		msg = "첨부파일 삭제 실패 ";
    	}
    	logger.debug(msg);
        map.put("result" , result);
    	
    	return  map;
    }
    
    @RequestMapping("storeinfo/closed.do")
    @ResponseBody
    public Map<String, Object> closedStore(@RequestParam (name = "storeNo") String storeNo ){
    	logger.debug("@@@@@@@@@@@@@@@@@@@storeNo"+storeNo);
    	
   	 Map<String, Object> map = new HashMap<>();
   	int result = storeInfoService.closedStore(storeNo);
   	
   	
   	String msg = "";
   	if(result >0) {
   		msg = "폐업신고 완료 ";
   	}else {
   		msg = "폐업신고 실패 ";
   	}
   	logger.debug(msg);
       map.put("result" , result);
 
    	return map;
    }
    
    @RequestMapping("storeinfo/brnoCheckDuplicate.do")
    @ResponseBody
    public Map<String, Object> brnoCheckDuplicate(@RequestParam (name = "brno") String storeNo ){
    	logger.debug("@@@@@@@@@@@@@@@@@@@storeNo"+storeNo);
    	
    	Map<String, Object> map = new HashMap<>();
    	StoreInfo si = storeInfoService.selectOnebyStoreNo(storeNo);
    	String brno = "";
    	String msg = "" ;
    	int result = 0 ;
    	
    	if(si != null) {
    		brno= si.getStoreNo();
    		if(brno.equals(storeNo)) {
    		
    			msg = "이미 등록된 번호입니다.";
    		}
    	}	
    	else {
    		msg = "확인버튼을 눌러주세요.";
    		result = 1;
    	}
    	
    	map.put("msg" , msg );
    	map.put("result" , result );
    
    	
    	return map;
    }
    
    @RequestMapping(value="/storeInfo/report.do" , method=RequestMethod.POST)
    public String stroeReport(Report r , Model model)	{
    	
    	logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+r);
    	String loc = "/menu/menuList.do?storeNo="+r.getStoreNo();
		String msg = "";
		String view = "common/msg";
    	
    	
    	int result = storeInfoService.insertReport(r);
    	
    	if(result > 0) {
    		msg ="신고가 완료 되었습니다.";
    	}else {
    		msg ="신고 오류 : 다시 신고해주세요.";
    	}
    	///menu/menuList.do?storeNo=257-86-00648 성공시
    	model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);
    	
    	return view;
    }
    
    
    
	
}

