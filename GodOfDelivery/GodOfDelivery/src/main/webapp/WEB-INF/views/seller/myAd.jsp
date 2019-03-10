<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="배달의 신" name="pageTitle" />
</jsp:include>

<!-- Custom fonts for this template-->
<link href="${pageContext.request.contextPath }/resources/css/fontawesome-free/css/all.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.css" rel="stylesheet">
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


<script>
$(function(){
	var storeNo = "${param.storeNo}"
	$("#collapse"+storeNo).addClass("show");
	$("#collapse"+storeNo).parent("li").addClass("active");	
	$("#collapse"+storeNo+">div>a.myAd").addClass("active");	
});

$(function(){
	$("#adRe").on("click",function(){
		$(".card").hide();
		$("#adRe-View").show();
	});
	
});
$(function(){
	$("#whatAd").on("click",function(){
		$(".card").show();
		$("#adRe-View").hide();
	})
	
});

function adReValidate(){
	if(!confirm('광고를 신청하시겠습니까?')) return;
	return true;
}

$(function(){
	$("#adNow").on("click",function(){
		var storeNo = "${storeNo }";
		location.href = "${pageContext.request.contextPath}/seller/myAd.do?status=now&storeNo="+storeNo;
	});
});
$(function(){
	$("#adPast").on("click",function(){
		var storeNo = "${storeNo }";
		location.href = "${pageContext.request.contextPath}/seller/myAd.do?status=past&storeNo="+storeNo;
	});
});
$(function(){
	$("#adAll").on("click",function(){
		var storeNo = "${storeNo }";
		location.href = "${pageContext.request.contextPath}/seller/myAd.do?status=all&storeNo="+storeNo
	});
});
 
</script>

<style>
div.card{
	margin: 0 auto;
	display : inline-block;
}
#adRe{	
	color : #1b9891;
	float : right;
}
#whatAd{	
	color : #1b9891;
	float : left;
}
#ad{
	color : #1b9891;
	float : right;
}
#adRe-View{
	margin  : 0 auto;
	vertical-align : middle;
	text-align:center;
	display:none;
}
table#tbl-event tr th{text-align:center;}
table#tbl-event tr td{text-align:center;}
table#tbl-event tr td a {text-decoration:none !important;}
</style>

