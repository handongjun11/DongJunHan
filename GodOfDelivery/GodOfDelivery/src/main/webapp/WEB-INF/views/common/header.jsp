<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.kh.god.seller.model.vo.*" %>
<%
	if(session.getAttribute("sellerLoggedIn") != null){
		Seller sellerLoggedIn = (Seller)session.getAttribute("sellerLoggedIn");
	System.out.println("##################################" + sellerLoggedIn.getSellerId());		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.pageTitle}</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script>
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous"> 
<link rel="shortcut icon" type="image/x-icon" href="이미지경로" />
<!-- 구글 차트 API -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />

<!-- 주소api -->

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 

<!-- favicon 설정 -->
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">

<!-- WebSocket: stomp.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

<style>
nav.navbar-light{
	background : #117a8b;
}
.navbar-light .navbar-brand{
	color : white;
}
.navbar-light .navbar-nav .active>.nav-link{
	color : white;
}

.header-btn{
	background-color: #117a8b;
	border-color: white;
	color : white;
}
.header-btn:hover {
    background-color: #117a8b;
    border-color: white;
}

.navbar-expand-lg .btn-outline-success:hover {
	background-color: #32aeb8;
}

#modal-checkbox{
	padding-right: 252px;
}
#modal-checkbox>span{
	visibility: hidden;
}
.loginbtn{
	background : none;
	border : none;
}
.loginbtn:hover{
	color : white;
}
#profileImage{
	position : relative;
	bottom : 0.3em;	
	border-radius : 0.25em;
}
 div#memberstatus{
	position : relative;
	left : 0.6em; 
	border-radius : 100%;
	width : 1rem;
	height : 1rem;
	padding : 0;
}

div#communicateWith{
	position : relative;
	left : 9rem;
	bottom : 1rem;
}
div#messagePreviewContent{
	overflow : hidden;
	text-overflow : ellipsis;
	white-space:normal;
}
div#chatView{
	width : 98%;
	margin-left : 0.25em;
	overflow: -moz-scrollbars-vertical;
	overflow-x: hidden;
	overflow-y: auto;	
}
div#chatView div.messageFormatMyself{

	position : relative;
	left : 9rem;
	width : 14rem;
	text-align : right;
	border : 1px solid lightgray;
	border-radius :1em;
	margin-top: 1rem;

	
}
div#chatView div.messageFormatHim{

	width : 14rem;
	text-align : left;
	border : 1px solid lightgray;
	border-radius : 1em;
	margin-top: 1rem;

}
div.dropdown-body{
	overflow-y : auto;
	max-height : 10rem;
}
#alertsDropdownBox{
	overflow-y : auto;
	max-height : 15rem;
}

div#socketAlert{
	display : none;
	z-index : 10;
}
div#messageContentShow{
	white-space : normal;
	position : relative;
}
div#createChatRoomHeader h5{
	margin : auto;
	margin-right : 1rem;
}
input#insertId{
	float : left;
	width : 13rem;
}

div#autoComplete{
	min-width: 160px;
	border : 1px solid gray;
	display : none;
	padding : 0;
	margin : 0;	
	
}
div#autoComplete li{
	padding : 0 10px;
	list-style : none;
	cursor : pointer;

}
div#autoComplete li:hover{
	background : lightseagreen;
	color : white;
}
div#autoComplete li.selected{
	background : lightseagreen;
	color : white;
}
span.srchVal{
	color : red;
	
}
#find-btn{
	padding: 0px;
    margin: 0px;
    border: none;
    color: black;
}
#find-btn:hover{
	background-color: none !important;
	border-color: none !important;
}
#find-id{
	width: 400px;
	display: inline;
} 
#find-pwd{
	width: 400px;
	display: inline;
} 
#find-pwd1{
	width: 400px;
	display: inline;
}

</style>
</head>
	<!-- chatting modal -->
	<div class="modal fade" id="chatModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content" style="height : 40em; width : 25em;" id="chatModalContent">
	    </div>
	  </div>
	</div><!-- end of chatting modal -->

	<!-- create chatRoom modal -->
	<div class="modal fade" id="createChatRoom" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
	    <div class="modal-content" style="height : 19rem; width : 19rem;" id="createChatRoomBody">
	    	<div class="modal-header" id="createChatRoomHeader">
	        <h5 class="modal-title" >채팅할 사람</h5>	
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="padding : 0.1em;">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body"  id="addPersonForChat">
			<input type="text" class="form-control" name="searchPerson" placeholder="추가할 아이디를 검색하세요." id="insertId" autocomplete="off" />
	        <button type="button" class="btn btn-link" id="addPersonForChatBtn" data-toggle="modal" data-target="#confirmModal"><i class="fas fa-plus"></i></button>
	        <div style="overflow-y : auto;" id="autoComplete"></div>
		  </div>
	      <div class="modal-footer">
	      	
	      </div>
	    </div>
	  </div>
	</div><!-- end of create chatRoom -->
	
	<!-- confirm modal -->
	<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
	    <div class="modal-content" style="height : 12rem; width : 20rem;" id="confrimBody">
	    	<div class="modal-header" id="confrimHeader">
	        <h5 class="modal-title" >확인</h5>	
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="padding : 0.1em;">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body"  id="confirmBody">
			<input type="text" class="form-control" name="confirmContent"  readonly />
	      <div class="modal-footer">
	        <button type="button" class="btn btn-outline-success" id="confirmOkBtn"  onclick="confirmOrNot();">확인</button>
	        <button type="button" class="btn btn-outline-danger" id="confirmCancleBtn" data-dismiss="modal">취소</button>
	      	</div>
	      </div>
	    </div>
	  </div>
	</div><!-- end of comfirm modal -->

