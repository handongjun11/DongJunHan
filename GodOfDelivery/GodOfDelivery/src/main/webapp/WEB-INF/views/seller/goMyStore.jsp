<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="배달의 신" name="pageTitle" />
</jsp:include>
<style>
div.timeChart div#hasData{
	/*  display : none;  */
}
</style>
<!-- Custom fonts for this template-->
<link href="${pageContext.request.contextPath }/resources/css/fontawesome-free/css/all.css" rel="stylesheet">

<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.css" rel="stylesheet">


<script>
$(function(){
   $("#dashBoard").addClass("active");   
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
          <div class="d-sm-flex align-items-center justify-content-between mb-4" id="summary">
            <h1 class="h3 mb-0 text-gray-800">요약</h1>
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">일주일 판매량</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">870,000원</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">월간 판매량</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">4,842,000원</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">주문 현황</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">3건</div>
                        </div>
                        <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pending Requests Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">새로운 리뷰</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">2건</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Content Row -->

          <div class="row">

            <!-- Area Chart -->
            <!-- Time Chart -->
              <div class="card shadow mb-4" style="width : 35rem; height : 30rem;">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between" >
                  <h6 class="m-0 font-weight-bold text-primary">시간대별 판매량</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink" id="chartofSaleVolume">
                      <div class="dropdown-header" >Sales volume by period:</div>
                      <div class="dropdown-item" id="totalSaleVolumeofToday" value="today">Today</div>
                      <div class="dropdown-item" id="totalSaleVolumeofWeek" value="week">Week</div>
                      <div class="dropdown-item" id="totalSaleVolumeofMonth" value="month">Month</div>
                      <div class="dropdown-item" id="totalSaleVolumeof3Month" value="3month">Three Month</div>
                    </div>
                  </div>
                </div>
                <!-- card body -->
                <div class="card-body">
                  <div class="timeChart" style="height : 100%;">
						
                  </div>
                  </div>
              </div>

            <!-- Pie Chart -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4" style="width:25rem">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">카테고리별 판매량</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header">카테고리:</div>
                      <a class="dropdown-item" href="#">한식</a>
                      <a class="dropdown-item" href="#">양식</a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="#">분식</a>
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                  <div class="chart-pie pt-4 pb-2">
                    <canvas id="myPieChart"></canvas>
                  </div>
                  <div class="mt-4 text-center small">
                    <span class="mr-2">
                      <i class="fas fa-circle text-primary"></i> 한식
                    </span>
                    <span class="mr-2">
                      <i class="fas fa-circle text-success"></i> 양식
                    </span>
                    <span class="mr-2">
                      <i class="fas fa-circle text-info"></i> 중식
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Content Column -->
            <div class="col-lg-6 mb-4">

              <!-- Project Card Example -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Projects</h6>
                </div>
                <div class="card-body">
                  <h4 class="small font-weight-bold">Server Migration <span class="float-right">20%</span></h4>
                  <div class="progress mb-4">
                    <div class="progress-bar bg-danger" role="progressbar" style="width: 20%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                  <h4 class="small font-weight-bold">Sales Tracking <span class="float-right">40%</span></h4>
                  <div class="progress mb-4">
                    <div class="progress-bar bg-warning" role="progressbar" style="width: 40%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                  <h4 class="small font-weight-bold">Customer Database <span class="float-right">60%</span></h4>
                  <div class="progress mb-4">
                    <div class="progress-bar" role="progressbar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                  <h4 class="small font-weight-bold">Payout Details <span class="float-right">80%</span></h4>
                  <div class="progress mb-4">
                    <div class="progress-bar bg-info" role="progressbar" style="width: 80%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                  <h4 class="small font-weight-bold">Account Setup <span class="float-right">Complete!</span></h4>
                  <div class="progress">
                    <div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                </div>
              </div>

              <!-- Color System -->
              <div class="row">
                <div class="col-lg-6 mb-4">
                  <div class="card bg-primary text-white shadow">
                    <div class="card-body">
                      Primary
                      <div class="text-white-50 small">#4e73df</div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6 mb-4">
                  <div class="card bg-success text-white shadow">
                    <div class="card-body">
                      Success
                      <div class="text-white-50 small">#1cc88a</div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6 mb-4">
                  <div class="card bg-info text-white shadow">
                    <div class="card-body">
                      Info
                      <div class="text-white-50 small">#36b9cc</div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6 mb-4">
                  <div class="card bg-warning text-white shadow">
                    <div class="card-body">
                      Warning
                      <div class="text-white-50 small">#f6c23e</div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6 mb-4">
                  <div class="card bg-danger text-white shadow">
                    <div class="card-body">
                      Danger
                      <div class="text-white-50 small">#e74a3b</div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6 mb-4">
                  <div class="card bg-secondary text-white shadow">
                    <div class="card-body">
                      Secondary
                      <div class="text-white-50 small">#858796</div>
                    </div>
                  </div>
                </div>
              </div>

            </div>

            <div class="col-lg-6 mb-4">

              <!-- Illustrations -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Illustrations</h6>
                </div>
                <div class="card-body">
                  <div class="text-center">
                    <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;" src="img/undraw_posting_photo.svg" alt="">
                  </div>
                  <p>Add some quality, svg illustrations to your project courtesy of <a target="_blank" rel="nofollow" href="https://undraw.co/">unDraw</a>, a constantly updated collection of beautiful svg images that you can use completely free and without attribution!</p>
                  <a target="_blank" rel="nofollow" href="https://undraw.co/">Browse Illustrations on unDraw &rarr;</a>
                </div>
              </div>

              <!-- Approach -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Development Approach</h6>
                </div>
                <div class="card-body">
                  <p>SB Admin 2 makes extensive use of Bootstrap 4 utility classes in order to reduce CSS bloat and poor page performance. Custom CSS classes are used to create custom components and custom utility classes.</p>
                  <p class="mb-0">Before working with this theme, you should become familiar with the Bootstrap framework, especially the utility classes.</p>
                </div>
              </div>

            </div>
          </div>

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

  <!-- Core plugin JavaScript-->
  <script src="${pageContext.request.contextPath}/resources/js/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${pageContext.request.contextPath }/resources/js/sb-admin-2.js"></script>


  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath}/resources/js/demo/chart-bar-demo.js"></script>
  
  <script>
  //그려낼 차트변수
  var chart = null;
  
  $("div[id^=totalSaleVolumeof]").css("cursor","pointer");
  //저번주 판매량데이터 가져옴
  $("div[id^=totalSaleVolumeof]").on('click',function(){
	  var types = $(this).attr("value");
	  //먼저 그려져 있던 차트를 지운 뒤 차트를 그릴 준비를 한다.
	  clearChart();
	  $.ajax({
		  url : "${pageContext.request.contextPath}/chart/totalSaleVolume.do",
		  data : {sellerId : '${sellerLoggedIn.sellerId}',
				  type : types	
		  },
		  success : function(data){
			  if(data.length != 0){ //data가 들어있는지 안들어있는지 검사하고 안들어있으면 현재 판매량이 없다고 보여줌.
	  		  	google.charts.load('current', {'packages':['corechart']});
	  		  	google.charts.setOnLoadCallback(drawChart(data,types));
			  }else{
				  var noData = $("<span id='hasData' style='position : relative; left : 8rem; top : 10rem;'><i class='far fa-dizzy'></i>&nbsp이런 아직 판매량이 없습니다!</span>");
				  $(".timeChart").html(noData);
			  }
		  },
		  erorr : function(jqxhr,textStatus,errorTrown){
	 			console.log("종합보기의  판매량을 가져오는 중 에러 남!");
				console.log(jqxhr);
				console.log(textStatus);
				console.log(errorTrown);
	 		}
	  });//end of ajax
	  
  });//end of totalSaleVolume click
  
  
  //이미 그려져 있는 차트를 지운다.
  function clearChart(){
	  if(chart != null){
	 	 chart.clearChart();
	  }
  }
  //판매량 차트 그리기
  function drawChart(data,types){
	  if(types === 'week'){
		//금액 초기화
		  //각 요일별 총금액
		  var storeName = [];
		  storeName = storeNameArr(data);
		  makeArray(storeName.length);
		  for(var i in data){
			  var sale = data[i];
	          var week = sale.ORDERDAY;
	          var totalPrice = parseInt(sale.TOTALPRICE);
				  for(var i = 0; i < day.length; i++){
					  if(storeName[i] != sale.STORENAME){
					
					  }else{
						  if(week === '월'){
							  day[i][0] = 0;
							  day[i][0] += totalPrice;
						  }else if(week === '화'){
							  day[i][1] = 0;
							  day[i][1] += totalPrice;
						  }else if(week === '수'){
							  day[i][2] = 0;
							  day[i][2] += totalPrice; 
						  }else if(week === '목'){
							  day[i][3] = 0;
							  day[i][3] += totalPrice;
						  }else if(week === '금'){
							  day[i][4] = 0;
							  day[i][4] += totalPrice;
						  }else if(week === '토'){
							  day[i][5] = 0;
							  day[i][5] += totalPrice;
						  }else if(week === '일'){
							  day[i][6] = 0;
							  day[i][6] += totalPrice;
						  } 
						  break;
					  }
				  }//end of for
				  
			  
		  }// end of for in
		  //2차 배열 생성
		  var info = [];
		  for(var i = 0; i < 8; i++){
			  info[i] = new Array();
		  }
		  for(var j = 0; j < 2; j++){
			  //처음은 카테고리가 들어갈 배열
			  if(j == 0){
				 info[0][0] = 'week';	 			 
				  for(var i = 0; i < storeName.length; i++){
					  	info[0][i+1] = storeName[i];
			 	 }//end of for
			  }else{
				  info[1][0] = 'Mon';
				  info[2][0] = 'Tues';
				  info[3][0] = 'Wed';
				  info[4][0] = 'Thurs';
				  info[5][0] = 'Fri';
				  info[6][0] = 'Satur';
				  info[7][0] = 'Sun';
					
				  for(var i = 0; i < storeName.length; i++){
					for(var k = 1; k < info.length; k++){
					 if(day[i][(k-1)] > 0){
					  	info[k][(i+1)] = 0;
					  	info[k][(i+1)] += day[i][k-1];
						 
					 }else{
					  	info[k][(i+1)] = 0;
					 }
				  }
				}
				 
			  }
			  console.log(info);
		  }//end of for
	  }else if(types === 'today'){
		  //시간대별 판매량으로서 3시간씩 끊어서 나타낼 예정임  ex) time0는 0시부터 3시, time1 : 3시~6시
			var storeName = [];
			storeName = storeNameArr(data);
			makeArray(storeName.length);
		 
			  
		  for(var i in data){
			  var sale = data[i];
			  var totalPrice = parseInt(sale.TOTALPRICE);
	          var hour = parseInt(sale.ORDERDAY);
				  for(var i = 0; i < storeName.length; i++){
					  if(storeName[i] != sale.STORENAME){
					  }else{
						  for(var k = 0; k < 24; k++){
							  if(hour == k){
								  day[i][k] = 0;
								  day[i][k] += totalPrice;
							  }
						  }
						 /*  if(hour >= 0 && hour < 3){
							  day[i] += totalPrice;
						  }else if(hour >= 3 && hour < 3){
							  day[i] += totalPrice;
						  }else if(hour >= 6 && hour < 9){
							  day[i] += totalPrice; 
						  }else if(hour >= 9 && hour < 12){
							  day[i] += totalPrice;
						  }else if(hour >= 12 && hour < 15){
							  day[i] += totalPrice;
						  }else if(hour >= 15 && hour < 18){
							  day[i] += totalPrice;
						  }else if(hour >= 18 && hour < 21){
							  day[i] += totalPrice;
						  }else if(hour >= 21 && hour <= 23){
							  day[i] += totalPrice;
						  } */
						  break;
					  }
				  }//end of for
		  }// end of for in
		  //2차 배열 생성
		  var info = [];
		  for(var i = 0; i < 25; i++){
			  info[i] = new Array();
		  }
		  
			  //처음은 카테고리가 들어갈 배열
			  
				 info[0][0] = 'Time';	 			 
				  for(var i = 0; i < storeName.length; i++){
					  	info[0][i+1] = storeName[i];
			 	 }//end of for
		console.log(info);
				  for(var i = 0; i < storeName.length; i++){
					  for(var j = 1; j < info.length; j++){
						  if((j-1) < 10){
						  	info[j][0] = "0"+(j-1)+":00 ~ 0"+(j)+":00";
						  }else{
							info[j][0] = (j-1)+":00 ~ "+(j)+":00";
						  }
						//  console.log(info);
						  if(day[i][(j-1)] > 0){
							  info[j][(i+1)] = 0;
							  info[j][(i+1)] = day[i][(j-1)];
						  }else{
							  info[j][(i+1)] = 0;
						  }
					  }
				  }
				 
			
			  
		
	  }else if(types === 'month'){
		  //day = []
		  var storeName = [];
		  storeName = storeNameArr(data);
		  makeArray(storeName.length);
		  console.log(day);
		  for(var i in data){
			  var sale = data[i];
	          var date = parseInt((sale.ORDERDAY).substr(3));
	          var totalPrice = parseInt(sale.TOTALPRICE);
				  for(var i = 0; i < day.length; i++){
					  if(storeName[i] != sale.STORENAME){
					
					  }else{
						  day[i][date] = 0;
						  day[i][date] += totalPrice;
						  break;
					  }
				  }//end of for
				  
			  
		  }// end of for in
		  //2차 배열 생성
		  var info = [];
		  for(var i = 0; i < 32; i++){
			  info[i] = new Array();
		  }
			 
		//처음은 카테고리가 들어갈 배열
		info[0][0] = 'Day';	 			 
		 for(var i = 0; i < storeName.length; i++){
		  	info[0][i+1] = storeName[i];
		 	for(var k = 1; k <= 31; k++ ){
			  info[k][0] = k+'일';
			  if(day[i][k] > 0){
			  	//console.log(day[i][k]+" i: "+i+" k: "+k +" i+1:"+(i+1));
				  info[k][i+1] = day[i][k];
			  }else{
				  info[k][i+1] = 0;
			  }
		  
		 	}
			}//end of for
				
		
			  
		  
		 // console.log(info);
	  }else if(types === '3month'){
		  var storeName = [];
		  storeName = storeNameArr(data);
		  makeArray(storeName.length);
		   var date = new Date();
		   var time =  (date.getMonth() + 1, 2);
		   console.log("시간 : "+time);
		  for(var i in data){
			  var sale = data[i];
	          var month = parseInt((sale.ORDERDAY));
	          console.log(month);
	          var totalPrice = parseInt(sale.TOTALPRICE);
				  for(var i = 0; i < day.length; i++){
					  if(storeName[i] != sale.STORENAME){
					
					  }else{
						  day[i][month] = 0;
						  day[i][month] += totalPrice;
						  break;
					  }
				  }//end of for
				  
			  
		  }// end of for in
		  //2차 배열 생성
		  var info = [];
		  for(var i = 0; i < 4; i++){
			  info[i] = new Array();
		  }
			 
		//처음은 카테고리가 들어갈 배열
		info[0][0] = 'Month';	 			 
		 for(var i = 0; i < storeName.length; i++){
		  	info[0][i+1] = storeName[i];
		 	for(var k = 3; k > 0; k-- ){
		 		if(time == 1){
		 		if(time-k == 0){
		 			info[4-k][0] = '12월';
		 		}else if(time-k == -2){
		 			info[4-k][0] = '11월';
		 		}else if((time-k) == -2){
		 			info[4-k][0] = '10월';
		 		}else{
					info[4-k][0] = (time-k)+'월';
		 			
		 		}
		 		}else if(time == 2 ){
		 			if(time-k == -1){
			 			info[4-k][0] = '12월';
			 		}else if(time-k == 0){
			 			info[4-k][0] = '1월';
			 		}else{
			 			info[4-k][0] = (time)+'월';
			 		}
		 		}else{
		 			info[4-k][0] = (time-(k-1))+'월';
		 		}
			  if(day[i][k] > 0){
			  	//console.log(day[i][k]+" i: "+i+" k: "+k +" i+1:"+(i+1));
				  info[4-k][i+1] = day[i][k];
			  }else{
				  info[4-k][i+1] = 0;
			  }
		  
		 	}
			}//end of for
			console.log(info);
	  }//end of types If
	  
	 
	  // Some raw data (not necessarily accurate) 2차 배열 형태로 넣어야함.
	    var chartData = google.visualization.arrayToDataTable(info);
	    var options = {
	      title : types+' Store Sale volume',
	      vAxis: {title: 'Sale Price'},
	      hAxis: {title: 'Time'}
	      //seriesType: 'line'
	     // series: {2: {type: 'line'}}
	    };

	    chart = new google.visualization.LineChart($(".timeChart")[0]);
	    chart.draw(chartData, options);
		  
	  
  }//end of drawChat
  
  google.charts.load('current', {'packages':['corechart']});
  window.onload=function(){
	  var storeInfo = new Array();
	    <c:forEach items="${saleVolume}" var="info">
	    	var json = new Object();
	    	json.originalPrice = '${info.originalPrice}';
	    	json.STORENAME = '${info.STORENAME}';
	    	json.storeNo = '${info.STORENO}';
	    	json.TOTALPRICE = '${info.TOTALPRICE}';
	    	json.ORDERDAY = '${info.ORDERDAY}';
	    	json.SELLERID = '${info.SELLERID}';
	    	storeInfo.push(json);
	    </c:forEach>
	    console.log(storeInfo);
  if(storeInfo.length > 0){
	  google.charts.setOnLoadCallback(drawChart(storeInfo,'today'));
  }else{
	  var noData = $("<span id='hasData' style='position : relative; left : 8rem; top : 10rem;'><i class='far fa-dizzy'></i>&nbsp이런 아직 판매량이 없습니다!</span>");
	  $(".timeChart").html(noData);
  }
  }
  
  
	var day = [];
	
	function storeNameArr(data){
		var storeName = [];
		  var storeNameFlag = false;
		  //배열의 길이를 동적으로 만들기 위한 거
		  for(var i in data){
			  var sale = data[i];
			  if(storeName.length == 0){
				  storeName[0] = sale.STORENAME;
			  }else{
				  for(var i = 0; i < storeName.length; i++){
					  if(storeName[i] != sale.STORENAME){
						  storeNameFlag = true;
					  }else{
						  storeNameFlag = false;
						  break;
					  }
				  }
				  
		  	  }
			  if(storeNameFlag == true){
				  storeName[storeName.length] = sale.STORENAME;
				  console.log(storeName);
			  }
		  }
		  return storeName;
	}
	
	function makeArray(length){
		//2차 배열 만듬.
		  for(var i = 0; i < length; i++){
			  day[i] = new Array();
		  }
		return day;
	}
  </script>