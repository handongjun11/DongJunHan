<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원정보조회" name="pageTitle"/>
</jsp:include>

<link href="${pageContext.request.contextPath }/resources/css/fontawesome-free/css/all.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.css" rel="stylesheet">

<style>
div#MemberView-wapper{
 /* position: absolute;
    height: 100%;
    width: 100%; */
}

div#MemberView-sideBar{
    background-color: #36b9cc;
    float: left;
	width: 20%;
	height: 960px;
}

div#memberViewFrm-container{
  	float : left;
	width : 80%;
	text-align : center;
}

.memberViewCategory{
	margin: 75px 0;
    padding-left: 20px;
}

#MemberView-ul{
	margin-top:80px;
	list-style:none;
}
#MemberView-ul li a{
	line-height: 83px;
    color: white;
    font-size: 15px;
    opacity: 0.8;
    /* cursor: pointer; */
}
#reviewTable{
	width: 70%;
	margin: 0 auto;
}
#reviewTable tbody{
	
}
#reviewTable tr{

}
#reviewTable th{
	width : 100px;
	border : none;
	border-right : 1px solid #dddfeb;
}

.deleteReviewCls{
  text-align: right;
  color : red;
  cursor: pointer;
}

#reviewTable td{
	border : none;
}

.checked {
  color: orange;
}


</style>


<!-- 일반회원 정보조회 -->
<div id="MemberView-wapper">

	<div id="MemberView-sideBar">
		<ul id="MemberView-ul">
			<li>
				<a href="${pageContext.request.contextPath}/member/memberView.do?memberId=${memberLoggedIn.memberId}">회원 정보 변경</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/member/orderList.do?memberId=${memberLoggedIn.memberId}">구매 내역</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/member/reviewList.do?memberId=${memberLoggedIn.memberId}">내 리뷰 보기</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/member/bookMarkList.do?memberId=${memberLoggedIn.memberId}">즐겨찾는 매장</a>	
			</li>
		</ul>	
	</div>

	<div id="memberViewFrm-container">
		
		<!-- 리뷰 리스트 css 잡아야함 -->
		<div class = "memberViewCategory">		
			
			<h2>내 리뷰 보기</h2>
			<br /><br />	
			
			<table class="table table-hover active" id="reviewTable">				  
				<c:if test="${not empty reviewList }">
					<tbody>					
						<c:forEach var="review" items="${reviewList }" varStatus="status">
							<tr style="border-bottom : 1px solid #dddfeb;">
								<td colspan="2" class="deleteReviewCls" onclick="deleteReview(${review.reviewNo});">삭제하기</td>
							</tr>						
							<tr>
								<th>제목</th>
								<td>${review.title }</td>
							</tr>
							
							<tr>
								<th>작성일</th>
								<td>${review.rDate }</td>
							</tr>							
							<tr>
								<th>평점</th>	
								<td>
								<c:forEach var="i" begin="1" end="${review.rate }">								
				    				<span class="fa fa-star checked"></span>
				      			</c:forEach>
				      			<c:forEach var="i" begin="${review.rate+1}" end='5'>
				      				<span class="fa fa-star"></span>
				      			</c:forEach>	
								</td>
							</tr>							
							<tr>
								<th>내용</th>
								<td>${review.content }</td>
							</tr>
							<!-- 리뷰 첨부파일 꺼내기 -->
							<c:if test="${not empty attachList}">	
								<tr style="border-bottom : 1px solid #dddfeb;">
									<th>후기사진</th>
									<td class="attachList-td">
										<c:forEach var="a" items="${attachList }">
											<!-- 현재 review와 review번호가 같은 첨부파일만 꺼내기 -->															
											<c:if test="${review.reviewNo == a.reviewNo }">										
												<img src="${pageContext.request.contextPath }/resources/upload/review/${a.renamedFileName}"
													 style="max-width : 100px; margin:0 10px;" >
											</c:if>									
										</c:forEach>
									</td>
								</tr>					
							</c:if>
																					
						</c:forEach> <!-- reviewList를 돌면서 review 꺼내기 -->
					</tbody>
				</c:if>
				<c:if test="${empty reviewList }">
					<tbody><tr><td>작성한 리뷰가 없습니다.</td></tr></tbody>
				</c:if>
			</table>

		</div>
		
		
	</div> <!-- div#memberViewFrm-container -->
</div> <!-- div#MemberView-container -->


<form name="memberDeleteReviewFrm" method="POST" 
	  action="${pageContext.request.contextPath}/member/memberReviewDelete.do">
    <input type="hidden" name="reviewNo" id="reviewNoFrm" />
        <input type="hidden" name="writer" id="FrmWriter"/>
</form>


<script>
function deleteReview(reviewNo){
	
	if(confirm("정말 삭제하시겠습니까?")){
		
		$('input#reviewNoFrm').val(reviewNo);			
		$('input#FrmWriter').val("${memberLoggedIn.memberId}");
		
		$('[name="memberDeleteReviewFrm"]').submit();	
	}
	
}
	

</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	