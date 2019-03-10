<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="고객센터" name="pageTitle"/>
</jsp:include>
<style>
/*글쓰기버튼*/
input#btn-add{float:right; margin: 0 0 15px;}
table#tbl-board tr th{text-align:center;}
table#tbl-board tr td{text-align:center;}
a {text-decoration:none;}
table#tbl-board{ width : 500px; margin:-35px auto;}
div#head-container{margin:70px auto; width : 900px; height:50px;}
div#qna{margin-left : -40px; width : 450px; height : 50px; text-align : center; font-weight : bold;cursor : pointer;display: table-cell;vertical-align: middle;}
div#asking{margin-top:-50px; margin-left : 500px; width : 450px; height : 50px; text-align : center; font-weight : bold; cursor : pointer;display: table-cell;vertical-align: middle;}
div#pageBar{margin:35px auto;}
div#chat-container{margin:0 auto; width:700px; height:350px; overflow:scroll;}
ul#data{padding:10px;}
li.chatMe{background-color:#32aeb8; border:1px solid lightgray; border-radius:10px; padding:5px; margin:5px; display:table; float:right; clear:both;}
li.chatAdmin{border:1px solid lightgray; border-radius:10px; padding:5px; margin:5px; display:table; float:left; clear:both;}
div#send-container{margin:10px auto; width:700px;}
</style>
<script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.6.0/moment.min.js"></script>
<script>
function fn_goAskingList(){
	if("${memberLoggedIn }" != ""){
		var memberId= "${memberLoggedIn.memberId }";
		location.href = "${pageContext.request.contextPath}/admin/askingList.do?boardWriter="+memberId;	
	}else if("${sellerLoggedIn }" != ""){
		var sellerId = "${sellerLoggedIn.sellerId }";
		location.href = "${pageContext.request.contextPath}/admin/askingList.do?boardWriter="+sellerId;
	}else if("${sellerLoggedIn }" == "" && "${memberLoggedIn }" == ""){
		alert("로그인 후 이용 가능합니다.");
		return;
	}
}
function fn_goQnaList(){
	location.href = "${pageContext.request.contextPath}/admin/qnaboard.do";
}
function fn_goStomp(){
	location.href = "${pageContext.request.contextPath}/ws/stomp.do";
}

function getMoment(time){
	var date = moment("/Date("+time+")/").format("YYYY/MM/DD hh:mm:ss").toString();
	return date;
}
</script>

<script type="text/javascript">
$(document).ready(function() {
	$("#sendBtn").click(function() {
		sendMessage();
		$('#message').val('')
	});
	$("#message").keydown(function(key) {
		if (key.keyCode == 13) {// 엔터
			sendMessage();
			$('#message').val('')
		}
	});

	//window focus이벤트핸들러 등록
	$(window).on("focus", function() {
		//console.log("focus");
		lastCheck();
	});
	
	$("#chat-container").scrollTop($("#chat-container")[0].scrollHeight); 
});
//윈도우가 활성화 되었을때, chatroom테이블의 lastcheck(number)컬럼을 갱신한다.
//안읽은 메세지 읽음 처리
function lastCheck() {
	let data = {
		chatId : "${chatId}",
		memberId : "${memberId}",
		time : new Date().getTime()
	}
	stompClient.send('<c:url value="/lastCheck" />', {}, JSON.stringify(data));
}

//웹소켓 선언
//1.최초 웹소켓 생성 url: /stomp
let stompSocket = new SockJS('<c:url value="/stomp" />');
let stompClient = Stomp.over(stompSocket);

//connection이 맺어지면, 콜백함수가 호출된다.
stompClient.connect({}, function(frame) {
	//console.log('connected stomp over sockjs');
	//console.log(frame);
	
	//사용자 확인
	lastCheck();

	//stomp에서는 구독개념으로 세션을 관리한다. 핸들러 메소드의 @SendTo어노테이션과 상응한다.
	stompClient.subscribe('/chat/${chatId}', function(message) {
		//console.log("receive from /subscribe/stomp/abcde :", message);
		let messageBody = JSON.parse(message.body);
		var time = getMoment(messageBody.time);
		if(messageBody.memberId == 'admin'){
			$("#data").append("<li class=\"list-group-item chatAdmin\">"+messageBody.msg+"</br><sub>"+time+"</sub></li>");
		} else{
			$("#data").append("<li class=\"list-group-item chatMe\">"+messageBody.msg+"</br><sub>"+time+"</sub></li>");
		}
		$("#chat-container").scrollTop($("#chat-container")[0].scrollHeight); 
	});

});

function sendMessage() {

	let data = {
		chatId : "${chatId}",
		memberId : "${memberId}",
		msg : $("#message").val(),
		time : new Date().getTime(),
		type: "MESSAGE"
	}

	//테스트용 /hello
	//stompClient.send('<c:url value="/hello" />', {}, JSON.stringify(data));
	
	//채팅메세지: 1:1채팅을 위해 고유한 chatId를 서버측에서 발급해 관리한다.
	stompClient.send('<c:url value="/chat/${chatId}" />', {}, JSON.stringify(data));
}


</script>

<section id="board-container" class="container">
<!-- 전체 게시글 출력 -->
	
<div id="head-container">
	<div id="qna" class="alert-light" onclick="fn_goQnaList();">FAQ</div> <div id="asking" class="alert-light" onclick="fn_goAskingList();">1:1문의</div> <div id="asking" class="alert-info" onclick="fn_goStomp();">채팅 문의</div>
</div>
<section id="stomp-container">
	
	<div id="chat-container">
	  <ul id="data">
		<c:forEach items="${chatList}" var="m">
		  <c:if test="${m.memberId != 'admin' }">
	  	    <li class="chatMe" >${m.msg } </br> <sub><script>document.write(getMoment("${m.time}"));</script></sub> </li>
		  </c:if>
		  <c:if test="${m.memberId == 'admin' }">
		    <li class="chatAdmin">${m.msg } </br> <sub><script>document.write(getMoment("${m.time}"));</script></sub> </li>
		  </c:if>
		</c:forEach>	
	  </ul>
	</div>
	
	<div id="send-container" class="input-group mb-3">
	  <input type="text" id="message" class="form-control" placeholder="Message">
	  <div class="input-group-append" style="padding: 0px;">
		<button id="sendBtn" class="btn btn-outline-secondary" type="button">전송</button>
	  </div>
	</div>

</section> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>