package com.kh.god.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class Utils {
	
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	

	
	public static String getPerBar(int totalContents,int cPage,int numPerPage,String loc) {
	
		int totalPage = (int)Math.ceil((double)totalContents/numPerPage);
		int pageBarSize = 5;
		int startPage = ((cPage-1)/pageBarSize) * pageBarSize + 1;
		int endPage = startPage + pageBarSize - 1; 
		int pageNo = startPage;
		String pageBar = "<nav><ul class=\'pagination justify-content-center\'>";
		
		
		
		if(loc.contains("storeInfoList.do")) {
			//[이전]section
			if(pageNo == 1) {
				
			}
			else {
				pageBar += "<li class='page-itme'><a class='page-link' href='"+loc+
									 "&cPage="+(pageNo-1)+
									 "&numPerPage="+numPerPage+"'>PREVIOUS</a><li>";
			}
			
			//[페이지]section
			while(pageNo<=endPage && pageNo<=totalPage) {
				if(cPage == pageNo) {
					pageBar += "<li class='page-item disabled'> <a class='page-link'>"+pageNo+"</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
							   "&cPage="+pageNo+
							   "&numPerPage="+numPerPage+"'>"+
							   pageNo+"</a></li>";
				}
				pageNo++;
			}

			//[다음]section
			if(pageNo > totalPage) {
				
			} 
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
						   "&cPage="+pageNo+
						   "&numPerPage="+numPerPage+"'>NEXT</a></li>";
			}
			
			pageBar += "</ul></nav>";
			
		}else if(loc.contains("boardWriter")){
			//[이전]section
			if(pageNo == 1) {
				
			}
			else {
				pageBar += "<li class='page-itme'><a class='page-link' href='"+loc+
									 "&cPage="+(pageNo-1)+
									 "&numPerPage="+numPerPage+"'>PREVIOUS</a><li>";
			}
			
			//[페이지]section
			while(pageNo<=endPage && pageNo<=totalPage) {
				if(cPage == pageNo) {
					pageBar += "<li class='page-item disabled'> <a class='page-link'>"+pageNo+"</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
							   "&cPage="+pageNo+
							   "&numPerPage="+numPerPage+"'>"+
							   pageNo+"</a></li>";
				}
				pageNo++;
			}

			//[다음]section
			if(pageNo > totalPage) {
				
			} 
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
						   "&cPage="+pageNo+
						   "&numPerPage="+numPerPage+"'>NEXT</a></li>";
			}
			
			pageBar += "</ul></nav>";
		}else if(loc.contains("adControl.do?status")){
			//[이전]section
			if(pageNo == 1) {
				
			}
			else {
				pageBar += "<li class='page-itme'><a class='page-link' href='"+loc+
									 "&cPage="+(pageNo-1)+
									 "&numPerPage="+numPerPage+"'>PREVIOUS</a><li>";
			}
			
			//[페이지]section
			while(pageNo<=endPage && pageNo<=totalPage) {
				if(cPage == pageNo) {
					pageBar += "<li class='page-item disabled'> <a class='page-link'>"+pageNo+"</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
							   "&cPage="+pageNo+
							   "&numPerPage="+numPerPage+"'>"+
							   pageNo+"</a></li>";
				}
				pageNo++;
			}

			//[다음]section
			if(pageNo > totalPage) {
				
			} 
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
						   "&cPage="+pageNo+
						   "&numPerPage="+numPerPage+"'>NEXT</a></li>";
			}
			
			pageBar += "</ul></nav>";
		}else if(loc.contains("eventList.do?status")){
			//[이전]section
			if(pageNo == 1) {
				
			}
			else {
				pageBar += "<li class='page-itme'><a class='page-link' href='"+loc+
									 "&cPage="+(pageNo-1)+
									 "&numPerPage="+numPerPage+"'>PREVIOUS</a><li>";
			}
			
			//[페이지]section
			while(pageNo<=endPage && pageNo<=totalPage) {
				if(cPage == pageNo) {
					pageBar += "<li class='page-item disabled'> <a class='page-link'>"+pageNo+"</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
							   "&cPage="+pageNo+
							   "&numPerPage="+numPerPage+"'>"+
							   pageNo+"</a></li>";
				}
				pageNo++;
			}

			//[다음]section
			if(pageNo > totalPage) {
				
			} 
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
						   "&cPage="+pageNo+
						   "&numPerPage="+numPerPage+"'>NEXT</a></li>";
			}
			
			pageBar += "</ul></nav>";
		}else if(loc.contains("webreview.do")) {
			//[이전]section
			if(pageNo == 1) {
				
			}
			else {
				pageBar += "<li class='page-itme'><a class='page-link' href='"+loc+
									 "&cPage="+(pageNo-1)+
									 "&numPerPage="+numPerPage+"'>PREVIOUS</a><li>";
			}
			
			//[페이지]section
			while(pageNo<=endPage && pageNo<=totalPage) {
				if(cPage == pageNo) {
					pageBar += "<li class='page-item disabled'> <a class='page-link'>"+pageNo+"</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
							   "&cPage="+pageNo+
							   "&numPerPage="+numPerPage+"'>"+
							   pageNo+"</a></li>";
				}
				pageNo++;
			}

			//[다음]section
			if(pageNo > totalPage) {
				
			} 
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
						   "&cPage="+pageNo+
						   "&numPerPage="+numPerPage+"'>NEXT</a></li>";
			}
			
			pageBar += "</ul></nav>";
		
		
	}else {
		
			//[이전]section
			if(pageNo == 1) {
				
			}
			else {
				pageBar += "<li class='page-itme'><a class='page-link' href='"+loc+
									 "?cPage="+(pageNo-1)+
									 "&numPerPage="+numPerPage+"'>PREVIOUS</a><li>";
			}
			
			//[페이지]section
			while(pageNo<=endPage && pageNo<=totalPage) {
				if(cPage == pageNo) {
					pageBar += "<li class='page-item disabled'> <a class='page-link'>"+pageNo+"</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
							   "?cPage="+pageNo+
							   "&numPerPage="+numPerPage+"'>"+
							   pageNo+"</a></li>";
				}
				pageNo++;
			}

			//[다음]section
			if(pageNo > totalPage) {
				
			} 
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='"+loc+
						   "?cPage="+pageNo+
						   "&numPerPage="+numPerPage+"'>NEXT</a></li>";
			}
			
			pageBar += "</ul></nav>";
			
			
		}
		
		return pageBar;
     
        
	}

	public static String getRenamedFileName(String fname) {
		//확장자 분리
		String ext = fname.substring(fname.lastIndexOf(".")+1);
		//날짜
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		//난수 만들기
		int rndNum = (int)(Math.random()*1000);
		
		return sdf.format(new Date())+"_"+rndNum+"."+ext;
	}

	
	public static String getRenamedEventFileName(String fName,String bs, int eventNo) {
		//확장자 분리
		String ext = fName.substring(fName.lastIndexOf(".")+1);
		if(bs.equals("s")) {
			return eventNo+"_Small."+ext;
		}else {
			return eventNo+"_Big."+ext;
		}
		
	}
	
	public static String getRandomPassword(int len) {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
				'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' }; 
		
		int idx = 0;
		StringBuffer sb = new StringBuffer();
	
		
		for(int i = 0; i < len; i++) {
			idx = (int) (charSet.length * Math.random()); // 36 * 생성된 난수를  Int로 추출 (소숫점제거)
			sb.append(charSet[idx]);
		}
		
		return sb.toString();
	}

	
	


}
