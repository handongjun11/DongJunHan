<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/categoryHeader.jsp">
	<jsp:param value="고객센터" name="pageTitle"/>
</jsp:include>

<style>
div.row{
 	margin-top: 168px;
    margin-left: 92px;
}

li#STORENO{
	display: none;
}
.card{
    margin: 10px;
}
</style>
<script>
$(document).ready(function(){
	var categoryNo = ${categoryNo};
	if(categoryNo==1){
		$("#chicken").addClass("active");
	} else if(categoryNo==2){
		$("#pizza").addClass("active");

	} else if(categoryNo==3){
		$("#bossam").addClass("active");

	} else if(categoryNo==4){
		$("#bunsik").addClass("active");

	} else if(categoryNo==5){
		$("#china").addClass("active");

	} else if(categoryNo==6){
		$("#japan").addClass("active");

	} else if(categoryNo==7){
		$("#korea").addClass("active");

	}
	
});
</script>
<section id="storeInfo-container" class="container">
	<!-- 전체 게시글 출력 -->
	<div class="row">
			<c:forEach items="${list }" var="list" varStatus="status">
			
				<c:if test="${list.STOREGRADE eq 'A'}">
					<div class="card" style="width: 20rem; border : 1px solid #e9fbfa; background-color:#e9fbfa;" >
				</c:if>
				<c:if test="${list.STOREGRADE eq 'B'}">
					<div class="card" style="width: 20rem; border:1px solid #26d9d0;">
				</c:if>
				<c:if test="${list.STOREGRADE eq 'C'}">
					<div class="card" style="width: 20rem;"  style="border:red;">
				</c:if>
					<!-- 썸네일이 존재할 경우 -->
					<c:if test="${not empty list.RENAMEDFILENAME}">					
					<img class="card-img-top" style="width:319px; height:208px;" src="${pageContext.request.contextPath}/resources/upload/menu/${list.RENAMEDFILENAME }" alt="StoreInfo Thumbnail">
					</c:if>
					
					<!-- 카테고리가 치킨이고, 썸네일이 없을 때 -->
					<c:if test="${empty list.RENAMEDFILENAME && list.CATEGORYNO==1}">					
					<img class="card-img-top" style="width:319px; height:208px;" src="${pageContext.request.contextPath}/resources/upload/storeInfo/thumbNail/chicken.jpg" alt="썸네일">
					</c:if>
					
					<!-- 카테고리가 피자이고, 썸네일이 없을 때 -->
					<c:if test="${empty list.RENAMEDFILENAME && list.CATEGORYNO==2}">					
					<img class="card-img-top" style="width:319px; height:208px;" src="${pageContext.request.contextPath}/resources/upload/storeInfo/thumbNail/pizza.png" alt="썸네일">
					</c:if>
					
					<!-- 카테고리가 보쌈/족발이고, 썸네일이 없을 때 -->
					<c:if test="${empty list.RENAMEDFILENAME && list.CATEGORYNO==3}">					
					<img class="card-img-top" style="width:319px; height:208px;" src="${pageContext.request.contextPath}/resources/upload/storeInfo/thumbNail/bossam.jpg" alt="썸네일">
					</c:if>
					
										
					<!-- 카테고리가 분식이고, 썸네일이 없을 때 -->
					<c:if test="${empty list.RENAMEDFILENAME && list.CATEGORYNO==4}">					
					<img class="card-img-top" style="width:319px; height:208px;" src="${pageContext.request.contextPath}/resources/upload/storeInfo/thumbNail/bunsik.jpeg" alt="썸네일">
					</c:if>
					
										
					<!-- 카테고리가 중식이고, 썸네일이 없을 때 -->
					<c:if test="${empty list.RENAMEDFILENAME && list.CATEGORYNO==5}">					
					<img class="card-img-top" style="width:319px; height:208px;" src="${pageContext.request.contextPath}/resources/upload/storeInfo/thumbNail/chineseFood.jpg" alt="썸네일">
					</c:if>
					
					<!-- 카테고리가 일식이고, 썸네일이 없을 때 -->
					<c:if test="${empty list.RENAMEDFILENAME && list.CATEGORYNO==6}">					
					<img class="card-img-top" style="width:319px; height:208px;" src="${pageContext.request.contextPath}/resources/upload/storeInfo/thumbNail/japaneseFood.jpeg" alt="썸네일">
					</c:if>
					
					<!-- 카테고리가 중식이고, 썸네일이 없을 때 -->
					<c:if test="${empty list.RENAMEDFILENAME && list.CATEGORYNO==7}">					
					<img class="card-img-top" style="width:319px; height:208px;" src="${pageContext.request.contextPath}/resources/upload/storeInfo/thumbNail/koreanFood.jpg" alt="썸네일">
					</c:if>
					
					
					
					
					
					<div class="card-body">
						<h5 class="card-title" style="font-weight: bold;">
							<c:out value="${list.STORENAME }" />
						</h5>
						<p class="card-text">
							<c:out value="${list.STOREINTRO }" />
						</p>
					</div>
					
						<ul class="list-group list-group-flush">
					
					<c:if test="${list.STOREGRADE eq 'A'}">
						<li id="STORENO" ><c:out value="${list.STORENO }"></c:out></li>
						<li class="list-group-item" style="border:1px solid #e9fbfa; background-color:#e9fbfa;"><strong>영업시간 </strong> <c:out
								value="${list.OPERATINGHOURS }" /></li>
						<li class="list-group-item" style="border:1px solid #e9fbfa; background-color:#e9fbfa;"><strong>전화번호 </strong> <c:out
								value="${list.STORETEL }" /></li>
						<li class="list-group-item" style="border:1px solid #e9fbfa; background-color:#e9fbfa;"><strong>배달최소금액 </strong> <c:out
								value="${list.DELIVERYMINPRICE }" /></li>
					</c:if>
					
					<c:if test="${list.STOREGRADE eq 'B'}">
						<li id="STORENO" ><c:out value="${list.STORENO }"></c:out></li>
						<li class="list-group-item" style="border:1px solid #e9fbfa;"><strong>영업시간 </strong> <c:out
								value="${list.OPERATINGHOURS }" /></li>
						<li class="list-group-item" style="border:1px solid #e9fbfa;"><strong>전화번호 </strong> <c:out
								value="${list.STORETEL }" /></li>
						<li class="list-group-item" style="border:1px solid #e9fbfa;"><strong>배달최소금액 </strong> <c:out
								value="${list.DELIVERYMINPRICE }" /></li>
					</c:if>
					
					<c:if test="${list.STOREGRADE eq 'C'}">
						<li id="STORENO" ><c:out value="${list.STORENO }"></c:out></li>
						<li class="list-group-item" ><strong>영업시간 </strong> <c:out
								value="${list.OPERATINGHOURS }" /></li>
						<li class="list-group-item" ><strong>전화번호 </strong> <c:out
								value="${list.STORETEL }" /></li>
						<li class="list-group-item" ><strong>배달최소금액 </strong> <c:out
								value="${list.DELIVERYMINPRICE }" /></li>
					</c:if>
						</ul>
					<div class="card-body">
						<a class="btn btn-primary" href="${pageContext.request.contextPath }/menu/menuList.do?storeNo=${list.STORENO}">주문하기</a>
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