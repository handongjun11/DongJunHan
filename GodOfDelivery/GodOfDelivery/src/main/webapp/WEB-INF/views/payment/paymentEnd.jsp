<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="배달의 신" name="pageTitle" />
</jsp:include>
<style>
body{
background : rgb(242,242,242);

}
#container{
margin: 0 auto;
    position: relative;
}
#deliveryImg{
    width: 300px;
    height: 300px;
    position: relative;
    top: 153px;
    left: 34%;
}
#text-div{
    position: relative;
    top: 188px;
    left: 11%;
}
h1{
    position: relative;
    left: 18%;
}
#homeBtn{
    position: relative;
    left: 46%;
    top: 214px;
}
</style>
<div id="container">
<img id="deliveryImg" src="${pageContext.request.contextPath }/resources/images/delivery.gif">
	<div id="text-div">
	<h1>주문이 완료되었습니다.</h1>
	<h3>주문이 접수되면 고객님의 번호로 배달소요시간을 발송해드립니다.</h3>
	</div>
<button type="button" id="homeBtn" class="btn btn-outline-info" onclick="location.href='${pageContext.request.contextPath}'">홈으로</button>
</div>
