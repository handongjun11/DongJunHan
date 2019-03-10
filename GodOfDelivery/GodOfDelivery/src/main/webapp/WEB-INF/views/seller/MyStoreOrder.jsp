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
<script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="crossorigin="anonymous"></script>
<!-- Custom styles for this template-->
<link href="${pageContext.request.contextPath}/resources/css/seller/MyStoreOrder.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.css" rel="stylesheet">

<script>
$(function(){
	var storeNo = "${param.storeNo}"
	$("#collapse"+storeNo).addClass("show");
	$("#collapse"+storeNo).parent("li").addClass("active");	
	$("#collapse"+storeNo+">div>a.myStoreOrder").addClass("active");	
});
</script>

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
          <h1 class="h3 mb-4 text-gray-800">주문현황</h1>
          
          <!-- 여기부터 코드 붙여넣으면 됨 -->
<div id="container">
  <div>
    <div class="list-group" id="list-tab" role="tablist" style="display:inline">
      <a class="list-group-item list-group-item-action active" id="list-home-list" data-toggle="list" href="#list-home" role="tab" aria-controls="home" style="display:inline">접수대기</a>
      <a class="list-group-item list-group-item-action" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile" style="display:inline">접수완료</a>
      <a class="list-group-item list-group-item-action" id="list-messages-list" data-toggle="list" href="#list-messages" role="tab" aria-controls="messages" style="display:inline">배달완료</a>
    </div>
  </div>
