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

<script>
$(function(){
	$("#collapsePages").addClass("show");	
	$("#qnaControl").addClass("active");	
	$("#toDoList").addClass("active");	
});
</script>

<style>

div#board-container input{width:400px; margin:0 auto; text-align:center;}
div#board-container div{width:400px; margin:0 auto; }
div#mine {margin-left:250px; font-weight : bold;}
div#mine_ {margin-left:300px; font-weight : bold;}
table#tbl-board tr th{text-align:center;}
table#tbl-board tr td{text-align:center;}
a {text-decoration:none;}
div#head-container{margin:70px auto; width : 900px; height:50px;}
input#boardTitle{font-weight : bold;}
div#answer{margin-top:-50px auto;}
form{width:500px; margin:0 auto;}
form input#answerbtn {
margin-left:200px;
}
</style>

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
        <div id="mine" > 문의 내용 : </div>
 			<br />
 		<div id="board-container">
 		
		<input type="text" class="form-control" style="background-color:transparent;" placeholder="제목" name="boardTitle" id="boardTitle" value="${board.boardTitle }" required>
		<br />
		<div class="form-control" name="boardContent" placeholder="내용" style="border:none; background-color:transparent;height:150px;" required>${board.boardContent }</div>
	
		</div>
		<br />
        </div>
        
        <form name="answerForm" action="${pageContext.request.contextPath }/admin/insertAnswer.do" method="post" onsubmit="return insertValidate();">
			<input type="hidden" class="form-control" placeholder="제목" name="boardNo" id="boardNo" value="${board.boardNo }">
			<input type="text" class="form-control" placeholder="제목" name="answerTitle" id="boardTitle">
			<br />
		 	<input type="hidden" class="form-control" name="boardWriter" id="boardWriter" value="admin"/>
		 	<br />
			<textarea class="form-control" name="answerContent" id="answerContent" placeholder="내용" style="height:300px;" ></textarea>
			<br />
			<input type="submit" class="btn-info" id="answerbtn" value="답변하기" >
		</form>
		<br />
		<br />
		
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->