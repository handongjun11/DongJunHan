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
	$("#adControl").addClass("active");	
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
			<form name="adFrm" action="${pageContext.request.contextPath }/admin/deleteAd.do" method="post" onsubmit="return validate();" >
				<table class="table table-bordered" id="tblEvent">
					<tr>
						<th>가입 아이디</th>
						<td>${store.sellerId }</td>
					</tr>
					<tr>
						<th>가게번호</th>
						<td>${store.storeNo }</td>
					</tr>
					<tr>
						<th>가게명</th>
						<td>${store.storeName }</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${store.storeTel }</td>
						
					</tr>
					<tr>
						<th>현재 등급</th>
						<td>${store.storeGrade }</td>
					</tr>
					<tr>
						<th>광고 시작일</th>
						<td><fmt:formatDate value="${ad.startDate}" type="date" /> </td>
					</tr>
					<tr>
						<th>광고 종료일</th>
						<td><fmt:formatDate value="${ad.endDate}" type="date" /> </td>
					</tr>
				</table>
			
				<br />
				<input type="button" id="deleteAd" class="btn btn-outline-success" value="해지" >
			</form>
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
$("#updateEvent").on("click", function(){
	
});

$("#deleteAd").on("click", function(){
	if(!confirm("정말 삭제하시겠습니까?")) return;
	location.href="${pageContext.request.contextPath}/admin/deleteAd.do?adNo=${ad.adNo}&storeNo=${store.storeNo}";
});
</script>