<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="이벤트" name="pageTitle"/>
</jsp:include>
<style>
div#event-container{width:700px; margin:30px auto; text-align:center;}
div#event-container input{margin-bottom:15px;}
table#tblEvent{margin-top:50px;}
input#eventBtn{margin-bottom: 100px;}
</style>

<div id="event-container" class="container">
	<table class="table table-bordered" id="tblEvent">
		<tr>
			<td><img src="${pageContext.request.contextPath }/resources/upload/event/${event.eventBig }" width="500px" onclick="fileDownload('${event.eventBig}')"/></td>
		</tr>
	
	</table>
		<input type="button" class="btn btn-info" id="eventBtn" value="쿠폰받기" />
</div> 

<script>
$("#eventBtn").on("click",function(){
	if(!confirm("쿠폰을 다운 받으시겠습니까?")) return;
	if("${memberLoggedIn }" != ""){
		var memberId= "${memberLoggedIn.memberId }";
		location.href = "${pageContext.request.contextPath}/admin/coupon.do?memberId="+memberId+"&eventNo="+${event.eventNo};	
	}else if("${sellerLoggedIn }" != ""){
		var sellerId = "${sellerLoggedIn.sellerId }";
		alert("사장님! 쿠폰은 회원만 받을 수 있어요ㅠㅠㅠ");
	}else if("${sellerLoggedIn }" == "" && "${memberLoggedIn }" == ""){
		alert("로그인 후 이용 가능합니다.");
		return;
	}
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>