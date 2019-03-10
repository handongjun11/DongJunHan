<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/categoryHeader.jsp">
	<jsp:param value="배달의 신" name="pageTitle" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/store/menuList.css" />

<!-- 지도 관련 -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5f71510449902565d91fe4cae2a1eecd&libraries=services"></script>
<!-- 페이지 스크롤 해도 지도 튀어나오지 않게 하기 -->
<style>
#map{
	z-index: -1;
}
</style>

<!-- 매장 요약----------------------------------------------------------->
<div id="menuThumb-container" class="card">
  <ul class="list-group">
	<c:forEach items="${storeInfo}" var="storeInfo">
	    <li class="list-group-item" id=storeName>
		    ${storeInfo.storeName}
		    <span style="float: right;">
		    	<i class="fas fa-concierge-bell" style="font-size:27px;color:gray; cursor:pointer;padding-left: 319px;" data-toggle="modal" data-target="#ReportModal" ></i>&nbsp;
		    <span style="float : right">
		    	<c:if test="${checkedBookMark != 1}"> 
					<a href="#" class="btn-checkBookMark" onclick="checkBookMark(0,'${storeInfo.STORENO}','${memberLoggedIn.memberId}');">
						<i class='fas fa-heart' style='font-size:24px;color:gray'></i>
					</a>
				</c:if>
				<c:if test="${checkedBookMark == 1}">
					<a href="#" class="btn-checkBookMark" onclick="checkBookMark(1,'${storeInfo.STORENO}','${memberLoggedIn.memberId}');">
						<i class='fas fa-heart' style='font-size:24px;color:red'></i>
					</a>	
				</c:if>
		    </span>
		    </span>
	    </li>
	    <input type="hidden" value="${storeInfo.STORENO}" id="storeNoForPayment">
	    <input type="hidden" value=" ${storeInfo.DELIVERYMINPRICE}" id="deliveryMinPrice">
	    <input type="hidden" id="checkSum">

	    <li class="list-group-item">
		    <div>
		    <c:if test="${not empty storeInfo.RENAMEDFILENAME}"><img src="${pageContext.request.contextPath }/resources/upload/menu/${storeInfo.RENAMEDFILENAME}"></c:if>
		    <c:if test="${empty storeInfo.RENAMEDFILENAME}"></c:if>  	
		    </div>
	    	<div class="introduce">최소주문금액  ${storeInfo.DELIVERYMINPRICE}</div>
	    	<div class="introduce">결제수단 카드결제,만나서결제</div>
	    </li>	    
	    <li class="list-group-item">가게소개 : ${storeInfo.STOREINTRO}</li>
	</c:forEach>	
  </ul>
</div> 

