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

div.form-group label{ padding-top : 0.5em; text-align: left;}
div.form-group input{
	width : 280px;
}
div#inputProfile{
    position: relative;
    float: right;
    top: -35px;
    left: -6%;
}
.imgProfile-wrapper{
	width: 150px;
    height : 150px;
    padding: 3px;
    border: 1px solid #ced4da;
}
.profile{
	background-image: url("${pageContext.request.contextPath }/resources/images/outbox.png");
	background-repeat: no-repeat;
	background-position: center;
	border : 1px solid #ced4da;
	width : 120px;
	overflow: hidden;
	margin-top: 8px;
}
form[name="memberViewFrm"]{
    margin: 75px 0;
    padding-left: 20px;
}
input#inputProfileFile{opacity: 0;}
input#gender1, input#gender2{width : 30px;}
input#gender2 {margin-left:50px;}
select#selectYear{ width : 100px;}
select#selectMonth, select#selectDay{ width : 65px;}
.checkFavorite{width:30px !important}

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
		<!-- 회원정보 -->
		<div class = "memverViewCategory">		
			<form name="memberViewFrm" 
				  action="${pageContext.request.contextPath}/member/memberUpdate.do" 
				  method="post" 
				  onsubmit="return validate();" 
				  enctype="multipart/form-data">
				  
				<input type="hidden" name="renamedFile" value='${m.renamedFile}' />  
				<h2>개인 회원 정보</h2>
				<br /><hr /><br />			
				
				<!-- 프로필 사진 -->
				<div id=inputProfile class="form-group">	
					<div class="imgProfile-wrapper">
						<img id="imgProfile" style="width:100%; height:100%">				
		  			</div>
		  			<div class="profile custom-file">
		    			<input type="file" id="inputProfileFile" name="upFile">		
		  			</div>				
				</div>		
				
				<!-- 아이디 -->
				<div class="form-group row">
		    		<label for="inputMemberId" class="col-sm-3">아이디</label>
		    		<div>
		      			<input type="text" class="form-control" id="inputMemberId" name="memberId" value="${m.memberId }" readonly>
		    		</div>
		  		</div>	
		  		
				<!-- 비밀번호 -->
				<div class="form-group row">
		    		<label for="inputPassword" class="col-sm-3">비밀번호</label>
		    		<div>
		      			<input type="password" class="form-control" id="inputPassword" name = "password">
		    		</div>
		  		</div>
		  		<div class="form-group row">
		    		<label for="checkPassword" class="col-sm-3">비밀번호 확인</label>
		    		<div>
		      			<input type="password" class="form-control" id="checkPassword">
		    		</div>
		  		</div>
		  		
				<hr />
				
				<!-- 이름 -->
				<div class="form-group row">
		    		<label for="inputMemberName" class="col-sm-3">이름</label>
		    		<div>
		      			<input type="text" class="form-control" id="inputMemberName" name="memberName" 
		      				   value="${m.memberName }" readonly>
		    		</div>
		  		</div>		
		  		
				<!-- 생년월일 -->
				<div class="form-group row">
					<input type="hidden" name="birth" />
					<label for="selectBirth" class="col-sm-3">생년월일</label>	
					<select class="form-control selectBirth" id="selectYear" disabled>  
		  				<option selected="selected" disabled="disabled">년</option>
		  				<c:forEach var="year" begin="1935" end = "2004">
		  					<option>${year }</option>
		  				</c:forEach>
					</select>
					&nbsp;
					<select class="form-control selectBirth" id="selectMonth" disabled> 
		  				<option selected="selected" disabled="disabled">월</option>
		  				<c:forEach var="month" begin="1" end = "12">
		  					<option>${month }</option>
		  				</c:forEach>
					</select>
					&nbsp;
					<select class="form-control selectBirth" id="selectDay" disabled> 
		  				<option selected="selected" disabled="disabled">일</option>
		  				<c:forEach var="day" begin="1" end = "31">
		  					<option>${day }</option>
		  				</c:forEach>
					</select>
				</div>
				
				<!-- 이메일 -->
				<div class="form-group row">
					<input type="hidden" name="email" />
		    		<label for="inputEmail" class="col-sm-3">이메일</label>
		    		<div class="form-inline">
		      			<input type="text" class="form-control" id="inputEmailAddress1">
		      			&nbsp;@&nbsp;
		      			<input type="text" class="form-control" id="inputEmailAddress2">
		      			&nbsp;
		      			<select class="form-control" id="selectEmailAddress" >
		      				 <option value="">선택하세요</option>
		      				 <option value="naver.com">naver.com</option>
		                     <option value="hanmail.net">hanmail.net</option>
		                     <option value="nate.com">nate.com</option>
		                     <option value="daum.net">daum.net</option>
		                     <option value="gmail.com">gmail.com</option>
		                     <option value="etc">직접입력</option>
		      			</select> 
		      		</div>
		  		</div>
		  	
			
				<!-- 핸드폰 번호 -->
				<div class="form-group row">
					<input type="hidden" name="phone" />
					<label for="phone1" class="col-sm-3">핸드폰 번호</label>	
					<div class="form-inline">
						<select class="form-control selectPhone" id="phone1"> 
			  				<option>010</option>
			  				<option>019</option>
			  				<option>016</option>
						</select>
						&nbsp;-&nbsp;
						<input class="form-control selectPhone" type="text" id="phone2" 
							   maxlength="4" style="width: 80px;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>  
						&nbsp;-&nbsp;
						<input class="form-control selectPhone" type="text" id="phone3" 
							   maxlength="4" style="width: 80px;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
					</div>
				</div>
					
				
				<!-- 주소 api -->
				<div class="form-group row">
					<label for="address" class="col-sm-3">주소</label>	
					<input class = "form-control" type="text" name="address" id="address" 
						   value="${m.address }" onclick="execDaumPostcode();"/>		
				</div>
				
				<!-- 취향 -->
				<div class="form-group row">
					<label class="col-sm-3">취향</label>
					
					<div class="form-inline">						  			
						<input type="checkbox" class="form-check-input checkFavorite" name="favorite" id="favorite0" value="1"><label for="favorite0" class="form-check-label col-form-label">치킨</label>&nbsp;
						<input type="checkbox" class="form-check-input checkFavorite" name="favorite" id="favorite1" value="2"><label for="favorite1" class="form-check-label col-form-label">피자</label>&nbsp;
						<input type="checkbox" class="form-check-input checkFavorite" name="favorite" id="favorite2" value="3"><label for="favorite2" class="form-check-label col-form-label">족발/보쌈</label>&nbsp;
						<input type="checkbox" class="form-check-input checkFavorite" name="favorite" id="favorite3" value="4"><label for="favorite3" class="form-check-label col-form-label">분식</label>&nbsp;
						<input type="checkbox" class="form-check-input checkFavorite" name="favorite" id="favorite4" value="5"><label for="favorite4" class="form-check-label col-form-label">중식</label>&nbsp;
						<input type="checkbox" class="form-check-input checkFavorite" name="favorite" id="favorite4" value="6"><label for="favorite4" class="form-check-label col-form-label">일식</label>&nbsp;
						<input type="checkbox" class="form-check-input checkFavorite" name="favorite" id="favorite4" value="7"><label for="favorite4" class="form-check-label col-form-label">한식</label>&nbsp;
					</div>
				</div>
				<hr />
				
				<input type="submit" class="btn btn-outline-success" value="수정하기" >
				<input type="button" class="btn btn-outline-success" value="탈퇴하기" onclick= "memberDelete();" >
			</form>
			
		</div>
		

		
		
		
	</div> <!-- div#memberViewFrm-container -->
	
	
	
	
	
