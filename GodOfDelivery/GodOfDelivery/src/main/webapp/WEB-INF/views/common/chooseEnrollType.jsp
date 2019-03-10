<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name=""/>
</jsp:include>
<style>
#enrollType-container{
    margin-top: 158px;
    margin-left: 329px;
}
#enrollType-container2{
	width : 800px;
	height :500px;
	left : 50%;
}
#btn1{
margin-left: 200px; width:184px; 
}
#btn2{
margin-left: 180px; width:184px; 
}
#enrollType-container2 >h1{
	margin-left: 100px;
}

</style>


<div id="enrollType-container">

	<div id="enrollType-container2">
	<h1>회원가입을 환영합니다</h1>
	<br />
	<br />
	<br />
	
	<div class="container">
	
	 <button type="button" id="btn1" class="btn btn-info btn-lg" 
	  			onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do'">개인 회원 가입</button>
	
	</div>
	<br />
	<br />
	
	
	<div class="container">
		
	&nbsp;&nbsp;&nbsp;&nbsp;	<button type="button" id="btn2" class="btn btn-info btn-lg" 
				onclick="location.href='${pageContext.request.contextPath}/seller/sellerEnroll.do'">사업자 회원 가입</button>	
	</div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	