<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<!-- DatePicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(function(){
	var storeNo = "${param.storeNo}"
	$("#collapse"+storeNo).addClass("show");
	$("#collapse"+storeNo).parent("li").addClass("active");	
	$("#collapse"+storeNo+">div>a.myChart").addClass("active");	
});


</script>
		<div id="wrapper">

	<jsp:include page="/WEB-INF/views/seller/sideBar.jsp"></jsp:include>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          
          <h1 class="h3 mb-4 text-gray-800" >통계</h1>
           </div>
           
           <div class="card-header py-3">
           </div>
           
           <div class="row" style="margin : 1rem;">
           <div class="card shadow mb-4" style="width : 35rem; height : 30rem;">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between" >
                  <h6 class="m-0 font-weight-bold text-primary" id="saleVolumeTitle">기간별 판매량</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                     <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink" id="chartofSaleVolume">
                      <div class="dropdown-header" >Sales volume by period:</div>
                      <div class="dropdown-item" id="totalSaleVolumeofWeek" value="week">Week</div>
                      <div class="dropdown-item" id="totalSaleVolumeofMonth" value="month">Month</div>
                      <div class="dropdown-item" id="totalSaleVolumeof3Month" value="3month">Three Month</div>
                    </div> 
                  </div> 
                </div>
                <!-- card body -->
                <div class="card-body" id="saleVolumeBody" style="text-align : center;" value="saleVolume">
                 <input class='form-control' type='text' id='weeklyDatePicker' placeholder='Select Week' readonly style="width:15rem; display :none;"/>&nbsp
                 <button type='button' class='btn btn-light' id='btnByWeek' value="week" style="display : none;">조회</button>
                 <input class='form-control' type='text' id='monthlyDatePicker' placeholder='Select Month' readonly style="width:15rem; display :none;"/>&nbsp
                 <button type='button' class='btn btn-light' id='btnByMonth' value="month" style="display : none;">조회</button>
                 <input class='form-control' type='text' id='3monthlyDatePicker' placeholder='Select End Month' readonly style="width:15rem; display :none;"/>&nbsp
                 <button type='button' class='btn btn-light' id='btnBy3Month' value="3month" style="display : none;">조회</button>
                 <div class='timeChart' style='height : 90%;'></div>
                  </div>
              </div>
             
       
         <div class="col-xl-4 col-lg-5">
           <div class="card shadow mb-4" style="width : 35rem; height : 30rem;">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between" >
                  <h6 class="m-0 font-weight-bold text-primary" id="saleVolumeTitleOfMember">회원/비회원 판매량</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                     <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink" id="chartofSaleVolume">
                      <div class="dropdown-header" >Sales volume by period:</div>
                      <div class="dropdown-item" id="memberSaleVolumeofWeek" value="week">Week</div>
                      <div class="dropdown-item" id="memberSaleVolumeofMonth" value="month">Month</div>
                      <div class="dropdown-item" id="memberSaleVolumeof3Month" value="3month">Three Month</div>
                    </div> 
                  </div> 
                </div>
                <!-- card body -->
                <div class="card-body" id="saleVolumeBodyOfMember" style="text-align : center;" value="saleVolumeOfMember">
                 <input class='form-control' type='text' id='weeklyDatePickerOfMember' placeholder='Select Week' readonly style="width:15rem; display :none;"/>&nbsp
                 <button type='button' class='btn btn-light' id='btnFromMemberWeek' value="week" style="display : none;">조회</button>
                 <input class='form-control' type='text' id='monthlyDatePickerOfMember' placeholder='Select Month' readonly style="width:15rem; display :none;"/>&nbsp
                 <button type='button' class='btn btn-light' id='btnFromMemberMonth' value="month" style="display : none;">조회</button>
                 <input class='form-control' type='text' id='3monthlyDatePickerOfMember' placeholder='Select End Month' readonly style="width:15rem; display :none;"/>&nbsp
                 <button type='button' class='btn btn-light' id='btnFromMember3Month' value="3month" style="display : none;">조회</button>
                 <div class='timeChartOfMember' style='height : 90%;'></div>
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
<script>
var chart = null;
google.charts.load('current', {'packages':['corechart']});
var chartData;
$("div[id^=totalSaleVolumeof]").css("cursor","pointer");
$("div[id^=memberSaleVolumeof]").css("cursor","pointer");
//일반 판매량에서 기간을 선택시 발생하는 이벤트
$("div[id^=memberSaleVolumeof]").on('click',function(){
	clearChart();
	$("#saleVolumeTitleOfMember").text(($(this).text())+" (회원/비회원) 판매량");
	if($(this).text() === 'Week'){
		$("#weeklyDatePickerOfMember").css("display","inline-block");
		$("#btnFromMemberWeek").css("display","inline");
		$("#monthlyDatePickerOfMember").css("display","none");
		$("#btnFromMemberMonth").css("display","none");
		$("#3monthlyDatePickerOfMember").css("display","none");
		$("#btnFromMember3Month").css("display","none");
		$("#weeklyDatePickerOfMember").val("");
		$("#monthlyDatePickerOfMember").val("");
		$("#3monthlyDatePickerOfMember").val("");
	}else if($(this).text() === 'Month'){
		$("#weeklyDatePickerOfMember").css("display","none");
		$("#btnFromMemberWeek").css("display","none");
		$("#monthlyDatePickerOfMember").css("display","inline-block");
		$("#btnFromMemberMonth").css("display","inline-block");
		$("#3monthlyDatePickerOfMember").css("display","none");
		$("#btnFromMember3Month").css("display","none");
		$("#weeklyDatePickerOfMember").val("");
		$("#monthlyDatePickerOfMember").val("");
		$("#3monthlyDatePickerOfMember").val("");
	}else{
		$("#weeklyDatePickerOfMember").css("display","none");
		$("#btnFromMemberWeek").css("display","none");
		$("#monthlyDatePickerOfMember").css("display","none");
		$("#btnFromMemberMonth").css("display","none");
		$("#3monthlyDatePickerOfMember").css("display","inline-block");
		$("#btnFromMember3Month").css("display","inline-block");
		$("#weeklyDatePickerOfMember").val("");
		$("#monthlyDatePickerOfMember").val("");
		$("#3monthlyDatePickerOfMember").val("");
	}
});
//회원/비회원에대한 기간을 선택시 발생하는 이벤트
$("div[id^=totalSaleVolumeof]").on('click',function(){
	clearChart();
	$("#saleVolumeTitle").text(($(this).text())+" 판매량");
	if($(this).text() === 'Week'){
		$("#weeklyDatePicker").css("display","inline-block");
		$("#btnByWeek").css("display","inline");
		$("#monthlyDatePicker").css("display","none");
		$("#btnByMonth").css("display","none");
		$("#3monthlyDatePicker").css("display","none");
		$("#btnBy3Month").css("display","none");
		$("#weeklyDatePicker").val("");
		$("#monthlyDatePicker").val("");
		$("#3monthlyDatePicker").val("");
	}else if($(this).text() === 'Month'){
		$("#weeklyDatePicker").css("display","none");
		$("#btnByWeek").css("display","none");
		$("#monthlyDatePicker").css("display","inline-block");
		$("#btnByMonth").css("display","inline-block");
		$("#3monthlyDatePicker").css("display","none");
		$("#btnBy3Month").css("display","none");
		$("#weeklyDatePicker").val("");
		$("#monthlyDatePicker").val("");
		$("#3monthlyDatePicker").val("");
	}else{
		$("#weeklyDatePicker").css("display","none");
		$("#btnByWeek").css("display","none");
		$("#monthlyDatePicker").css("display","none");
		$("#btnByMonth").css("display","none");
		$("#3monthlyDatePicker").css("display","inline-block");
		$("#btnBy3Month").css("display","inline-block");
		$("#weeklyDatePicker").val("");
		$("#monthlyDatePicker").val("");
		$("#3monthlyDatePicker").val("");
	}
});

