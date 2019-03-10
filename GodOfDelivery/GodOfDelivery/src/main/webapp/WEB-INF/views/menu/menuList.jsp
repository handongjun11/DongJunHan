<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="고객센터" name="pageTitle"/>
</jsp:include>
<style>
div.row{
	margin-top: 80px;
}

li#storeNo{
	display: none;
}
</style>
<script>
var storeNo = $
</script>
<section id="storeInfo-container" class="container">
	<!-- 전체 게시글 출력 -->
	<div class="row">
			<c:forEach items="${list }" var="list" varStatus="status">
				<div class="card" style="width: 20rem;">
					<img class="card-img-top" src="" alt="StoreInfo Thumbnail">
					<div class="card-body">
						<h5 class="card-title" style="font-weight: bold;">
							<c:out value="${list.storeName }" />
						</h5>
						<p class="card-text">
							<c:out value="${list.storeIntro }" />
						</p>
					</div>
					<ul class="list-group list-group-flush">
						<li id="storeNo"><c:out value="${list.storeNo }"></c:out></li>
						<li class="list-group-item"><strong>영업시간 </strong> <c:out
								value="${list.operatingHours }" /></li>
						<li class="list-group-item"><strong>전화번호 </strong> <c:out
								value="${list.storeTel }" /></li>
						<li class="list-group-item"><strong>배달최소금액 </strong> <c:out
								value="${list.deliveryMinPrice }" /></li>
					</ul>
					<div class="card-body">
						<a class="btn btn-primary" href="${pageContext.request.contextPath }/menu/menuList.do?storeNo=${list.storeNo }">주문하기</a>
					</div>
				</div>
			</c:forEach>
	</div>

	<%
		int totalContents = (int) request.getAttribute("totalContents");
		int numPerPage = (int) request.getAttribute("numPerPage");
		int cPage = (int) request.getAttribute("cPage");
		int categoryNo = (int) request.getAttribute("categoryNo");
	%>
	
	<%=com.kh.god.common.util.Utils.getPerBar(totalContents, cPage, numPerPage,"storeInfoList.do?categoryNo="+categoryNo) %>
		
	<!-- 페이지바  -->
</section> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>