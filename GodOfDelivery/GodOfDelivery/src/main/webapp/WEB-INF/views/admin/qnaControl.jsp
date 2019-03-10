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
table#tbl-qnaControl thead tr th {
	text-align: center;
}

table#tbl-qnaControl tbody tr td {
	text-align: center;
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
         <table id="tbl-qnaControl" class="table table-borderless">
		<thead class="thead-light">
			<tr>
				<th>질문</th>
				<th>답변</th>
			</tr>
		</thead>
		<c:if test="${not empty list}">
			<c:forEach items="${list }" var="b">
		<tbody>
			<tr>
				<td>${b.boardTitle }</td>
				<td><a href="${pageContext.request.contextPath }/admin/qnaAnswer.do?boardNo=${b.boardNo } ">답변하러가기</a></td>
			</tr>
		</tbody>
			</c:forEach>
		</c:if>
		<c:if test="${empty list}">
		<tbody>
			<tr>
				<td colspan="4">질문이존재하지 않습니다!</td>
			</tr>
		</tbody>
		</c:if>
	
	 </table>
	 <%
	int totalContents = (int) request.getAttribute("totalContents");
	int numPerPage = (int) request.getAttribute("numPerPage");
	int cPage = (int) request.getAttribute("cPage");
	%>
	<br /><br />
	 <div id="pageBar">
		<%=com.kh.god.common.util.Utils.getPerBar(totalContents, cPage, numPerPage, "qnaControl.do")%>
	 </div>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->