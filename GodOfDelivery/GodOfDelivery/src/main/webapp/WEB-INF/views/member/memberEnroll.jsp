<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name=""/>
</jsp:include>

<style>
div#MemberEnroll-container{
    margin: 150px auto 0;
	width : 800px;
	text-align : center;
}
div.form-group label{ padding-top : 0.5em; text-align: left;}
div.form-group input{
	width : 280px;
}
div#inputProfile{
    position: absolute;
    z-index: 1;       
    left: 69%;
    top: 244px;
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
input#inputProfileFile{opacity: 0;}
input#gender1, input#gender2{width : 30px;}
input#gender2 {margin-left:50px;}
select#selectYear{ width : 100px;}
select#selectMonth, select#selectDay{ width : 65px;}
.checkFavorite{width:30px !important}
</style>
		

<div id="MemberEnroll-container">
	<h2>개인 회원 가입</h2>
	<br />
	<hr />	
	<br />
	
	<form name="memberEnrollFrm" 
		  action="${pageContext.request.contextPath}/member/memberEnrollEnd.do" 
		  method="post" 
		  onsubmit="return validate();" 
		  enctype="multipart/form-data">

		<!-- 프로필 사진 -->
		<div id=inputProfile>	
			<div class="imgProfile-wrapper">
				<img id="imgProfile" src="${pageContext.request.contextPath }/resources/images/avatar.png" style="width:100%; height:100%">				
  			</div>
  			<div class="profile custom-file">
    			<input type="file" id="inputProfileFile" name="upFile">		
  			</div>				
		</div>		
		
		<!-- 아이디 -->
		<div class="form-group row">
    		<label for="inputMemberId" class="col-sm-3">아이디<span style="color:red;">&nbsp;*</span></label>
    		<div>
      			<input type="text" class="form-control" id="inputMemberId" name="memberId" required placeholder="영어, 숫자 4글자 이상">
    		</div>
  		</div>	
  		
		<!-- 비밀번호 -->
		<div class="form-group row">
    		<label for="inputPassword" class="col-sm-3">비밀번호<span style="color:red;">&nbsp;*</span></label>
    		<div>
      			<input type="password" class="form-control" id="inputPassword" name = "password" required>
    		</div>
  		</div>
  		<div class="form-group row">
    		<label for="checkPassword" class="col-sm-3">비밀번호 확인<span style="color:red;">&nbsp;*</span></label>
    		<div>
      			<input type="password" class="form-control" id="checkPassword">
    		</div>
  		</div>
  		
		<hr />
		
		<!-- 이름 -->
		<div class="form-group row">
    		<label for="inputMemberName" class="col-sm-3">이름<span style="color:red;">&nbsp;*</span></label>
    		<div>
      			<input type="text" class="form-control" id="inputMemberName" name="memberName" required>
    		</div>
  		</div>		
  		
		<!-- 생년월일 -->
		<div class="form-group row">
			<input type="hidden" name="birth" />
			<label for="selectBirth" class="col-sm-3">생년월일</label>	
			<select class="form-control selectBirth" id="selectYear">  
  				<option selected="selected" disabled="disabled">년</option>
  				<c:forEach var="year" begin="1935" end = "2004">
  					<option>${year }</option>
  				</c:forEach>
			</select>
			&nbsp;
			<select class="form-control selectBirth" id="selectMonth"> 
  				<option selected="selected" disabled="disabled">월</option>
  				<c:forEach var="month" begin="01" end = "12">
  					<option>${month }</option>
  				</c:forEach>
			</select>
			&nbsp;
			<select class="form-control selectBirth" id="selectDay"> 
  				<option selected="selected" disabled="disabled">일</option>
  				<c:forEach var="day" begin="1" end = "31">
  					<option>${day }</option>
  				</c:forEach>
			</select>
		</div>
		
		<!-- 성별 -->
  		<div class="form-group row">
  			<input type="hidden" name="gender"/>
  			
	  		<label for="checkGender" class="col-sm-3">성별</label>
	  		<div class="form-check form-check-inline">
	  			<input class="form-check-input" type="radio" id="gender1" value="M" name="genderCheck">
	  			<label class="form-check-label col-form-label" for="gender1">남자</label>
			</div>
			<div class="form-check form-check-inline">
	  			<input class="form-check-input" type="radio" id="gender2" value="F" name="genderCheck" checked>
	  			<label class="form-check-label col-form-label" for="gender2">여자</label>
			</div>
  		</div>
		
		<!-- 이메일 -->
		<div class="form-group row">
			<input type="hidden" name="email" />
    		<label for="inputEmail" class="col-sm-3">이메일<span style="color:red;">&nbsp;*</span></label>
    		<div class="form-inline">
      			<input type="text" class="form-control" id="inputEmailAddress1">
      			&nbsp;@&nbsp;
      			<input type="text" class="form-control" id="inputEmailAddress2" >
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
			<label for="phone1" class="col-sm-3">핸드폰 번호<span style="color:red;">&nbsp;*</span></label>	
			<div class="form-inline">
				<select class="form-control selectPhone" id="phone1"> 
	  				<option selected="selected">010</option>
	  				<option>019</option>
	  				<option>016</option>
				</select>
				&nbsp;-&nbsp;
				<input class="form-control selectPhone" type="text" id="phone2" required
					   maxlength="4" style="width: 80px;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>  
				&nbsp;-&nbsp;
				<input class="form-control selectPhone" type="text" id="phone3" required
					   maxlength="4" style="width: 80px;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
			</div>
		</div>
			
		
		<!-- 주소 api -->
		<div class="form-group row">
			<label for="address" class="col-sm-3">주소<span style="color:red;">&nbsp;*</span></label>	
			<input class ="form-control" type="text" name="address" id="address" onclick="execDaumPostcode();"/>		
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
		
		<input type="submit" class="btn btn-outline-success" value="가입하기" >	
	</form>
	
