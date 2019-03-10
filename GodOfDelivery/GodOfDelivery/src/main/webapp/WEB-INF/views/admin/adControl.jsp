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
input#btn-add{float:right; margin: 0 0 15px;}
table#tbl-event tr th{text-align:center;}
table#tbl-event tr td{text-align:center;}
table#tbl-event tr td a {text-decoration:none !important;}
</style>
<script>
$(function(){
	$("#collapsePages").addClass("show");	
	$("#adControl").addClass("active");	
	$("#toDoList").addClass("active");	
});
function fn_goAllAd(){
	location.href = "${pageContext.request.contextPath}/admin/adControl.do?status=all";
}; 
function fn_goAding(){
	location.href = "${pageContext.request.contextPath}/admin/adControl.do?status=ading";
};
function fn_goAded(){
	location.href = "${pageContext.request.contextPath}/admin/adControl.do?status=aded";
};
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
         <section id="board-container" class="container">

		<input type="button" value="ALL" id="btn-add" class="btn btn-outline-success" onclick="fn_goAllAd();"/>
		<input type="button" value="진행중인 광고" id="btn-add" class="btn btn-outline-success" onclick="fn_goAding();"/>
		<input type="button" value="끝난 광고" id="btn-add" class="btn btn-outline-success" onclick="fn_goAded();"/>
		<table id="tbl-event" class="table table-striped table-hover">
			<tr>
				<th>번호</th>
				<th>가게번호</th>
				<th>광고 등급</th>
				<th>광고 시작일</th>
				<th>광고 종료일</th>
				
			</tr>
			<c:if test="${not empty adList}">
				<c:forEach items="${adList }" var="ad">
			<tr>
				<td>${ad.adNo }</td>
				<td><a href="${pageContext.request.contextPath }/admin/adStoreView.do?adNo=${ad.adNo }&storeNo=${ad.storeNo }" >${ad.storeNo }</a></td>
				<td>${ad.storeGrade }</td>
				<td><fmt:formatDate value="${ad.startDate}" type="date" /> </td>
				<td><fmt:formatDate value="${ad.endDate}" type="date" /> </td>
			</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty adList}">
				<tr>
					<td colspan="5">등록된 정보가 없습니다.</td>
				</tr>
			</c:if>
		
		</table>
	
	<%
		int totalContents = (int)request.getAttribute("totalContents");
		int numPerPage = (int)request.getAttribute("numPerPage");
		int cPage = (int)request.getAttribute("cPage");
		String status = (String)request.getAttribute("status");
	%>
	<div>
	<%=com.kh.god.common.util.Utils.getPerBar(totalContents,cPage,numPerPage,"adControl.do?status="+status) %>
	</div>
		
	<!-- 페이지바  -->
</section> 

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->