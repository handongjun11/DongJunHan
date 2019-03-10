<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="배달의 신" name="pageTitle" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/payment/paymentPreparations.css" />
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<div id="container">
  <div id="deliveryInformation-container">
	<form name=deliveryFrm action="${pageContext.request.contextPath}/payment/paymentEnd.do" method="POST">
		<input type="hidden" name="storeNo" id="storeNo" value="${storeNo}">
		<input type="hidden" name="memberId" id="memberId" value="${memberLoggedIn.memberId}">
		<input type="hidden" name="paymentId" id="paymentId">
		<input type="hidden" name="originalPrice" id="originalPrice">
		<input type="hidden" name="paymentPrice" id="paymentPrice">
		<input type="hidden" name="methodForController" id="methodForController">
		<input type="hidden" name="orginalPrice" id="orginalPrice">
		<input type="hidden" name="orderMenu" id="orderMenu">
		<input type="hidden" name="couponNo" id="couponNo">
		
		
			<table class="table" id="deliveryInformation">
			  <thead class="thead-light">
			    <tr><th scope="col">배달정보</th></tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td>
			      <label for="inputEmail3" class="col-sm-2 col-form-label">주소</label>
						<div class="col-sm-10">
			  			<input type="text" class="form-control" name="fixedAddress" id="fixedAddress" required>
			  			<br>
			  		    <input type="text" class="form-control" id="address" name="address" placeholder="(필수)상세주소 입력" required>
			  		    <span id="addressWarning">상세한 주소를 입력해주세요.</span>
				    </div>
				    <label for="inputEmail3" class="col-sm-2 col-form-label">전화번호</label>
						<div class="col-sm-10">
						
						<c:if test="${memberLoggedIn!=null}">
						<input type="tel" class="form-control" id="tel" name="tel" value="${memberPhone}" placeholder="(필수)휴대전화 번호 입력(-제외한 번호만 입력해주세요)" required>
						</c:if>
						
		                <c:if test="${memberLoggedIn==null}">						
			  			<input type="tel" class="form-control" id="tel" name="tel" placeholder="(필수)휴대전화 번호 입력(-제외한 번호만 입력해주세요)" required>
			  			 </c:if>
			  			 
			  			 <c:if test="${memberLoggedIn==null}">
			  			 <button type="button" class="btn btn-info" id="phoneCheckBtn" onclick="phoneCheck();">휴대폰인증</button>
			  			 </c:if>
			  			 <!-- 보낸인증번호 -->
			  			 <input type="hidden" id="rndNoToTel">
			  			 <span id="phoneChkTxt">휴대폰 정보로 인증번호6자리를 보냈습니다!</span>
			  			 <div id="phoneChk-container"> 
			  			 <input type="text" class="form-control" id="phoneChkNum" name="phoneChkNum" placeholder="입력 후 확인버튼을 눌러주세요." required>
			  		     <span id="notEqualsRndNo">인증번호가 올바르지 않습니다.다시 시도해주세요.</span>
			  		     <span id="equalsRndNo">인증이 완료되었습니다.</span>
			  			 </div>
			  			 <span id="telWarning">휴대전화번호는 숫자만 입력해주세요.</span> 
			  		     <span id="tel11Warning">휴대전화번호는 11자 이내로 입력해주세요.</span>

			  			 
				    </div>
				  </td>
			    </tr>
			  </tbody>
			  
			<thead class="thead-light">
			    <tr>
			      <th scope="col">주문시 요청사항</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td>
						<div class="col-sm-10">
			  				<input type="text" class="form-control" name="request" id="request" placeholder="주문시 요청사항이 있다면 남겨주세요.">
				  	</div>
				  </td>
			    </tr>
			  </tbody>
			  
			  	<thead class="thead-light">
			    <tr>
			      <th scope="col">결제수단 선택</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td>  
			     
			      	<div class="laterPayment">
					      	만나서 결제
					      	<br>
					      	  <button type="button" class="btn btn-outline-info method" value="later_cash" name="method">현금</button>&nbsp;
					    	  <button type="button" class="btn btn-outline-info method" value="later_card" name="method">카드</button>
					    </div>
					   	<br>
					    <div class="nowPayment">
					      	웹에서 결제
					      	<br>
					      	  <button type="button" class="btn btn-outline-info method" value="now_card" name="method">신용카드</button>&nbsp;
					    </div>
				   </td>
			    </tr>
			  </tbody>
			  
			<thead class="thead-light">
			    <tr>
			      <th scope="col">할인방법 선택</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      	<td>
					    <label for="inputPassword3" class="col-sm-2 col-form-label">쿠폰</label>
					    <div class="col-sm-10">
					  <!-- 쿠폰이 있을 경우 -->
					   <c:if test="${not empty couponList}">
					   <select class="custom-select mb-2 mr-sm-2 mb-sm-0 locationNum" id="couponList" name="couponList" disabled="true">
						   <c:forEach items="${couponList}" var="couponList">						  
						      	 <option value="${couponList.EVENTNO}" name="eventCoupon">${couponList.EVENTTITLE}</option>						      	 
						   </c:forEach>
					   </select>
					   </c:if>
					   <c:if test="${empty couponList&&memberLoggedIn != null}">
					   		<select class="custom-select mb-2 mr-sm-2 mb-sm-0 locationNum" id="noCouponList" name="noCouponList" disabled="true">
					   			<option>사용하실 수 있는 쿠폰이 없습니다.</option>						      	 
					   		</select>
					   </c:if>
					   
					 <c:if test="${memberLoggedIn == null}">
					   		<select class="custom-select mb-2 mr-sm-2 mb-sm-0 locationNum" id="noLoginCouponList" name="noLoginCouponList" disabled="true">
					   			<option>로그인후 이용하실 수 있습니다.</option>						      	 
					   		</select>
					   </c:if>
					      <button type="button" class="btn btn-info" id="couponBtn">적용</button>
						  <button type="button" class="close" aria-label="닫기" id="couponCancel">
			  					<span aria-hidden="true">&times;</span>
						  </button>
					    </div>
					</td>
			    </tr>
			  </tbody>
			</table>
		</form>
 	</div>
		
		
	<div id="cart">
		<table class="table" id="cartTbl" >
		  <thead class="thead-light">
		    <tr>
		      <th scope="col" colspan="2">주문내역</th>
		    </tr>
		  </thead>
		  <tbody>
			<!-- 카트세션에서 꺼내옴 -->	
		  </tbody>
		</table>
		<c:if test="${memberLoggedIn!=null}">
		<button type="button" class="btn btn-info" id="orderEndBtn">주문완료</button>
		</c:if>
		<c:if test="${memberLoggedIn==null}">
		<button type="button" class="btn btn-info guestOrderBtn" id="orderEndBtn" disabled>주문완료</button>
		</c:if>

		
	</div> <!-- div#cart -->
	
	<!-- 결제후 폼제출 -->
	<from name="paymentEndFrm">
	
	</from>

