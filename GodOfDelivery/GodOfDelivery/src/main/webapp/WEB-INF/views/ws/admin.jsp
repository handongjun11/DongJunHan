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

<script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.6.0/moment.min.js"></script>

<script>
$(function(){
	$("#collapsePages").addClass("show");	
	$("#stompControl").addClass("active");	
	$("#toDoList").addClass("active");	
});

//웹소켓 선언
//1.최초 웹소켓 생성 url: /stomp
let stompSocket = new SockJS('<c:url value="/stomp" />');
let stompClient = Stomp.over(stompSocket);

stompClient.connect({}, function(frame) {
	//console.log('connected stomp over sockjs');
	//console.log(frame);

	// subscribe message
	stompClient.subscribe('/chat/admin', function(message) {
		//console.log("receive from /chat/admin :", message);
		//새로운 메세지가 있을때 목록 갱신을 위해서 reload함.
		//location.reload();
		//let messsageBody = JSON.parse(message.body);
		//$("#data").append(messsageBody.memberId+":"+messsageBody.msg+ "<br/>");
	});
});

function getMoment(time){
	var date = moment("/Date("+time+")/").format("YYYY/MM/DD hh:mm:ss").toString();
	return date;
}
	
function goChat(chatId){
	
	var chatId = chatId;
	
	var html = "<iframe id='frame' src=";
	html += "${pageContext.request.contextPath}/ws/adminChat.do/"+chatId;
	html += ' frameborder="0" width="420" height="300" marginwidth="0" marginheight="0">';

	$("#chat-wrapper").html(html);
}
	
</script>

<style>
div#chatroom-container{display:inline-block;}
div#chat-wrapper{display:inline-block; margin:0 auto; width:430px; height:350px;}
li.chatAdmin{background-color:#32aeb8; border:1px solid lightgray; border-radius:10px; padding:5px; margin:5px; display:table; float:right; clear:both;}
li.chatUser{border:1px solid lightgray; border-radius:10px; padding:5px; margin:5px; display:table; float:left; clear:both;}
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
          <h1 class="h3 mb-4 text-gray-800">채팅 문의 관리</h1>
          
          <div id="chatroom-container" style="width:300px;">
          <table class="table" id="chatTable">
			  <thead>
			    <tr>
			      <th scope="col">#</th>
			      <th scope="col">회원아이디</th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:forEach items="${recentList }" var="m" varStatus="vs">
			    <tr chatNo='<c:out value="${m.CHATID}.${m.MEMBERID}"/>' /><%-- el의 문자열 더하기 연산대신 jstl out태그 사용 --%>
			      <th scope="row">${vs.count}</th>
			      <td><a href="javascript:goChat('${m.CHATID}')">${fn:substring(m.MEMBERID,0,20) }</a> <span class="badge badge-primary badge-pill msgCount${m.CHATID }">${m.CNT }</span></td>
			      <%-- <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">${fn:substring(m.MEMBERID,0,20) } <span class="badge badge-primary badge-pill msgCount${m.CHATID }">${m.CNT }</span></button> </td> --%>
			    </tr>
			  </c:forEach>
		  	</tbody>
		  </table>
		  </div>
		  
		  <div id="chat-wrapper">
	  	  	
		   </div>
		   
		   <!-- Modal시작 -->
		<!-- https://getbootstrap.com/docs/4.1/components/modal/#live-demo -->
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
		  Launch demo modal
		</button>
		
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        
		        <iframe id="frame" src="/god/ws/adminChat.do/chat_ll2dO09iTX7LVc7" frameborder="0" width="420" height="300" marginwidth="0" marginheight="0"></iframe>
		        
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
		      </div>
		    </div>
		  </div>
		</div>
		<!-- Modal 끝-->
		
        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->