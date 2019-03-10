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
table#tbl-event tr th{text-align:center; vertical-align:middle;}
table#tbl-event tr td{text-align:center; vertical-align:middle;}
div#searchContainer{text-align:center; padding:10px;}
div#searchContainer select{display:inline; width:150px;}
div#searchContainer input[type=search]{display:inline; width:200px;}
div#searchContainer input[type=button]{display:inline; width:70px;}
</style>

<script>
$(function(){
	$("#storeList").addClass("active");	
});

function goSearch(){
	var searchType = $("select[name=searchType]").val();
	var searchKeyword = $("input[type=search]").val();
	location.href="${pageContext.request.contextPath}/admin/storeList.do?searchType="+searchType+"&searchKeyword="+searchKeyword;
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
          <h1 class="h3 mb-4 text-gray-800">가게 관리</h1>
          
          <div id="searchContainer">
	          <select name="searchType" class="form-control">
			    <option value="storeNo" <c:if test="${param.searchType=='storeNo'}">selected</c:if>>사업자 번호</option>
			    <option value="storeName" <c:if test="${param.searchType=='storeName'}">selected</c:if>>가게 이름</option>
			    <option value="sellerId" <c:if test="${param.searchType=='sellerId'}">selected</c:if>>사장님 아이디</option>
			  </select>
	          <input type="search" class="form-control" value="${param.searchKeyword}"/>
	          <input type="button" class="btn btn-outline-success" value="검색" onclick="goSearch();"/>
          </div>
          
          <table id="tbl-event" class="table table-striped table-hover">
			<tr>
				<th>사업자 번호</th>
				<th>가게 이름</th>
				<th>가게 전화번호</th>
				<th>가게 등급</th>
				<th>카테고리</th>
				<th>사장님 아이디</th>
				<th>영업 중지 여부</th>
			</tr>
			<c:if test="${not empty list}">
				<c:forEach items="${list }" var="store">
					<tr>
						<td>${store.storeNo}</td>
						<td><a href="${pageContext.request.contextPath }/admin/storeView.do?storeNo=${store.storeNo} " >${store.storeName }</a></td>
						<td>${store.storeTel }</td>
						<td>${store.storeGrade }</td>
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
						<td>${store.sellerId }</td>
						<td>${store.pmsFlag=='C'?"중지":"" }</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty list}">
				<tr>
					<td colspan="7">등록된 가게가 없습니다.</td>
				</tr>
			</c:if>
		
		  </table>
	
		<%
			int totalContents = (int)request.getAttribute("totalContents");
			int numPerPage = (int)request.getAttribute("numPerPage");
			int cPage = (int)request.getAttribute("cPage");
		%>
		<div>
		<%=com.kh.god.common.util.Utils.getPerBar(totalContents,cPage,numPerPage,"storeList.do") %>
		</div>
          

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->