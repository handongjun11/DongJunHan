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

<!-- 구글차트 API -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<!-- DatePicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
$(function(){
	$("#chart").addClass("active");	
});

/* 카테고리별 판매량 (파이 차트) */
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChartByCategory);

function drawChartByCategory() {


	var data0 = ${chartByCategoryList[0]};
	var data1 = ${chartByCategoryList[1]};
	var data2 = ${chartByCategoryList[2]};
	var data3 = ${chartByCategoryList[3]};
	var data4 = ${chartByCategoryList[4]};
	var data5 = ${chartByCategoryList[5]};
	var data6 = ${chartByCategoryList[6]};


  var data = google.visualization.arrayToDataTable([
	    ['Category', 'Total Price'],
	    ['치킨', data0],
	    ['피자', data1],
	    ['보쌈/족발', data2],
	    ['분식',data3],
	    ['중식', data4],
	    ['일식', data5],
	    ['한식', data6],

  ]);

  var options = {
  };

  var chart = new google.visualization.PieChart(document.getElementById('chartByCategory'));

  chart.draw(data, options);
}


/* 일주일 판매량 */
/* 일주일 판매량 DatePicker*/
$(function(){
	var startDate;
    var endDate;
    
    $('#weeklyDatePicker').datepicker( {
    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        showOtherMonths: true,
        selectOtherMonths: true,
		selectWeek:true,
		maxDate : 0,
        onSelect: function(dateText, inst) { 
            var date = $(this).datepicker('getDate');
            startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
            endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
			var dateFormat = 'yy/mm/dd'
            startDate = $.datepicker.formatDate( dateFormat, startDate, inst.settings );
            endDate = $.datepicker.formatDate( dateFormat, endDate, inst.settings );

			$('#weeklyDatePicker').val(startDate + '~' + endDate);
            
            setTimeout("applyWeeklyHighlight()", 100);
        },
		beforeShow : function() {
			setTimeout("applyWeeklyHighlight()", 100);
		},
		onChangeMonthYear: function(year, month, widget) {
			setTimeout("applyWeeklyHighlight()", 100);
		}
    });
});

function applyWeeklyHighlight() {

	$('.ui-datepicker-calendar tr').each(function() {

		if ($(this).parent().get(0).tagName == 'TBODY') {
			$(this).mouseover(function() {
				$(this).find('a').css({
					'background' : '#ffffcc',
					'border' : '1px solid #dddddd'
				});
				$(this).find('a').removeClass('ui-state-default');
				$(this).css('background', '#ffffcc');
			});
			
			$(this).mouseout(function() {
				$(this).css('background', '#ffffff');
				$(this).find('a').css('background', '');
				$(this).find('a').addClass('ui-state-default');
			});
		}

	});
}

/* 일주일 판매량 ajax*/
$(function(){
	$('#btnByWeek').on("click", function(){
		
		var weeklyStartDate = $("#weeklyDatePicker").val().substring(0, 10);
		var weeklyEndDate = $("#weeklyDatePicker").val().substring(11, 21);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/chartByWeek.do?weeklyStartDate="+weeklyStartDate+"&weeklyEndDate="+weeklyEndDate,
			type : "post",
			async:"false",
			success : function(data){
				
				google.charts.setOnLoadCallback(drawChartByWeek);

				function drawChartByWeek(){

					// 차트 데이터
					var chartData = new google.visualization.arrayToDataTable([
						['요일', '치킨', '피자', '보쌈/족발', '분식', '중식', '일식', '한식'], 
						['월', data.chartByWeekList[0], data.chartByWeekList[1], data.chartByWeekList[2], data.chartByWeekList[3], data.chartByWeekList[4], data.chartByWeekList[5], data.chartByWeekList[6]],
						['화', data.chartByWeekList[7], data.chartByWeekList[8], data.chartByWeekList[9], data.chartByWeekList[10], data.chartByWeekList[11], data.chartByWeekList[12], data.chartByWeekList[13]],
						['수', data.chartByWeekList[14], data.chartByWeekList[15], data.chartByWeekList[16], data.chartByWeekList[17], data.chartByWeekList[18], data.chartByWeekList[19], data.chartByWeekList[20]],
						['목', data.chartByWeekList[21], data.chartByWeekList[22], data.chartByWeekList[23], data.chartByWeekList[24], data.chartByWeekList[25], data.chartByWeekList[26], data.chartByWeekList[27]],
						['금', data.chartByWeekList[28], data.chartByWeekList[29], data.chartByWeekList[30], data.chartByWeekList[31], data.chartByWeekList[32], data.chartByWeekList[33], data.chartByWeekList[34]],
						['토', data.chartByWeekList[35], data.chartByWeekList[36], data.chartByWeekList[37], data.chartByWeekList[38], data.chartByWeekList[39], data.chartByWeekList[40], data.chartByWeekList[41]],
						['일', data.chartByWeekList[42], data.chartByWeekList[43], data.chartByWeekList[44], data.chartByWeekList[45], data.chartByWeekList[46], data.chartByWeekList[47], data.chartByWeekList[48]],
					]);
					
					var chart_options = {
						width : 700,
						height : 400,
						bar : {
							groupWidth : '50%'
						},
						isStacked : true // 그래프 쌓기(스택), 기본값은 false
					};

					var chart = new google.visualization.ColumnChart(document.getElementById('chartByWeek'));
					chart.draw(chartData, chart_options);
				}
			}
		});
	})
});