<body>
<!-- 알람 -->
<div id="socketAlert" class="alert alert-success" role="alert" ></div>
<div id="container">
   <header>
		<nav class="fixed-top navbar-expand-lg navbar-light" style="z-index : 1;">
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		  
		  <!-- //collapse navbar-collapse -->
		  <div class="navbar-collapse collapse " id="navbarTogglerDemo01">
		    <a class="navbar-brand" href="${pageContext.request.contextPath}">God of Delivery</a>
		    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
		      <li class="nav-item active">
		        <a class="nav-link" href="${pageContext.request.contextPath}" id="sweetHome">Home <span class="sr-only">(current)</span></a>
		      </li>
		      <li class="nav-item">				    
		        <a class="nav-link" href="${pageContext.request.contextPath }/admin/qnaboard.do">고객센터</a>
		      </li>		    
		      <li class="nav-item">				    
		        <a class="nav-link" href="${pageContext.request.contextPath }/member/webreview.do">배달의신평가</a>
		      </li>		    
		      <c:if test="${memberLoggedIn.memberId eq 'admin' }">
		     	 <li class="nav-item">
		        	<a class="nav-link" href="${pageContext.request.contextPath }/admin/dashBoard.do">관리자</a>
		     	 </li>
		      </c:if>
		    </ul>
		    
			<!-- 회원 로그인,회원가입 버튼 -->
		    <c:if test="${memberLoggedIn == null}">
		   		<c:if test="${sellerLoggedIn == null}">
				<!--https://getbootstrap.com/docs/4.1/components/buttons/#outline-buttons-->
					<button class="btn btn-outline-success header-btn" type="button" data-toggle="modal" data-target="#loginModal">로그인</button> 
			 		&nbsp;  
					<button class="btn btn-outline-success header-btn" type="button" 
		     				onclick="location.href='${pageContext.request.contextPath}/chooseEnrollType.do'">회원가입</button>
				</c:if>
			</c:if>
			
			<!-- member 로그인후  -->
			<c:if test="${memberLoggedIn != null}">
			  <c:if test="${sellerLoggedIn == null}">
			  	<c:if test="${'admin' == memberLoggedIn.memberId}">
			  		<ul class="navbar-nav ml-auto">
            		<li class="nav-item dropdown no-arrow mx-1">
              		<a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-bell fa-fw"></i>
                <!-- Counter - Alerts -->
                <span class="badge badge-danger badge-counter" id="adminAlertCount"></span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" id="alertsDropdownBox" aria-labelledby="alertsDropdown">
               
              </div>
            </li>

            <!-- 메신저 -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Messages -->
                <span class="badge badge-danger badge-counter" id="messageCount"></span>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown" id="messageDropdownBox" style="width : 30rem;">
             
              </div>
            </li>
            </ul> <!-- ul.navbar-nav ml-auto -->
			</c:if>	
			  	<!-- onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do' -->
			  	<c:if test="${memberLoggedIn.memberId != 'admin'}">
					<a href="${pageContext.request.contextPath}/member/memberView.do?memberId=${memberLoggedIn.memberId}">${memberLoggedIn.memberName}</a>님 안녕하세요 &nbsp;
				</c:if>
				<c:if test="${memberLoggedIn.memberId == 'admin'}">
					${memberLoggedIn.memberName}님 안녕하세요 &nbsp;
				</c:if>
				<button class="btn btn-outline-sucess" type="button" 
						onclick = "memberLogOut();">로그아웃</button>
				
			  </c:if>
			</c:if>
			
			<!-- seller 로그인후  -->
			<c:if test="${sellerLoggedIn != null}">
		  <c:if test="${memberLoggedIn == null}">
		  <!-- 알람  -->
			<ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-bell fa-fw"></i>
                <!-- Counter - Alerts -->
                <span class="badge badge-danger badge-counter" id="sellerAlertCount"></span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" id="alertsDropdownBox" aria-labelledby="alertsDropdown" style="width : 30rem;">
               
              </div>
            </li>

            <!-- 메신저 -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Messages -->
                <span class="badge badge-danger badge-counter" id="messageCount"></span>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown" id="messageDropdownBox" style="width : 30rem;">
             
              </div>
            </li>
            </ul> <!-- ul.navbar-nav ml-auto -->
            
			<a href="${pageContext.request.contextPath}/seller/sellerView.do">${sellerLoggedIn.sellerName}</a>&nbsp;사장님 안녕하세요 &nbsp;
			<button class="btn loginbtn"  type="button" onclick="location.href='${pageContext.request.contextPath}/seller/sellerLogout.do?sellerId=${sellerLoggedIn.sellerId}'">로그아웃</button>
		    &nbsp;  
		 	<button class="btn btn-outline-success header-btn" type="button"  id="myStore-btn"
		 	 onclick="location.href='${pageContext.request.contextPath}/seller/goMyStore.do?sellerId=${sellerLoggedIn.sellerId}'" >내가게</button> 
		  </c:if>
		</c:if>
		
		  </div> <!-- div#navbarTogglerDemo01 -->
	    </nav>
  </header>

