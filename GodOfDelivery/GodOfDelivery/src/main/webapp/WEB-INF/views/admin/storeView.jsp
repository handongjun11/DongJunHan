<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="배달의 신" name="pageTitle" />
</jsp:include>

<!-- Custom fonts for this template-->
<link href="${pageContext.request.contextPath }/resources/css/fontawesome-free/css/all.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.css" rel="stylesheet">

<style>
div#event-container{width:700px; margin:30px auto; text-align:center;}
div#event-container input{margin-bottom:15px;}
#tblEvent th{width:200px; vertical-align:middle}
#tblEvent td{width:500px;}
#tblEvent td img:hover{cursor:pointer;}
</style>

<script>
$(function(){
	$("#storeList").addClass("active");		
});

function fileDownload(oName, rName){
	oName = encodeURIComponent(oName);
	location.href="${pageContext.request.contextPath}/admin/storePMSfileDownload.do?oName="+oName+"&rName="+rName;
}
</script>

<!-- Page Wrapper -->
  <div id="wrapper">

	<jsp:include page="/WEB-INF/views/admin/sideBar.jsp"></jsp:include>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div id="event-container">
			<table class="table table-bordered" id="tblEvent">
				<tr>
					<th>사업자 번호</th>
					<td>${store.storeNo }</td>
				</tr>
				<tr>
					<th>사업자 아이디</th>
					<td>${store.sellerId }</td>
				</tr>
				<tr>
					<th>사업자 등록증 사본</th>
					<td>
						<button type="button" class="btn btn-outline-secondary btn-block"
								onclick="fileDownload('${atta[0].originalFileName}','${atta[0].renamedFileName }');">
								${atta[0].originalFileName}
						</button>
					</td>
				</tr>
				<tr>
					<th>영업신고증 사본</th>
					<td>
						<button type="button" class="btn btn-outline-secondary btn-block"
								onclick="fileDownload('${atta[1].originalFileName}','${atta[1].renamedFileName }');">
								${atta[1].originalFileName}
						</button>
					</td>
				</tr>
				<tr>
					<th>사업장 이름</th>
					<td>${store.storeName }</td>
				</tr>
				<tr>
					<th>사업장 종류</th>
					<td>
						<c:choose>
							<c:when test="${store.categoryNo=='1'}">치킨</c:when>
							<c:when test="${store.categoryNo=='2'}">피자</c:when>
							<c:when test="${store.categoryNo=='3'}">보쌈, 족발</c:when>
							<c:when test="${store.categoryNo=='4'}">분식</c:when>
							<c:when test="${store.categoryNo=='5'}">중식</c:when>
							<c:when test="${store.categoryNo=='6'}">일식</c:when>
							<c:when test="${store.categoryNo=='7'}">한식</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>사업장 번호</th>
					<td>${store.storeTel }</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${store.storeAddress }</td>
				</tr>
				<tr>
					<th>사업장 소개</th>
					<td>${store.storeIntro }</td>
				</tr>
				<tr>
					<th>휴업일</th>
					<td>${store.personalDay }</td>
				</tr>
				<tr>
					<th>영업시간</th>
					<td>${store.operatingHours }</td>
				</tr>
				<tr>
					<th>최소주문금액</th>
					<td>${store.deliveryMinPrice }원</td>
				</tr>
				<tr>
					<th>광고 등급</th>
					<td>${store.storeGrade }</td>
				</tr>
				
			</table>
			
			<br />
			<c:if test="${store.pmsFlag=='Y' }">
				<input type="button" id="storePMSClose" class="btn btn-outline-danger" value="가게 영업 중지" >
			</c:if>
			<c:if test="${store.pmsFlag=='C' }">
				<input type="button" id="storePMSOpen" class="btn btn-outline-success" value="가게 영업 중지 해제" >
			</c:if>
						
			
		  </div>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->
  
<script>
$("#storePMSOpen").on("click", function(){
	location.href="${pageContext.request.contextPath}/admin/storePMSOpen.do?storeNo=${store.storeNo}";
});
$("#storePMSClose").on("click", function(){
	location.href="${pageContext.request.contextPath}/admin/storePMSClose.do?storeNo=${store.storeNo}";
});
</script>