</script>

<style>
input#btnYear{float : right;}
input#getYear{float : right;}
</style>

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
          <h1 class="h3 mb-4 text-gray-800">통계</h1>
          
          <!-- 카테고리별 판매량 (파이 차트) -->
          <div class="card shadow mb-4" style="width:740px">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">카테고리별 판매량</h6>
            </div>
            <div class="card-body">
              <div id="chartByCategory" style="width:700px; height:300px;"></div>
            </div>
          </div>
          
          <div class="card shadow mb-4" style="width:740px">
            <div class="card-header py-3" style="display:inline-block;">
              <h6 class="m-0 font-weight-bold text-primary" style="display:inline-block;">월별 판매량</h6>
              <input type="button" id="btnYear" class="btn-light btn-sm" value="검색" />
              <input type="text" id="getYear" placeholder="ex)2018" />
            </div>
            <div class="card-body">
              <div id="chartByMonth" style="width:700px; height:300px;"></div>
            </div>
          </div>
		  
		  <div class="card shadow mb-4" style="width:740px">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">일주일 판매량</h6>
            </div>
            <div class="card-body" style="text-align:center;">
              <input class="form-control" type='text' id='weeklyDatePicker' placeholder="Select Week" style="width:210px; display:inline-block"/>
              <button type="button" class="btn btn-light" id="btnByWeek">조회</button>
              <div id="chartByWeek" style="width:700px; height:400px;"></div>
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

  <script>
  $(function(){
	  

  $("#btnYear").on("click",function(){
		
	  var year = $("#getYear").val();
	  google.charts.load("current", {packages:["corechart", 'bar']});
	  google.charts.setOnLoadCallback(drawByMonthChart);
 
	  function drawByMonthChart(){
	  	var month1 = 0;
	  	var month2 = 0;
	  	var month3 = 0;
	  	var month4 = 0;
	  	var month5 = 0;
	  	var month6 = 0;
	  	var month7 = 0;
	  	var month8 = 0;
	  	var month9 = 0;
	  	var month10 = 0;
	  	var month11 = 0;
	  	var month12 = 0;
		
	  	$.ajax({
	  		url : "${pageContext.request.contextPath}/admin/chartByMonth.do?year="+year,
	  		type : "post",
	  		async : "false",
	  		success : function(list){

	 			$.each(list,function(index,item){
	 				
	 				for(var i in item){
	 					if(item[i] == 01){
	 						month1 +=1;
	 					}else if(item[i]==02){
	 						month2 +=1;
	 					}else if(item[i]==03){
	 						month3 +=1;
	 					}else if(item[i]==04){
	 						month4 +=1;
	 					}else if(item[i]==05){
	 						month5 +=1;
	 					}else if(item[i]==06){
	 						month6 +=1;
	 					}else if(item[i]==07){
	 						month7 +=1;
	 					}else if(item[i]==08){
	 						month8 +=1;
	 					}else if(item[i]==09){
	 						month9 +=1;
	 					}else if(item[i]==10){
	 						month10 +=1;
	 					}else if(item[i]==11){
	 						month11 +=1;
	 					}else if(item[i]==12){
	 						month12 +=1;
	 					}
	 				} /* for end */
	 				
	  			var data= new google.visualization.arrayToDataTable([
		  			 ['Month', 'Quantity',{role:'style'}],
		  	          ['01',  month1,'#6B8E23'],
		  	          ['02',  month2,'#DA70D6'],
		  	          ['03',  month3,'#66CDAA'],
		  	          ['04',  month4,'#20B2AA'],
		  	          ['05',  month5,'#ADD8E6'],
		  	          ['06',  month6,'#6495ED'],
		  	          ['07',  month7,'#8B008B'],
		  	          ['08',  month8,'#008B8B'],
		  	          ['09',  month9,'#000080'],
		  	          ['10',  month10,'#483D8B'],
		  	          ['11',  month11,'#2F4F4F'],
		  	          ['12',  month12,'#8B4513']
	  			]);

	  	        var options = {
	  	        		title: year+'년도 월별 판매량',
	  	              chartArea: {width: '70%'},
	  	              hAxis: {
	  	                title: 'Month',
	  	                minValue: 0
	  	              },
	  	              vAxis: {
	  	                title: 'Quantity'
	  	              }
	  	        };

	  	        var chart = new google.visualization.LineChart(document.getElementById('chartByMonth'));
	  	        $("#searchYear").show();
	  	        chart.draw(data, options);
	  		}); /* each end */
	  	}/* success end */

	  	});/* ajax end */
	  }/* function end  */
  }); /* btn click end */
  
  }); /* onload function end */
  </script>