</div>

<script>


/* 유효성 검사 */
function validate(){ 
	
	//아이디 글자수 확인 
	if($("#inputMemberId").val().trim().length < 4){
	      alert("아이디는 4글자 이상 입력해주세요");
	      return false;	      
 	}
	
	var regExp = /^[a-z0-9_]{4,20}$/;
	
	if(!regExp.test($("#inputMemberId").val())){
			alert("아이디에 특수문자는 사용하실 수 없습니다.");
	      return false;	  
	}
	
 	
 	//비밀번호 일치 여부 검사
	if($("#inputPassword").val() != $("#checkPassword").val()){
	      alert("비밀번호가 일치하지 않습니다.");
	      return false;
	}
 	
 	/*생년월일 처리*/
 	var birth = null;
 	if($('#selectYear').val() != null && $('#selectMonth').val() != null && $('#selectDay').val() != null){
 		var year = $('#selectYear').val();
 		var month =  $('#selectMonth').val();
 		var day = $('#selectDay').val();
 			
 		if($('#selectMonth').val().length == 1){
 			month = '0'+$('#selectMonth').val();
 		}
 		if($('#selectDay').val().length == 1){
 			day = '0'+$('#selectDay').val();
 		}
 		
 	  	birth = year + month + day; 	  
 	  	$('[name="birth"]').val(birth);	 
 	}
 	
 	/*성별 처리*/
 	$("input[name=gender]").val($("input[name=genderCheck]:checked").val());
 	
 	/*이메일 처리*/
 	$("input[name=email]").val($('#inputEmailAddress1').val()+'@'+$('#inputEmailAddress2').val());
 	
 	/*핸드폰 번호 처리*/
	$("input[name=phone]").val($('#phone1').val()+"-"+$('#phone2').val()+"-"+$('#phone3').val());
 	
	return true;
}



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




</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	
