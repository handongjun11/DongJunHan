<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원정보조회" name="pageTitle"/>
</jsp:include>

<link href="${pageContext.request.contextPath }/resources/css/fontawesome-free/css/all.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.css" rel="stylesheet">

<style>
div#MemberView-wapper{
 /* position: absolute;
    height: 100%;
    width: 100%; */
}

div#MemberView-sideBar{
    background-color: #36b9cc;
    float: left;
	width: 20%;
	height: 960px;
}

div#memberViewFrm-container{
  	float : left;
	width : 80%;
	text-align : center;
}

.memberViewCategory{
	margin: 75px 0;
    padding-left: 20px;
}

#MemberView-ul{
	margin-top:80px;
	list-style:none;
}
#MemberView-ul li a{
	line-height: 83px;
    color: white;
    font-size: 15px;
    opacity: 0.8;
    /* cursor: pointer; */
}

</style>

<!-- 일반회원 정보조회 -->
<div id="MemberView-wapper">

	<div id="MemberView-sideBar">
		<ul id="MemberView-ul">
			<li>
				<a href="${pageContext.request.contextPath}/member/memberView.do?memberId=${memberLoggedIn.memberId}">회원 정보 변경</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/member/orderList.do?memberId=${memberLoggedIn.memberId}">구매 내역</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/member/reviewList.do?memberId=${memberLoggedIn.memberId}">내 리뷰 보기</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/member/bookMarkList.do?memberId=${memberLoggedIn.memberId}">즐겨찾는 매장</a>	
			</li>
		</ul>	
	</div>

	<div id="memberViewFrm-container">
		
		<!-- 주문 리스트 -->
		<div class = "memberViewCategory">		
			
			<h2>즐겨찾는 매장 확인</h2>
			<br /><br />		
			
			<table class="table table-hover active" id="bookmarkTable" style="width: 96%;">				  
				<!-- orderList가 존재하면 -->
				<c:if test="${not empty bookmarkList}">
					<thead>
						  <tr>
							<th>매장명</th>
							<th>매장번호</th>
							<th>매장주소</th>
						  </tr>
					</thead>
					<tbody>				
					<c:forEach var="b" items="${bookmarkList}">	
						<tr>
							<td><a href="${pageContext.request.contextPath }/menu/menuList.do?storeNo=${b.storeNo }">${b.storeName}</a></td>
							<td>${b.storeTel}</td>
							<td>${b.storeAddress}</td>									
						</tr>
					</c:forEach>
					</tbody>					
				</c:if>
				<c:if test="${empty bookmarkList}">
					<thead></thead>
					<tbody><tr><td>즐겨찾는 매장이 없습니다.</td></tr></tbody>
				</c:if>			
			</table>

		</div>		
	</div> <!-- div#memberViewFrm-container -->
</div> <!-- div#MemberView-container -->


<script>



</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	