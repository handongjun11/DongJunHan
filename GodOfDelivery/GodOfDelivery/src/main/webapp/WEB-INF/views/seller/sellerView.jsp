<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<fmt:requestEncoding value="UTF-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="배달의신" name="pageTitle"/>
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
#inputPassword{
	display: inline;
}
#presentpwd-btn{
	margin-bottom: 5px;
	position : relative;
}
#presentPasswordOk{
	position: relative;
	display: none;
	left: 16px;
    top: 4px;
}
#newpassword-div{
	display: none;
}
#addStore{
	width: 800px;
    text-align: left;
    border: 1px solid lightgray;
    height: 80px;
    color: gray;
    cursor : pointer;
}
.filelabel{
    width: 359px;
    margin-left: 8px;
    border-radius: 3px;
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
#brnocheck{
	position: relative;
    top: -31px;
    left: 49px;
    display : none;
}
#myStore-btn{
	display: block;
	background-color: #117a8b;
	border-color: white;
	color : white;
}
</style>

<div id="MemberEnroll-container">
	<h2>사업자 정보 수정</h2>
	<br />
	<hr />	
	<br />

	
		<!-- 아이디 -->
		<div class="form-group row">
    		<label for="inputSellerId" class="col-sm-3">아이디</label>
    		<div>
      			<input type="text" class="form-control" id="inputSellerId" value="${s.sellerId}" disabled="disabled">
    		</div>
  		</div>	
  		
		<!-- 비밀번호 -->
		<div class="form-group row" >
    		<label for="inputPassword" class="col-sm-3">비밀번호</label>
    		<div>
				<button class="btn btn-outline-success" id="update-password" onclick="showPwd();">변경하기</button>
    		</div>
  		</div>
  		<div id="newpassword-div" >
  		<div class="form-group row">
    		<label for="inputPassword" class="col-sm-3">현재 비밀번호</label>
    		<div>
      			<input type="password"  class="form-control" id="presentPassword" placeholder="6~16자 영문,숫자"> 
      			<input type="hidden" id="resultCheck" />
    		</div>
    		<span class="guide ok" id="presentPasswordOk"></span>
  		</div>
		<div class="form-group row">
    		<label for="inputPassword" class="col-sm-3">새 비밀번호</label>
    		<div>
      			<input type="password"   class="form-control" name="password" disabled="disabled" id="inputPassword"  placeholder="6~16자 영문,숫자">
    		</div>
    		<span class="guide error" id="passworderror3">특수문자를 제거해 주세요.</span>
  		</div>
  		<div class="form-group row">
    		<label for="checkPassword" class="col-sm-3">새 비밀번호 확인</label>
    		<div>
      			<input type="password" class="form-control" id="checkPassword" disabled="disabled" placeholder="Password Check">
    		</div>
    		<span class="guide error" id="passworderror">비밀번호가 일치하지 않습니다.</span>
    		<span class="guide error" id="passworderror2">특수문자를 제거해 주세요.</span>
  		</div>
  		<div class="form-group row">
    		<label for="checkPassword" class="col-sm-3">새 비밀번호 확인</label>
    		<div>
      			<input type="button" class="btn btn-outline-success" onclick="updatePwd()" value="수정">
    		</div>
  		</div>
  		</div>
  		
		<hr />
			<form name="sellerUpdateFrm" 
		  method="post"  action="${pageContext.request.contextPath}/seller/sellerUpdate.do">
		
		<!-- 이름 -->
		<div class="form-group row">
    		<label for="inputMemberName" class="col-sm-3">이름</label>
    		<div>
      			<input type="text" class="form-control" name="sellerName" id="inputMemberName" value="${s.sellerName}" disabled="disabled">
    		</div>
  		</div>		
  		
		
	
		<!-- 이메일 -->
		<div class="form-group row">
			<input type="hidden" name="email" />
    		<label for="inputEmail" class="col-sm-3">이메일</label>
    		<div class="form-inline">
      			<input type="text" class="form-control" id="inputEmailAddress" value="${fn:split(s.email , '@')[0]}" />
      			&nbsp;@&nbsp;
      			<input type="text" class="form-control" id="inputEmailAddress1" value="${fn:split(s.email , '@')[1]}" />
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
				<select class="form-control selectPhone" id="selectPhone"  > 
	  				<option <c:if test="${fn:split(s.phone ,'-')[0] eq '010'}">selected</c:if>>010</option>
	  				<option <c:if test="${fn:split(s.phone ,'-')[0] eq '019'}">selected</c:if>>019</option>
	  				<option <c:if test="${fn:split(s.phone ,'-')[0] eq '016'}">selected</c:if>>016</option>
				</select>
				&nbsp;-&nbsp;
				<input class="form-control selectPhone" type="text" id="phone1" maxlength="4" style="width: 80px;" value="${fn:split(s.phone ,'-')[1]}"
					   onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>  
				&nbsp;-&nbsp;
				<input class="form-control selectPhone" type="text" id="phone2" maxlength="4" style="width: 80px;" value="${fn:split(s.phone ,'-')[2]}"
					   onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
			</div>
		</div>
			
		
		<input type="submit" class="btn btn-outline-success" onclick="validate();" value="수정하기" >
	
	</form>
	
	<hr />
	<br />
	<!-- 리스트로 본인 사업장 보여주기 -->
		<div>
			<table class="table table-striped table-hover" style="text-align: center;"  >
				<tr>
					<th>허가상태</th>
					<th>사업자명</th>
					<th>수정/삭제</th>
				</tr>
					<c:if test="${not empty si}">
						<c:forEach items="${si}" var="storeInfo" >
							<tr>
								<td>
								<c:if test="${storeInfo.pmsFlag eq 'N'}">
									대기중
								</c:if> 
								<c:if test="${storeInfo.pmsFlag eq 'Y'}">
									허가 완료
								</c:if> 
								<c:if test="${storeInfo.pmsFlag eq 'C'}">
									거래 중지
								</c:if> 
								<c:if test="${storeInfo.pmsFlag eq 'R'}">
									거래 중지
								</c:if> 
								</td>
								<td>${storeInfo.storeName }</td>
								<td><input type="button" onclick="storeModify('${storeInfo.storeNo}', '${storeInfo.sellerId}');" value="수정" class="btn btn-outline-success"  />&nbsp;&nbsp;<input type="button" value="삭제" class="btn btn-outline-success" onclick="storeDelete('${storeInfo.storeNo}');" /></td>
							</tr>
								<c:if test="${storeInfo.pmsFlag eq 'R'}">
									<c:if test="${storeInfo.rejectInfo != null}">
										<tr><td  colspan="3">거절사유 : ${storeInfo.rejectInfo}</td></tr>
									</c:if> 
								</c:if> 
						</c:forEach>
					</c:if>
				</table>
		</div>
	
	<hr />
	<br />
	<!-- 사업장 추가 버튼 -->
	<div id="addStore"  onclick="addStore();" >
	<br />
   	&nbsp;&nbsp;<i class="fas fa-plus" style="font-size:28px; display:inline;"></i><h5 style="display: inline;">&nbsp;&nbsp;사업장 추가</h5>
	</div>
	<br />
	<br />
	
	
	
	<!-- 사업장 정보 출력하기 -->
	<div id="addStore-container" style="display:none;">
	<h2>사업장 정보</h2>
	<br />
	<hr />	
	<br />
	<!-- action="${pageContext.request.contextPath}/seller/addStore.do" -->
		<div class="form-group row">
    		<label for="inputSellerId" class="col-sm-3">사업자번호</label>
    		<div>
      			<input type="text" class="form-control" id="brno"  >
      			<span id="brnocheck">이미 등록된 번호입니다.</span>
    		</div>&nbsp;&nbsp;
    		<button  class="btn btn-outline-success" id="brno-btn" onclick="brnoChk();" style="width : 58; height: 40;" >확인</button>
    		<input type="hidden" id="brnoCheck" value="0"/>
  		</div>	
  		<div id="addStoreNext-container" >
			<form  enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath }/storeInfo/addStore.do"  >
				<input type="hidden" name="storeNo" id="storeNo" />
				<input type="hidden" name="sellerId" value="${s.sellerId}" />
				
				<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
				<!-- 사업자등록증 사본등록 -->
			<div class="form-group row input-group mb-3">
			<label for="upfile1" class="col-sm-3">사업자등록증 사본등록</label>
			  <div class="input-group-prepend form-inline " style="padding:0px;">
			   <!-- <span class="input-group-text" >첨부파일1</span>  -->
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple />
			    <label class="custom-file-label filelabel" for="upFile1" style="overflow: hidden; border-radius: 3px;z-index: -1;">파일을 선택하세요</label>
			  </div>
			</div>
			
			<!--영업시곤증 사본등록 -->
			<div class="form-group row input-group mb-3">
				<label for="upfile2" class="col-sm-3">영업신고증 사본등록</label>
			  <div class="input-group-prepend form-inline" style="padding:0px;">
			    <!-- <span class="input-group-text" >첨부파일2</span> -->
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" name="upFile" id="upFile2" multiple />
			    <label class="custom-file-label filelabel" for="upFile2" style="overflow: hidden; border-radius: 3px; z-index: -1;">파일을 선택하세요</label>
			  </div>
			</div>
			<!--사업장 이름 -->
			 <div class="form-group row">
    		<label for="storeName" class="col-sm-3">사업장 이름</label>
    		<div>
      			<input type="text" class="form-control" name="storeName" id="storeName"/>
    		</div>&nbsp;&nbsp;
  		</div>	
			
			<!-- 사업장 종류 selectbox -->
				<div class="form-group row">
					<label for="categoryNo" class="col-sm-3">사업장 종류</label>	
					<div class="form-inline">
						<select class="form-control" id="categoryNo" name="categoryNo" required="required"> 
	  						<option selected="selected">선택</option>
	  						<option value="1">치킨</option>
	  						<option value="2">피자</option>
	  						<option value="3">보쌈/족발</option>
	  						<option value="4">분식</option>
	  						<option value="5">중식</option>
	  						<option value="6">일식</option>
	  						<option value="7">한식</option>
						</select>
					</div>
				</div>
			 	
				 <!-- 사업자 전화번호 -->
			<div class="form-group row">
				<input type="hidden" name="storeTel" />
				<label for="selectPhone" class="col-sm-3">사업장 번호</label>	
			<div class="form-inline">
				<select class="form-control selectPhone" id="selectStoretel" > 
	  				<option selected="selected">02</option>
	  				<option>010</option>
	  				<option>019</option>
	  				<option>016</option>
				</select>
				&nbsp;-&nbsp;
				<input class="form-control selectPhone" type="text" id="storetel1" maxlength="4" style="width: 80px;" 
					   onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>  
				&nbsp;-&nbsp;
				<input class="form-control selectPhone" type="text" id="storetel2" maxlength="4" style="width: 80px;"
					   onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
			</div>
			 
		</div>
	<!--  주소 api -->
		<div class="form-group row">
			<label for="address" class="col-sm-3">주소<span style="color:red;">&nbsp;*</span></label>	
			<input class ="form-control" type="text" name="storeAddress" id="storeAddress" onclick="execDaumPostcode();"/>		
		</div>
		<!-- storIntro -->
		<div class="form-group row">
    		<label for="storeIntro" class="col-sm-3">사업장 소개</label>
    		<div>
      			<input type="text" class="form-control" name="storeIntro" id="storeIntro" style="height : 100px;" />
    		</div>&nbsp;&nbsp;
  		</div>	
  		<!-- personalDay -->
		<div class="form-group row">
    		<label for="personalDay" class="col-sm-3">휴업일</label>
    		<div>
      			<input type="text" class="form-control" name="personalDay" id="personalDay" />
    		</div>&nbsp;&nbsp;
  		</div>		
  		<!-- operatingHours -->
		<div class="form-group row">
    		<label for=operatingHours" class="col-sm-3">영업시간</label>
    	<div class="form-inline">
    			<input type="hidden" name="operatingHours" />
      			<input type="text" class="form-control"  id="operatingHours"  style="width: 80px;" />
      			&nbsp;&nbsp;-&nbsp;&nbsp;
      			<input type="text" class="form-control"  id="operatingHours1"  style="width: 80px;" />
    		</div>&nbsp;&nbsp;
  		</div>		
  		<!-- deliveryMinPrice -->
		<div class="form-group row">
    		<label for=deliveryMinPrice" class="col-sm-3">최소주문금액</label>
    	<div>
      			<input type="text" class="form-control" name="deliveryMinPrice" id="deliveryMinPrice" />
    		</div>&nbsp;&nbsp;
  		</div>		
    	
  		
				<input type="submit" class="btn btn-outline-success" value="등록하기"  onclick="return validate2();"/>
		</form>
  		</div>
	</div>
	</div>