<div id="last-container">

	<!-- 상세보기-------------------------------------------------------------------------------------------------->
	<div id="menuView-container">
		
		<div id=menuView-left>	
			<!-- 네비게이션 탭 --------------------------------------------------------->
			<div id="MenuNavi">		
				<ul class="nav nav-tabs">
					  <li class="nav-item">
					    <a class="nav-link active" id="clickMenu">메뉴 <span>${menuTotalCount}</span>개</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link" id="clickreview">클린리뷰  <span></span></a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link" id="clickInformation">정보</a>
					  </li>
				</ul>
			</div>
				
			<!-- 메뉴/리뷰/사업자 정보---------------------------------------------------->
			<div id="Menu-wrapper">		
				<!-- 메뉴리스트 -->
				<table class="table table-hover active" id="menuTable">				  
					<!--menuList 가 존재하면 -->
					<c:if test="${not empty menuList}">
					  
					  <!-- 주메뉴 -->
					  <thead><tr><th scope="col" colspan="3">주메뉴</th></tr></thead>
					  <tbody>
						  <c:forEach items="${menuList}" var="menuList">
							<c:if test = "${fn : contains(menuList.MENUCODE, 'M')}">
							    <tr id="main-menu">
							      <td>${menuList.MENUNAME}</td>
							      <td>
							      <c:if test="${menuList.RENAMEDFILENAME!=null}">
							      <img class="card-img-top" style="width:100px; height:100px;" src="${pageContext.request.contextPath}/resources/upload/menu/${menuList.RENAMEDFILENAME}" alt="썸네일">
							      </c:if>
							      </td>
							      <td>${menuList.MENUPRICE}</td>
								  <td>
								  	<button type="button" class="btn header-btn btn-primary btn-sm"
											onclick = "inputCart('${menuList.MENUCODE}');">
										주문담기
									</button>
								  </td>    
							    </tr>
							 </c:if>
						   </c:forEach>
					  </tbody>
					  
					  <!-- 사이드메뉴 -->
					  <thead><tr><th scope="col" colspan="3">사이드메뉴</th></tr></thead>
					  <tbody>
					    <c:forEach items="${menuList}" var="menuList">
							<c:if test = "${fn : contains(menuList.MENUCODE, 'S')}">
							    <tr id="side-menu">
							      <td>${menuList.MENUNAME}</td>
							      <td>
							      <c:if test="${menuList.RENAMEDFILENAME!=null}">
							      <img class="card-img-top" style="width:100px; height:100px;" src="${pageContext.request.contextPath}/resources/upload/menu/${menuList.RENAMEDFILENAME}" alt="썸네일">
							      </c:if>
							      </td>
							      <td>${menuList.MENUPRICE}</td>
								  <td>
								  	<button type="button" class="btn header-btn btn-primary btn-sm" 
											onclick = "inputCart('${menuList.MENUCODE}');">주문담기</button>
								  </td>     
							    </tr>
							 </c:if>
						 </c:forEach>
					  </tbody>
					  
					  <!--  음료  -->
					  <thead><tr><th scope="col" colspan="3">음료</th></tr></thead>
					  <tbody>
					    <c:forEach items="${menuList}" var="menuList">
							<c:if test = "${fn : contains(menuList.MENUCODE, 'D')}">
							    <tr id="drink-menu">
							      <td>${menuList.MENUNAME}</td>
							      <td>
							      
							      <c:if test="${menuList.RENAMEDFILENAME!=null}">
							      <img class="card-img-top" style="width:100px; height:100px;" src="${pageContext.request.contextPath}/resources/upload/menu/${menuList.RENAMEDFILENAME}" alt="썸네일">
							      </c:if>
							      
							      </td>
							      <td>${menuList.MENUPRICE}</td>
								  <td>
								  	<button type="button" class="btn header-btn btn-primary btn-sm"
											onclick = "inputCart('${menuList.MENUCODE}');">주문담기</button>
								  </td>      
							    </tr>
							 </c:if>
						 </c:forEach>
					  </tbody>		  		  
					
					</c:if>
				</table> <!-- menuTable -->
				
				<!-- 클린리뷰테이블 : css 수정 필요-------------------------------------------------------->
				<div class="inner_border">
			
				<table class="table" id="sellerReviewList">
					
					<c:if test="${empty reviewList}">
						<tr style="border-bottom:0.2px solid lightgray;">
							<td colspan="4" align="center" height="100px">리뷰가 없습니다.</td>
						</tr>
					</c:if>
					
					<c:if test="${not empty reviewList}">					
						<c:forEach items="${reviewList}" var="review">														
							<!-- 고객이 작성한 리뷰 -->									
							<c:if test="${review.commentLevel == 1 }">							
								<tr> 
									<td><strong>${review.writer } 님 </strong>| ${review.rDate }</td>
								</tr>
								<tr> 
									<td>
										<c:forEach var="i" begin="1" end="${review.rate }">								
				    						<span class="fa fa-star checked"></span>
				      					</c:forEach>
				      					<c:forEach var="i" begin="${review.rate+1}" end='5'>
				      						<span class="fa fa-star"></span>
				      					</c:forEach>									
									</td>
								</tr>
								
								<!-- 리뷰 첨부파일 꺼내기 -->
								<c:if test="${not empty attachList}">	
									<tr>
									<td class="attachList-td">
										<c:forEach var="a" items="${attachList }">
											<!-- 현재 review와 review번호가 같은 첨부파일만 꺼내기 -->															
											<c:if test="${review.reviewNo == a.reviewNo }">										
												<img src="${pageContext.request.contextPath }/resources/upload/review/${a.renamedFileName}"
													 style="max-width : 100px; margin:0 10px;" >
											</c:if>									
										</c:forEach>
									</td>
									</tr>					
								</c:if>
						
								<tr class = "reviewNo${review.reviewNo }">
									<td>${review.content }</td>
								</tr>
							</c:if>												
						</c:forEach>
						
					</c:if>
				</table>
				</div> <!-- div inner_border -->
			
				<!-- 사업자정보 -->
				<table class="table" id="sellerInformation">
					<c:forEach items="${storeInfo}" var="storeInfo">		
						<thead><tr><th scope="col">가게명</th></tr></thead>
						<tbody><tr><td id="mapStoreName">${storeInfo.STORENAME}</td></tr></tbody>						  				  
						<thead><tr><th scope="col">사업자번호</th></tr></thead>
						<tbody><tr><td>${storeInfo.STORENO}</td></tr></tbody>		  				  
						
						<thead><tr><th scope="col">가게소개</th></tr></thead>
						<tbody><tr><td>${storeInfo.STOREINTRO}</td></tr></tbody>
						
						<thead><tr><th scope="col">가게주소</th></tr></thead>
						<tbody>
							<tr>
								<td>
									<p style="margin-top: -12px">
										<em class="link"> 
											<a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
												혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요. 
											</a>
										</em>
									</p>
									<div id="map" style="width:100%;height:350px;"></div>
								</td>
									
							</tr>
							<tr><td id="mapStoreAddr">${storeInfo.STOREADDRESS}</td></tr>
						</tbody>			  
						
						<thead><tr><th scope="col">가게전화번호</th></tr></thead>
						<tbody><tr><td>${storeInfo.STORETEL}</td></tr></tbody>			 
						
						<thead><tr><th scope="col">휴무일</th></tr></thead>
						<tbody><tr><td>${storeInfo.PERSONALDAY}</td></tr></tbody>			 
						
						<thead><tr><th scope="col">영업시간</th></tr></thead>
						<tbody><tr><td>${storeInfo.OPERATINGHOURS}</td></tr></tbody>
					</c:forEach> <!-- end of ${storeInfo} -->
				</table> <!-- end of table#sellerInformation -->
				
			</div>		
		</div>
		
		<!-- 주문표 ---------------------------------------------------------------->
		<div id="Cart-wrapper">
			<table class="table" id="cart">
				<thead class="thead-dark">
					<tr>
						<th scope="col" colspan="3">주문표</th>
					</tr>
				</thead>
				<tbody id="tbody-cart">		
				
			    </tbody>
			    <tfoot>
			    	<tr>
			    		<td colspan="4">
			    			<button type="button" class="btn" id="btn-order"		
			    					onclick="checkOrder();">주문하기</button>			    						    			
			    		</td>
			    	</tr>    	
			    </tfoot>
			</table>
		</div><!-- div#Cart-wrapper -->			
	</div> <!-- div#menu-container -->
	
	
	<!-- 주문표 삭제여부 물어보는 Modal  -->	
	<div class="modal fade" id="checkEmptyCart" tabindex="-1" role="dialog" 
		 aria-labelledby="checkEmptyCartLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      
	      <div class="modal-header">
	        <div class="modal-title" id="checkEmptyCartLabel">주문표에 담기</div>
	        <div>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
	        </div>
	      </div>
	      
	      <div class="modal-body">
	        	다른 음식점에서 이미 담은 메뉴가 있습니다. <br />
	        	담긴 메뉴를 취소하고 새로운 음식점에서 메뉴를 담을까요?
	        	<input type="hidden" id = "newMenuCode"/>
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" onclick="emptyCart( $('#newMenuCode').val() );">확인</button>
	      </div>
    	</div>
  	  </div>
	</div>

