<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="배달의 신" name="pageTitle" />
</jsp:include>
<div class="modal" id="loginDuplication" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">로그인 중복</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>현재 다른 브라우져에서 로그인중입니다.</p>
        <p> 다른 브라우져를 로그아웃 시키시겠습니까?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary"  id="logoutConfirm">확인</button>
        <button type="button" class="btn btn-secondary"  onclick="location.href='${pageContext.request.contextPath}/seller/goIndexPage.do'">취소</button>
      </div>
    </div>
  </div>
</div>
<script>
$(document).ready(function(){
	$('#loginDuplication').modal('show');

});
$("#logoutConfirm").click(function(){
	//기존에 로그인 되어있던 브라우저를 로그아웃 시킴.
	var msg = {};
	msg.cmd = "forcedlogout";
	msg.userId = "${seller.sellerId}";
	socket.send(JSON.stringify(msg));
	location.href='${pageContext.request.contextPath}/index.do';
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	