<div class="row">
  <div class="col-8">
    <div class="tab-content" id="nav-tabContent">
      <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">
      	<!-- 접수대기중인 목록 -->
				<table class="table table-hover" id="orderWaitng">
				  <thead>
				    <tr>
				      <th scope="col">주문메뉴</th>      
				      <th scope="col">주소</th>
				      <th scope="col">전화번호</th>
				      <th scope="col">요청사항</th>
				      <th scope="col">결제수단</th>
				      <th scope="col">총 가격</th>
				      <th scope="col">주문시간</th>     
				      <th scope="col"></th>
				    </tr>
				  </thead>
				  <tbody>
				    <!--${fn:split('1|2|3|4|5', '|') }  -->
				      <c:forEach items="${orderList1}" var="orderList1" varStatus="var">
				  <tr class="trOrderList1" no="${var.count}">
				  <!--주문메뉴 -->
				      <td class="orderMenu">
				      <c:forEach items="${fn:split(orderList1.NAME,'/')}" var="menu">
				      ${menu}<br>
				      </c:forEach>
				      </td>
				  <!--주소 -->
				      <td class="orderAddress" >${orderList1.ADDRESS}</td>
				  <!--전화번호 -->
				      <td class="orderPhone" >${orderList1.PHONE}</td>
				  <!--요청사항 -->    
				      <c:if test="${not empty orderList1.REQUEST}">
				      <td class="orderRequest">${orderList1.REQUEST}</td>
				      </c:if>
				      
				      <c:if test="${empty orderList1.REQUEST}">
				      <td class="orderRequest"></td>
				      </c:if>
				      
				      <c:if test="${orderList1.PRICEWAY=='Y'}">
				      <td class="orderWay">결제완료</td>
				      </c:if>
				      
				      <c:if test="${orderList1.PRICEWAY=='현금'}">
				      <td class="orderWay">만나서결제(현금)</td>
				      </c:if>
				      
				      <c:if test="${orderList1.PRICEWAY=='카드'}">
				      <td class="orderWay">만나서결제(카드)</td>
				      </c:if>
				     
				      <td class="orderPrice">${orderList1.TOTALPRICE}</td>
				      <td class="orderPrice">${orderList1.ORDERTIME}</td>
				     
				      <td>
				      <button type="button" id="orderAcception" onclick="orderNo(${orderList1.ORDERNO},'${orderList1.STORENO}',${var.count},'${orderList1.PHONE}')" class="btn btn-info" data-toggle="modal" data-target="#receiveModal">주문접수</button>
				      <button type="button" id="orderCancel" onclick="cancelOrder(${orderList1.ORDERNO},'${orderList1.STORENO}',${var.count},'${orderList1.PHONE}','${orderList1.PRICEWAY}','${orderList1.PAYMENTID}');" class="btn btn-secondary" data-toggle="modal" data-target="#cancelModal">접수취소</button>
				      </td> 
				    </tr>
				      </c:forEach>
				  </tbody>
				</table>
      </div>
      <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">
		<!-- 접수완료된 오더들 -->
				<table class="table table-hover" id="list2">
				  <thead>
				    <tr>
				      <th scope="col">주문메뉴</th>      
				      <th scope="col">주소</th>
				      <th scope="col">전화번호</th>
				      <th scope="col">요청사항</th>
				      <th scope="col">결제수단</th>
				      <th scope="col">총 가격</th>
				      <th scope="col">주문시간</th>     
				     <th scope="col"></th>
				    </tr>
				  </thead>
				  <tbody>
				      <c:forEach items="${orderList2}" var="orderList2" varStatus="var">
				    <tr no="${var.count}" class="trOrderList2">
				    <!--${fn:split('1|2|3|4|5', '|') }  -->
				      <td class="orderMenu">
				      <c:forEach items="${fn:split(orderList2.NAME,'/')}" var="menu">
				      ${menu}<br>
				      </c:forEach>
				      </td>
				      <td class="orderAddress">${orderList2.ADDRESS}</td>
				      <td class="orderPhone">${orderList2.PHONE}</td>
				      				  <!--요청사항 -->    
				      <c:if test="${not empty orderList2.REQUEST}">
				      <td class="orderRequest">${orderList2.REQUEST}</td>
				      </c:if>
				      
				      <c:if test="${empty orderList2.REQUEST}">
				      <td class="orderRequest"></td>
				      </c:if>
				      
				      <c:if test="${orderList2.PRICEWAY=='Y'}">
				      <td class="orderWay">결제완료</td>
				      </c:if>
				      <c:if test="${orderList2.PRICEWAY=='N'}">
				      <td class="orderWay">만나서결제</td>
				      </c:if>
				     
				      <td class="orderPrice">${orderList2.TOTALPRICE}</td>
				      <td class="orderPrice">${orderList2.ORDERTIME}</td>
				     
				      <td>
				      <button type="button" onclick="deliveryEnd(${orderList2.ORDERNO},'${orderList2.STORENO}',${var.count})" class="btn btn-info">배달완료</button>
				      </td> 
				    </tr>
				     </c:forEach>
				  </tbody>
				</table>


	   </div>
      <div class="tab-pane fade" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">
		<!-- 배달완료된 오더들 -->
		<table class="table table-hover" id="orderWaitng">
				  <thead>
				    <tr>
				      <th scope="col">주문메뉴</th>      
				      <th scope="col">주소</th>
				      <th scope="col">전화번호</th>
				      <th scope="col">요청사항</th>
				      <th scope="col">결제수단</th>
				      <th scope="col">총 가격</th>
				      <th scope="col">배달완료시간</th>     
				 
				    </tr>
				  </thead>
				  <tbody>
				    <c:forEach items="${orderList3}" var="orderList3" varStatus="var">
				    <tr no="${var.count}" class="trOrderList3">
				    <!--${fn:split('1|2|3|4|5', '|') }  -->
				      <td class="orderMenu">
				      <c:forEach items="${fn:split(orderList3.NAME,'/')}" var="menu">
				      ${menu}<br>
				      </c:forEach>
				      </td>
				      <td class="orderAddress">${orderList3.ADDRESS}</td>
				      <td class="orderPhone">${orderList3.PHONE}</td>
				      
				      <c:if test="${not empty orderList3.REQUEST}">
				      <td class="orderRequest">${orderList3.REQUEST}</td>
				      </c:if>
				      
				      <c:if test="${empty orderList3.REQUEST}">
				      <td class="orderRequest"></td>
				      </c:if>
				      
				      <c:if test="${orderList3.PRICEWAY=='Y'}">
				      <td class="orderWay">결제완료</td>
				      </c:if>
				      <c:if test="${orderList3.PRICEWAY=='N'}">
				      <td class="orderWay">만나서결제</td>
				      </c:if>
				     
				      <td class="orderPrice">${orderList3.TOTALPRICE}</td>
				      <td class="orderPrice">${orderList3.DELIVERYEND}</td>
				     
				    </tr>
				     </c:forEach>
				  </tbody>
				</table>

	  </div>
    </div>
  </div>
</div>
	
     
     <!-- 접수모달창 -->

<!-- Modal -->
<div class="modal fade" id="receiveModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">배달예정시간</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="receiveForm" method="POST">
      <div class="modal-body">
      		<input type="hidden" id="orderNoForReceive" name="orderNoForReceive">
      		<input type="hidden" id="howLongChecked" name="howLongChecked">
      		<input type="hidden" id="ForHide" name="ForHide">
      		<input type="hidden" id="memberPhone" name="memberPhone">
      		
			<button type="button" name="howLong" class="btn btn-info howLong" value="10분~30분">10분~30분</button>
			<button type="button" name="howLong" class="btn btn-info howLong" value="30분~50분">30분~50분</button>
			<button type="button" name="howLong" class="btn btn-info howLong" value="50분~60분">50분~60분</button>
			<button type="button" name="howLong" class="btn btn-info howLong" value="60분 이상">60분 이상</button>
      </div>
      <div class="modal-footer">
        <button type="button" id="receiveBtn" class="btn btn-primary">주문접수</button>
      </div>
      </form>
    </div>
  </div>
</div>
</div>

