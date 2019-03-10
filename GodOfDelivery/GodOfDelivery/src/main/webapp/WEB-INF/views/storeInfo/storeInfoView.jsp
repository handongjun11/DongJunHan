<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<fmt:requestEncoding value="UTF-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
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

</style>

<div id="MemberEnroll-container">
	<h2>사업장 정보 수정</h2>
	<br />
	<hr />	
	<br />
	
	<!-- 사업장 정보 출력하기 -->
	<div id="addStore-container" >
		<div class="form-group row">
    		<label for="inputSellerId" class="col-sm-3">사업자번호</label>
    		<div>
      			<input type="text" class="form-control" id="brno" value="${storeInfo.storeNo}" disabled="disabled" >
    		</div>&nbsp;&nbsp;
    		<button  class="btn btn-outline-success" id="brno-btn" onclick="brnoChk();" >확인</button>
    		<input type="hidden" id="brnoCheck" value="0"/>
  		</div>	
  		<div id="addStoreNext-container" >
		 	<form  enctype="multipart/form-data" method="post"  id="storeInfoUpdateFrm"  action="${pageContext.request.contextPath }/storeInfo/UpdateStore.do"> 
				<input type="hidden" name="storeNo" id="storeNo" value="${storeInfo.storeNo}"/>
				<input type="hidden" name="sellerId" value="${storeInfo.sellerId}" />
				
				<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
				<!-- 사업자등록증 사본등록 -->
		
			<div class="form-group row input-group mb-3" sytle="position : absolute;">
			<label for="upfile1" class="col-sm-3" >사업자등록증 사본등록</label>
			  <div class="input-group-prepend form-inline" style="padding:0px;">
			   <!-- <span class="input-group-text" >첨부파일1</span>  -->
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple >
			    <label class="custom-file-label filelabel" id="labeloldfile" for="upFile1" style="overflow: hidden; border-radius: 3px;">
			    <c:if test="${attachmentList[0].originalFileName == null}">
			    	첨부파일선택
			    </c:if>
			    <c:if test="${attachmentList[0].originalFileName != null}">
			    ${attachmentList[0].originalFileName}
			    </c:if>
			    </label>
			  	<button class="btn btn-outline-success" type="button" style="margin-left: 95px;" onclick="deletefile1();">삭제</button>
			  </div>
			</div>
			
			<!--영업시곤증 사본등록 -->
			<div class="form-group row input-group mb-3">
				<label for="upfile2" class="col-sm-3">영업신고증 사본등록</label>
			  <div class="input-group-prepend form-inline" style="padding:0px;">
			    <!-- <span class="input-group-text" >첨부파일2</span> -->
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" name="upFile" id="upFile2" multiple >
			    <label class="custom-file-label filelabel" id="labeloldfile1" for="upFile2" style="overflow: hidden; border-radius: 3px;">
			    <c:if test="${attachmentList[1].originalFileName == null}">
			    	첨부파일선택
			    </c:if>
			    <c:if test="${attachmentList[1].originalFileName != null}">
			    ${attachmentList[1].originalFileName}
			    </c:if>
			    </label>
			    <button type="button" class="btn btn-outline-success" style="margin-left: 95px;" onclick="deletefile2();">삭제</button>
			  </div>
			</div>
			
	
	
			<!--사업장 이름 -->
			 <div class="form-group row">
    		<label for="storeName" class="col-sm-3">사업장 이름</label>
    		<div>
      			<input type="text" class="form-control" name="storeName" id="storeName" value="${storeInfo.storeName}"/>
    		</div>&nbsp;&nbsp;
  		</div>	
			
			<!-- 사업장 종류 selectbox -->
				<div class="form-group row">
					<label for="categoryNo" class="col-sm-3">사업장 종류</label>	
					<div class="form-inline">
						<select class="form-control" id="categoryNo" name="categoryNo" required="required" > 
	  						<option selected="selected">선택</option>
	  						<option value="1" <c:if test="${storeInfo.categoryNo eq '1'}">selected</c:if>>치킨</option>
	  						<option value="2" <c:if test="${storeInfo.categoryNo eq '2'}">selected</c:if>>피자</option>
	  						<option value="3" <c:if test="${storeInfo.categoryNo eq '3'}">selected</c:if>>보쌈/족발</option>
	  						<option value="4" <c:if test="${storeInfo.categoryNo eq '4'}">selected</c:if>>분식</option>
	  						<option value="5" <c:if test="${storeInfo.categoryNo eq '5'}">selected</c:if>>중식</option>
	  						<option value="6" <c:if test="${storeInfo.categoryNo eq '6'}">selected</c:if>>일식</option>
	  						<option value="7" <c:if test="${storeInfo.categoryNo eq '7'}">selected</c:if>>한식</option>
						</select>
					</div>
				</div>
			 	
				 <!-- 사업자 전화번호 -->
			<div class="form-group row">
				<input type="hidden" name="storeTel" />
				<label for="selectPhone" class="col-sm-3">사업장 번호</label>	
			<div class="form-inline">
				<select class="form-control selectPhone" id="selectStoretel" > 
	  				<option <c:if test="${fn:split(storeInfo.storeTel ,'-')[0] eq '02'}">selected</c:if>>02</option>
	  				<option <c:if test="${fn:split(storeInfo.storeTel ,'-')[0] eq '010'}">selected</c:if>>010</option>
	  				<option <c:if test="${fn:split(storeInfo.storeTel ,'-')[0] eq '019'}">selected</c:if>>019</option>
	  				<option <c:if test="${fn:split(storeInfo.storeTel ,'-')[0] eq '016'}">selected</c:if>>016</option>
				</select>
				&nbsp;-&nbsp;
				<input class="form-control selectPhone" type="text" id="storetel1" maxlength="4" style="width: 80px;"  value="${fn:split(storeInfo.storeTel ,'-')[1]}"
					   onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>  
				&nbsp;-&nbsp;
				<input class="form-control selectPhone" type="text" id="storetel2" maxlength="4" style="width: 80px;" value="${fn:split(storeInfo.storeTel ,'-')[2]}"
					   onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
			</div>
			 
		</div>
	<!--  주소 api -->
		<div class="form-group row">
			<label for="address" class="col-sm-3">주소<span style="color:red;">&nbsp;*</span></label>	
			<input class ="form-control" type="text" name="storeAddress" id="storeAddress" onclick="execDaumPostcode();" value="${storeInfo.storeAddress }"/>		
		</div>
		<!-- storIntro -->
		<div class="form-group row">
    		<label for="storeIntro" class="col-sm-3">사업장 소개</label>
    		<div>
      			<input type="text" class="form-control" name="storeIntro" id="storeIntro" style="height : 100px;" value="${storeInfo.storeIntro }"/>
    		</div>&nbsp;&nbsp;
  		</div>	
  		<!-- personalDay -->
		<div class="form-group row">
    		<label for="personalDay" class="col-sm-3">휴업일</label>
    		<div>
      			<input type="text" class="form-control" name="personalDay" id="personalDay" value="${storeInfo.personalDay}"/>
    		</div>&nbsp;&nbsp;
  		</div>		
  		<!-- operatingHours -->
		<div class="form-group row">
    		<label for=operatingHours" class="col-sm-3">영업시간</label>
    	<div class="form-inline">
    			<input type="hidden" name="operatingHours" />
      			<input type="text" class="form-control"  id="operatingHours"  style="width: 80px;" value="${fn:split(storeInfo.operatingHours ,'~')[0]}"/>
      			&nbsp;&nbsp;-&nbsp;&nbsp;
      			<input type="text" class="form-control"  id="operatingHours1"  style="width: 80px;" style="width: 80px;" value="${fn:split(storeInfo.operatingHours ,'~')[1]}" />
    		</div>&nbsp;&nbsp;
  		</div>		
  		<!-- deliveryMinPrice -->
		<div class="form-group row">
    		<label for=deliveryMinPrice" class="col-sm-3">최소주문금액</label>
    	<div>
      			<input type="text" class="form-control" name="deliveryMinPrice" id="deliveryMinPrice" value="${storeInfo.deliveryMinPrice }" />
    		</div>&nbsp;&nbsp;
  		</div>		
    	
  		
				<input type="submit" class="btn btn-outline-success " value="수정"  onclick="return validate2();"/>
				<button type="button" class="btn btn-outline-success "  onclick="closed();" >폐업</button>
 </form> 
  		</div>
	</div>
	</div>


