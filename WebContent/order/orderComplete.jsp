<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
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
		// 현재 세션 상태를 체크한다
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		int orderID = 1;
		if (request.getParameter("orderID") != null) {
			orderID = Integer.parseInt(request.getParameter("orderID"));
		}
		
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getUser(userID);
	%>
	<div id="container">
		<h2>주문 완료되었습니다.</h2>
		
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">받는 사람</th>
					<th style="background-color: #eeeeee; text-align: center;"><%= user.getUserName() %></th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td></td>
						<td>주소 블라블라</td>
					</tr>
	
			</tbody>
		</table>
	
		<a href="main.jsp" class="btn btn-primary">메인으로</a>
	</div>
	
	<!-- 게시판 메인 페이지 영역 끝 -->
</body>
</html>