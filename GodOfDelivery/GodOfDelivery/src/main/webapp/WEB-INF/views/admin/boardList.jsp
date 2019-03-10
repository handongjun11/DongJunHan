<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="고객센터" name="pageTitle"/>
</jsp:include>
<style>
/*글쓰기버튼*/
input#btn-add{float:right; margin: 0 0 15px;}
table#tbl-board tr th{text-align:center;}
table#tbl-board tr td{text-align:center;}
a {text-decoration:none;}
table#tbl-board{ width : 500px; margin:-35px auto;}
div#head-container{margin:70px auto; width : 900px; height:50px;}
div#qna{margin-left : -40px; width : 450px; height : 50px; text-align : center; font-weight : bold;cursor : pointer;display: table-cell;vertical-align: middle;}
div#asking{margin-top:-50px; margin-left : 500px; width : 450px; height : 50px; text-align : center; font-weight : bold; cursor : pointer;display: table-cell;vertical-align: middle;}
div#pageBar{margin:35px auto;}
</style>
<script>
function fn_goAskingList(){
	if("${memberLoggedIn }" != ""){
		var memberId= "${memberLoggedIn.memberId }";
		location.href = "${pageContext.request.contextPath}/admin/askingList.do?boardWriter="+memberId;	
	}else if("${sellerLoggedIn }" != ""){
		var sellerId = "${sellerLoggedIn.sellerId }";
		location.href = "${pageContext.request.contextPath}/admin/askingList.do?boardWriter="+sellerId;
	}else if("${sellerLoggedIn }" == "" && "${memberLoggedIn }" == ""){
		alert("로그인 후 이용 가능합니다.");
		return;
	}
}
function fn_goQnaList(){
	location.href = "${pageContext.request.contextPath}/admin/qnaboard.do";
}
function fn_goStomp(){
	location.href = "${pageContext.request.contextPath}/ws/stomp.do";
}
</script>

<section id="board-container" class="container">
<!-- 전체 게시글 출력 -->
	
<div id="head-container">
	<div id="qna" class="alert-info" onclick="fn_goQnaList();">FAQ</div> <div id="asking" class="alert-light" onclick="fn_goAskingList();">1:1문의</div> <div id="asking" class="alert-light" onclick="fn_goStomp();">채팅 문의</div>
</div>
<section id="board-container" class="container">
<!-- 전체 게시글 출력 -->
	<table id="tbl-board" class="table table-borderless table-hover">
		<thead class="thead-light">
			<tr>
				<th>자주 묻는 질문</th>
			</tr>
		</thead>
		<c:if test="${not empty list}">
			<c:forEach items="${list }" var="b">
		<tbody>
		<tr>
			<td><a href="${pageContext.request.contextPath }/admin/boardView.do?boardNo=${b['BOARDNO'] } ">${b["BOARDTITLE"] }</a></td>
		</tr>
		</tbody>
			</c:forEach>
		</c:if>
		<c:if test="${empty list}">
		<tbody>
			<tr>
				<td colspan="4">등록된 정보가 없습니다</td>
			</tr>
		</tbody>
		</c:if>
	
	 </table>
	 
	
	<%
		int totalContents = (int)request.getAttribute("totalContents");
		int numPerPage = (int)request.getAttribute("numPerPage");
		int cPage = (int)request.getAttribute("cPage");
	%>

	<div id="pageBar">
	<%=com.kh.god.common.util.Utils.getPerBar(totalContents,cPage,numPerPage,"qnaboard.do") %>
	</div>
		
	<!-- 페이지바  -->
</section> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>