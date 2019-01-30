<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String msg = (String)request.getAttribute("msg");
	String loc = request.getContextPath()+
				 (String)request.getAttribute("loc");
	System.out.printf("[%s %s]\n", msg, loc);
%>
<script>
alert("<%=msg%>");
location.href = "<%=loc%>";
</script>