<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.kh.god.seller.model.vo.*" %>
<%
	Seller sellerLoggedIn = (Seller)session.getAttribute("sellerLoggedIn");
	if(sellerLoggedIn != null){
	System.out.println("##################################" + sellerLoggedIn.getSellerId());		
	}
%>

<link href="${pageContext.request.contextPath }/resources/css/fontawesome-free/css/all.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.css" rel="stylesheet">

<!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-god sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Divider -->
      <br />
      <br />
      <hr class="sidebar-divider my-0">
      <!-- Nav Item - Dashboard -->
     
    
       <li class="nav-item" id="dashBoard">
        <a class="nav-link" href="${pageContext.request.contextPath}/seller/goMyStore.do?sellerId=${sellerLoggedIn.sellerId}">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>요약</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">
	  
      <!-- Nav Item - Pages Collapse Menu -->
      <c:if test="${not empty storeSideBar }">
      	<c:forEach items="${storeSideBar}" var="store" varStatus="status">
      		<li class="nav-item">
		        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapse${store.storeNo}" aria-expanded="true" aria-controls="collapse${store.storeNo}">
		          <i class="fas fa-fw fa-folder"></i>
		          <span>${store.storeName}</span>
		        </a>
		        <div id="collapse${store.storeNo}" class="collapse" aria-labelledby="heading${store.storeNo}" data-parent="#accordionSidebar">
		          <div class="bg-white py-2 collapse-inner rounded">
		            <a class="collapse-item myStoreOrder" href="${pageContext.request.contextPath}/seller/goMyStoreOrder.do?storeNo=${store.storeNo}">주문내역 <span class="badge badge-primary badge-pill orderCount">14</span></a>
		            <a class="collapse-item myStoreMenu" href="${pageContext.request.contextPath}/seller/myStoreMenu.do?storeNo=${store.storeNo}&sellerId=${store.sellerId}">내 가게 메뉴</a>
		            <a class="collapse-item myChart" href="${pageContext.request.contextPath }/seller/myStoreChart.do?storeNo=${store.storeNo}&&sellerId=${sellerLoggedIn.sellerId}">내 가게 통계</a>
		            <a class="collapse-item updateMyStoreInfo" href="${pageContext.request.contextPath}/seller/goUpdateMyStore.do?storeNo=${store.storeNo}">내 가게 수정</a>
		            <a class="collapse-item sellerReview" href="${pageContext.request.contextPath}/seller/goSellerReview.do?storeNo=${store.storeNo}">리뷰</a>
		            <a class="collapse-item myAd" href="${pageContext.request.contextPath }/seller/myAd.do?storeNo=${store.storeNo}">광고</a>
		          </div>
		        </div>
		      </li>
      	</c:forEach>
      </c:if>

      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
     <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- End of Sidebar -->