<script>



function validate2(){
	
	if($("#categoryNo").val() === "선택"){
		alert("사업장 종류를 선택하십시오.");
		return false;
	}
	
	var operatingHours = $("#operatingHours").val().trim() + " ~ " + $("#operatingHours1").val().trim() ;
	$("[name=operatingHours]").val(operatingHours);

	var storetelval = $("#selectStoretel").val()+"-"+$("#storetel1").val().trim()+"-"+$("#storetel1").val().trim();
	$("[name=storeTel]").val(storetelval);
	 
	return true;
};


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
   	});
};



$(function(){
	
	$("[name=upFile]").on('change' , function(){
		
		//var fileName = $(this).val();
		console.log($(this));
		var fileName = $(this).prop("files")[0].name ;
		
		$(this).next(".custom-file-label").html(fileName);
	});
	
});

function deletefile1(){
	
	var oldfile = $("#labeloldfile").text();
	console.log(oldfile);
	
	
	$.ajax({
		url : "${pageContext.request.contextPath}/storeinfo/deletefile1.do",
		data : {filename : oldfile},
		dataType: "json",
		success : function(data){
			console.log(data);
	
		 if(data.result>0){
				$("#labeloldfile").text('첨부파일선택');
			}else{
				alert("첨부파일 삭제 에러");
			}
		},
		error : function(){
			console.log("ajax요청 에러!");
			
		}
		
	})
};
function deletefile2(){
	
	var oldfile = $("#labeloldfile1").text();
	console.log(oldfile);
	
	
	$.ajax({
		url : "${pageContext.request.contextPath}/storeinfo/deletefile1.do",
		data : {filename : oldfile},
		dataType: "json",
		success : function(data){
			console.log(data);
	
		 if(data.result>0){
				$("#labeloldfile1").text('첨부파일선택');
			}else{
				alert("첨부파일 삭제 에러");
			}
		},
		error : function(){
			console.log("ajax요청 에러!");
			
		}
		
	})
};
function closed(){
	var storeNo = $("#brno").val();
	
	$.ajax({
		url : "${pageContext.request.contextPath}/storeinfo/closed.do",
		data : {storeNo : storeNo},
		dataType: "json",
		success : function(data){
			console.log(data);
	
		 if(data.result>0){
				alert("폐업신고가 정상적으로 처리되었습니다.");
			}else{
				alert("폐업신고 실패");
			}
		},
		error : function(){
			console.log("ajax요청 에러!");
			
		}
		
	})
	
	
};


</script>



		
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	