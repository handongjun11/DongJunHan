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
div#head-container {
	margin: 30px auto;
	width: 500px;
	height: 50px;
}

div#member {
	margin-left: -40px;
	width: 250px;
	height: 50px;
	text-align: center;
	font-weight: bold;
	cursor: pointer;
	display: table-cell;
	vertical-align: middle;
}

div#memberBL {
	margin-left: -40px;
	width: 250px;
	height: 50px;
	text-align: center;
	font-weight: bold;
	cursor: pointer;
	display: table-cell;
	vertical-align: middle;
}

div#seller {
	margin-top: -50px;
	margin-left: 500px;
	width: 250px;
	height: 50px;
	text-align: center;
	font-weight: bold;
	cursor: pointer;
	display: table-cell;
	vertical-align: middle;
}

div#sellerBL {
	margin-top: -50px;
	margin-left: 500px;
	width: 250px;
	height: 50px;
	text-align: center;
	font-weight: bold;
	cursor: pointer;
	display: table-cell;
	vertical-align: middle;
}
</style>
<script>
$(function(){
	$("#memberList").addClass("active");	
});

function fn_goMemberList(){
	location.href = "${pageContext.request.contextPath}/admin/memberList.do";
};
function fn_goSellerList(){
	location.href = "${pageContext.request.contextPath}/admin/sellerList.do";
};
function fn_goSellerBL(){
	location.href = "${pageContext.request.contextPath}/admin/sellerBList.do";
};
function fn_goMemberBL(){
	location.href = "${pageContext.request.contextPath}/admin/memberBList.do";
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
          <div id="head-container">
					<div id="member" class="alert-light" onclick="fn_goMemberList();">일반회원</div>
					<div id="memberBL" class="alert-light" onclick="fn_goMemberBL();">일반회원 BL</div>
					
					<div id="seller" class="alert-light" onclick="fn_goSellerList();">판매자</div>
					<div id="sellerBL" class="alert-light" onclick="fn_goSellerBL();">판매자 BL</div>
		 </div>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->