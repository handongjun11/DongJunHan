<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.god.storeInfo.model.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/locationHeader.jsp">
	<jsp:param value="배달의 신" name="pageTitle" />
</jsp:include>

<style>
div.row{
 	margin-top: 168px;
    margin-left: 92px;
}

li#storeNo{
	display: none;
}
</style>
<%-- <script>
$(document).ready(function(){
	var categoryNo = ${categoryNo};
	if(categoryNo==1){
		$("#chicken").addClass("active");
	} else if(categoryNo==2){
		$("#pizza").addClass("active");

	} else if(categoryNo==3){
		$("#bossam").addClass("active");

	} else if(categoryNo==4){
		$("#bunsik").addClass("active");

	} else if(categoryNo==5){
		$("#china").addClass("active");

	} else if(categoryNo==6){
		$("#japan").addClass("active");

	} else if(categoryNo==7){
		$("#korea").addClass("active");

	}
	
});
</script>
<section id="storeInfo-container" class="container">
	<!-- 전체 게시글 출력 -->
	<div class="row">
	
			<c:forEach items="${list }" var="list" varStatus="status">
			
				<c:if test="${list.storeGrade eq 'A'}">
					<div class="card" style="width: 20rem; border : 1px solid #e9fbfa; background-color:#e9fbfa;" ></div>
				</c:if>
				<c:if test="${list.storeGrade eq 'B'}">
					<div class="card" style="width: 20rem; border:1px solid #26d9d0;"></div>
				</c:if>
				<c:if test="${list.storeGrade eq 'C'}">
					<div class="card" style="width: 20rem;"  style="border:red;"></div>
				</c:if>
					<img class="card-img-top" src="" alt="StoreInfo Thumbnail">
					<div class="card-body">
						<h5 class="card-title" style="font-weight: bold;">
							<c:out value="${list.storeName }" />
						</h5>
						<p class="card-text">
							<c:out value="${list.storeIntro }" />
						</p>
					</div>
					
					<ul class="list-group list-group-flush">						
						<c:if test="${list.storeGrade eq 'A'}">
							<li id="storeNo" ><c:out value="${list.storeNo }"></c:out></li>
							<li class="list-group-item" style="border:1px solid #e9fbfa; background-color:#e9fbfa;"><strong>영업시간 </strong> <c:out
									value="${list.operatingHours }" /></li>
							<li class="list-group-item" style="border:1px solid #e9fbfa; background-color:#e9fbfa;"><strong>전화번호 </strong> <c:out
									value="${list.storeTel }" /></li>
							<li class="list-group-item" style="border:1px solid #e9fbfa; background-color:#e9fbfa;"><strong>배달최소금액 </strong> <c:out
									value="${list.deliveryMinPrice }" /></li>
						</c:if>
						
						<c:if test="${list.storeGrade eq 'B'}">
							<li id="storeNo" ><c:out value="${list.storeNo }"></c:out></li>
							<li class="list-group-item" style="border:1px solid #e9fbfa;"><strong>영업시간 </strong> <c:out
									value="${list.operatingHours }" /></li>
							<li class="list-group-item" style="border:1px solid #e9fbfa;"><strong>전화번호 </strong> <c:out
									value="${list.storeTel }" /></li>
							<li class="list-group-item" style="border:1px solid #e9fbfa;"><strong>배달최소금액 </strong> <c:out
									value="${list.deliveryMinPrice }" /></li>
						</c:if>
						
						<c:if test="${list.storeGrade eq 'C'}">
							<li id="storeNo" ><c:out value="${list.storeNo }"></c:out></li>
							<li class="list-group-item" ><strong>영업시간 </strong> <c:out
									value="${list.operatingHours }" /></li>
							<li class="list-group-item" ><strong>전화번호 </strong> <c:out
									value="${list.storeTel }" /></li>
							<li class="list-group-item" ><strong>배달최소금액 </strong> <c:out
									value="${list.deliveryMinPrice }" /></li>
						</c:if>
					</ul>
					<div class="card-body">
						<a class="btn btn-primary" href="${pageContext.request.contextPath }/menu/menuList.do?storeNo=${list.storeNo }">주문하기</a>
					</div>
						
			</c:forEach>
	</div> <!-- div.row -->

	<%
		int totalContents = (int) request.getAttribute("totalContents");
		int numPerPage = (int) request.getAttribute("numPerPage");
		int cPage = (int) request.getAttribute("cPage");
		int categoryNo = (int) request.getAttribute("categoryNo");
	%>
	
	<%=com.kh.god.common.util.Utils.getPerBar(totalContents, cPage, numPerPage,"storeInfoList.do?categoryNo="+categoryNo) %> --%>
		
	<!-- 페이지바  -->
	
<br />	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5f71510449902565d91fe4cae2a1eecd&libraries=services"></script>

<div id="map" style="width:100%;height:350px;"></div>

<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();


//src="${pageContext.request.contextPath}/resources/images/delivery2.gif"
/* var imageSrc = '${pageContext.request.contextPath}/resources/images/pizza.png', // 마커이미지의 주소입니다     */
 var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
 // 마커 이미지의 이미지 크기 입니다
 var imageSize = new daum.maps.Size(24, 35); 
 
 // 마커 이미지를 생성합니다    
 var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 



 
 var result1 = new Array();
<c:forEach items="${storeInfoList}" var = "list">
	var json = new Object();
	json.position = "${list.storeAddress}";
	json.name = "${list.storeName}";
	json.storeNo = "${list.storeNo}";
	result1.push(json);
</c:forEach>
//console.log("dlkajdfa"+JSON.stringify(result));

	
	 var storename = "";
	 var position1 = "";
$.each(result1,function(index,item){

 for(var i in item){
	
	position1 = item.position;
	geocoder.addressSearch(position1, function(result, status) {
	
		 
    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {

        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
        
    
        

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new daum.maps.Marker({
            map: map,
            position: coords,
            image: markerImage
        }); 

        // 인포윈도우로 장소에 대한 설명을 표시합니다
       var infowindow = new daum.maps.InfoWindow({
			
             content: "<div style='width:150px;text-align:center;padding:6px 0;'><a href='${pageContext.request.contextPath}/menu/menuList.do?storeNo="+item.storeNo+"'>"+item.name+"</a></div>" 
            
         
        });
        infowindow.open(map, marker);
 

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
       map.setCenter(coords); 
    } 
			
});   
 
 };
	}); /* for each */

	
$(document).ready(function() {
    



setTimeout("ozit_timer_test()", 3000); // 3000ms(3초)가 경과하면 ozit_timer_test() 함수를 실행합니다.




});
function ozit_timer_test(){

//주소로 좌표를 검색합니다
geocoder.addressSearch('${location}', function(result, status) {

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
            content: '<div style="width:150px;text-align:center;padding:6px 0;">내 위치</div>'
        });
        infowindow.setContent('<div style="width:150px;text-align:center;padding:6px 0;">내 위치</div>');
        infowindow.open(map, marker);
        map.setCenter(coords);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    } 
});    
};

</script>



</section> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>