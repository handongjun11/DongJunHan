/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.35
 * Generated at: 2019-01-16 09:42:20 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.product;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import semi.kh.member.model.vo.*;
import semi.kh.product.model.service.*;
import java.net.URLEncoder;
import java.util.*;
import java.util.*;
import semi.kh.product.model.vo.*;
import semi.kh.member.model.service.*;
import java.text.DecimalFormat;

public final class productBuy_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/WEB-INF/views/common/header.jsp", Long.valueOf(1547621309758L));
    _jspx_dependants.put("/WEB-INF/views/common/footer.jsp", Long.valueOf(1547621309705L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("java.util");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("semi.kh.member.model.vo");
    _jspx_imports_packages.add("semi.kh.product.model.service");
    _jspx_imports_packages.add("semi.kh.product.model.vo");
    _jspx_imports_packages.add("semi.kh.member.model.service");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("java.net.URLEncoder");
    _jspx_imports_classes.add("java.text.DecimalFormat");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");

	Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
boolean saveId = false;
String memberId = "";

Cookie[] cookies = request.getCookies();

for(Cookie c : cookies){
	String key = c.getName();
	String value = c.getValue();
	if("saveId".equals(key)){
		saveId = true;
		memberId = value;
	}
}




      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<title>SHOPINGMALL</title>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath() );
      out.write("/css/style.css\" />\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath());
      out.write("/js/jquery-3.3.1.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath());
      out.write("/js/Chart.bundle.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath());
      out.write("/js/PPRbgb.js\"></script>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css\">\r\n");
      out.write("<style>\r\n");
      out.write("div.login-container input[type=button]{\r\n");
      out.write("\tmargin:0 auto;\r\n");
      out.write("\twidth:100px;\r\n");
      out.write("\theight:25px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("tr#lasttr input[type=button]{\r\n");
      out.write("\tposition:absolute;\r\n");
      out.write("\tmargin:0 auto;\r\n");
      out.write("\twidth:115px;\r\n");
      out.write("\theight:25px;\r\n");
      out.write("\tright:58px;\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write("div.login-container input[type=checkbox]{\r\n");
      out.write("\tposition: absolute;\r\n");
      out.write("\tmargin:0 auto;\r\n");
      out.write("\ttop:50px;\r\n");
      out.write("\tright: 45px;\r\n");
      out.write("}\r\n");
      out.write("div.login-container label{\r\n");
      out.write("\tposition:absolute;\r\n");
      out.write("\tcolor:rgb(51,122,194);\r\n");
      out.write("\ttop:50px;\r\n");
      out.write("\tright: 6px;\r\n");
      out.write("}\r\n");
      out.write("div.login-container input[type=submit]{\r\n");
      out.write("\t\r\n");
      out.write("\tposition: absolute;\r\n");
      out.write("\tmargin:0 auto;\r\n");
      out.write("\twidth: 60px;\r\n");
      out.write("\theight: 35px;\r\n");
      out.write("\ttop:13px;\r\n");
      out.write("\tright: 3px;\r\n");
      out.write(" \tpadding: 5px 5px;\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("tr#log input[type=button]{\r\n");
      out.write("\tmargin:0 auto;\r\n");
      out.write("}\r\n");
      out.write("#btn-logout{\r\n");
      out.write("\tposition:absolute;\r\n");
      out.write("\tmargin:0 auto;\r\n");
      out.write("\tright:60px;\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write("#time{\r\n");
      out.write("\tposition:absolute;\r\n");
      out.write("\twidth:100px;\r\n");
      out.write("\ttop:10px;\r\n");
      out.write("}\r\n");
      out.write("#timer-button{\r\n");
      out.write("\tposition:absolute;\r\n");
      out.write("\tmargin:0 auto;\r\n");
      out.write("\ttext-align:center;\r\n");
      out.write("\tfont-size:5;\r\n");
      out.write("\twidth:45px;\r\n");
      out.write("\tleft:34px;\r\n");
      out.write("\ttop:3px;\r\n");
      out.write("}\r\n");
      out.write("#title{\r\n");
      out.write("\tposition:absolute;\r\n");
      out.write("\tmargin-top:-10px;\r\n");
      out.write("\tmargin-left:20px;\r\n");
      out.write(" \tfont-size:50px;\r\n");
      out.write(" \tcolor:rgb(110,102,92);\r\n");
      out.write("}\r\n");
      out.write("#title:hover{\r\n");
      out.write("\tcursor:pointer;\r\n");
      out.write("}\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("\r\n");
      out.write("function loginValidate() {\r\n");
      out.write("\tif($(\"#memberId\").val().trim().length ==0){\r\n");
      out.write("\t\talert(\"아이디를 입력하세요\");\r\n");
      out.write("\t\t$(\"#memberId\").focus();\r\n");
      out.write("\t\treturn false;//폼 전송 방지\r\n");
      out.write("\t}\r\n");
      out.write("\tif($(\"#password\").val().trim().length==0){\r\n");
      out.write("\t\talert(\"비밀번호를 입력하세요\");\r\n");
      out.write("\t\t$(\"#password\").focus();\r\n");
      out.write("\t\treturn false;\r\n");
      out.write("\t}\r\n");
      out.write("\t//form에서 유효성 검사할때는 onsubmit, 로그인버튼 부분에서 유효성검사할때는 onclick\r\n");
      out.write("\treturn true;\r\n");
      out.write("}\r\n");
      out.write("function findPassword(){\r\n");
      out.write("\tvar url = \"");
      out.print(request.getContextPath());
      out.write("/member/findPassword\";\r\n");
      out.write("\tvar title =\"findPassword\";\r\n");
      out.write("\tvar status = \"left=500px,top=200px,width=400px,height=210px\";\r\n");
      out.write("\topen(url,title,status);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
if(memberLoggedIn!=null && !("admin".equals(memberLoggedIn.getMemberId()))) {
      out.write("\r\n");
      out.write("\r\n");
      out.write("var iM = 30;\r\n");
      out.write("var iS = iM * 60;\r\n");
      out.write("var timerchecker = null;\r\n");
      out.write("\r\n");
      out.write("$(function(){\r\n");
      out.write("\tfncClearTime();\r\n");
      out.write("\tinitTimer();\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("Lpad = function(str,len){\r\n");
      out.write("\tstr = str + \"\";\r\n");
      out.write("\twhile(str.length < len){\r\n");
      out.write("\t\tstr = \"0\"+str;\r\n");
      out.write("\t}\r\n");
      out.write("\treturn str;\r\n");
      out.write("};\r\n");
      out.write("\r\n");
      out.write("initTimer = function(){\r\n");
      out.write("\trM = parseInt(iS/60);\r\n");
      out.write("\trS = iS % 60;\r\n");
      out.write("\tif(iS>0){\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$(\"#time\").text(Lpad(rM,2)+\"M \"+Lpad(rS,2)+\"S\");\r\n");
      out.write("\t\tiS--;\r\n");
      out.write("\t\ttimerchecker = setTimeout(\"initTimer()\",1000);\r\n");
      out.write("\t}else {\r\n");
      out.write("\t\tclearTimeout(timerchecker);\r\n");
      out.write("\t\tlogout();\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function fncClearTime(){\r\n");
      out.write("\tiM = 30;\r\n");
      out.write("\tiS = iM*60;\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function logout(){\r\n");
      out.write("\tlocation.href='");
      out.print(request.getContextPath());
      out.write("/member/logout';\r\n");
      out.write("}\r\n");
      out.write("\r\n");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("function goToPrdList(obj){\r\n");
      out.write("\t\r\n");
      out.write("\t  var pCategory = $(obj).attr(\"name\");\r\n");
      out.write("\t  console.log($(obj).parent().eq(0));\t /*모바일, 스마트폰,태블릿, 웨어러블 */\r\n");
      out.write("\t ");
      out.write(" \r\n");
      out.write("\t  location.href = \r\n");
      out.write("\t \t  \"");
      out.print(request.getContextPath());
      out.write("/product/productList?pCategory=\"+pCategory;\r\n");
      out.write("\t \r\n");
      out.write("\t}\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t<div id=\"container\">\r\n");
      out.write("\t\t<header>\r\n");
      out.write("\t\t<div id=\"title\" onclick=\"location.href ='");
      out.print(request.getContextPath());
      out.write("/'\">\r\n");
      out.write("\t\t\t<img src='");
      out.print(request.getContextPath());
      out.write("/images/LOGO.png' style=\"width: 80px;\"/>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t<!-- 로그인 폼 -->\r\n");
      out.write("\t\t\t<!-- 로그인 시작 -->\r\n");
      out.write("\t\t\t<div class=\"login-container\">\r\n");
      out.write("\t\t\t");
if(memberLoggedIn == null) { 
      out.write("\r\n");
      out.write("\t\t\t\t<form action=\"");
      out.print(request.getContextPath());
      out.write("/member/login\" method=\"post\" id=\"LoginFrm\" onsubmit=\"return loginValidate();\">\r\n");
      out.write("\t\t\t\t\t<table>\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input type=\"text\" name=\"memberId\" id=\"memberId\" placeholder=\"아이디\" value=\"");
      out.print(memberId);
      out.write("\" style=\"width:170px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input type=\"password\" name=\"password\" id=\"password\" placeholder=\"비밀번호\" style=\"width:170px;\"></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td><input type=\"submit\" class=\"btn btn-primary\" value=\"로그인\" /></td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td colspan=\"2\">\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"button\" class=\"btn btn-link\" value=\"비밀번호찾기\"  onclick=\"findPassword();\"/>\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"button\" class=\"btn btn-link\" value=\"회원가입\" onclick=\"location.href='");
      out.print(request.getContextPath());
      out.write("/member/memberEnroll'\"/>\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"checkbox\" name=\"saveId\" id=\"saveId\" ");
      out.print(saveId?"checked":"" );
      out.write("/> \r\n");
      out.write("\t\t\t\t\t\t\t<label for=\"saveId\">ID저장</label>\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr id=\"lasttr\">\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=\"2\">\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"button\" class=\"btn btn-link\" value=\"비회원 주문조회\" onclick=\"location.href = '");
      out.print(request.getContextPath());
      out.write("/product/noneOrderView'\"/>\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t");
 }
				else {
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<table id=\"logged-in\">\r\n");
      out.write("\t\t\t\t\t\t<tr id=\"welcome\">\r\n");
      out.write("\t\t\t\t\t\t\t<td>");
      out.print(memberLoggedIn.getMemberId() );
      out.write("님, 안녕하세요! Welcome:)</td>\r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t<tr id=\"log\">\r\n");
      out.write("\t\t\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"button\" class=\"btn btn-link\" value=\"내정보보기\" onclick='location.href = \"");
      out.print(request.getContextPath());
      out.write("/member/memberView?memberId=");
      out.print(memberLoggedIn.getMemberId());
      out.write("\";' />\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"button\" id=\"btn-logout\" value=\"로그아웃\" class=\"btn btn-link\" onclick =\"location.href='");
      out.print(request.getContextPath());
      out.write("/member/logout';\"/>\r\n");
      out.write("\t\t\t\t\t\t\t</td> \r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t\t");
 if(!("admin".equals(memberLoggedIn.getMemberId()))) {
      out.write("\r\n");
      out.write("\t\t\t\t\t<table id=\"timer\">\r\n");
      out.write("\t\t\t\t\t\t<tr >\r\n");
      out.write("\t\t\t\t\t\t<td id=\"time\"></td>\r\n");
      out.write("\t\t\t\t\t\t<td id=\"timer-button\"><input type=\"button\" class=\"btn btn-link\" value=\"연장\" onclick=\"fncClearTime();\"/></td>\r\n");
      out.write(" \r\n");
      out.write("\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t\t");
} 
      out.write("\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t");
 } 
      out.write("\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<!-- 로그인 폼 -->\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t<!-- 메인메뉴 시작 -->\r\n");
      out.write("\t\t\t<nav>\r\n");
      out.write("\t\t\t\t<ul class=\"main-nav\">\r\n");
      out.write("\t\t\t\t\t<li><a href=\"");
      out.print(request.getContextPath() );
      out.write("/\">Home</a></li>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<li>\r\n");
      out.write("\t\t\t\t\t\t<a onclick=\"goToPrdList(this);\" name=\"모바일\">모바일</a>\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<ul class=\"sub-nav\">\r\n");
      out.write("\t\t\t\t\t\t\t<li><a onclick=\"goToPrdList(this);\" name=\"스마트폰\">스마트폰</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t<li><a onclick=\"goToPrdList(this);\" name=\"태블릿\">태블릿</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t<li><a onclick=\"goToPrdList(this);\" name=\"웨어러블\">웨어러블</a></li>\r\n");
      out.write("\t\t\t\t\t\t</ul>\t\t\r\n");
      out.write("\t\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<li><a onclick=\"goToPrdList(this);\" name=\"PC\">PC</a>\r\n");
      out.write("\t\t\t\t\t\t<ul class=\"sub-nav\">\r\n");
      out.write("\t\t\t\t\t\t\t<li><a onclick=\"goToPrdList(this);\" name=\"노트북\">노트북</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t<li><a onclick=\"goToPrdList(this);\" name=\"모니터\">모니터</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t<li><a onclick=\"goToPrdList(this);\" name=\"데스크탑\">데스크탑</a></li>\r\n");
      out.write("\t\t\t\t\t\t</ul>\t\r\n");
      out.write("\t\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<li><a href=\"");
      out.print(request.getContextPath());
      out.write("/board/boardList\">고객센터</a></li>\r\n");
      out.write("\t\t\t\t\t<li><a href=\"");
      out.print(request.getContextPath());
      out.write("/product/productCart\">장바구니</a></li>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\t ");
      out.write("\r\n");
      out.write("               ");
if(memberLoggedIn != null && ("admin").equals(memberLoggedIn.getMemberId())){ 
      out.write("\r\n");
      out.write("               <li>\r\n");
      out.write("                  <a href=\"#\">관리자</a>\r\n");
      out.write("                  <ul class=\"sub-nav\">\r\n");
      out.write("                     <li><a href=\"");
      out.print(request.getContextPath());
      out.write("/admin/memberList\">회원관리</a></li>                              \r\n");
      out.write("                     <li><a href=\"");
      out.print(request.getContextPath());
      out.write("/admin/memberManagement\">통계</a></li>\r\n");
      out.write("                     <li><a href=\"");
      out.print(request.getContextPath());
      out.write("/admin/Management\">스케줄러</a></li>\r\n");
      out.write("                     <li><a href=\"");
      out.print(request.getContextPath());
      out.write("/admin/orderView\">주문내역</a></li>\r\n");
      out.write("                  </ul>\r\n");
      out.write("               </li>\r\n");
      out.write("               ");
} 
      out.write("\r\n");
      out.write("\t\t\t\t</ul>\r\n");
      out.write("\t\t\t</nav>\r\n");
      out.write("\t\t\t<!-- 메인메뉴 끝 -->\r\n");
      out.write("\t\t</header>\r\n");
      out.write("\t\t<div id=\"wrapper\" style=\"position:relative\">\r\n");
      out.write("\t\t<div id=\"todayList\" style=\"position:absolute; width:130px; min-height:100px; left:970px;\">\r\n");
      out.write("\t\t<h6 id=\"todayList_h6\"> 최근 본 상품</h6>\r\n");
      out.write("\t\r\n");
      out.write("\t\t<script>\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tvar arr = new Array();\r\n");
      out.write("\t\t");

		request.setCharacterEncoding("UTF-8");
		Cookie[] pcookies = request.getCookies();
		
		
		for(Cookie pc : pcookies){
			String key = pc.getName();
			String value = pc.getValue();
			
			if(key.contains("pcc")){
		
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t\t\tvar todayList = new Object();\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tconsole.log(\"length\"+arr.length);\r\n");
      out.write("\t\t\tif(arr.length >=5){\r\n");
      out.write("\t\t\t\tarr.shift();\r\n");
      out.write("\t\t\t\ttodayList.toID=\"");
      out.print( key.substring(3) );
      out.write("\";\r\n");
      out.write("\t\t\t\ttodayList.toNAME=\"");
      out.print( value );
      out.write("\";\r\n");
      out.write("\t\t\t\tarr.push(todayList);\r\n");
      out.write("\t\t\t}else {\r\n");
      out.write("\t\t\t\ttodayList.toID=\"");
      out.print( key.substring(3) );
      out.write("\";\r\n");
      out.write("\t\t\t\ttodayList.toNAME=\"");
      out.print( value );
      out.write("\";\r\n");
      out.write("\t\t\t\tarr.push(todayList);\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\t");
 
				
			}
		}
		
		
      out.write("\r\n");
      out.write("\t\t\tvar addr = \"");
      out.print(request.getContextPath() );
      out.write("/product/productView?pId=\";\r\n");
      out.write("\t\t\tvar html1 = \"<a href='\";\r\n");
      out.write("\t\t\tvar html2 = \"' >\"\r\n");
      out.write("\t\t\tvar html3 = \"</a>\";\r\n");
      out.write("\t\t\tvar src1 = \"<img class='listimg' src='\";\r\n");
      out.write("\t\t\tvar src2 = \"");
      out.print(request.getContextPath() );
      out.write("/images/product/\";\r\n");
      out.write("\t\t\tvar src3 = \"_thumb1.png' \"+\"onerror= javascript:this.src='");
      out.print(request.getContextPath() );
      out.write("/images/error_thumb.jpg'\"+\" />\";\r\n");
      out.write("\t\t\t");
      out.write("\r\n");
      out.write("\t\t\tfor(var i in arr){\r\n");
      out.write("\t\t\t\t$(\"#todayList\").append( \"<div class='todayList_list'>\"+html1+addr+arr[i].toID+html2+src1+src2+arr[i].toNAME+src3+\" <br />\" +arr[i].toNAME+ \"<br /></h6>\"+html3+\"</div>\");\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t</script>\r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<section id=\"content\" style=\"background:none;\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script src=\"http://dmaps.daum.net/map_js_init/postcode.v2.js\"></script>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css\">\r\n");


	Member m = new MemberService().selectOne(memberLoggedIn.getMemberId());
	String grade = m.getGrade();

	double sale = 0;
	switch(grade){
	case "VVIP" : grade = "VVIP(5%할인)"; sale = 0.05; break;
	case "VIP" : grade = "VIP(3%할인)"; sale = 0.03; break;
	case "GOLD" : grade = "GOLD(1%할인)"; sale = 0.01; break;
	case "일반" : grade = "일반(할인X)"; sale = 0; break;
	}
	
	Cart sc = (Cart)session.getAttribute("sc");
	
	int totalPrice = 0;
	if(sc==null){
		List<Cart> list = (List<Cart>)request.getAttribute("list");
		
		for(Cart c : list){
			totalPrice += (c.getAmount()*c.getpPrice());
		}
		
	}else{
		totalPrice = (sc.getAmount()*sc.getpPrice());
	}
	
	

      out.write("\r\n");
      out.write("\r\n");
      out.write("<style>\r\n");
      out.write("#enroll-container table{\r\n");
      out.write("\twidth:500px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<section id=\"enroll-container\">\r\n");
      out.write("\t<h2 style=\"text-align:center;\">회원 주문/결제</h2>\r\n");
      out.write("\t<hr />\r\n");
      out.write("\t<form action=\"");
      out.print(request.getContextPath() );
      out.write("/product/productBuyEnd\" name=\"showAddrFrm\" method=\"post\">\r\n");
      out.write("\t\t<table id=\"table1\" class=\"table\">\r\n");
      out.write("\t\t\t<h3 style=\"text-align:left; margin-left:200px;\">구매자 정보</h3>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<th style=\"width:135px; height:40px; vertical-align:middle;\">이름</th>\r\n");
      out.write("\t\t\t\t<td style=\"background-color:white; vertical-align:middle;\">\r\n");
      out.write("\t\t\t\t\t");
      out.print(memberLoggedIn.getMemberName() );
      out.write("\r\n");
      out.write("\t\t\t\t\t<input type=\"hidden\" name=\"memberId\" value=\"");
      out.print(memberLoggedIn.getMemberId() );
      out.write("\" />\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<th style=\"width:135px; height:40px; vertical-align:middle;\">회원등급</th>\r\n");
      out.write("\t\t\t\t<td style=\"background-color:white; vertical-align:middle;\">\r\n");
      out.write("\t\t\t\t\t");
      out.print(grade );
      out.write("\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<th style=\"width:135px; height:40px; vertical-align:middle;\">이메일</th>\r\n");
      out.write("\t\t\t\t<td style=\"background-color:white; vertical-align:middle;\">\r\n");
      out.write("\t\t\t\t\t");
      out.print(memberLoggedIn.getEmail() );
      out.write("\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<th style=\"width:135px; height:40px; vertical-align:middle;\">휴대폰 번호</th>\r\n");
      out.write("\t\t\t\t<td style=\"background-color:white; vertical-align:middle;\">\r\n");
      out.write("\t\t\t\t\t");
      out.print(memberLoggedIn.getPhone() );
      out.write("\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t\t<hr />\r\n");
      out.write("\t\t<table class=\"table\">\t\r\n");
      out.write("\t\t\t<h3 style=\"text-align:left; margin-left:200px;\">받는사람 정보</h3>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<th style=\"width:135px; vertical-align:middle;\">이름</th>\r\n");
      out.write("\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t<input type=\"text\" class=\"form-control\" name=\"resName\" value=\"");
      out.print(memberLoggedIn.getMemberName() );
      out.write("\" placeholder=\"");
      out.print(memberLoggedIn.getMemberName() );
      out.write("\" />\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<th style=\"width:135px; vertical-align:middle;\">배송주소</th>\r\n");
      out.write("\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t<input type=\"text\" class=\"form-control\" name=\"resAddress\" id=\"resAddress\" value=\"");
      out.print(memberLoggedIn.getAddress() );
      out.write("\" placeholder=\"");
      out.print(memberLoggedIn.getAddress() );
      out.write("\" />\r\n");
      out.write("\t\t\t\t\t<button type=\"button\" style=\"margin-left:35px;\" class=\"btn btn-link\" onclick=\"showAddress();\">최근 배송지 보기</button>\r\n");
      out.write("\t\t\t\t\t<button type=\"button\" class=\"btn btn-link\" onclick=\"execDaumPostcode();\" >새로운 배송지 추가</button>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<th style=\"width:135px; vertical-align:middle;\">연락처</th>\r\n");
      out.write("\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t<input type=\"text\" class=\"form-control\" name=\"resPhone\" value=\"");
      out.print(memberLoggedIn.getPhone() );
      out.write("\" placeholder=\"");
      out.print(memberLoggedIn.getPhone() );
      out.write("\" />\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<th style=\"width:135px; height:30px; vertical-align:middle;\">배송 요청사항</th>\r\n");
      out.write("\t\t\t\t<td>\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<select class=\"form-control\" name=\"resRequirement\">\r\n");
      out.write("\t\t\t\t\t    <option>문앞</option>\r\n");
      out.write("\t\t\t\t\t    <option>경비실</option>\r\n");
      out.write("\t\t\t\t\t    <option>택배함</option>\r\n");
      out.write("\t\t\t\t\t    <option>기타</option>\r\n");
      out.write("\t\t\t\t  \t</select>\t\t\t\r\n");
      out.write("\t\t\t\t  \t<input type=\"text\" class=\"form-control\" name=\"resRequirementEtc\" readonly/>\t\t\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t\t<hr />\r\n");
      out.write("\t\t<table class=\"table\">\r\n");
      out.write("\t\t\t<h3 style=\"text-align:left; margin-left:200px;\">결제 정보</h3>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<th style=\"width:135px; height:40px; vertical-align:middle;\">총 상품가격</th>\r\n");
      out.write("\t\t\t\t<td style=\"background-color:white; vertical-align:middle; text-align:right;\">\r\n");
      out.write("\t\t\t\t\t");
      out.print(new DecimalFormat().format(totalPrice) );
      out.write("원\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<th style=\"width:135px; height:40px; vertical-align:middle;\">할인금액</th>\r\n");
      out.write("\t\t\t\t<td style=\"background-color:white; vertical-align:middle; text-align:right;\">\r\n");
      out.write("\t\t\t\t\t-");
      out.print(new DecimalFormat().format((int)(totalPrice * sale)) );
      out.write("원\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<th style=\"width:135px; height:40px; vertical-align:middle;\">총 결제금액</th>\r\n");
      out.write("\t\t\t\t<td style=\"background-color:white; vertical-align:middle; text-align:right;\">\r\n");
      out.write("\t\t\t\t\t");
      out.print(new DecimalFormat().format((int)(totalPrice-(totalPrice*sale))) );
      out.write("원\r\n");
      out.write("\t\t\t\t\t<input type=\"hidden\" name=\"afterPrice\" value=");
      out.print((int)(totalPrice-(totalPrice*sale)) );
      out.write(" />\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t\t<br />\r\n");
      out.write("\t\t<button type=\"submit\" id=\"submitBuy\" class=\"btn btn-primary btn-lg\">결제하기</button>\r\n");
      out.write("\t</form>\r\n");
      out.write("</section>\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("$(\"[name=resRequirement]\").on(\"change\", function(){\r\n");
      out.write("\t\r\n");
      out.write("\tif($(this).val() == \"기타\"){\r\n");
      out.write("\t\t$(\"[name=resRequirementEtc]\").attr(\"readonly\", false);\r\n");
      out.write("\t}\r\n");
      out.write("\telse{\r\n");
      out.write("\t\t$(\"[name=resRequirementEtc]\").attr(\"readonly\", true).val(\"\");\r\n");
      out.write("\t}\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("function showAddress(){\r\n");
      out.write("    var url = \"");
      out.print(request.getContextPath() );
      out.write("/product/showAddress?memberId=");
      out.print(memberLoggedIn.getMemberId());
      out.write("\";\r\n");
      out.write("    var title =\"내 주소지 보기\";\r\n");
      out.write("    var status = \"left=500px,top=200px,width=350px,height=365px\";\r\n");
      out.write("    open(url,title,status);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function execDaumPostcode(){\r\n");
      out.write("\r\n");
      out.write("\t  new daum.Postcode({\r\n");
      out.write("\t        oncomplete:function(data){\r\n");
      out.write("\t            var fullRoadAddr = data.roadAddress;\r\n");
      out.write("\t            var extraRoadAddr = '';\r\n");
      out.write("\t            \r\n");
      out.write("\t            if(data.bname !=='' &&/[동|로|가]$/g.test(data.bname)){\r\n");
      out.write("\t                extraRoadAddr += data.bname;\r\n");
      out.write("\t            }\r\n");
      out.write("\t            if(data.buildingName !=='' &&data.apartment === 'Y'){\r\n");
      out.write("\t                extraRoadAddr += (extraRoadAddr !== ''?','+data.buildingName : data.build);\r\n");
      out.write("\t            }\r\n");
      out.write("\t            if(extraRoadAddr !== ''){\r\n");
      out.write("\t                extraRoadAddr = '(' + extraRoadAddr +')';\r\n");
      out.write("\t            }\r\n");
      out.write("\t            if(fullRoadAddr !== ''){\r\n");
      out.write("\t                fullRoadAddr += extraRoadAddr;\r\n");
      out.write("\t            }\r\n");
      out.write("\t     \r\n");
      out.write("\t\t  \t\t$.ajax({\r\n");
      out.write("\t\t  \t\t\turl : \"");
      out.print(request.getContextPath() );
      out.write("/product/insertnewAddr?addr=\"+fullRoadAddr+\"&memberId=");
      out.print(memberLoggedIn.getMemberId());
      out.write("\",\r\n");
      out.write("\t\t  \t\t\tsuccess : function(data){\r\n");
      out.write("\t\t  \t\t\t\tdocument.getElementById(\"resAddress\").value = fullRoadAddr;\r\n");
      out.write("\t\t  \t\t\t}\r\n");
      out.write("\t\t  \t\t})\r\n");
      out.write("\t\t  \t\t\r\n");
      out.write("\t        }\r\n");
      out.write("\t    }).open();\r\n");
      out.write("\t  \r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t</section>\r\n");
      out.write("\t\t<footer>\r\n");
      out.write("        \t<div>        \t \r\n");
      out.write("        \t\t  주식회사 SEMI_HDJ &nbsp;|&nbsp; CEO HDJ &nbsp;|&nbsp; BUSINESS REGISTRATION 103-88-00990 \r\n");
      out.write("        \t\t <br/><br/> ⓒCopyright 2018 All rights reserved.\r\n");
      out.write("        \t</div>\t\t\r\n");
      out.write("    \t</footer>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write(" </div> <!-- <div id=\"container\"> -->\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
      out.write('	');
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