</div> <!-- div#MemberView-container -->



<script>
function validate(){ 	
	
 	//비밀번호 일치 여부 검사
	if($("#inputPassword").val() != $("#checkPassword").val()){
	      alert("비밀번호가 일치하지 않습니다.");
	      return false;
	}
 	
	/*이메일 처리*/
 	$("input[name=email]").val($('#inputEmailAddress1').val()+'@'+$('#inputEmailAddress2').val());
 	
 	/*핸드폰 번호 처리*/
	$("input[name=phone]").val($('#phone1').val()+"-"+$('#phone2').val()+"-"+$('#phone3').val());
  	
	return true;
}

$(function(){
	
	//프로필사진
	if('${m.renamedFile}' != null){
		$('#imgProfile').attr('src',
							  "${pageContext.request.contextPath }/resources/upload/member/${m.renamedFile}");
	}else{
		$('#imgProfile').attr('src',"${pageContext.request.contextPath }/resources/images/avatar.png");
	}
	
	
	//생년월일
	var birth = '${m.birth}';
	var year = birth.substr(0,4);
	var month = birth.substr(4,2);
	var day = birth.substr(6,2);
	
	if(month.substr(0,1) == 0){
		month = month.substr(1,1);
	}
	if(day.substr(0,1) == 0){
		day = day.substr(1,1);
	}

	$('#selectYear').val(year);
	$('#selectMonth').val(month);
	$('#selectDay').val(day);
	
	//핸드폰
	var phoneArr = '${m.phone}'.split('-');
	$('#phone1').val(phoneArr[0]);
	$('#phone2').val(phoneArr[1]);
	$('#phone3').val(phoneArr[2]);
	
	//이메일
	var emailArr = '${m.email}'.split('@');
	$('#inputEmailAddress1').val(emailArr[0]);
	$('#inputEmailAddress2').val(emailArr[1]);
	
	//취향
	<c:forEach items = "${m.favorite}" var="favorite" varStatus="vs">
		$('input:checkbox[name="favorite"]').each(function() {
		    if(this.value == "${favorite}")
		           this.checked = true;       
		});
	</c:forEach>

});	
	

