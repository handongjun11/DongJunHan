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
	border: 1px solid;
    background-size: cover;
    width: 150px;
    height: 150px;
    z-index: 100;
    position: absolute;
    left: 71%;
    top: 27%;
}
input#gender1, input#gender2{width : 30px;}
input#gender2 {margin-left:50px;}
select#selectYear{ width : 100px;}
select#selectMonth, select#selectDay{ width : 65px;}
span#ok{
	color: green;
	position: relative;
	display: none;
	left: 16px;
    top: 4px;
	

}
span#error{
	color: red;
	position: relative;
    left: 16px;
    top: 4px;
    display: none;
}
span#error2{
	color: red;
	position: relative;
    left: 16px;
    top: 4px;
    display: none;
}
   

.form-group row span.guide{
	/* display: none; */
	font-size: 12px;
	position: absolute;
	top : 12px;
	right: 10px; 
	
}
span#passworderror{
	color: red;
	position: relative;
    left: 16px;
    top: 4px;
    display: none;
}
span#passworderror2{
	color: red;
	position: relative;
    left: 16px;
    top: 4px;
    display: none;
}
span#passworderror3{
	color: red;
	position: relative;
    left: 16px;
    top: 4px;
    display: none;
}
.btn-outline-success:hover {
	 background-color: #117a8b; 
     border-color: white;
     color : white;
}
.btn-outline-success{
     border-color: #117a8b;
     color : #117a8b;
}

</style>


<div id="MemberEnroll-container">
	<h2>사업자 회원 가입</h2>
	<br />
	<hr />	
	<br />
	
	<form name="sellerEnrollFrm" action="${pageContext.request.contextPath}/seller/sellerEnrollEnd.do" 
		  method="post" 
		  onsubmit="return validate();" >
		<!-- 아이디 -->
		<div class="form-group row">
    		<label for="inputSellerId" class="col-sm-3">아이디</label>
    		<div>
      			<input type="text" class="form-control" id="inputSellerId" name="sellerId" placeholder="6~16자 영문,숫자">
    		</div>
    		<!-- 중복 관련 체크  -->
    		<span class="guide ok" id="ok">이 아이디는 사용 가능합니다.</span>
    		<span class="guide error" id="error">이 아이디는 사용할 수 없습니다.</span>
    		<span class="guide error" id="error2">특수 문자 및 공백을 제거해 주세요.</span>
    		<input type="hidden" name="idDuplicateCheck" id="idDuplicateCheck" value="0" />
  		</div>	
  		
		<!-- 비밀번호 -->
		<div class="form-group row">
    		<label for="inputPassword" class="col-sm-3">비밀번호</label>
    		<div>
      			<input type="password"  name="password" class="form-control" id="inputPassword" placeholder="6~16자 영문,숫자">
    		</div>
    		<span class="guide error" id="passworderror3">특수 문자 및 공백을 제거해 주세요.</span>
  		</div>
  		<div class="form-group row">
    		<label for="checkPassword" class="col-sm-3">비밀번호 확인</label>
    		<div>
      			<input type="password" class="form-control" id="checkPassword" placeholder="Password Check">
    		</div>
    		<span class="guide error" id="passworderror">비밀번호가 일치하지 않습니다.</span>
    		<span class="guide error" id="passworderror2">특수 문자 및 공백을  제거해 주세요.</span>
  		</div>
  		
		<hr />
		
		<!-- 이름 -->
		<div class="form-group row">
    		<label for="inputMemberName" class="col-sm-3">이름</label>
    		<div>
      			<input type="text" class="form-control" name="sellerName" id="inputMemberName">
    		</div>
  		</div>		
  		
		
	
		<!-- 이메일 -->
		<div class="form-group row">
			<input type="hidden" name="email" />
    		<label for="inputEmail" class="col-sm-3">이메일</label>
    		<div class="form-inline">
      			<input type="text" class="form-control" id="inputEmailAddress">
      			&nbsp;@&nbsp;
      			<input type="text" class="form-control" id="inputEmailAddress1" >
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
			<label for="selectPhone" class="col-sm-3">핸드폰 번호</label>	
			<div class="form-inline">
				<select class="form-control selectPhone" id="selectPhone" > 
	  				<option selected="selected">010</option>
	  				<option>019</option>
	  				<option>016</option>
				</select>
				&nbsp;-&nbsp;
				<input class="form-control selectPhone" type="text" id="phone1" maxlength="4" style="width: 80px;"
					   onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>  
				&nbsp;-&nbsp;
				<input class="form-control selectPhone" type="text" id="phone2" maxlength="4" style="width: 80px;" 
					   onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
			</div>
		</div>
			
		
	
		
		<input type="submit" class="btn btn-outline-success" value="가입하기" >
	
	</form>