</div> <!-- #last-container -->

<!-- 신고 모달 -->
<div class="modal fade" id="ReportModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">신고하기</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	        <form action="${pageContext.request.contextPath}/storeInfo/report.do" method="post" id="report-frm">
	      <div class="modal-body">
		        <c:forEach items="${storeInfo}" var="storeInfo">
		          <div class="form-group">
		            <label for="email" class="col-form-label" style="font-size:large;">상호명</label>
		            <br />
		            <input type="text" class="form-control" id="find-id" name="storeName" placeholder="${storeInfo.storeName}" disabled="disabled" style="background: white;"/>
		            <input type="hidden" name="storeNo" value="${storeInfo.storeNo}" />
		          	<input type="hidden" name="category" value="S" />
		          </div>
		          <div class="form-group">
		              <label for="password" class="col-form-label" style="font-size:large;">신고사유</label>
						<select name="reportDetails" class="form-control" style="width:400px;">
						    <option value="">신고사유선택</option>
						    <option value="위생불량">위생불량</option>
						    <option value="불친절한 서비스">불친절한 서비스</option>
						    <option value="카드결제 거부">카드결제 거부</option>
						    <option value="배달시간 초과">배달시간 초과</option>
						    <option value="기타" id="ect">기타</option>
						</select>
						<br />
		          	<input type="text" name="reportReason" id="reportReason" class="form-control" placeholder="기타 사유를 작성해주세요" style="display: none;" />
		          </div>
		        </c:forEach>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" onclick="checkSelect();">신고</button> 
	         <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	        </form>
	    </div>
	  </div>
	</div>