/* 이미지 파일 첨부시 미리보기 */
function readURL(input) {
 
    if (input.files && input.files[0]) {
        var reader = new FileReader();
 
        reader.onload = function (e) {
            $('#imgProfile').attr('src', e.target.result);
        }
 
        reader.readAsDataURL(input.files[0]);
    }
}

/*이미지파일 미리보기 URL 넣기*/
$("#inputProfileFile").change(function(){
    readURL(this);
});

/* select창에서 선택한 이메일 주소를 input이메일주소창으로 넣어주기 */
$("#selectEmailAddress").on("change",function(){
	$('#inputEmailAddress2').val($('#selectEmailAddress').val());	
});

/* input이메일 주소창에 수정이 있으면 select이메일 창의 값을 직접입력으로 변경 */
$("#inputEmailAddress2").on("focus",function(){
	$('#selectEmailAddress').val('etc');
});


/*다음 주소 API 관련 함수*/
function execDaumPostcode(){	
    var popUpAddress = 
	new daum.Postcode({
	    oncomplete:function(data){
	         var fullRoadAddr = data.roadAddress;
	         var extraRoadAddr = '';
	         
	         if(data.bname !=='' &&/[동|로|가]$/g.test(data.bname)){
	            extraRoadAddr += data.bname;
	         }
	         if(data.buildingName !=='' &&data.apartment === 'Y'){
	            extraRoadAddr += (extraRoadAddr !== ''?','+data.buildingName : data.build);
	         }
	         if(extraRoadAddr !== ''){
	            extraRoadAddr = '(' + extraRoadAddr +')';
	         }
	         if(fullRoadAddr !== ''){
	            fullRoadAddr += extraRoadAddr;
	         }
	         document.getElementById("address").value = fullRoadAddr;
	     }
   	}).open({
   	    popupName: 'postcodePopup' //팝업 이름을 설정(영문,한글,숫자 모두 가능, 영문 추천)
   	});
  
}


function memberDelete(){
	var bool = confirm("정말 탈퇴하시겠습니까?");
	if(bool){
		location.href="${pageContext.request.contextPath}/member/memberDelete.do?memberId=${m.memberId}";
	}
	
	
	
	
}

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	