</div>

<script>


function validate(){ /* 유효성 검사 */
	
	if($("#inputSellerId").val().trim().length < 7){
	      alert("아이디는 6글자 이상 입력해주세요");
	      return false;	      
 	}else if( $("#inputSellerId").val().trim().length >16){
 		alert("아이디는 16글자 이하 입력해주세요");
	      return false;	
 		
 	}
	//아이디 중복 검사
	if($("#idDuplicateCheck").val()==0){
			alert("아이디 중복검사를 해주세요");
			return false;
	}
 	
	if($("#password_").val() != $("#password2").val()){
	      alert("비밀번호가 일치하지 않습니다.");
	      return false;
	}
	
	var emailval = $("#inputEmailAddress").val().trim() + "@" + $("#inputEmailAddress1").val().trim();
	$("[name=email]").val(emailval);

	var phoneval = $("#selectPhone").val()+"-"+	$("#phone1").val().trim() +"-"+$("#phone2").val().trim();
	$("[name=phone]").val(phoneval);
	
	
	return true;
}


$("#inputSellerId").on("keyup",function(){
		
		re = /[~!@\#$%^&*\()\-=+_' ']/gi; 
	
	   var sellerId = $(this).val();
	   
	   if(re.test(sellerId)){
		   $("#error2").show();
	   }else{
		   $("#error2").hide();
	   //아이디 4글자 이상 작성했을 시 에만 중복여부 검사요청
	   if(sellerId.trim().length < 6 || sellerId.trim().length > 17){
	      $("#ok").hide();
	      $("#error").hide();
	      $("#idDuplicateCheck").val(0);
	      return;
	   }
	   
	   //ajax요청
	   $.ajax({
	      url : "${pageContext.request.contextPath}/seller/checkIdDuplicate.do",
	      method : "get",
	      data: {sellerId : sellerId}, //{}: 객체형태  // "memberId="+memberId+"&age=": 직렬화된 형태도 가능
	      success : function(data){
	         console.log(data);
	         //console.log(JSON.stringify(data));
	         //console.log(JSON.parse(JSON.stringify(data)));
	         
	        /*  if(data === "true"){  --> ajax 사용할때는 text로 왔었다  */
	       	 if(data.isUsable == true){  //jsonView는 객체로 뱉는중(boolean 으로 뱉고있다. jquery 가 바꿔줌)
	        	 $("#error").hide();
	        	 $("#ok").show();
	        	 $("#idDuplicateCheck").val(1);	        	
	         }else{ //false
	        	 $("#error").show();
	        	 $("#ok").hide();
	        	 $("#idDuplicateCheck").val(0);
	         }
	      },
	      error : function(){
	         console.log("ajax요청 에러");
	      }
	   });
	   }
	   
});

$("#inputPassword").on("keyup" , function(){
	re = /[~!@\#$%^&*\()\-=+_' ']/gi; 
	var inputPassword = $(this).val();

	
	if(re.test(inputPassword)){
		$("#passworderror3").show();
		
	}else{
		$("#passworderror3").hide();
	}
});

$("#checkPassword").on("keyup" , function(){
	re = /[~!@\#$%^&*\()\-=+_' ']/gi; 
	var inputPassword = $("#inputPassword").val();
	var checkPassword = $(this).val();

	if(re.test(checkPassword)){
		$("#passworderror2").show();
		
	}else{
		$("#passworderror2").hide();
	if(inputPassword != checkPassword){
		$("#passworderror").show();
		
	}else{
		$("#passworderror").hide();
	}
		
	}

});

$("#selectEmailAddress").on("change", function(){

	var selectemail = $(this).val();
	console.log(selectemail);
	$("#inputEmailAddress1").val(selectemail);
	
	
	
});





</script>





<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	