<!--스크립트------------------------------------------------------------>
<script>

var cart = JSON.parse(sessionStorage.getItem("cart"));

$(document).ready(function() {  
	
    $(window).scroll(function(){
  	  		
    /*     $('#cart').animate(    		
        	{top: $(window).scrollTop()+"px"},
        	{queue: false, duration: 300}
        );   */
    
    });  
 
	<!-- 사장이 작성한 리뷰 -->
	<c:forEach items="${reviewList}" var="review">	
		<c:if test="${review.commentLevel == 2 }">	
			//console.log(" ${review.rDate }");
		
			var html = "";
			html += "<tr class= 'reviewAnswerTr'> <td>사장님 | ${review.rDate }</td></tr>";
			html += "<tr class= 'reviewAnswerTr'> <td>${review.title }</td></tr>";
			html += "<tr class= 'reviewAnswerTr'> <td>${review.content }</td></tr>";
		
			$('#sellerReviewList .reviewNo${review.reviewRef}').after(html);	//태그 넣기			
		</c:if>
	</c:forEach>
    
	 //리뷰숨기기
    $(".inner_border").hide();
    //가게정보숨기기
	$("#sellerInformation").hide();
    
   
    cartHtml();
});

//매장 북마크
function checkBookMark(value, storeNo, memberId){
	console.log("북마크 함수 호출");
	
	//아이디값과 매장명을 기준으로 북마크 추가 또는 해제
 	if(${memberLoggedIn != null}){ // 로그인 되어있으면 이 기능을 
				
		$.ajax({
			url : "${pageContext.request.contextPath}/member/checkBookMark.do",
			method: "get",
			data : {memberId : memberId, storeNo : storeNo, value : value},
			success : function(checkedBookMark){
				var html = "";
				var msg = "";
				
 				if(checkedBookMark == 1) { //북마크에 등록됨
					html += "<a href='#' class = 'btn-checkBookMark' onclick = checkBookMark(1,'"+storeNo+"','"+memberId+"');>";
					html += "<i class = 'fas fa-heart' style = 'font-size:24px; color:red'></i>";	
					html += "</a>";	
					msg = "북마크에 등록되었습니다.";					
				}else if(checkedBookMark == 0){ //북마크에서 삭제됨
					html += "<a href='#' class = 'btn-checkBookMark' onclick = checkBookMark(0,'"+storeNo+"','"+memberId+"');>";
					html += "<i class = 'fas fa-heart' style = 'font-size:24px; color:gray'></i>";
					html += "</a>";		
					msg = "북마크가 해제되었습니다.";
				} 
											
				$('#storeName >span').html(html);	//태그 넣기
				alert(msg);
				
			}, //success;
			error : function(){
				console.log("ajax 에러");
			}
		});	
 			
	}else{ //로그인 안되어있으면 로그인하라고 알림
		alert("로그인 하셔야 사용하실 수 있습니다.");		
	} 	
	
};


