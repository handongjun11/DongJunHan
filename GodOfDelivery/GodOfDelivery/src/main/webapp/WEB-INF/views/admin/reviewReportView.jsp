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
#tblEvent th{width:150px; vertical-align:middle}
#tblEvent td{width:550px;}
#tblEvent td img:hover{cursor:pointer;}
</style>

<script>
$(function(){
	$("#collapsePages").addClass("show");	
	$("#reportControl").addClass("active");	
	$("#toDoList").addClass("active");	
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
          <div id="event-container">
			<table class="table table-bordered" id="tblEvent">
				<tr>
					<th>리뷰 제목</th>
					<td>${review.title }</td>
				</tr>
				<tr>
					<th>리뷰 작성자</th>
					<td>${review.writer }</td>
				</tr>
				<tr>
					<th>리뷰 내용</th>
					<td>${review.content }</td>
				</tr>
				<tr>
					<td colspan="2" style="border-left:hidden; border-right:hidden;"></td>
				</tr>
				<tr>
					<th>신고 내용</th>
					<td>${report.reportDetails }</td>
				</tr>
				<tr>
					<th>처리 여부</th>
					<td>${report.reportFlag=="N"?"미처리":report.reportFlag=="Y"?"처리완료":"처리거절"}</td>
				</tr>
				
			</table>
			
			<br />
			<c:if test="${report.reportFlag=='N'}">
				<input type="button" id="updateReportFlagY" class="btn btn-outline-danger" value="블랙리스트 등록" >
				&nbsp;&nbsp;&nbsp;
				<input type="button" id="updateReportFlagR" class="btn btn-outline-success" value="신고 거절" >
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
$("#updateReportFlagY").on("click", function(){
	if(!confirm("정말 블랙리스트로 등록하시겠습니까?")) return;
	location.href="${pageContext.request.contextPath}/admin/updateReviewReportFlagY.do?reportNo=${report.reportNo}&reviewNo=${review.reviewNo}&memberId=${review.writer}";
});

$("#updateReportFlagR").on("click", function(){
	if(!confirm("정말 신고를 거절하시겠습니까?")) return;
	location.href="${pageContext.request.contextPath}/admin/updateReportFlagR.do?reportNo="+${report.reportNo};
});
</script>
