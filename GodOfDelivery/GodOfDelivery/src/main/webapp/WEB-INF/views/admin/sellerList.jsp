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
<link
	href="${pageContext.request.contextPath }/resources/css/fontawesome-free/css/all.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link
	href="${pageContext.request.contextPath }/resources/css/sb-admin-2.css"
	rel="stylesheet">

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
input#boardTitle {
	font-weight: bold;
}

div#pageBar {
	margin: 35px auto;
}

table#tbl-seller thead tr th {
	text-align: center;
}

table#tbl-seller tbody tr td {
	text-align: center;
}

table#tbl-seller tbody tr td input {
	text-align: center;
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

function bFlagCheck(sellerId,bFlag){
	if(bFlag=='Y'){
		if(!confirm("정말 블랙리스트에서 제거하시겠습니까?")){
			return;
		}
	}else {
		if(!confirm("정말 블랙리스트에 추가하시겠습니까?")){
			return;
		}
	}
	location.href = "${pageContext.request.contextPath}/admin/sellerBlackList.do?sellerId="+sellerId+"&bFlag="+bFlag+"&page=SList";
	
};

function fn_goSellerBL(){
	
	location.href = "${pageContext.request.contextPath}/admin/sellerBList.do";
};
function fn_goMemberBL(){
	location.href = "${pageContext.request.contextPath}/admin/memberBList.do";
};


</script>
<%
	int totalContents = (int) request.getAttribute("totalContents");
	int numPerPage = (int) request.getAttribute("numPerPage");
	int cPage = (int) request.getAttribute("cPage");
%>

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
					<div id="seller" class="alert-info" onclick="fn_goSellerList();">판매자</div>
					<div id="sellerBL" class="alert-light" onclick="fn_goSellerBL();">판매자 BL</div>
				
				</div>

				<br />
				<table class="table" id="tbl-seller">
					<thead>
						<tr>
							<th scope="col">아이디</th>
							<th scope="col">이름</th>
							<th scope="col">이메일</th>
							<th scope="col">전화번호</th>
							<th scope="col">블랙리스트</th>

						</tr>
					</thead>
					<c:if test="${not empty seller }">
						<c:forEach items="${seller }" var="seller">
							<tbody>
								<c:if test="${seller['BLACKFLAG'] eq 'Y'}">
									<tr class="table-danger">
								</c:if>
								<c:if test="${seller['BLACKFLAG'] eq 'N'}">
									<tr>
								</c:if>
								<td name="sellerId" id="sellerId">${seller['SELLERID'] }</td>
								<td name="sellerName" id="sellerName">${seller['SELLERNAME'] }</td>
								<td name="email" id="email">${seller['EMAIL'] }</td>
								<td name="phone" id="phone">${seller['PHONE'] }</td>
								<c:if test="${seller['BLACKFLAG'] eq 'Y' }">
									<td><input type="checkbox" class="form-check-input"
										value="Y" name="blackFlag" id="bFlag1" checked /> <input
										type="button" class="btn btn-info" value="해제"
										onclick="bFlagCheck('${seller['SELLERID'] }','${seller['BLACKFLAG'] }');" />
									</td>
								</c:if>
								<c:if test="${seller['BLACKFLAG'] eq 'N' }">
									<td><input type="checkbox" class="form-check-input"
										value="N" name="blackFlag" id="bFlag2" /> <input
										type="button" class="btn btn-secondary" value="등록"
										onclick="bFlagCheck('${seller['SELLERID'] }','${seller['BLACKFLAG'] }');" />
									</td>
								</c:if>
								</tr>
							</tbody>
						</c:forEach>
					</c:if>

					<c:if test="${empty seller}">
						<tbody>
							<tr>
								<td colspan="6">등록된 정보가 없습니다</td>
							</tr>
						</tbody>
					</c:if>

				</table>
				<div id="pageBar">
					<%=com.kh.god.common.util.Utils.getPerBar(totalContents, cPage, numPerPage, "sellerList.do")%>
				</div>

			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- End of Main Content -->

	</div>
	<!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->