</div> <!-- div#container -->

<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>

<script>
var cart = JSON.parse(sessionStorage.getItem("cart"));

$(document).ready(function(){
	var IMP = window.IMP; // 생략가능
	IMP.init('imp40675186'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

	//cartTable 채우기
	var html = "";
	var orderMenu ="";
	var sum = 0;
	html += "<tr><td colspan = '2'>${storeName}</td></tr>";
	for (var i=0; i<cart.length; i++){
		orderMenu += cart[i].menuCode + ":" + cart[i].amount+"/";
	 	<!-- 주문메뉴 -->
	    html += "<tr class= 'checkOut'><td>"+cart[i].menuName+"</td><td>"+cart[i].amount+"개</td></tr>";	    
	    sum += cart[i].menuPrice*cart[i].amount;
	}
	
  	html += "<tr id='totalPrice' class='checkOut'><td id='totalPriceSpan'>총 주문내역</td><td id='totalPriceNum'>"+sum+"</td></tr>";	
	$('#cartTbl tbody').html(html);
	$("#orginalPrice").val(sum);
	$("#orderMenu").val(orderMenu);

	
});
/* 쿠폰적용 */
$("#couponBtn").on("click", function(){
	console.log($("[name=eventCoupon]:selected").val());
	var eventNo = $("[name=eventCoupon]:selected").val();
	console.log("이벤트번호인가요?",eventNo);
	var sum=0;
	for (var i=0; i<cart.length; i++){
	 	<!-- 주문메뉴 -->
	    sum += cart[i].menuPrice*cart[i].amount;
	}
	$.ajax({
		url :  "${pageContext.request.contextPath}/member/getDiscount.do",
		data : {eventNo:eventNo,price:sum},
		success : function(data){
			console.log("에이젝스 성공");
			sessionStorage.setItem("totalPrice",JSON.stringify(data));
			var totalPrice = JSON.parse(sessionStorage.getItem("totalPrice"));
		  	var html = "<tr id='couponPrice' class='checkOut' style='color: blue;''><td id='checkOutSpan'>쿠폰적용가격</td><td id='totalPriceNum'>"+totalPrice.totalPrice+"</td></tr>";	
			$("#cartTbl tbody").append(html);
			/* $("#totalPriceNum").html(totalPrice.totalPrice); */
			
		},error:function(){
			console.log("에이젝스 오류");
		}
	});
});
function getLocation(){
	if(navigator.geolocation){
		navigator.geolocation.getCurrentPosition(function(position) {
			var lon = position.coords.latitude; //y
			var lat = position.coords.longitude; //x
		
			$.ajax({
				//https://developers.kakao.com/docs/restapi/local#좌표-행정구역정보-변환
			    url: 'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x='+lat+'&y='+lon,
			    type: 'GET',
			    cache: false,
			    contentType : 'application/json;charset=UTF-8',
			    crossOrigin: true,
			    headers:{'Authorization' : 'KakaoAK 4c6d6939204abedb25e64dcf1adfaaf2'},
			    success: function(data) {
			    	var address=data.documents[1].address_name;
			    	$("#fixedAddress").val(address);
			    },error:function(request,status,error){
			        alert("다시 시도해주세요.\n" + "code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		}, function(error){
			console.log(error);
		}, {
			enableHighAccuracy:false,
			maximumAge:0,
			timeout : Infinity
		});
	} else {
		alert("GPS를 지원하지 않습니다.");
	}
}
getLocation();
$("#tel").keyup(function() {
 	var data = $("#tel").val();
 	
 	if(data.indexOf("-") != -1||data.trim().length>11){
 		$("#tel").addClass(" is-invalid");
 		if(data.indexOf("-") != -1){
 		$("#telWarning").css("display","inline");
 		}else if(data.trim().length>11){
 		$("#tel11Warning").css("display","inline");
 		}
 	} else{
 		$("#tel").removeClass(" is-invalid");
 		$("#telWarning").css("display","none");
 		$("#tel11Warning").css("display","none");

 	}

});
//주소 입력하지않고 전화번호를 클릭했을 시
$("#tel").on("click", function(){
	if($("#address").val().trim().length==0){
		$("#address").addClass(" is-invalid");
 		$("#addressWarning").css("display","inline");
	}
});
$("#address").keyup(function() {
		console.log("도달");
		$("#address").removeClass(" is-invalid");
		$("#addressWarning").css("display","none");
});

//paymentMethod
/* 만나서 결제클릭시  */
$(".laterPayment").on("click", function(){
	$("#coupon").prop('readonly', true);

});
/* 웹에서 결제클릭시 */
$(".nowPayment").on("click", function(){
	$("#coupon").prop('readonly', false);
});


/* 결제수단클릭시 */
 $("[name=method]").on("click", function(){
	 console.log($(this).val());
	 if($(this).val()=='now_card'){
	 	$("#couponList").attr("disabled",false);		 
	 }else{
		$("#couponList").attr("disabled",true);		 
	 }

	$("input[name=methodForController]").val($(this).val());
	
	
})

/* 쿠폰취소 누르기 */
$("#couponCancel").on("click", function(){
	sessionStorage.removeItem("totalPrice");
	$("#couponPrice").css("display","none");
});

$("#orderEndBtn").on("click",function(){
	var address = $("#address").val().trim().length;
	var tel = $("#tel").val().trim().length;

	if($("input[type=text]").hasClass("is-invalid")==true||address==0||tel==0){
		alert("배달정보를 제대로 완성해주세요");
		return;
	}
	var sum=0;
	for (var i=0; i<cart.length; i++){
	 	<!-- 주문메뉴 -->
	    sum += cart[i].menuPrice*cart[i].amount;
	}
	 
	
	$("#originalPrice").val(sum); //원가격
	var totalPrice = JSON.parse(sessionStorage.getItem("totalPrice"));
	if(totalPrice!=null){
		sum = totalPrice.totalPrice; 
	}
	
	//11자
	 var method = $("input[name=methodForController]").val();
	 if(method=='now_card'){
		 
		 IMP.request_pay({
		       pg : 'inicis', // version 1.1.0부터 지원.
		       pay_method : 'card',
		       merchant_uid : 'merchant_' + new Date().getTime(),//주문번호
		       name : '${storeName}', //메뉴
		       amount : sum, //가격
		       buyer_email : 'iamport@siot.do', //멤버 전화번호
		       
		       buyer_tel : '010-1234-5678', //멤버 전화번호
		   }, function(rsp) {
		       if ( rsp.success ) {
		    	   //컨트롤러단에 보내기
		           var msg = '결제가 완료되었습니다.';
		           msg += '고유ID : ' + rsp.imp_uid;
		           msg += '상점 거래ID : ' + rsp.merchant_uid;
		           msg += '결제 금액 : ' + rsp.paid_amount;
		           msg += '카드 승인번호 : ' + rsp.apply_num;
		           $("#paymentId").val(rsp.imp_uid);
		           $("#paymentPrice").val(rsp.paid_amount);

		           $("[name=deliveryFrm]").submit();
		           console.log("결제ajax완료");
		       } else {
		           var msg = '결제에 실패하였습니다.';
		           msg += '에러내용 : ' + rsp.error_msg;
		           location.href = "${pageContext.request.contextPath}/menu/menuList.do?storeNo="+$("#storeNo").val();
		       }
		       alert(msg);
		   });

	 } else if(method=="later_cash"||method=="later_card"){
		 
		 $("#paymentPrice").val(sum);
       
		$("[name=deliveryFrm]").submit();
	 } else {
		 alert("결제수단을 선택해주세요.");
		 return;
	 }

});
$("#phoneCheckBtn").on("click",function(){
		$("#phoneChkTxt").css("display","inline");
		$("#phoneChk-container").show(1000);

});
/* 비회원일때 휴대폰인증 */
function phoneCheck(){
	var tel = $("#tel").val();
	$.ajax({
		url: "${pageContext.request.contextPath}/guest/phoneCheck.do",
	    type: 'POST',
	    data : {tel:tel},
	    success: function(data) {
			$("#rndNoToTel").val(data);
			console.log(data);	
	        $("#phoneChkNum").keyup(function() {
	        	if($("#phoneChkNum").val()==$("#rndNoToTel").val()){
	    			$("#notEqualsRndNo").css("display","none");
	    			$("#equalsRndNo").css("display","inline");
					$("#orderEndBtn").attr("disabled",false);
	        	}else{		
	    			$("#notEqualsRndNo").css("display","inline");
	    			$("#equalsRndNo").css("display","none");
	    			$("#orderEndBtn").attr("disabled",true);
	        	}
	   		 })
	    },error:function(){
	        console.log("휴대폰인증에이젝스오류");
	    }
	});
	

}

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>