//주문표 html 
function cartHtml(){
    
	console.log("cartHtml 호출");
    
	var sum = 0;
    
    //데이터를 테이블에 추가하기
	var html = "";
	$('#tbody-cart').html("");
    
		if(cart != null){		    								
		
		/* if(cart.length != 0){
			
			html += "<tr><th>메뉴</th><th>가격</th><th>수량</th><th></th></tr>";
			
	    	for (var i=0; i<cart.length; i++){			  
	    	
		  		html += "<tr><td>"+cart[i].menuName+"</td>";
		  		html += "<td>"+cart[i].menuPrice*cart[i].amount+"</td>"
		  		html += "<td><button type='button' class='btn-xs add-order-num' onclick=InputCartAmount('" +i+ "'," +1+ "); ";
		  		
		  		if(cart[i].amount==9){html += "disabled";}
		  		
		  		html += ">+</button>";
		  		html += "<input type='text' class='order-num' readonly value="+cart[i].amount+">";
		  		html += "<button type='button' class='btn-xs minus-order-num' onclick=InputCartAmount('"+i+"'," +-1 +"); ";
		  		
		  		if(cart[i].amount==1){html += "disabled";}
		  		
		  		html += ">-</button></td>";
				html += "<td><button  type='button' class='btn-xs delete-order' onclick=deleteCartMenu('"+i+"');>x</button></td></tr>";  //삭제 버튼	
		  		sum += cart[i].menuPrice*cart[i].amount;
		   	}   
	    	
	    	html += "<tr><td>합계</td><td colspan ='3'>"+sum+"</td></tr>"; */
	    	
	    	if(cart.length != 0){
	    		html += "<tr><th>메뉴</th><th></th></tr>";
	    		
	    		for (var i=0; i<cart.length; i++){	
	    			//메뉴 이름
	    			html += "<tr><td colspan = '3' style='text-align: left'>"+cart[i].menuName+"</td></tr>"; 
	    			 			    	
	    			//삭제 버튼
	    			html += "<tr><td><button  type='button' class='btn-xs delete-order' onclick=deleteCartMenu('"+i+"');>x</button></td>";
	    					
	    			//<i class="fas fa-times"></i>
	    			//수량 버튼
	    			html += "<td><button type='button' class='btn-xs add-order-num' onclick=InputCartAmount('" +i+ "'," +1+ "); "; //증가 버튼
	    			if(cart[i].amount==9){html += "disabled";} 
	    			html += ">+</button>";	    			
	    			html += "<input type='text' class='order-num' readonly value="+cart[i].amount+">"; //카트에 담긴 수량			  		
	    			html += "<button type='button' class='btn-xs minus-order-num' onclick=InputCartAmount('"+i+"'," +-1 +"); "; //감소 버튼		  		
			  		if(cart[i].amount==1){html += "disabled";}
			  		html += ">-</button></td>";
			  		
			  		//가격
	    			html += "<td>"+cart[i].menuPrice*cart[i].amount+"</td>";
			  		
			  		html += "</tr>";
			  		
			  		sum += cart[i].menuPrice*cart[i].amount;
	    		}
	    		
	    		html += "<tr><td colspan ='2'>합계</td><td>"+sum+"</td></tr>"; 
	    		$('#btn-order').removeAttr("disabled");
	    		$("#checkSum").val(sum);
	    	}else{
				html += "<tr><td>주문표에 담긴 메뉴가 없습니다.</td></tr>";
				$('#btn-order').attr("disabled","disabled");
			}
		  	
	}else{ //cart == null
		
		html += "<tr><td>주문표에 담긴 메뉴가 없습니다.</td></tr>";
		$('#btn-order').attr("disabled","disabled");
		
	}//end of if(cart.length)

	$('#tbody-cart').html(html);
	
};

//메뉴 수량 증가 감소
function InputCartAmount(index,num){
	
	if(cart[index].amount == 1 && num==-1){ 
		//cart[index].amount 는 1이 최소값
	}else if(cart[index].amount == 9 && num == 1){
		//cart[index].amount 는 9가 최대값
	}else{
		cart[index].amount = cart[index].amount + num;	
	}
	sessionStorage.setItem("cart", JSON.stringify(cart));		
	cartHtml();

};

//메뉴 삭제
function deleteCartMenu(index){
	
	cart.splice(index,1);
	sessionStorage.setItem("cart", JSON.stringify(cart));	
	cartHtml();
	
};

//주문 담기 : 카트에 담기 (세션)
function inputCart(menuCode){
	
	console.log("inputCart 호출",menuCode);
	
	//menuCode를 이용해서 menu 객체 꺼내기
	$.ajax({
		url : "${pageContext.request.contextPath}/menu/selecOneMenu.do",
		method : "get",
		data : {menuCode : menuCode},
		success : function(menu){	
			
			console.log("cart = ",cart);
			console.log("selectMenu = ",menu);
			
			//cart 배열에 menu 객체 추가
			if(cart == null){ //cart 가 이미 storage에 없음 : 첫 객체일 경우 cart 배열을 생성 하고 추가			
				cart = [];						
				cart.push(menu);
				
			}else{ //cart 가 이미 storage에 있음
				
				var cnt = 0;		
			
				for (var i=0; i<cart.length; i++){					
					if(menu.storeNo != cart[i].storeNo){ //새로 추가한 메뉴가 기존의 메뉴와 다른 사업자번호를 가지고 있다면
						$('#newMenuCode').val(menu.menuCode);
						$('#checkEmptyCart').modal(); //모달이 실행되고서 아래도 계속실행중임..
						cnt = 1;
					}else{						
						if(menu.menuCode == cart[i].menuCode){ //꺼낸 메뉴가 cart에 이미 담겨있으면 	
							cnt ++;
							if(cart[i].amount < 9 ){
								cart[i].amount = cart[i].amount + 1;
							}
							
						}						
					}	
									
					
				}//end of for (중복찾기)
				
				if(cnt == 0){ //중복없음
					cart.push(menu);
				}
				
			}//else (cart != null)
			
			// 세션 스토리지에 저장
			sessionStorage.setItem("cart", JSON.stringify(cart));			
			cartHtml();
			console.log("ajax 완료-----------------------------------------------------------------");
		}, //success : 
		error : function(){
			console.log("ajax 에러");
		}
	});
};

