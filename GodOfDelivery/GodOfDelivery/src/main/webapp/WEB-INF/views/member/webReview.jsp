<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="배달의신" name="pageTitle"/>
</jsp:include>



	<div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <h1 class="h3 mb-4 text-gray-800">배달의 신</h1>
          
          <table id="tbl-event" class="table table-striped table-hover" >
			<tr>
				<th style="text-align: center;">글번호</th>
				<th style="text-align: center;">평점</th>
				<th style="text-align: center;">내용</th>
				<th style="text-align: center;">작성자</th>
				<th style="text-align: center;">날짜</th>
			</tr>
			
         	<c:if test="${wr != null}"> 
         		<c:if test="${not empty wr}"> 
           			<c:forEach items="${wr}" var="wr" varStatus="vs">		 
           				<tr>
           					<td><span>${vs.count}</span></td>
           				
							<td>
							  <div class="review-star">
							    <span class="review-score" value ="${wr.rate}">
							    	<img src="${pageContext.request.contextPath}/resources/images/star.png"/>
							    </span>    
							  </div>
						  	</td>
						  
							<td>
						    <div class="reviewImage">
								<span class="post">제목:${wr.title} <br/>${wr.content}</span>
		      				</div>
		      				</td>
		      				<td>
						  <div class="review-cont">
						  	<div><span class="post">${wr.writer}</span></div>
						  	</td>
						  	<td>   
		      				<div class="date">${wr.writeDate}</div>
						  </div>
						  </td>
						</tr>
						</c:forEach>
					</c:if>
				</c:if>
			<c:if test="${empty wr}">
				<tr>
					<td colspan="6">등록된 리뷰가 없습니다.</td>
				</tr>
			</c:if>
		
		  </table>
	
		<%
			int totalContents = (int)request.getAttribute("totalContents");
			int numPerPage = (int)request.getAttribute("numPerPage");
			int cPage = (int)request.getAttribute("cPage");
		%>
		<div>
		<%=com.kh.god.common.util.Utils.getPerBar(totalContents,cPage,numPerPage,"webreview.do") %>
		</div> 
          

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->



		
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	