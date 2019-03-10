<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="배달의 신" name="pageTitle" />
</jsp:include>

<style>
#category-nav{
     position: relative;
    top: 88px;
    width: 89%;
    left: 7%;
    pointer:cursor;
}
#search-container{
    position: relative;
    top: 72px;
    left: 39%;
}
hr{
    top: 102px;
    position: relative;
}
</style>
 

<div id="category-container">  	
	
	<!-- 검색창 -->
    <div id="search-container">
	 <form class="form-inline my-2 my-lg-0">
	   <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" id="search">
	   <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
	 </form>
    </div>
	
	<!-- 카테고리란 -->
	<div id ="category-nav-container">
		<ul class="nav nav-pills nav-fill" id="category-nav">
		  <li class="nav-item">
		    <a class="nav-link" onclick="categoryList(this);" name="1" id="chicken">치킨</a>
		  </li>
		    <li class="nav-item">
		    <a class="nav-link" onclick="categoryList(this);" name="2" id="pizza">피자</a>
		  </li>
		    <li class="nav-item">
		    <a class="nav-link"onclick="categoryList(this);" name="3" id="bossam">보쌈/족발</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" onclick="categoryList(this);" name="4" id="bunsik">분식</a>
		  </li>
		    <li class="nav-item">
		    <a class="nav-link" onclick="categoryList(this);" name="5" id="china">중식</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" onclick="categoryList(this);" name="6" id="japan">일식</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" onclick="categoryList(this);" name="7" id="korea">한식</a>
		  </li>
		</ul>		
		<hr>
	</div>

</div>

<script>	
	function categoryList(item){
		var categoryNo = $(item).attr("name");
	    location.href = "${pageContext.request.contextPath}/storeInfo/storeInfoList.do?categoryNo="+categoryNo;
	}

	//치킨눌렀을 시
	$("#chicken").on("click", function(){
		$("#all").removeClass("active");
		$("#chicken").addClass("active");
		$("#pizza").removeClass("active");
		$("#bossam").removeClass("active");
		$("#bunsik").removeClass("active");
		$("#china").removeClass("active");
		$("#japan").removeClass("active");
		$("#korea").removeClass("active");
	});
	//피자
	$("#pizza").on("click", function(){
		$("#all").removeClass("active");
		$("#chicken").removeClass("active");
		$("#pizza").addClass("active");
		$("#bossam").removeClass("active");
		$("#bunsik").removeClass("active");
		$("#china").removeClass("active");
		$("#japan").removeClass("active");
		$("#korea").removeClass("active");
	});
	//보쌈
	$("#bossam").on("click", function(){
		$("#all").removeClass("active");
		$("#chicken").removeClass("active");
		$("#pizza").removeClass("active");
		$("#bossam").addClass("active");
		$("#bunsik").removeClass("active");
		$("#china").removeClass("active");
		$("#japan").removeClass("active");
		$("#korea").removeClass("active");
	});
	//분식
		$("#bunsik").on("click", function(){
		$("#all").removeClass("active");
		$("#chicken").removeClass("active");
		$("#pizza").removeClass("active");
		$("#bossam").removeClass("active");
		$("#bunsik").addClass("active");
		$("#china").removeClass("active");
		$("#japan").removeClass("active");
		$("#korea").removeClass("active");
	});
	//중식
		$("#china").on("click", function(){
		$("#all").removeClass("active");
		$("#chicken").removeClass("active");
		$("#pizza").removeClass("active");
		$("#bossam").removeClass("active");
		$("#bunsik").removeClass("active");
		$("#china").addClass("active");
		$("#japan").removeClass("active");
		$("#korea").removeClass("active");
	});
	//일식
		$("#japan").on("click", function(){
		$("#all").removeClass("active");
		$("#chicken").removeClass("active");
		$("#pizza").removeClass("active");
		$("#bossam").removeClass("active");
		$("#bunsik").removeClass("active");
		$("#china").removeClass("active");
		$("#japan").addClass("active");
		$("#korea").removeClass("active");
	});
	//한식
		$("#korea").on("click", function(){
		$("#all").removeClass("active");
		$("#chicken").removeClass("active");
		$("#pizza").removeClass("active");
		$("#bossam").removeClass("active");
		$("#bunsik").removeClass("active");
		$("#china").removeClass("active");
		$("#japan").removeClass("active");
		$("#korea").addClass("active");
	});
	
</script>


