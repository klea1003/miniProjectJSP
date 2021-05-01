<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="notice.Notice"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
	<style>
		#container {
			width: 1000px;
			float: right;
		}
	</style>
</head>
<jsp:include page="/include/header.jsp" flush="false"/>
<body>
	<%
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	// 세션에 값이 담겨있는지 체크
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	
	UserDAO userDAO = new UserDAO();
	User user = userDAO.getUser(userID);
	int admin = user.getAdmin();
	
	%>
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div id="container">
		<div>
	    	<p style="font-size:28px">공지사항</p>
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
						NoticeDAO noticeDAO = new NoticeDAO();
						ArrayList<Notice> list = noticeDAO.getList(pageNumber);
						for(Notice notice: list) {
					%>
						<tr>
							<td><%= notice.getNoticeID() %></td>
							<td><a href="noticeView.jsp?noticeID=<%= notice.getNoticeID() %>">
							<%= notice.getNoticeTitle() %></a></td>
							<td><%= notice.getUserID() %></td>
							<td><%= notice.getNoticeDate() %></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href="notice.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%		
				}
				if(noticeDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="notice.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
			<%
				if(admin == 1) {
			%>
				<a href="writeNotice.jsp" class="btn btn-primary pull-right">글쓰기</a>
			<%
				}
			%>
		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
</body>
</html>