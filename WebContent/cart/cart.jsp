<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="cart.CartStock"%>
<%@ page import="cart.CartDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<script language=javascript>
	function getPost(mode) { 
		var theForm = document.basket;
		if(mode == "buy") { 
			theForm.method = "post";
			theForm.target = "_self";
			theForm.action = "orderAction.jsp"; 
		} else if(mode == "delete") { 
			theForm.method = "post";
			theForm.target = "_self";
			theForm.action = "deleteCartAction.jsp" 
		} theForm.submit(); 
	}
</script>
</head>
<jsp:include page="/include/header.jsp" flush="false"/>
<body>
	<%
		// 현재 세션 상태를 체크한다
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
	%>
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="container">
		<div class="row">
			<form name="basket">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">목록</th>
							<th style="background-color: #eeeeee; text-align: center;">책 제목</th>
							<th style="background-color: #eeeeee; text-align: center;">가격</th>
							<th style="background-color: #eeeeee; text-align: center;">수량</th>
							<th style="background-color: #eeeeee; text-align: center;">합계</th>
						</tr>
					</thead>
					<tbody>
						<%
							CartDAO cartDAO = new CartDAO();
							ArrayList<CartStock> list = cartDAO.getStockList(userID);
							for(CartStock cartStock: list) {
						%>						
							<tr>
								<td><input type="checkbox" name="checkList" value="<%= cartStock.getBookID() %>"></td>
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
				<input type="button" class="btn btn-primary" value="구입" onClick="getPost('buy')">
				<input type="button" class="btn btn-primary" value="삭제" onClick="getPost('delete')">	
			</form>
			

		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
</body>
</html>