<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<%@ page import="com.kh.god.seller.model.vo.* , com.kh.god.member.model.vo.*" %>
<%
	/* if(session.getAttribute("sellerLoggedIn") != null){
		Seller sellerLoggedIn = (Seller)session.getAttribute("sellerLoggedIn");
	System.out.println("##################################" + sellerLoggedIn.getSellerId());		
	} */
   Member memberLoggedIn = null;
	if(session.getAttribute("memberLoggedIn") != null){
		 memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
	}

%>
<style>
/*#star-container{
	width : 192;
	height : 38;
	overflow:hidden;
}*/

.star_rating {font-size:0; letter-spacing:-4px;}
.star_rating a {
    font-size:22px;
    letter-spacing:0;
    display:inline-block;
    margin-left:5px;
    color:#ccc;
    text-decoration:none;
}
.star_rating a:first-child {margin-left:0;}
.star_rating a.on {color:red;}
#reviewcategory{
	background : none;
	border : none;

}
#reviewWriter{
background : none;
	border : none;
}
#profilePre{
	
	display : none;

}
#div-profilePre{
	width : 100px;
	height : 100px;
}
#delivery2{
	  
animation:move 5s 1s infinite ;	

}
 @keyframes move{
	 0% {left: -130px;} 
    10% {left:169px;} 
    20% {left:229px;} 
    30% {left:340px;} 
    40% {left:480px;} 
    50% {left:580px;} 
    60% {left:680px;} 
    70% {left:780px;} 
    80% {left:980px;} 
    85% {left:1024px;} 
    90%{left:1110px;}
    100%{left:1205px;}
  
   
	
} 
</style>


<script>
function validate(){
	//내용을 작성하지 않은 경우에 대한 유효성 검사하세요.
	//공백만 작성한 경우도 폼이 제출되어서는 안됨.

	var content = $("textarea[name=content]");
	var title = $("#title").val();
	if(title.trim() == 0){
		alert("제목을 입력하세요");
		return false;
	}
	
	if(content.val().trim().length  ==  0 ){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}


	$(function() {
		$( ".star_rating a" ).click(function() {
		    $(this).parent().children("a").removeClass("on");
		    $(this).addClass("on").prevAll("a").addClass("on");
		     var star = $(this).attr("id");
		    $("[name='star']").val(star);
		    return false;
		});
		})	;


</script>

<div class="form-group row" style="padding-left: 407px;
    padding-top: 80px;">
<section id="board-container">
<h2 >후기 작성</h2>

<form action="${pageContext.request.contextPath}/member/webreviewformEnd.do"  method="post">
 <!--  파일 업로드 속성 추가 enctype="multipart/form-data" : 파일 업로드를 위한 필수 속성-->
  <input type="hidden" name="star" >
	<table id="tbl-board-review">
	<tr>
		<th class="col-sm-3">평가</th>
		<td><input type="text"  id="reviewcategory" value="배달의신을 평가해주세요" style= " width: 194px;"readonly ></td>
	</tr>
	<tr>
		<th class="col-sm-3">작성자</th>
		 <td>
			<c:if test="${memberLoggedIn == null}" >
               <input type="text" name="writer" value="비회원"
                     id="reviewWriter"  placeholder="비회원"  readonly /> 
            </c:if>                
            <c:if test="${memberLoggedIn != null}" >
             	 <input type="text" name="writer" value="${memberLoggedIn.memberId}"
                     id="reviewWriter"  readonly />              
            </c:if>          
		</td> 
	</tr>
	<tr>
		<th class="col-sm-3">제목</th>
		<td>
			 <input type="text" name="title" id="title"  style="border-top:none;border-left:none;border-right:none;" autofocus="autofocus"/>
		</td>
	</tr>
	<tr>
		<th class="col-sm-3">평점</th>
		<td>	
		<p class="star_rating">
    			<a href="#" name="rate" id="1" value="1">★</a>
    			<a href="#" name="rate" id="2" value="2">★</a>
    			<a href="#" name="rate" id="3" value="3">★</a>
    			<a href="#" name="rate" id="4" value="4">★</a>
    			<a href="#" name="rate" id="5" value="5">★</a>
    			<input type="hidden" name="star" />
			</p>                                   
		</td>
	</tr>

	<tr>
		<th class="col-sm-3">내 용</th>
		<td><textarea rows="5" cols="50" name="content"></textarea></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="등록하기" class="btn btn-outline-success" style="margin-left: 226px;" onclick="return validate();">
		</th>
	</tr>
	
</table>
</form>
</section>
</div>
<img src="${pageContext.request.contextPath}/resources/images/delivery2.gif" style="width:200px;position: relative;top: 25px; left: -138px; " id="delivery2"/>
		
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	