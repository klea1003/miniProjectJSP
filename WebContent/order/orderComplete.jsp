<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="cart.CartStock"%>
<%@ page import="cart.CartDAO"%>
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
		
		CartDAO cartDAO = new CartDAO();
		ArrayList<CartStock> list = cartDAO.getOrderCompleteList(userID, orderID);
	%>
	<div id="container">
		<h2>주문 완료되었습니다.</h2>
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">받는 사람</th>
					<th style="background-color: #eeeeee; text-align: center;">주소</th>
				</tr>
				
			</thead>
			<tobdy>
				<tr>
					<td><%= user.getUserName() %></td>
					<td><%= user.getUserAddress() %></td>
				</tr>
			</tobdy>
		</table>
			
			
		
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">책 제목</th>
					<th style="background-color: #eeeeee; text-align: center;">가격</th>
					<th style="background-color: #eeeeee; text-align: center;">수량</th>
					<th style="background-color: #eeeeee; text-align: center;">합계</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(CartStock cartStock: list) {
				%>	
					<tr>
							<td><a href="product.jsp?bookID=<%= cartStock.getBookID() %>">
							<%= cartStock.getBookTitle() %></a></td>
							<td><%= cartStock.getBookPrice() %></td>
							<td><%= cartStock.getBookAmount() %></td>
							<td><%= cartStock.getTotalPrice() %></td>								
						</tr>	
				<%
					}
				%>
	
			</tbody>
		</table>
	
		<a href="../product/MainCategoryView.jsp" class="btn btn-primary">메인으로</a>
	</div>
	<%
	
	cartDAO.close();
	%>
	
	<!-- 게시판 메인 페이지 영역 끝 -->
</body>
</html>