<!-- </div> -->
	
 

   	<!-- 로그인모달 : https://getbootstrap.com/docs/4.1/components/modal/#live-demo -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	    <!-- 1 -->
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">로그인</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <!--로그인폼 : https://getbootstrap.com/docs/4.1/components/forms/#overview -->
	      <!-- 팝업창이 생겼을때 부모창 영역을 컨트롤할 수 없는 상태를 모달이라고 한다. 제어권이 팝업에 우선으로 부여된다. 그외의 팝업창은 nonemodal이라한다. -->
          <form id="loginFrm" method="post">
	     <!-- 2 -->
	      <div class="modal-body">
			    <input type="text" class="form-control" name="memberId" placeholder="아이디" required>
			    <br />
			    <input type="password" class="form-control" name="password" placeholder="비밀번호" required>
	      </div>
	      <!-- 3 -->
	      
	      <div class="modal-footer">
	      	<div id="modal-checkbox" style="padding-right :80px;     width: 602px;">
	      		<input type="checkbox" name="login" value="mem" onclick="NoMultiChk(this);"/> &nbsp;회원
	      		<input type="checkbox" name="login" value="sell" onclick="NoMultiChk(this);"/> &nbsp;사장님
	      		<br />
	      		<input type="checkbox" id="autologin" value="no" /> &nbsp;로그인 상태 유지
	      		 	<input type="hidden" id="autologin1" name="autologin" value="no"/>
	      		<span style="color:red;margin: -13px;">&nbsp;회원유형을 체크하세요</span>
		      	<br />
	      	</div>
	      	<br />
	      	<br />
	      	<br />
	      	<!-- <input type="checkbox" name="autoLogin" /> -->
		      	<span id="find-id-pw" style="width: 556px; cursor: pointer;">
		      		
		      		
				<button type="button" class="btn btn-outline-info"  data-toggle="modal" data-target="#FindModal" id="find-btn" >아이디/비밀번호찾기</button>
		      	</span>
	        <button type="button" class="btn btn-outline-success" onclick="check();" >로그인</button>
	     
	      </div>
		  </form>
	<!-- 	  <div id="find" style="text-align: center; border-color: black;">
		  			<table>
		  				<tr colspan="2">아이디 찾기</tr>
		  				<tr>
		  					<td><input type="email" placeholder="이메일을 입력하세요"/></td>
		  					<td><button  type="button">찾기</button></td>
		  				</tr>
		  				<tr colspan="2">비밀번호 찾기</tr>
		  				<tr>
		  					<td><input type="email" placeholder="이메일을 입력하세요"/></td>
		  					<td><button  type="button">찾기</button></td>
		  				</tr>
		  				
		  				
		  			</table>
		  		
		  </div>
		   -->
	    </div>
	  </div>
	</div>
	
	<div class="modal fade" id="FindModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">아이디/비밀번호 찾기</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        
	          <div class="form-group">
	            <label for="email" class="col-form-label">아이디 찾기</label>
	            <input type="text" class="form-control" id="find-id" name="email" placeholder="등록했던 이메일을 입력해 주세요."/>
	            <button class="btn btn-outline-success" onclick="findId();" style="margin-top: -7px;"> 찾기</button>
	          
	          </div>
	          <div class="form-group">
	              <label for="password" class="col-form-label">비밀번호찾기</label>
	            <input type="text" class="form-control" id="find-pwd" placeholder="아이디를 입력해주세요." name="id"/>
	            <input type="text" class="form-control" id="find-pwd1" placeholder="핸드폰번호를 입력해주세요." name="phone" />
	            <button class="btn btn-outline-success" style="margin-top: -7px;" onclick="findPwd();"> 찾기</button>
	          </div>
	      </div>
	      <div class="modal-footer">
	        <!-- <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        <button type="submit" class="btn btn-primary">수정</button> -->
	      </div>
	    </div>
	  </div>
	</div>
	

	
	<script>
	
	function memberLogOut(){
		sessionStorage.clear();
		location.href=
			'${pageContext.request.contextPath}/member/memberLogout.do?memberId=${memberLoggedIn.memberId}';
	}
	
	function NoMultiChk(chk){
		var obj = document.getElementsByName("login");
	    for(var i=0; i<obj.length; i++){
	        if(obj[i] != chk){
	            obj[i].checked = false;
	        }
	    }
	}
	
	function check(){
		
 		if($("#autoLogin :checked")){
			$("#autoLogin").val("1");
		}else{
			$("#autoLogin").val("");
		}  
		
		var chk = $("[name='login']:checked").val();
		
		if(chk == undefined) {
			$("#modal-checkbox>span").css("visibility", "visible");
			return false;
		}
		
		if(chk === "mem"){
			$("#loginFrm").attr("action","${pageContext.request.contextPath}/member/memberLogin.do" );
			$("#loginFrm").submit();			
		}else{
			$("#loginFrm").attr("action","${pageContext.request.contextPath}/seller/sellerLogin.do" );
			$("#loginFrm").submit();
		}
		
		
	}
	//알람 목록 가져오기
	$("#alertsDropdown").on("click",function(){
		if($("#alertsDropdown").attr('aria-expanded') === 'false'){
			$.ajax({
				url : "${pageContext.request.contextPath}/chat/getAlertList.do",
				data : {"userId" : chattingId},
				success : function(data){
					if(chattingId == "admin"){
						console.log("관리자!");
						var alertHeader = $("<div><h6 class='dropdown-header'>Alerts Center</h6></div>");
						for(var i in data){
							var alert = data[i];
							var alertBody = $("<div class='dropdown-item d-flex align-items-center' id='alertView'"+i+" style='cursor : pointer;'></div>")
							if(alert.TYPE === 'report'){
								var type = $("<div class='mr-3'><div class='icon-circle bg-warning' style='width : 2rem; height : 2rem; border-radius:100%;'><i class='fas fa-exclamation-triangle text-white' style='position : relative; left : 0.5em; top : 0.2em;'></i></div></div>");
								var content = $("<div class='alertType' value="+alert.TYPE+"><div>");
								var alertData = "<div class='small text-gray-500' >("+alert.STORENO+")"+alert.STORENAME+"</div><span class='font-weight-bold'>신고가 접수 되었습니다!</span>";
								content.append(alertData);
								type.append(content);
							}else if(alert.TYPE === 'qna'){
								var type = $("<div class='mr-3'><div class='icon-circle bg-primary' style='width : 2rem; height : 2rem; border-radius:100%;'><i class='fas fa-file-alt text-white' style='position : relative; left : 0.6em; top : 0.2em;'></i></div></div>");
								var content = $("<div class='alertType' value="+alert.TYPE+"><div>");
								var alertData = "<div class='small text-gray-500' >("+alert.STORENO+") 님께서 </div><span class='font-weight-bold'>"+alert.STORENAME+" 라는 제목의 문의를 주셨습니다.</span>";
								content.append(alertData);
								type.append(content);
							}else if(alert.TYPE === 'pms'){
								var type = $("<div class='mr-3'><div class='icon-circle bg-success' style='width : 2rem; height : 2rem; border-radius:100%;'><i class='fas fa-donate text-white' style='position : relative; left : 0.5em; top : 0.2em;'></i></div></div>");
								var content = $("<div class='alertType' value="+alert.TYPE+"><div>");
								var alertData = "<div class='small text-gray-500' >("+alert.STORENO+")"+alert.STORENAME+"</div><span class='font-weight-bold'> 가게 신청이 들어왔습니다.</span>";
								content.append(alertData);
								type.append(content);
							}
							alertBody.append(type);
							alertHeader.append(alertBody);
						}
						$("#alertsDropdownBox").html(alertHeader);
					}else{
						console.log("판매자!");
						var alertHeader = $("<div><h6 class='dropdown-header'>Alerts Center</h6></div>");
						for(var i in data){
							var alert = data[i];
							var date = (alert.RDATE).substring(0,16);
							var alertBody = $("<div class='dropdown-item d-flex align-items-center' value="+alert.STORENO+"  id='alertView'"+i+" style='cursor : pointer;'></div>")
							if(alert.TYPE === 'review'){
								var type = $("<div class='mr-3'><div class='icon-circle bg-primary' style='width : 2rem; height : 2rem; border-radius:100%;'><i class='fas fa-file-alt text-white' style='position : relative; left : 0.6em; top : 0.2em;'></i></div></div>");
								var content = $("<div class='alertType' value="+alert.TYPE+"><div>");
								var alertData = "<div class='small text-gray-500' >"+date+"  </div><span class='font-weight-bold'>"+alert.WRITER+"님 께서 "+alert.TITLE+"라는 제목의 리뷰를 남기셨습니다.</span>";
								content.append(alertData);
								type.append(content);
							}else if(alert.TYPE === 'order'){
								var type = $("<div class='mr-3'><div class='icon-circle bg-success' style='width : 2rem; height : 2rem; border-radius:100%;'><i class='fas fa-donate text-white' style='position : relative; left : 0.5em; top : 0.2em;'></i></div></div>");
								var content = $("<div class='alertType' value="+alert.TYPE+"><div>");
								var alertData = "<div class='small text-gray-500'>"+date+"</div><span class='font-weight-bold'> 주문이 들어왔습니다. </span>";
								content.append(alertData);
								type.append(content);
							}
							alertBody.append(type);
							alertHeader.append(alertBody);
						}
						$("#alertsDropdownBox").html(alertHeader);
					}
				},
				error : function(jqxhr,textStatus,errorTrown){
					console.log("알람 목록 가져오는중 에러 남!");
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorTrown);
				}
			});//end of ajax
		}//end of if alertsDropdown aria-expanded
	}); // end of alertsDropdown click event
	
	
	//알람 div를 눌렀을 때 각각의 페이지로 보내준다.
	 $(document).on('click', 'div[id^="alertView"]', function(){
		 	var alertType = $(this).children().children().eq(1).attr("value");
		 	var storeNo ;
		 	console.log("alertType : "+alertType);
		 	if(alertType === 'report'){
		 		location.href= "${pageContext.request.contextPath}/admin/reportList.do";
		 	}else if(alertType === 'qna'){
		 		location.href = "${pageContext.request.contextPath}/admin/qnaControl.do";
		 	}else if(alertType === 'pms'){
		 		location.href = "${pageContext.request.contextPath}/admin/storePMSList.do";
		 	}else if(alertType === 'review'){
		 		storeNo = $(this).attr("value");
		 		location.href = "${pageContext.request.contextPath}/seller/goSellerReview.do?storeNo="+storeNo;
		 	}else if(alertType === 'order'){
		 		storeNo = $(this).attr("value");
		 		location.href = "${pageContext.request.contextPath}/seller/goMyStoreOrder.do?storeNo="+storeNo;
		 	}
	 });
	
	
	//참여하는 채팅 유저
	var chatUserList = new Array();
	//맨처음만 채팅유저 리스트를 받아오게하려고 0일때만 작동하도록함.
	var init = 0;
	var chattingId = '${sellerLoggedIn}'.trim().length==0?"${memberLoggedIn.memberId}":"${sellerLoggedIn.sellerId}";
	console.log(chattingId);
	 //채팅방 목록 구현
	 $("#messagesDropdown").on('click',function(){
		if($("#messagesDropdown").attr('aria-expanded') === 'false'){
			$.ajax({
				url : "${pageContext.request.contextPath}/chat/chatRoomList.do",
				data : {"sellerId" : chattingId},
				type : "get",
				dataType : "json",
				success : function(data){
					timeStamp = "";
					var messageForm ;
					var mform = $("<div><h6 class='dropdown-header'>Message Center <div class='btn btn-link'  id='openChatRoom' data-toggle='modal' data-target='#createChatRoom' > <i class='fas fa-comment-dots'></i></div></h6></div>");
					var bodyForm = $("<div class='dropdown-body'></div>");
					for(var i in data){
						var message = data[i];
						var chatPerson = "";
						if(message.SELLERID ===  chattingId){
							chatPerson = message.SELLERID2;
						}else{
							chatPerson = message.SELLERID;
						}
						
						if(realTimeConnectUser.length != 0){
							console.log("채팅방 목록 만들기전에 들어옴");
							var chatUser = new Object();
							var connectFlag = false;
							for(var j in realTimeConnectUser){
								if(realTimeConnectUser[j] != null){
									
								if(realTimeConnectUser[j] == chatPerson){
									if(init == 0){
										console.log("on임!"+init);
										chatUser.chatPerson = chatPerson;
										chatUser.status = "on";
										chatUserList.push(chatUser);
									}
									messageForm = $("<div class='dropdown-item d-flex align-items-center' id='messageView"+i+"' style='border : 1px solid gray; cursor : pointer;''> <div class='dropdown-list-image mr-3'>"+chatPerson+"<div class='status-indicator bg-success' id='memberstatus'><i class='far fa-grin' id='profileImage' ></i></div></div></div>");
									connectFlag = true;
									break;
								}else{
									messageForm = $("<div class='dropdown-item d-flex align-items-center' id='messageView"+i+"' style='border : 1px solid gray; cursor : pointer;''> <div class='dropdown-list-image mr-3'>"+chatPerson+"<div class='status-indicator bg-light' id='memberstatus'><i class='far fa-grin' id='profileImage' ></i></div></div></div>");
								}
								}
							}//end of for
							if(connectFlag == false){
								if(init == 0){
									console.log("off임!"+init);
									chatUser.chatPerson = chatPerson;
									chatUser.status = "off";
									chatUserList.push(chatUser);
								}
							}
							
						}//end of if(connectUser.length != 0)
						var messageData = "";
						var notRead = 0;
						if(message.SENDMEMBER !=  chattingId){
							notRead = message.NOTREADCOUNT;
						}
						
						if(message.sendtime != null){
							timeStamp = (message.sendtime).substring(0,16);
						}
						messageData = "<div class='text-truncate' id='messagePreviewContent' value="+message.chatroomno+">"+(message.CHATCONTENT != null?message.CHATCONTENT:'')+"</div> &nbsp<div class='small text-gray-500' id='sendPerson'  value="+(message.SENDMEMBER != null?message.SENDMEMBER:'')+">"+(message.SENDMEMBER !=null ?message.SENDMEMBER+" / ":'')+  timeStamp+" <span class='badge badge-danger badge-counter' id='messageCount'>"+notRead+"</span></div>";
						
						messageForm.append(messageData);
						
						bodyForm.append(messageForm);
					}
						mform.append(bodyForm);
					
					$("#messageDropdownBox").html(mform);
					init = 1;
				},
				error : function(jqxhr,textStatus,errorTrown){
					console.log("채팅 목록 가져오는중 에러 남!");
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorTrown);
				}
			});//end of ajax
		}//end of if
	 });//end of messagesDropdown click event
	 
	 var socket = null;
	//채팅방에서 메세지 전송을 누르면 웹소켓을 통해서 메세지가 전달됨.
	$(document).on('click', 'button[id="sendMessage"]', function(evt){
			evt.preventDefault();
			sendMsgTime = getTimeStamp();
			var sendContent = $("input[name=messageContent]").val();
			
			
			if(sendContent.trim().length != 0){//메세지 내용이 없으면 보내지 않는다.
			if(socket.readyState !== 1) return;
				sendMessage();
			var message = {
					sendId :  chattingId,
					sendContent : sendContent,
					chatRoomNo : $("input[id=sendChatRoomNo]").val(),
					currentFocusChatRoomNo : hasFocusRoom
			};
			//ajax를 통해서 DB에 채팅 로그를 담음.
			 $.ajax({
				url : "${pageContext.request.contextPath}/chat/insertChatLog.do",
				data : message,
				success : function(data){
				 	messageData = "<div class='messageFormatMyself' ><div class='text-truncate' id='messageContentShow' value="+message.chatRoomNo+">"+message.sendContent+"</div> <div class='small text-gray-500' id='sendPerson'>"+message.sendId+" / "+  sendMsgTime +"</div> </div>";
				 	$("#chatView").append(messageData);
			 		setTimeout(function(){
		 				$("#chatView").scrollTop($("#chatView")[0].scrollHeight);
		 			},100);
			 		$("input[name=messageContent]").val("");
				},
				error : function(jqxhr,textStatus,errorTrown){
		 			console.log("작성한 채팅을 데이터베이스에 넣을때  에러 남!");
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorTrown);
		 		}
			});//end of ajax
	}
	});
	//1. cmd(채팅),메세지 보낸자 ,메세지 받는자, 메세지 내용 (축소), 채팅방 번호, 보낸시간 ex) chat,sendUser,receiver,messageContent , chatRoomNo, sendTime
	function sendMessage(){
		var msg ={};
		msg.cmd = "chat";
		msg.sender =  chattingId;
		msg.receiver = $("#communicateWith").text();
		msg.content =  $("input[name='messageContent']").val();
		msg.chatRoomNo = $("input[id=sendChatRoomNo]").val();
		msg.sendTime = getTimeStamp();
		sendMsgTime = msg.sendTime;
		
		socket.send(JSON.stringify(msg));
		$("input[name=messageContent]").val("");
	}
	//2. cmd(리뷰),리뷰 작성자, 가게이름, 가게번호, 가게사장아이디
	function sendReviewAlert(){
		var msg = {};
		msg.cmd = "review";
		if(!'$(sellerLoggedIn)'){
			msg.writer = '${sellerLoggedIn.sellerId}';
		}else{
			msg.writer = '${memberLoggedIn.memberId}';
		}
		msg.storeName = '${orderMenuList[0].STORENAME }';
		msg.storeNo = '${storeNo}';
		msg.sellerId = '${sellerId}';
		socket.send(JSON.stringify(msg));
	}
	//3. cmd(실시간 접속자), 현재로그인되어있는사람
	function sendRealTimeMember(){
		var msg = {};
		msg.cmd = "realTimeMember";
		socket.send(JSON.stringify(msg));
	}
	//4. cmd(신고),신고 작성자, 신고 유형
	function sendReportAlert(){
		var msg = {};
		msg.cmd = "report";
		if(!'$(sellerLoggedIn)'){
			msg.writer = '${sellerLoggedIn.sellerId}';
		}else{
			msg.writer = '${memberLoggedIn.memberId}';
		}
		msg.reportType = reportType ;
		msg.receiver = "admin";
		console.log("현재 신고유형은? "+msg.reportType);
		socket.send(JSON.stringify(msg));
	}
	function sendEnrollStore(storeName){
		console.log("가게 신청 가게 이름 : "+storeName);
		var msg = {};
		msg.cmd = "pms";
		msg.writer = '${sellerLoggedIn.sellerId}';
		msg.storeName = storeName;
		msg.receiver = "admin";
		socket.send(JSON.stringify(msg));
	}
	function getTimeStamp() {
		   var date = new Date();
		   var s =
		     leadingZeros(date.getFullYear(), 4) + '-' +
		     leadingZeros(date.getMonth() + 1, 2) + '-' +
		     leadingZeros(date.getDate(), 2) + ' ' +

		     leadingZeros(date.getHours(), 2) + ':' +
		     leadingZeros(date.getMinutes(), 2)
			
		   return s;
		}

		 function leadingZeros(n, digits) {
		   var zero = '';
		   n = n.toString();

		   if (n.length < digits) {
		     for (i = 0; i < digits - n.length; i++)
		       zero += '0';
		   }
		   return zero + n;
		 }


	$(document).ready(function(){
		 connectWebSocket();
	});
	 
	//개별 상세 채팅방 구현
	 $(document).on('click', 'div[id^="messageView"]', function(){
		 	var notRead =  $(this).children().eq(2).children().text();
		 	var allNotRead ;
		 	if($("#messageCount").text().trim().length == 0){
		 		allNotRead = 0;
		 	}else{
		 	 allNotRead = parseInt($("#messageCount").text());
		 	 if(allNotRead > 0)
		 		$("#messageCount").html(allNotRead-parseInt(notRead));
		 	}
		 	var chatroominfo ={
		 						chatRoomNo : $(this).children().eq(1).attr('value'),
		 						sendId : $(this).children().eq(2).attr('value')!=chattingId.length != 0?$(this).children().eq(2).attr('value'):"<no>"
		 					};
		 	$.ajax({
		 		url : "${pageContext.request.contextPath}/chat/chattingLog.do",
		 		data : chatroominfo,
		 		success : function(data){
		 			$("#chatModal").modal('show');
		 			successLodingChatLogs(data);
		 			setTimeout(function(){
			 			$("#chatView").scrollTop($("#chatView")[0].scrollHeight);
			 		},150);
		 			
				},
		 		error : function(jqxhr,textStatus,errorTrown){
		 			console.log("채팅 기록을 가져오는중 에러 남!");
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorTrown);
		 		},
		 		complete : function(){
		 		}
		 	});//end of ajax
		 	
	 });
	 
	 function successLodingChatLogs(data){
		 	messageData = "";
			var myId =  chattingId;
			var youId = (myId != data[0].SELLERID2 ? data[0].SELLERID2 : data[0].SELLERID);
			var chatForm = $("<div style='height : 100%; padding: 0;'></div>");
			var chatHeader;
			if(realTimeConnectUser.length != 0){
				console.log("채팅방 목록 만들기전에 들어옴");
				for(var j in realTimeConnectUser){
					if(realTimeConnectUser[j] == youId){
						//console.log("접속중!");
						chatHeader = $("<div class='modal-header'> <h5 class='modal-title' id='exampleModalLabel'></h5>	<div class='profileImage'><div class='status-indicator bg-success' id='memberstatus'><i class='far fa-grin' id='profileImage' ></i></div><div id='communicateWith'>"+ youId +"</div></div><button type='button' class='close' data-dismiss='modal' aria-label='Close' style='padding : 0.1em;'><span aria-hidden='true'>&times;</span></button></div>");
						break;
					}else{
						//console.log("아직 없음!");
						chatHeader = $("<div class='modal-header'> <h5 class='modal-title' id='exampleModalLabel'></h5>	<div class='profileImage'><div class='status-indicator bg-light' id='memberstatus'><i class='far fa-grin' id='profileImage' ></i></div><div id='communicateWith'>"+ youId +"</div></div><button type='button' class='close' data-dismiss='modal' aria-label='Close' style='padding : 0.1em;'><span aria-hidden='true'>&times;</span></button></div>");
					}
				
				}
			}//end of if(connectUser.length != 0)
			var chatBody = $("<div class='shadow rounded border border-success' id='chatView' style='height : 29rem;' ></div>");
			var chatFooter = $("<div class='modal-footer' style='width : 100%;'><input type='hidden' id='sendChatRoomNo' value="+data[0].chatRoomNo+" /><input type='text' class='form-control' name='messageContent' placeholder='메세지를 입력하세요.' id='messageContent' /><button type='button' class='btn btn-outline-success' id='sendMessage'>전송</button></div> ");
			for(var i in data){
				//console.log(data[i]);
					messageType = data[i];
				if(messageType.sendTime != null){
					timeStamp = (messageType.sendTime).substring(0,16);
				
				if(data[i].SENDMEMBER == myId){
					 messageData = "<div class='messageFormatMyself' ><div class='text-truncate' id='messageContentShow' style='left : -0.5em;' value="+messageType.chatRoomNo+">"+messageType.CHATCONTENT+"</div> <div class='small text-gray-500' style='position : relative; left : -0.5em;' id='sendPerson'>"+messageType.SENDMEMBER+" / "+  timeStamp +"</div></div>";
				}else{
					 messageData = "<div class='messageFormatHim' ><div class='text-truncate' id='messageContentShow' style='left : 0.5em;' value="+messageType.chatRoomNo+">"+messageType.CHATCONTENT+"</div> <div class='small text-gray-500'style='position : relative; left : 0.5em;' id='sendPerson'>"+messageType.SENDMEMBER+" / "+ timeStamp +"</div></div>";
				}
				}
				chatBody.append(messageData);
			}
				
			chatForm.html(chatHeader);
			chatForm.append(chatBody);
			chatForm.append(chatFooter);
			$("#chatModalContent").html(chatForm);
			roomNo = $("#sendChatRoomNo").val();
			console.log("채팅방 들어갈때 방번호 : "+roomNo);
			
	 }

	//현재 사용자가 어떤 채팅방을 보고있는지 hasFocusRoom이  0이면 아무것도 보고있지않다는 뜻.
	 $("#chatModal")[0].addEventListener("blur",function(){
		 hasFocusRoom = 0;  
		 //console.log("Page Has Not Focus "+hasFocusRoom);
	 });
	 $("#chatModal")[0].addEventListener("focusin",function(){
		 hasFocusRoom = roomNo;  
		 //console.log("Page Has Focus "+hasFocusRoom);
	 });
	 
	 // window.onfocus = function(){  
	 //    has_focus = true;  
	 //} 

	/*  $(document).ready(function(){
	    loading_time();
	 }); */ 
	////
	var roomNo = 0;
	var sendMsgTime = null;
	var alertType = null;
	var messageType = null;
	 //사용자가 어느 채팅방에 들어가 있는지 확인하는 변수
	var hasFocusRoom = 0;
	var messageData = "";
	var timeStamp = "";
	var messageCount = 0;
	//실시간 유저 리스트를 웹소켓에서 받아오는 변수
	var realTimeConnectUser;
	//신고시 신고유형을 담아서 웹소켓으로 전송하기 위한 변수.
	var reportType;
	
	//소켓으로 서버가 클라이언트한테 전달한 값을 바탕으로 만들어냄
	function receiveMessage(alertType,messageType){
		//console.log(hasFocusRoom+" : "+messageType.chatRoomNo);
		//console.log("메세지 전송 후 : "+alertType+" : "+messageType);
		 // 받는 사람이 현재 그 채팅방을 보고 있으면 알람을 주지 않고 메세지를 보냄.
		 if(hasFocusRoom === messageType.chatRoomNo){
			// if(messageType.sender === '${sellerLoggedIn.sellerId}'){
			//	 messageData = "<div class='messageFormatMyself' ><div class='text-truncate' id='messageContentShow' value="+messageType.chatRoomNo+">"+messageType.content+"</div> <div class='small text-gray-500' id='sendPerson'>"+messageType.sender+" / "+  (messageType.sendTime) +"</div></div>";
			//}else{
				 messageData = "<div class='messageFormatHim' ><div class='text-truncate' id='messageContentShow' value="+messageType.chatRoomNo+">"+messageType.content+"</div> <div class='small text-gray-500' id='sendPerson'>"+messageType.sender+" / "+  (messageType.sendTime) +"</div></div>";
			//}
			 $("#chatView").append(messageData);
			 setTimeout(function(){
		 			$("#chatView").scrollTop($("#chatView")[0].scrollHeight);
		 	},150);
		 }else{
			
			 $("#messageCount").html($("#messageCount").text().trim().length!=0?parseInt($("#messageCount").text())+1:0+1);
			 $("#socketAlert").css("display","block").text(alertType.sender+"님이 "+alertType.content+"라고 보냄");
		 		setTimeout(function(){
		 			$("#socketAlert").css("display","none");
		 		},3000); 
		 }
		 
	 }
	//리뷰,신고등 알람이 올때 실행하는 함수
   function	alertMessage(alertType,type){
	   if(type === 'review'){
			 $("#socketAlert").css("display","block").text(alertType.reviewWriter+"님이 "+alertType.storeName+"에("+alertType.storeNo +")리뷰를 작성");
			var alertCount = parseInt( $("#sellerAlertCount").text())+1;
			$("#sellerAlertCount").html(alertCount);
		 	setTimeout(function(){
		 		$("#socketAlert").css("display","none");
		 	},3000);
		 }else if(type === 'report'){
			var alertCount = parseInt( $("#adminAlertCount").text())+1;
			$("#adminAlertCount").html(alertCount);
			$("#socketAlert").css("display","block").text(alertType.reportWriter+"님이  "+alertType.reportType+"를 접수함.");
			 
		 	setTimeout(function(){
		 		$("#socketAlert").css("display","none");
		 	},3000);
		 }else if(type === 'pms'){
			var alertCount = parseInt( $("#adminAlertCount").text())+1;
			$("#adminAlertCount").html(alertCount);
			$("#socketAlert").css("display","block").text(alertType.reportWriter+"님이  "+alertType.reportType+"라는 가게를 신청함.");
		 	setTimeout(function(){
		 		$("#socketAlert").css("display","none");
		 	},3000);
			 
		 }
	}
	 function connectWebSocket(){
	 	var ws = new SockJS("<c:url value="/echo"/>"); 
	 	socket = ws;
	 	ws.onopen = function(){
	 		sendRealTimeMember();
	 		console.log("Info : connection opened.");
	 	};
	 	//서버로부터 메세지를 받을 때
	 	ws.onmessage = function(event){
	 		alertType = null;
	 		messageType = null;
	 		var message = JSON.parse(event.data);
	 		for(var i = 0; i < message.length; i++){
		 		if(message[i].cmd === "alert")
		 			  alertType = message[i];
		 		else if(message[i].cmd === "review"){
		 			alertType = message[i];
					alertMessage(alertType,"review");		 			
		 		}else if(message[i] === "realTimeMember"){
		 			realTimeConnectUser = new Array();
		 			for(var j = 1; j < message.length; j++){
		 				realTimeConnectUser.push(message[j]);
		 			}
		 		 	/* if(chatUserList.length != 0){
		 				console.log("현재 채팅중인 사람 : "+chatUserList.length+" 명");
		 				console.log("현재 채팅중인 사람 : "+chatUserList[0].chatPerson+" 명");
		 			}  */
		 			//실시간으로  상태 바꿔줌. on,off을 넣어서 on이면 온라인, off면 오프라인이라는 뜻.
		 			for(var j = 0; j < chatUserList.length; j++){
		 				var currentChatUser = chatUserList[j].chatPerson;
		 				var currentUserStatus = chatUserList[j].status;
		 				var statusFlag = false;
		 				for(var k = 0; k < realTimeConnectUser.length; k++){
		 					 if(realTimeConnectUser[k] == null){//웹소켓에서 바로 삭제하면 null값이 들어간다. 따라서 null이 넘어오기 때문에 null은 걸러준다.
		 						continue;
		 					}
		 					if(realTimeConnectUser[k] == currentChatUser){
		 						statusFlag = true;
		 						chatUserList[j].status = "on";
		 					}
		 				}//end of for realTimeConnectUser
		 				if(statusFlag == false){
		 					chatUserList[j].status = "off";
		 				}
		 				//채팅방 목록의 상태
		 				if(chatUserList[j].status === "on"){
		 					$("div[id^=messageView]").each(function(i){
		 						var loginSeller = $("#messageView"+i).children().eq(0).text();
		 						console.log("dd : "+loginSeller);
		 						if(loginSeller === currentChatUser){
		 							$("#messageView"+i).children().children().eq(0).attr("class","status-indicator bg-success");
		 						}
		 					});
		 				}else{
		 					$("div[id^=messageView]").each(function(i){
		 						var loginSeller = $("#messageView"+i).children().eq(0).text();
		 						console.log("ss : "+loginSeller);
		 						if(loginSeller === currentChatUser){
		 							$("#messageView"+i).children().children().eq(0).attr("class","status-indicator bg-light");
		 						}
		 					});
		 				}//end of if status
		 				//개별 채팅방의 상태를 나타내기 위한 if문
	 					var nowChatView = $("#communicateWith").text();
	 					console.log("현재 비활성화되어있는걸 활성화 개별 채팅방 : "+nowChatView);
	 					if(nowChatView === currentChatUser){
	 						//var nowStatus = $(".profileImage").children().eq(0).attr("class");
	 						if(chatUserList[j].status === "on"){
		 						$(".profileImage").children().eq(0).attr("class","status-indicator bg-success");
	 						}else{
		 						$(".profileImage").children().eq(0).attr("class","status-indicator bg-light");
	 						}//end of if status
	 					}//end of if(new ChatView == currentChatUser[j])
		 			}
		 			break;
		 		}else if(message[i] === "forcedlogout"){
		 			alert("현재 다른 브라우져에서 강제 로그아웃을 요청했습니다.");
		 			location.href='${pageContext.request.contextPath}/seller/sellerLogout.do?sellerId=${sellerLoggedIn.sellerId}';
		 		}else if(message[i].cmd = "report"){
		 			alertType = message[i];
		 			alertMessage(alertType,"report");
		 		}else if(message[i].cmd = "pms"){
		 			alertType = message[i];
		 			alertMessage(alertType,"pms");
		 		}
		 		else
		 			 messageType = message[i];
	 		}
	 		if(alertType != null && messageType != null){
	 			console.log(alertType);
		 		receiveMessage(alertType,messageType);
	 		}
	 		
	 	};
	 	ws.onclose = function(event){
	 		sendRealTimeMember();
	 		console.log("Info : connection closed.");
	 	};
	 	ws.onerror = function(err){
	 		console.log("Error : ",err);
	 	}; 
	 	
	 }
	 
	 var scrollPosition = 0;
	 var curHeight = 0;
	//추가할 채팅방 사람ID를 검색할때 ajax를 사용해서 자동완성
	$("#insertId").keyup(function(e){
		var selected = $(".selected");
		var li = $("#autoComplete li");
		if(e.key == 'ArrowDown'){
			curHeight += $(this).height();
			if(curHeight > $("#autoComplete").height()){
			scrollPosition += $(this).height();
			$("#autoComplete").animate({
				scrollTop : scrollPosition
			},100);
				
			}
			if(selected.length == 0){
				$("#autoComplete li:first").addClass("selected");
			}else if(selected.is(li.last())){
				//처리코드없음
			}else{
				
				selected.removeClass("selected").next().addClass("selected");
			}		
			
			
		}else if(e.key == 'ArrowUp'){
		
			scrollPosition -= $(this).height() ;
			$("#autoComplete").animate({
				scrollTop : scrollPosition
			},100);
			if(selected.length == 0){
				//처리코드 없음 
			}else if(selected.is(li.first())){
				selected.removeClass("selected");
			}else{
				selected.removeClass("selected").prev().addClass("selected");
			}
		}else if(e.key == 'Enter'){
			//값 선택
			$(this).val(selected.text());
			//검색어 목록은 감추고, li태그들은 모두 삭제
			$("#autoComplete").hide().children().remove();
		}else{
			var searchId = $(this).val();
			if(searchId.trim().length == 0){
				$("#autoComplete").css('display','none');
				return;
			}
			
			$.ajax({
				url : "${pageContext.request.contextPath}/chat/searchPerson.do",
				type : "post",
				data : {searchId : searchId},
				success : function(data){
					
					console.log("검색ID들 : "+data);
					var html = "";
					
					for(var i in data){
						var name = data[i].sellerId;
						html += "<li id='searchId'"+i+" data-target='#data'"+i+">"+name.replace(searchId,"<span class='srchVal'>"+searchId+"</span>")+"</li>";
					}
					
					//서버로부터 전달된값이 있는경우에만 보이게 처리
					if(data.length != 0){//nameArr.length > 1 도 됨
						setTimeout(function(){
						$("#autoComplete").html(html).css('display','block').css("overflow-y","auto").css("max-height","7rem");
						},150); 
					}
				}
				});
		}
	});
	$(document).on('click', 'li[id^="searchId"]',function(){
		
		$("input[name=searchPerson]").val($(this).text());
		//검색어 목록은 감추고, li태그들은 모두 삭제
		$("#autoComplete").hide().children().remove();
	});
	
	function confirmOrNot(value){
		var searchId = {
				addId : $("input[name=searchPerson]").val(),
				loginId : chattingId				
		};
		if(searchId.addId != searchId.loginId){
			
		if($("input[name=confirmContent]").attr('placeholder') ==='정말로 추가하시겠습니까?' ){
		$.ajax({
			url : "${pageContext.request.contextPath}/chat/addPerson.do",
			data : searchId,
			success : function(data){
				console.log(data);
				if(data[0].SELLERID === '존재하지않는아이디'){
					$("#confirmModal").modal('hide');
					alert('아이디가 존재하지 않습니다.');
				}else{
					$("#createChatRoom").modal('hide');
					$("#confirmModal").modal('hide');
					$("#chatModal").modal('show');
					successLodingChatLogs(data);
					setTimeout(function(){
		 				$("#chatView").scrollTop($("#chatView")[0].scrollHeight);
		 			},100);
					
				}
			},
			error : function(jqxhr,textStatus,errorTrown){
	 			console.log("채팅방 만들다가 에러 남!");
				console.log(jqxhr);
				console.log(textStatus);
				console.log(errorTrown);
	 		}
		});//end of ajax
		}else{
			$("#confirmModal").modal('hide');
		}
		}else{
			alert('자신의 아이디를 초대할 수 없습니다.');
			$("#confirmModal").modal('hide');
		}
		
		
	}
	$("#addPersonForChatBtn").on('click',function(){
		if($("input[name=searchPerson]").val().trim().length == 0){
			$("input[name=confirmContent]").attr('placeholder','아이디를 입력해주세요');
		}else{
			$("input[name=confirmContent]").attr('placeholder','정말로 추가하시겠습니까?');
			
		}
	});
	
	function  findId(){
		var email = $("#find-id").val();
		console.log(email);
		
		$.ajax({
			url :  "${pageContext.request.contextPath}/member/findId.do",
			data : {email : email},
			dataType : "json",
			success: function(data){
				console.log(data);
				alert(data.msg);
				
			},
			error : function(){
				console.log("ajax요청 에러!");
			}
			
		});
		
	};
	function findPwd(){
		var id = $("#find-pwd").val().trim();
		var phone = $("#find-pwd1").val().trim();
		
		if(phone.length <= 0){
			alert("핸드폰 번호를 입력해 주세요.");
			return false;
		}
		console.log(id);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/member/findPwd.do",
			type : "post",
			data : {id : id , phone : phone},
			dataType : "json",
			success: function(data){
				console.log(data);
				alert(data.msg);
			},
			error : function(){
				console.log("ajax요청 에러!");
			}
		});
	};
	
	$("find-pwd1").on("keyup", function(){
		 $(this).val($(this).val().replace(/[^0-9]/g,""));
	});

	//로딩 되면 판매자일때 안읽은 메세지 뜨게함.
	$(function(){
		if('${sellerLoggedIn}'){
			$.ajax({
				url : '${pageContext.request.contextPath}/chat/notReadMessage.do?sellerId='+'${sellerLoggedIn.sellerId}',
				type : 'post',
				success : function(data){
						var messageCount = parseInt(data.message);
						var reviewCount = parseInt(data.review);
						var orderCount = parseInt(data.order);
						console.log(orderCount+" : 리뷰 : "+reviewCount);
						$("#sellerAlertCount").html(orderCount+reviewCount);
						$("#messageCount").html(messageCount);
				}
			});		
		}else{
			//관리자일때
			$.ajax({
				url : '${pageContext.request.contextPath}/chat/notReadMessage.do?sellerId=admin',
				type : 'post',
				success : function(data){
						var messageCount = parseInt(data.message);
						var reportCount = parseInt(data.report);
						var pmsCount = parseInt(data.pms);
						var qnaCount = parseInt(data.qna);
						$("#messageCount").html(messageCount);
						$("#adminAlertCount").html(reportCount+pmsCount+qnaCount);
					
				}
			});		
			
		}
	});

	
	$("#autologin").on("click" , function(){
		//console.log("클릭 먹니?");
		if($("#autologin").is(":checked")){
			$("#autologin1").val("yes");
		}else{
			$("#autologin1").val("no");
		}
		
	});
	
	

	

	</script>
   <section id="content">