<!-- 주문취소 선택시 -->
<div class="modal fade" id="cancelModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">배달 취소 사유</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="cancelFrm">
          <div class="form-group">
            <input type="hidden" id="orderNoForCancel" name="orderNoForCancel">
      		<!-- <input type="hidden" id="reason" name="howLongChecked"> -->
      		<input type="hidden" id="ForHideCancel" name="ForHideCancel">
      		<input type="hidden" id="memberPhoneForCancel" name="memberPhoneForCancel">
     
      		<!-- 결제여부 -->
      		<input type="hidden" id="priceWay" name="priceWay">
      		<!-- 페이먼트아이디 => 결제취소를 위해 -->
      		<input type="hidden" id="paymentId" name="paymentId">
      		
      		
            <input type='radio' name='reason' value='주문량이 너무 많습니다' class="btnReason"/>주문량이 너무 많아서
            <br>
            <br>
            <input type='radio' name='reason' value='배달소요시간이 오래 걸릴 거같습니다' class="btnReason"/>배달소요시간이 오래 걸릴 거같아서
            <br>
            <br>
            <input type='radio' name='reason' value='해당메뉴는 품절입니다' class="btnReason"/>해당메뉴품절
            <br>
            <br>
            <input type='radio' name='reason' value='기타' id="etc"/>기타
            <br>
            <label for="message-text" class="form-control-label">배달취소사유:</label>
            <textarea class="form-control" id="cancelReason" name="cancelReason" readonly></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
         <!-- onclick="backMoney();" -->
        <button type="button" class="btn btn-primary" id="cancelBtn">주문취소</button>
      </div>
    </div>
  </div>
</div>
<script
src="https://code.jquery.com/jquery-3.3.1.min.js"
integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
crossorigin="anonymous">


</script>
<script>

$("#etc").on("click", function(){
	$("#cancelReason").prop('readonly', false);
});
$(".btnReason").on("click", function(){
	$("#cancelReason").prop('readonly', true);
});

//선택된 배달소요시간 보내기
$("[name=howLong]").on("click", function(){
	$("input[name=howLongChecked]").val($(this).val());
	console.log($(this).val());
})
//주문접수,모달로 orderno 보내기
function orderNo(item,item2,item3,item4){	
	console.log(item);
	console.log(item2);
	console.log(item3);
	console.log(item4);

	$("#ForHide").val(item3);
	$("#orderNoForReceive").val(item);
	$("#memberPhone").val(item4);
	$("")
}

//주문취소
$("#cancelBtn").on("click", function(){
	var formData = $("#cancelFrm").serialize();
	var no = $("input[name=ForHideCancel]").val();
	var priceWay = $("#priceWay").val();
	var paymentId = $("#paymentId").val();
	
  	$.ajax({
		url : "${pageContext.request.contextPath}/payment/paymentCancel.do",
		data:formData,
		success : function(data){
			$(".trOrderList1[no="+no+"]").hide('1000'); 
			$("#cancelModal").removeClass("show");
			location.reload();
			console.log("에이젝스성공");
			
		},
		error:function(){
			console.log("ajax오류");
		}
	}); 

});

//주문접수 
$("#receiveBtn").on("click", function(){
	var no = $("input[name=ForHide]").val();
	
	var formData = $("#receiveForm").serialize();
  	$.ajax({
		url : "${pageContext.request.contextPath}/seller/receiveOrder.do",
		data:formData,
		success : function(data){
			$(".trOrderList1[no="+no+"]").hide('1000'); 
			$("#receiveModal").removeClass("show");
			location.reload();

			console.log("에이젝스성공");
			
		},
		error:function(){
			console.log("ajax오류");
		}
	}); 
});
function cancelOrder(item,item2,item3,item4,item5,item6){
/*     <input type="hidden" id="orderNoForCancel" name="orderNoForCancel">
		<!-- <input type="hidden" id="reason" name="howLongChecked"> -->
		<input type="hidden" id="ForHideCancel" name="ForHideCancel">
		<input type="hidden" id="memberPhoneForCancel" name="memberPhoneForCancel"> */
	console.log(item5);
	console.log(item6);

	$("#orderNoForCancel").val(item);
	$("#ForHideCancel").val(item3);
	$("#memberPhoneForCancel").val(item4);
	$("#priceWay").val(item5);
	$("#paymentId").val(item6);


}


/* */
	
	
/* 	$.ajax({
		url : "${pageContext.request.contextPath}/seller/cancelOrder.do",
		data:formData,
		success : function(data){
			$(".trOrderList1[no="+no+"]").hide('1000'); 
			$('#receiveModal').modal('hide')
			console.log("에이젝스성공");		
		},
		error:function(){
			console.log("ajax오류");
		}
	}); */
/* }); */
//배달완료 버튼 눌렀을 시
 function deliveryEnd(item, item2,item3){
	console.log(item);
	console.log(item2);
	console.log(item3);
    
  	$.ajax({
		url : "${pageContext.request.contextPath}/seller/deliveryEnd.do",
		data : {orderNo : item, storeNo:item2},
		success : function(data){
			 $(".trOrderList2[no="+item3+"]").hide('1000'); 
			console.log("에이젝스성공");
		},
		error:function(){
			console.log("ajax오류");
		}
	});  
} 



</script>
        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>