<!-- Page Wrapper -->
  <div id="wrapper">

	<jsp:include page="/WEB-INF/views/seller/sideBar.jsp"></jsp:include>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <h1 class="h3 mb-4 text-gray-800">광고</h1>
          
          <div style="color:black;font-weight:bold;"> 내 광고 :
           <input type="button" class="btn btn-light" class="ad" id="adAll" value="All" />
           <input type="button" class="btn btn-light" class="ad" id="adNow" value="NOW" />
           <input type="button" class="btn btn-light" class="ad" id="adPast" value="PAST" />
          </div>
           <hr />
          <div class="adView">
	          <table id="tbl-event" class="table table-striped table-hover">
				<tr>
					<th>번호</th>
					<th>가격</th>
					<th>광고 등급</th>
					<th>광고 시작일</th>
					<th>광고 종료일</th>
					
				</tr>
				<c:if test="${not empty list}">
					<c:forEach items="${list }" var="ad">
				<tr>
					<td>${ad.adNo }</td>
					<td>${ad.price }</td>
					<td>${ad.storeGrade }</td>
					<td><fmt:formatDate value="${ad.startDate}" type="date" /> </td>
					<td><fmt:formatDate value="${ad.endDate}" type="date" /> </td>
				</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty list}">
					<tr>
						<td colspan="5">등록된 정보가 없습니다.</td>
					</tr>
				</c:if>
			
			</table>
          
          </div>
          <br />
      <%
		int totalContents = (int)request.getAttribute("totalContents");
		int numPerPage = (int)request.getAttribute("numPerPage");
		int cPage = (int)request.getAttribute("cPage");
		String status = (String)request.getAttribute("status");
	%>
	<div>
	<%=com.kh.god.common.util.Utils.getPerBar(totalContents,cPage,numPerPage,"myAd.do?status="+status) %>
	</div>
		
          
          
         
        <br />
        <br />
          <input type="button" class="btn btn-light whatAd" id="whatAd" value="광고란" />
          <input type="button" class="btn btn-light adRe" id="adRe" value="광고신청하기" />
          <br />

          <hr />
          <div class="card" style="width: 20rem;">
			  <div class="card-body">
			    <h5 class="card-title" style="color:black;">광고?</h5>
			    <p class="card-text"> 광고를 신청한 경우 기본정렬 보기에서 먼저 보여질 수 있습니다! <br /><br /></p>
			  </div>
		 </div>
		 <div class="card" style="width: 20rem;">
			  <div class="card-body">
			    <h5 class="card-title" style="color:black;">광고 가격</h5>
			    <p class="card-text">광고의 가격에 따라 등급이 달라집니다. <br /> A : 50000원 <br />B : 30000원</p>
			  </div>
		 </div>
		  <div class="card" style="width: 20rem;">
			  <div class="card-body">
			    <h5 class="card-title" style="color:black;">광고 기간</h5>
			    <p class="card-text">한 달을 기준으로 광고를 등록합니다! <br /><br /> <br /></p>
			  </div>
		 </div>
		 
		 <div class="adRe-View" id="adRe-View" style="width:650px;">
		 <form name="adFrm" action="${pageContext.request.contextPath }/seller/adRequest.do" onsubmit="return adReValidate();">
			  <div class="form-group row">
			    <label for="inputEmail3" class="col-sm-2 col-form-label">사업장 번호</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control storeNo" id="storeNo" value="${storeNo}" readOnly >
			    </div>
			  </div>
			  <div class="form-group row">
			    <label for="inputEmail3" class="col-sm-2 col-form-label">전화번호</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control storeNo" id="buyerTel" placeholder="010-1234-1234" required>
			    </div>
			  </div>
			  <fieldset class="form-group">
			    <div class="row">
			      <legend class="col-form-label col-sm-2 pt-0">가격 : </legend>
			      <div class="col-sm-10">
			        <div class="form-check">
			          <input class="form-check-input grade" type="radio" name="cost" id="grade1" value="50000">
			          <label class="form-check-label" for="50000">
			            50000원
			          </label>
			        </div>
			        <div class="form-check">
			          <input class="form-check-input grade" type="radio" name="cost" id="grade2" value="30000">
			          <label class="form-check-label" for="30000">
			           30000원 
			          </label>
			        </div>
			      </div>
			    </div>
			  </fieldset>
			 <input type="button" id="adRequest" class="btn btn-light" value="지금 신청하기" style="color: #1b9891;margin-left:100px;" onclick="fn_adRequest()"/>
			</form>	 	
		 </div>

        </div>
        <!-- /.container-fluid -->
        
        <script>

      function fn_adRequest(){
        	var IMP = window.IMP; // 생략해도 괜찮습니다.
        		IMP.init('imp68637076'); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.
        		IMP.request_pay({ // param
        		    pg: "kakao",
        		    pay_method: "card",
        		    merchant_uid: $("#storeNo").val()+ new Date().getTime(),
        		    name: "광고 결제",
        		    amount : $("input[name=cost]:checked").val(),
        		    buyer_tel :  $("#buyerTel").val(),
        		    m_redirect_url : "${pageContext.request.contextPath}/seller/adRequest.do?storeNo=${storeNo}"
        		}, function (rsp) { // callback
        		    if (rsp.success) {
        		    	var msg = '결제가 완료되었습니다.';
        				msg += '고유ID : ' + rsp.imp_uid;
        				msg += '상점 거래ID : ' + rsp.merchant_uid;
        				msg += '결제 금액 : ' + rsp.paid_amount;
        				msg += '카드 승인번호 : ' + rsp.apply_num;
        				location.href = "${pageContext.request.contextPath}/seller/adRequest.do?storeNo=${storeNo}&cost="+$("input[name=cost]:checked").val();
        		     } else {
        		    	 var msg = '결제에 실패하였습니다.';
        		         msg += '에러내용 : ' + rsp.error_msg;
        		     }
        		alert(msg);
        	});
       
      };

        
        </script>

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->