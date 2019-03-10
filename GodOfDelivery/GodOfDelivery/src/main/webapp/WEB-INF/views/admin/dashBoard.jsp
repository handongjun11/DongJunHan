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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script>
$(function(){
	$("#dashBoard").addClass("active");	
});

$(function(){
	var total = 0;
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/totalCostByMonthly.do",
		type:"post",
		success : function(data){
			$.each(data,function(index,item){
				for(var i in item){
					total +=item[i];
				}
			});
			$("#totalCostByMonthly").text(addComma(total)+"원");
		}
	});
});
function addComma(num) {
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
	}

$(function(){
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(chartByCategoryAmount);
	google.charts.setOnLoadCallback(drawBasic);
	
});
function drawBasic() {
	var one = 0;
	var two = 0;
	var three = 0;
	var four = 0;
	var five = 0;
	var six = 0;
	var seven = 0;
	var eight = 0;
	var month = new Date();
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/timeChart.do?month=now",
		type : "post",
		async:"false",
		success : function(list){
			
			$.each(list,function(index,item){
				
			  for(var i in item){
				  
				  if(item[i] >= 9 && item[i] < 12){
					  one +=1;
				  }else if(item[i] >= 12 && item[i] < 15){
					  two +=1;
				  }else if(item[i] >= 15 && item[i] < 18){
					  three +=1;
				  }else if(item[i] >= 18 && item[i] < 21){
					  four +=1;
				  }else if(item[i] >= 21 && item[i] < 24){
					  five +=1;
				  }else if(item[i] >= 0 && item[i] < 3){
					  six +=1;
				  }else if(item[i] >= 3 && item[i] < 6){
					  seven +=1;
				  }else if(item[i] >= 6 && item[i] < 9){
					  eight +=1;
				  }
			  }
			  
			  var data = new google.visualization.arrayToDataTable([
				  ['시간','판매량',{role:'style'}, { role: 'annotation' } ],
				  ['09-12',one,'#FFF0F5',one],
				  ['12-15',two,'#ADD8E6',two],
				  ['15-18',three,'#E0FFFF',three],
				  ['18-21',four,'#66CDAA',four],
				  ['21-24',five,'#FFE4E1',five],
				  ['24-03',six,'#FFDAB9',six],
				  ['03-06',seven,'#DDA0DD',seven],
				  ['06-09',eight,'#6A5ACD',eight],
				  
			  ]);

			
		      var chart = new google.visualization.ColumnChart(
		        document.getElementById('chart-time'));
		
		      chart.draw(data);
			});/* each end */
		} /* success function end */
      
	}); /* ajax end  */
	
}

/* 이번달 카테고리별 판매량 (파이 차트) */
function chartByCategoryAmount() {

	$.ajax({
		url : "${pageContext.request.contextPath}/admin/chartByCategoryAmount.do",
		type : "post",
		async : "false",
		success : function(data){
			
			  var chartData = google.visualization.arrayToDataTable([
			    ['Category', 'Total Amount'],
			    ['치킨', data.chartByCategoryAmountList[0]],
			    ['피자', data.chartByCategoryAmountList[1]],
			    ['보쌈/족발', data.chartByCategoryAmountList[2]],
			    ['분식', data.chartByCategoryAmountList[3]],
			    ['중식', data.chartByCategoryAmountList[4]],
			    ['일식', data.chartByCategoryAmountList[5]],
			    ['한식', data.chartByCategoryAmountList[6]],
			  ]);

			  var options = {
					chartArea:{top:"20%", left:"10%", width:"100%", height:"100%"},
					is3D: true
			  };

			  var chart = new google.visualization.PieChart(document.getElementById('chartByCategoryAmount'));

			  chart.draw(chartData, options);		
			}
		});
};

$(function(){
	var total = 0;
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/adCostByMonthly.do",
		type:"post",
		success : function(data){
			$.each(data,function(index,item){
				for(var i in item){
					total +=item[i];
				}
			});
			$("#adCostByMonthly").text(addComma(total)+"원");
		}
	});
});
</script>

<!-- Page Wrapper -->
  <div id="wrapper">

    <jsp:include page="/WEB-INF/views/admin/sideBar.jsp"></jsp:include>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">요약</h1>
          </div>

          <!-- Content Row -->
          <div class="row">
          
          	<!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">새로운 가게 신청</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${storePMSCount }건</div>
                        </div>
                        <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="100-${storePMSCount }" aria-valuemin="0" aria-valuemax="100"></div>
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
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">새로운 문의</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">${qnaCount }건</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">이번달 광고 수입</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800" id="adCostByMonthly"></div>
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
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">이번달 판매량</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800" id="totalCostByMonthly"></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

          </div>

          <!-- Content Row -->

          <div class="row">

            <!-- Area Chart -->
            <!-- Bar Chart -->
              <div class="card shadow mb-4" style="width:440px;">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">이번달 시간대별 판매량</h6>
                </div>
                <div class="card-body">
                  <div class="chart-bar" id="chart-time">
                    <canvas id="myBarChart"></canvas>
                  </div>
                  </div>
              </div>
              
              <!-- Pie Chart -->
             <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4" style="width:295px;">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">이번달 카테고리별 판매량</h6>
                </div>
                <div class="card-body">
                  <div class="chart-bar" id="chartByCategoryAmount">
                    
                  </div>
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