<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="faq.FaqDAO"%>
<%@ page import="faq.Faq"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
</head>
<jsp:include page="header.jsp" flush="false"/>
<body>
	<%
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="container">
		<div>
	    	<p style="font-size:28px">FAQ</p>
	   	</div>
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						FaqDAO faqDAO = new FaqDAO();
						ArrayList<Faq> list = faqDAO.getList(pageNumber);
						for(Faq faq: list) {
					%>
						<tr>
							<td><%= faq.getFaqID() %></td>
							<td><a href="view.jsp?bbsID=<%= faq.getFaqID() %>">
							<%= faq.getFaqTitle() %></a></td>
							<td><%= faq.getUserID() %></td>
							<td><%= faq.getFaqDate() %></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href="faq.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%		
				}
				if(faqDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="faq.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
</body>
</html>