function emptyCart(newMenuCode){
	cart = [];
	inputCart(newMenuCode);
	$('#checkEmptyCart').modal('hide');
};


/* 각 메뉴->카트 확인 모달영역 */
function checkOrder(){
	var memberid= "${memberLoggedIn.memberId}";
	var deliveryMinPrice = $("#deliveryMinPrice").val();
	var checkSum = $("#checkSum").val();
	
	console.log("외않되죠deliveryMinPrice..?",deliveryMinPrice);
	console.log("외않되죠checkSum..?",checkSum);

	var bool = "";
	if(memberid==""){
		bool =  confirm("비회원으로 주문 하시겠습니까?");
		if(checkSum<deliveryMinPrice){
			alert("최소금액을 주문하셔야합니다.");
			return;
		}
	} else {
		bool =  confirm("주문 하시겠습니까?");
		if(checkSum<deliveryMinPrice){
			alert("최소금액을 주문하셔야합니다.");
			return;
		}
	}
	
	if(bool){
		location.href = "${pageContext.request.contextPath}/payment/goPaymentPage.do?storeName="+$('#storeName').text()+"&storeNo="+$('#storeNoForPayment').val()+"&memberId="+memberid;	
	}	
}; 


/* 클린리뷰 클릭시 */
$("#clickreview").click("on", function(){
	$("#clickreview").addClass("active");
	$("#clickMenu").removeClass("active");
	$("#clickInformation").removeClass("active");
	
	//클린리뷰 보이기
	$(".inner_border").show();	
	//메뉴테이블 숨기기
	$("#menuTable").hide();
	//가게정보 숨기기
	$("#sellerInformation").hide();
});

/* 메뉴클릭시 */
$("#clickMenu").click("on", function(){
	$("#clickMenu").addClass("active");
	$("#clickreview").removeClass("active");
	$("#clickInformation").removeClass("active");
	//메뉴테이블 보이기
	$("#menuTable").show();
	//리뷰 숨기기
	$(".inner_border").hide();
	//가게정보 숨기기
	$("#sellerInformation").hide();
});

/* 정보클릭시 */
$("#clickInformation").click("on", function(){
	$("#clickInformation").addClass("active");
	$("#clickMenu").removeClass("active");
	$("#clickreview").removeClass("active");
	//메뉴테이블 숨기기
	$("#menuTable").hide();
	//리뷰 숨기기
	$(".inner_border").hide();
	//메뉴테이블 보이기
	$("#sellerInformation").show();

});

function checkSelect(){
	
	if($("[name=reportDetails] option:eq(0)").is(":selected")){
		alert("신고사유를 선택해주세요.");
		return false;
	}else{
		if($("#reportReason").val() != ""){
			$("[name=reportDetails] option:eq(5)").val($("#reportReason").val());
		}
		reportType = "storeReport";
		//웹소켓으로 신고 접수를 관리자에게 알리기위한 메소드.
		sendReportAlert();
		$("#report-frm").submit();
	}
};
$("[name=reportDetails]").change( function(){
	var state = $('[name=reportDetails] option:selected').val();
	
	if(state == '기타'){
		$("#reportReason").show();
		
	}else{
		$("#reportReason").hide();
	}

});


/* 가게 위치 지도 */
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch($("#mapStoreAddr").text(), function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {

        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new daum.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new daum.maps.InfoWindow({
            content: '<div class="mapPin" style="width:150px; text-align:center; padding:1px; font-size:70%;">'+$("#mapStoreName").text()+'</div>'
            // content: '<div class ="label"><span class="left"></span><span class="center">' + $("#mapStoreName").text() + '</span><span class="right"></span></div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>