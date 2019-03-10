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
table#tbl-report tr th{text-align:center;}
table#tbl-report tr td{text-align:center;}
table#tbl-report tr td a {text-decoration:none !important;}
</style>

<script>
$(function(){
	$("#collapsePages").addClass("show");	
	$("#reportControl").addClass("active");	
});
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
          <h1 class="h3 mb-4 text-gray-800">신고 관리</h1>
          

          <section id="board-container" class="container">
		
		  <table id="tbl-report" class="table table-striped table-hover">
			<tr>
				<th>번호</th>
				<th>신고유형</th>
				<th>리뷰 번호</th>
				<th>사업자 번호</th>
				<th>처리 여부</th>
			</tr>
			<c:if test="${not empty list}">
				<c:forEach items="${list }" var="r">
			<tr>
				<td>${r.reportNo}</td>
				<td>${r.category=="R"?"리뷰 신고":"가게 신고"}</td>
				<td><a href="${pageContext.request.contextPath }/admin/reviewReportView.do?reportNo=${r.reportNo}&reviewNo=${r.reviewNo}">${r.reviewNo==0?"":r.reviewNo}</a></td>
				<td><a href="${pageContext.request.contextPath }/admin/storeReportView.do?reportNo=${r.reportNo}&storeNo=${r.storeNo}">${r.storeNo==null?"":r.storeNo}</a></td>
				<td>${r.reportFlag=="N"?"미처리":r.reportFlag=="Y"?"처리완료":"처리거절"}</td>
			</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty list}">
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
		<%=com.kh.god.common.util.Utils.getPerBar(totalContents,cPage,numPerPage,"reportList.do") %>
		</div>	
			
		</section>
			
        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->