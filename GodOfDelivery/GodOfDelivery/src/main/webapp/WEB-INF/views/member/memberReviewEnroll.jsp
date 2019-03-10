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

input[name="upFile"]{
	display : block;
	margin: 10px 0;
}

div#addReviewPhoto{
	cursor: pointer;
    font-weight: 400;
    color: #858796;
    text-align: center;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: 0.35rem;
    border : 1px solid #858796;
    width: 50%;	
}
.checked {
  color: orange;
}
.fa-star{
	cursor : pointer;
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
		
		<!-- 리뷰작성 폼 -->
		<div class = "memberViewCategory">		
		
			<h2>리뷰 작성</h2>
			<br /><hr /><br />
			
		<form name="memberEnrollEndFrm" method="post" 
		 	  action="${pageContext.request.contextPath}/member/memberReviewEnrollEnd.do"  
		  	  enctype="multipart/form-data">
		  	<!-- storeNo -->	  
		  	<input type="hidden" name="storeNo" value="${storeNo}"/>
			<!-- orderNo -->
			<input type="hidden" name="orderNo" value="${orderNo}"/>		  		  	
		  	<!-- 제목 -->
		  	<div class="form-group row">
		  		<label for="inputReviewTitle" class="col-sm-3">제목</label>
    			<div>
      				<input type="text" class="form-control" name="title" id="inputReviewTitle" required>
    			</div>
		  	</div>
		  			  	
		  	<!-- 아이디 -->
		  	<div class="form-group row">
		  		<label for="inputWriter" class="col-sm-3">아이디</label>
    			<div>
      				<input type="text" class="form-control" name="writer" value="${writer}" id="inputWriter"  readonly>
    			</div>
		  	</div>
		  	
		  	<!-- 주문 매장 -->
		  	<div class="form-group row">
		  		<label for="inputWriter" class="col-sm-3">주문매장</label>
    			<div class="orderInfo">
					${orderMenuList[0].STORENAME }
    			</div>
		  	</div>
		  	
		  	<!-- 주문한 메뉴 -->		  	
		  	<!-- orderMenuList는 존재한다-->
		  	<div class="form-group row">
		  		<label for="inputWriter" class="col-sm-3">주문메뉴</label>
    			<div>
    				<table class="orderInfo">
      					<c:forEach var="m" items="${orderMenuList }">
      						<tr><td>${m.MENUNAME } X ${m.AMOUNT } </td></tr>	      				
      					</c:forEach>
      				</table>
    			</div>
		  	</div>
		  	
		  	<!--  평점 -->
		  	<div class="form-group row">
		  	<label for="inputWriter" class="col-sm-3">평점</label>
    			<div id="star" >
    				<span class="fa fa-star checked"></span>
      				<span class="fa fa-star"></span>
					<span class="fa fa-star"></span>
					<span class="fa fa-star"></span>
					<span class="fa fa-star"></span>
    			</div>
		  	</div>
 			<input type="hidden" name="rate"/>
		  	
		  	<!-- 리뷰 내용 -->
		  	<div class="form-group row">
		  		<label for="inputReviewContent" class="col-sm-3">내용</label>
    			<div>
    				<textarea rows="6" cols="35" class="form-control" name="content">
    				
    				</textarea>
    			</div>		  	
		  	</div>
		  	
		  	<!-- 리뷰사진 -->
		  	<div class="form-group row">
		  		<label for="inputReviewPhoto" class="col-sm-3">첨부 사진</label>
		  		<div>
		  			<div id="inputReviewPhoto">
    					<input type="file" name="upFile">
    					<input type="file" name="upFile">		
  					</div>		
		  			<div id="addReviewPhoto" onclick="addReviewPhoto();">사진 추가</div> <!-- 버튼을 누르면 사진 업로드태그가 ajax로 생성됨 -->
		  		</div>
		  	</div>
		  	
		  	<input type="button" class="btn btn-outline-success" id="enrollReview" value="리뷰등록하기" >
		  	
		</form>
		 	  
		</div> <!-- div.memberViewCategory  -->
			
	</div> <!-- div#memberViewFrm-container -->
	
</div> <!-- div#MemberView-container -->



<script>
var cnt = 1;

//평점 
$('.fa-star').on("click",function(){

	var checkIndex = $(this).index()+1;

	$('.fa-star').removeClass( 'checked' );
	$('.fa-star:nth-child(-n+'+checkIndex+')').addClass( 'checked' );

	cnt = $('span.checked').length;

	$('input[name="rate"]').val(cnt);
});




function addReviewPhoto(){
	
	//사진 추가 창 추가
	var html = "";
	
	if($('input[name="upFile"]').length <3){
		html += "<input type='file' name='upFile'>";
		$('#inputReviewPhoto').append(html);
	}else{
		alert('사진은 최대 3개까지 가능합니다.');
	}

};
$("#enrollReview").click(function(){
	if(socket.readyState !== 1) return;
	sendReviewAlert();
	$("form[name=memberEnrollEndFrm]").submit();
});


</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	