<script>


function validate(){ /* 유효성 검사 */
	

	var emailval = $("#inputEmailAddress").val().trim() + "@" + $("#inputEmailAddress1").val().trim();
	$("[name=email]").val(emailval);

	var phoneval = $("#selectPhone").val()+"-"+	$("#phone1").val().trim() +"-"+$("#phone2").val().trim();
	$("[name=phone]").val(phoneval);
	
	
	return true;

};

function validate2(){
	
	if($("#brnoCheck").val() === "0"){
		alert("사업자번호를 확인하세요.");
		return false;
	}
	
	if($("#categoryNo").val() === "선택"){
		alert("사업장 종류를 선택하십시오.");
		return false;
	}
	
	var operatingHours = $("#operatingHours").val().trim() + " ~ " + $("#operatingHours1").val().trim() ;
	$("[name=operatingHours]").val(operatingHours);

	var storetelval = $("#selectStoretel").val()+"-"+$("#storetel1").val().trim()+"-"+$("#storetel1").val().trim();
	$("[name=storeTel]").val(storetelval);
	sendEnrollStore($("input[name=storeName]").val());
	return true;
};


$("#inputSellerId").on("keyup",function(){
		
		re = /[~!@\#$%^&*\()\-=+_']/gi; 
	
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
	re = /[~!@\#$%^&*\()\-=+_']/gi; 
	var inputPassword = $(this).val();

	
	if(re.test(inputPassword)){
		$("#passworderror3").show();
		
	}else{
		$("#passworderror3").hide();
	}
});

$("#checkPassword").on("keyup" , function(){
	re = /[~!@\#$%^&*\()\-=+_']/gi; 
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


function showPwd(){

	$("#newpassword-div").toggle();
};

$("#presentPassword").on("keyup" , function(){
	
var presentpwd = $(this).val();
	
	console.log(presentpwd);
	
	
	$.ajax({
		url : "${pageContext.request.contextPath}/seller/checkPresentPwd.do",
		method : "post",
		data : {password : presentpwd},
		success : function(data){
			//console.log(data);
			
			if(data.result === 1) {
				
				$("#resultCheck").val(data.result);
				$("#presentPasswordOk").text(data.msg);	
				$("#presentPasswordOk").css("color" , "green");	
				$("#inputPassword").removeAttr("disabled");
				$("#checkPassword").removeAttr("disabled");
				$("#presentPasswordOk").show();	
			
			}else{
				$("#resultCheck").val(data.result);
				$("#presentPasswordOk").text(data.msg);	
				$("#presentPasswordOk").css("color" , "red");	
				$("#presentPasswordOk").show();	
			}
		
		},
		error : function(){
			console.log("ajax요청 에러!");
			
		}
	
	});
	
	
	});

function updatePwd(){
	
	var password = $("#inputPassword").val();
	
	$.ajax({
		url : "${pageContext.request.contextPath}/seller/updatePwd.do" ,
		method : "post",
		data : {password : password},
		dataType : "json",
		success : function(data){
			console.log(data);
			
			alert(data.msg);
			$("input[type='password']").val("");
			$("#newpassword-div").hide();
			
			
		},
		error : function(){
			console.log("ajax요청 에러!");
		}
	});
};

function brnoChk(){
	var brno = $("#brno").val();
	
	
	console.log(brno);
	if($("#brno").val().length < 10 || $("#brno").val().length > 11){
		alert("사업자등록번호 입력형식이 맞지 않습니다.");
	}else{
	
	
	$.ajax({
		url : "${pageContext.request.contextPath}/storeinfo/checkBrno.do",
		method : "post",
		data : {brno : brno},
		dataType :"json",
		success : function(data){
			alert(data.msg);
			
			if(data.operate === "1"){
				$("#storeNo").val(data.storeNo);
				$("#addStoreNext-container").show();
				$("#brnoCheck").val("1");
				
			}else{
				$("#brnoCheck").val("0");
			}
		},
		error : function(){
			console.log("ajax요청 에러!");
			alert("새로고침 후 다시 이용해 주세요.");
		}
	});
	}
};

$("#brno").on("keyup", function(){
	 $(this).val($(this).val().replace(/[^0-9]/g,""));
	 var brno = $(this).val();
	
	  if(brno.length < 10 || brno.length > 11){
			$("#brnocheck").text("숫자10자리를 입력하세요.");
			$("#brnocheck").css("color" ,"black");
			$("#brnocheck").show();
		}else{ 
		var a =	brno.substr(0,3);
		var b =	$("#brno").val().substr(3,2);
		var c =	brno.substr(5,10);
		brno = a +"-"+b+"-"+c;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/storeinfo/brnoCheckDuplicate.do",
			method : "post",
			data : {brno : brno},
			dataType :"json",
			success : function(data){
				
				if(data.result === 1){
					
						$("#brnocheck").css("color" ,"green");
						$("#brnocheck").text(data.msg);
						$("#brnocheck").show();
					
				}else{
					$("#brnocheck").css("color", "red");
					$("#brnocheck").text(data.msg);
					$("#brnocheck").show();
				}
		
			},
			error : function(){
				console.log("ajax요청 에러!");
			}
		
	});
		}
		
});

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
	         document.getElementById("storeAddress").value = fullRoadAddr;
	     }
   	}).open({
   	    popupName: 'postcodePopup' //팝업 이름을 설정(영문,한글,숫자 모두 가능, 영문 추천)
   	})
};

function addStore(){
	$("#addStore-container").show();
};

$(function(){
	
	$("[name=upFile]").on('change' , function(){
		
		//var fileName = $(this).val();
		console.log($(this));
		var fileName = $(this).prop("files")[0].name ;
		
		$(this).next(".custom-file-label").html(fileName);
	});
	
});

function storeModify(storeNo, sellerId){
	
	location.href = "${pageContext.request.contextPath}/storeInfo/storeInfoView.do?storeNo="+storeNo+"&sellerId="+sellerId;
	
};




</script>



		
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	