//일반 판매량data를 가져온다.
$('button[id^=btnBy]').on("click", function(){
	var startDate;
	var endDate;
	var type = $("#saleVolumeBody").attr("value");
		$("#hasData").css("display","none");
		if($(this).attr("value") === 'week'){
		startDate = $("#weeklyDatePicker").val().substring(0, 10);
		endDate = $("#weeklyDatePicker").val().substring(11, 21);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/seller/chartByPeriod.do?startDate="+startDate+"&endDate="+endDate+"&storeNo="+'${storeNo}&type='+type,
			type : "post",
			success : function(data){
				if(data.length != 0){ //data가 들어있는지 안들어있는지 검사하고 안들어있으면 현재 판매량이 없다고 보여줌.
		  		  	google.charts.setOnLoadCallback(drawChart(data,'week'));
				  }else{
					  var noData = $("<span id='hasData' style='position : relative; left : 8rem; top : 10rem; display : inline;'><i class='far fa-dizzy'></i>&nbsp이런 아직 판매량이 없습니다!</span>");
					  $(".timeChart").html(noData);
				  }
			}
	     
		});//end of ajax by week
		}else if($(this).attr("value") === 'month'){
			startDate = $("#monthlyDatePicker").val().substring(0, 10);
			endDate = $("#monthlyDatePicker").val().substring(11, 21);
			$.ajax({
				url : "${pageContext.request.contextPath}/seller/chartByPeriod.do?startDate="+startDate+"&endDate="+endDate+"&storeNo="+'${storeNo}&type='+type,
				type : "post",
				success : function(data){
					if(data.length != 0){ //data가 들어있는지 안들어있는지 검사하고 안들어있으면 현재 판매량이 없다고 보여줌.
			  		  	google.charts.setOnLoadCallback(drawChart(data,'month'));
					  }else{
						  var noData = $("<span id='hasData' style='position : relative; left : 8rem; top : 10rem; display : inline;'><i class='far fa-dizzy'></i>&nbsp이런 아직 판매량이 없습니다!</span>");
						  $(".timeChart").html(noData);
					  }
				}
		     
			});//end of ajax by month
			
		}else{
			startDate = $("#3monthlyDatePicker").val().substring(0, 10);
			endDate = $("#3monthlyDatePicker").val().substring(11, 21);
			$.ajax({
				url : "${pageContext.request.contextPath}/seller/chartByPeriod.do?startDate="+startDate+"&endDate="+endDate+"&storeNo="+'${storeNo}&type='+type,
				type : "post",
				success : function(data){
					if(data.length != 0){ //data가 들어있는지 안들어있는지 검사하고 안들어있으면 현재 판매량이 없다고 보여줌.
			  		  	google.charts.setOnLoadCallback(drawChart(data,'3month'));
					  }else{
						  var noData = $("<span id='hasData' style='position : relative; left : 8rem; top : 10rem; display : inline;'><i class='far fa-dizzy'></i>&nbsp이런 아직 판매량이 없습니다!</span>");
						  $(".timeChart").html(noData);
					  }
				}
		     
			});//end of ajax by 3month
			
		}
});
// (회원/비회원)에 대한 기간별 판매량data를 가져온다.
$('button[id^=btnFromMember]').on("click", function(){
	var startDate;
	var endDate;
	var type = $("#saleVolumeBodyOfMember").attr("value");
		$("#hasDataOfMemer").css("display","none");
		if($(this).attr("value") === 'week'){
		startDate = $("#weeklyDatePickerOfMember").val().substring(0, 10);
		endDate = $("#weeklyDatePickerOfMember").val().substring(11, 21);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/seller/chartByPeriod.do?startDate="+startDate+"&endDate="+endDate+"&storeNo="+'${storeNo}&type='+type,
			type : "post",
			success : function(data){
				if(data.length != 0){ //data가 들어있는지 안들어있는지 검사하고 안들어있으면 현재 판매량이 없다고 보여줌.
		  		  	google.charts.setOnLoadCallback(drawChart(data,'week'));
				  }else{
					  var noData = $("<span id='hasDataOfMember' style='position : relative;  top : 9rem; display : inline;'><i class='far fa-dizzy'></i>&nbsp이런 아직 판매량이 없습니다!</span>");
					  $(".timeChartOfMember").html(noData);
				  }
			}
	     
		});//end of ajax by week
		}else if($(this).attr("value") === 'month'){
			startDate = $("#monthlyDatePickerOfMember").val().substring(0, 10);
			endDate = $("#monthlyDatePickerOfMember").val().substring(11, 21);
			$.ajax({
				url : "${pageContext.request.contextPath}/seller/chartByPeriod.do?startDate="+startDate+"&endDate="+endDate+"&storeNo="+'${storeNo}&type='+type,
				type : "post",
				success : function(data){
					if(data.length != 0){ //data가 들어있는지 안들어있는지 검사하고 안들어있으면 현재 판매량이 없다고 보여줌.
			  		  	google.charts.setOnLoadCallback(drawChart(data,'month'));
					  }else{
						  var noData = $("<span id='hasData' style='position : relative; left : 8rem; top : 10rem; display : inline;'><i class='far fa-dizzy'></i>&nbsp이런 아직 판매량이 없습니다!</span>");
						  $(".timeChart").html(noData);
					  }
				}
		     
			});//end of ajax by month
			
		}else{
			startDate = $("#3monthlyDatePickerOfMember").val().substring(0, 10);
			endDate = $("#3monthlyDatePickerOfMember").val().substring(11, 21);
			$.ajax({
				url : "${pageContext.request.contextPath}/seller/chartByPeriod.do?startDate="+startDate+"&endDate="+endDate+"&storeNo="+'${storeNo}&type='+type,
				type : "post",
				success : function(data){
					if(data.length != 0){ //data가 들어있는지 안들어있는지 검사하고 안들어있으면 현재 판매량이 없다고 보여줌.
			  		  	google.charts.setOnLoadCallback(drawChart(data,'3month'));
					  }else{
						  var noData = $("<span id='hasData' style='position : relative; left : 8rem; top : 10rem; display : inline;'><i class='far fa-dizzy'></i>&nbsp이런 아직 판매량이 없습니다!</span>");
						  $(".timeChart").html(noData);
					  }
				}
		     
			});//end of ajax by 3month
			
		}
});
//현재 들어온 가게의 이름을 담는 변수.
var storeNameForOne = "";
window.onload=function(){
    // 페이지가 로딩된 후 실행해야 되는 코드를 추가한다.
     var storeInfo = new Array();
	    <c:forEach items="${saleVolume}" var="info">
	    	var json = new Object();
	    	json.originalPrice = '${info.originalPrice}';
	    	json.STORENAME = '${info.STORENAME}';
	    	json.storeNo = '${info.STORENO}';
	    	json.TOTALPRICE = '${info.TOTALPRICE}';
	    	json.ORDERDAY = '${info.ORDERDAY}';
	    	storeInfo.push(json);
	    </c:forEach>
    	storeNameForOne = storeInfo[0].STORENAME;
		if(storeInfo[0].originalPrice === 'noData'){
			var noData = $("<span id='hasData' style='position : relative;  top : 7rem; display : inline; '><i class='far fa-dizzy'></i>&nbsp이런 아직 판매량이 없습니다!</span>");
			$(".timeChart").html(noData);
		}else{
			//console.log(storeInfo);
			google.charts.setOnLoadCallback(drawChart(storeInfo,'today'));
		}
}
$(function(){
	var startDate;
    var endDate;
    	$("input[id^=weeklyDatePicker]").datepicker({
        	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
            monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            showOtherMonths: true,
            selectOtherMonths: true,
    		selectWeek:true,
    		yearRange: 'c-99:c+99',
    		nextText : '다음달',
    		prevText : '이전달',
    		maxDate : 0,
            onSelect: function(dateText, inst) { 
                var date = $(this).datepicker('getDate');
                startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
                endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
    			var dateFormat = 'yy/mm/dd'
                startDate = $.datepicker.formatDate( dateFormat, startDate, inst.settings );
                endDate = $.datepicker.formatDate( dateFormat, endDate, inst.settings );
    			$(this).val(startDate + '~' + endDate);
                
                setTimeout("applyWeeklyHighlight()", 100);
            },
    		beforeShow : function() {
    			setTimeout("applyWeeklyHighlight()", 100);
    		},
    		onChangeMonthYear: function(year, month, widget) {
    			setTimeout("applyWeeklyHighlight()", 100);
    		}
        }); //end of week datepicker
    	$("input[id^=monthlyDatePicker]").datepicker({
        	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
            monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            showOtherMonths: true,
            selectOtherMonths: true,
    		selectWeek:true,
    		yearRange: 'c-99:c+99',
    		nextText : '다음달',
    		prevText : '이전달',
    		maxDate : 0,
            onSelect: function(dateText, inst) { 
                var date = $(this).datepicker('getDate');
                startDate = 
                	new Date(date.getFullYear(),date.getMonth(),
                			new Date(date.getFullYear(), date.getMonth(), 1).getDate());
                endDate =
                	new Date(date.getFullYear(),date.getMonth(), 
                			new Date(date.getFullYear(), date.getMonth()+1, 0).getDate());
    			var dateFormat = 'yy/mm/dd'
                startDate = $.datepicker.formatDate( dateFormat, startDate, inst.settings );
                endDate = $.datepicker.formatDate( dateFormat, endDate, inst.settings );
    			$(this).val(startDate + '~' + endDate);
                
                setTimeout("applyMonthlyHighlight()", 100);
            },
    		beforeShow : function() {
    			setTimeout("applyMonthlyHighlight()", 100);
    		},
    		onChangeMonthYear: function(year, month, widget) {
    			setTimeout("applyMonthlyHighlight()", 100);
    		}
        }); //end of  month datepicker
        
    	$("input[id^=3monthlyDatePicker]").datepicker({
        	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
            monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            showOtherMonths: true,
            selectOtherMonths: true,
    		selectWeek:true,
    		yearRange: 'c-99:c+99',
    		nextText : '다음달',
    		prevText : '이전달',
    		maxDate : 0,
            onSelect: function(dateText, inst) { 
                var date = $(this).datepicker('getDate');
                startDate = 
                	new Date(date.getFullYear(),date.getMonth()-2,
                			new Date(date.getFullYear(), date.getMonth(), 1).getDate());
                endDate =
                	new Date(date.getFullYear(),date.getMonth(), 
                			new Date(date.getFullYear(), date.getMonth()+1, 0).getDate());
                console.log(startDate+"  : "+endDate);
    			var dateFormat = 'yy/mm/dd'
                startDate = $.datepicker.formatDate( dateFormat, startDate, inst.settings );
                endDate = $.datepicker.formatDate( dateFormat, endDate, inst.settings );
    			$(this).val(startDate + '~' + endDate);
                
                setTimeout("applyMonthlyHighlight()", 100);
            },
    		beforeShow : function() {
    			setTimeout("applyMonthlyHighlight()", 100);
    		},
    		onChangeMonthYear: function(year, month, widget) {
    			setTimeout("applyMonthlyHighlight()", 100);
    		}
        }); //end of 3month datepicker
        
        
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
function applyMonthlyHighlight() {
	$('.ui-datepicker-calendar tbody').each(function() {
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
		
	});
}

//이미 그려져 있는 차트를 지운다.
function clearChart(){
	  if(chart != null){
	 	 chart.clearChart();
	  }
}

//판매량 차트 그리기
function drawChart(data,types){
	
	  if(types === 'week'){
		  var day = [];
		  for(var i = 0; i < 2; i++){
			  day[i] = new Array();
		  }
		  //각 요일별 총금액
		  var storeName = [storeNameForOne,'같은 업종 평균 판매량'];
		  for(var i in data){
			  var sale = data[i];
			  var totalSum = parseInt(sale.TOTALSUM);
			  var number = parseInt(sale.NUM);
			  var one = parseInt(sale.ONESUM);
			  var averagePrice = 0;
			  
	          if(number != 0){
	          	averagePrice = totalSum/number;
	          }
			 // day[0].push(sale.PERIOD);
			  day[0].push(one);
			  day[1].push(averagePrice);
			  
				  
			  
		  }// end of for in
		  console.log(day);
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
					  	info[k][(i+1)] = 0;
					  	info[k][(i+1)] += day[i][k-1];
				  }
				}
				 
			  }
		  }//end of for
	  }else if(types === 'today'){
		  var day = [];
			var storeName = [storeNameForOne];
			for(var i  = 0; i < storeName.length; i++){
				day[i] = new Array();
			}
			//storeName = storeNameArr(data);
			//makeArray(storeName.length);
		  console.log(data);
		  for(var i in data){
			  var sale = data[i];
			 // console.log(sale.ORDERDAY);
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
		  var info = [];
		  for(var i = 0; i < 25; i++){
			  info[i] = new Array();
		  }
		  
			  //처음은 카테고리가 들어갈 배열
			  
				 info[0][0] = 'Time';	 			 
				  for(var i = 0; i < storeName.length; i++){
					  	info[0][i+1] = storeName[i];
			 	 }//end of for
				  for(var i = 0; i < storeName.length; i++){
					  for(var j = 1; j < info.length; j++){
						  if((j-1) < 10){
						  	info[j][0] = "0"+(j-1)+":00 ~ 0"+(j)+":00";
						  }else{
							info[j][0] = (j-1)+":00 ~ "+(j)+":00";
						  }
						//  console.log(info);
						  
							  info[j][(i+1)] = 0;
							  info[j][(i+1)] = day[i][(j-1)];
						  
					  }
				  }
			//console.log(info);
				 
			
			  
		
	  }else if(types === 'month'){
		  day = [];
		  if(data[0].MEMBERSUM){
		  	for(var i = 0; i < 4; i++){
			  	day[i] = new Array();
		  	}
		  }else{
			  for(var i = 0; i < 2; i++){
				  	day[i] = new Array();
			  	}
		  }
		  var storeName ;
		  for(var i in data){
			  var sale = data[i];
			  var totalSum = 0; //같은 업종의 판매량(자기 가게 포함)
			  var totalSumNonMember = 0; //회원/비회원
			  var number = parseInt(sale.NUM);
			  var one = 0; //자기 가게에 판매량
			  var oneNonMember = 0;
			  var averagePrice = 0;
			  var averagePriceNon = 0;
			  if(!sale.MEMBERSUM){
			   storeName = [storeNameForOne,'같은 업종 평균 판매량'];
			   totalSum = parseInt(sale.TOTALSUM);
			   one = parseInt(sale.ONESUM);
	          	if(number != 0){
	          		averagePrice = totalSum/number;
	         	 }
	          	 day[0].push(one);
				 day[1].push(averagePrice);
			  }else{
			   storeName = ['(회원)'+storeNameForOne,'같은 업종 회원 평균 판매량','(비회원)'+storeNameForOne,'같은 업종 비회원 평균 판매량'];
			   totalSum = parseInt(sale.MEMBERTOTALSUM);
			   totalSumNonMember = parseInt(sale.NONMEMBERTOTALSUM);
			   one = parseInt(sale.MEMBERSUM);
			   oneNonMember = parseInt(sale.NONMEMBERSUM);
			   if(number != 0){
	          		averagePrice = totalSum/number;
	          		averagePriceNon = totalSumNonMember/number;
	         	 }
			   day[0].push(one);
			   day[1].push(averagePrice);
			   day[2].push(oneNonMember);
			   day[3].push(averagePriceNon);
			  }
			 // day[0].push(sale.PERIOD);
			 
		  }// end of for in
		  console.log(day);
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
		 	}//end of for k
			}//end of for i
		 // console.log(info);
	  }else if(types === '3month'){
		  day = []
		  for(var i = 0; i < 3; i++){
			  day[i] = new Array();
		  }
		  var storeName = [storeNameForOne,'같은 업종 평균 판매량'];
		  for(var i in data){
			  if(i == 3){
				  break;
			  }else{
			  var sale = data[i];
			  var totalSum = parseInt(sale.TOTALSUM);
			  var number = parseInt(sale.NUM);
			  var one = parseInt(sale.ONESUM);
			  var averagePrice = 0;
	          if(number != 0){
	          	averagePrice = totalSum/number;
	          }
			 // day[0].push(sale.PERIOD);
			  day[0].push(sale.PERIOD);
			  day[1].push(one);
			  day[2].push(averagePrice);
			  }
		  }// end of for in
		  console.log("3달치 : "+day);
		  //2차 배열 생성
		  var info = [];
		  for(var i = 0; i < 4; i++){
			  info[i] = new Array();
		  }
		//처음은 카테고리가 들어갈 배열
		info[0][0] = '3Month';
		 for(var i = 1; i <= storeName.length+1; i++){
			 if(i != storeName.length+1){
			  	info[0][i] = storeName[i-1];
			 }
		 	for(var k = 0; k < 3; k++ ){
		 		info[i][k] = 0;
		 		info[i][k] = day[k][i-1];
		 	}
			}//end of for
	  }//end of types If
	  
	 
	  // Some raw data (not necessarily accurate) 2차 배열 형태로 넣어야함.
	    chartData = google.visualization.arrayToDataTable(info);
	    var options = {
	      title : types+' Store Sale volume',
	      vAxis: {title: 'Sale Price'},
	      hAxis: {title: 'Time'},
	      legend: { position: 'bottom' },
	      seriesType: 'bars',
	      series: {1: {type: 'line'},
	      		   3 : {type:'line'}}
	    };
		if(day.length == 2){
	    chart = new google.visualization.ComboChart($(".timeChart")[0]);
		}else if(day.length == 4){
			chart = new google.visualization.ComboChart($(".timeChartOfMember")[0]);
		}
	    chart.draw(chartData, options);
		  
	  
}//end of drawChat





</script>   
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	
