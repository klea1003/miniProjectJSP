<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="cart.CartStock"%>
<%@ page import="cart.CartDAO"%>
<%@ page import="book.Book"%>
<%@ page import="book.BookDAO"%>
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
			theForm.action = "../order/orderAction.jsp"; 
		} else if(mode == "delete") { 
			theForm.method = "post";
			theForm.target = "_self";
			theForm.action = "deleteCartAction.jsp" 
		} theForm.submit(); 
	}
</script>
<style>
	#container {
		width: 1000px;
		float: right;
	}
	#bookImage {
		widht: 200px;
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
		// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='../user/login.jsp'");
			script.println("</script>");
		}
	%>
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div id="container">
		<form name="basket">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">목록</th>
						<th style="background-color: #eeeeee; text-align: center;">상품 이미지</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">가격</th>
						<th style="background-color: #eeeeee; text-align: center;">수량</th>
						<th style="background-color: #eeeeee; text-align: center;">합계</th>
					</tr>
				</thead>
				<tbody>
					<%
						CartDAO cartDAO = new CartDAO();
						ArrayList<CartStock> list = cartDAO.getStockList(userID);
						BookDAO bookDAO = new BookDAO();
						for(CartStock cartStock: list) {
					%>						
						<tr>
							<%
								int bookID = cartStock.getBookID();
								Book book = bookDAO.getBook(bookID);
							%>
							<td><input type="checkbox" name="checkList" value="<%= bookID %>"></td>
							<td><a href="../product/product.jsp?bookID=<%= book.getBookID()%>">
								<img src="<%=request.getContextPath()%>/images/<%= book.getBookImagePath() %>.jpeg" width="100"></a></td>
							<td><a href="../product/product.jsp?bookID=<%= cartStock.getBookID() %>">
							<%= cartStock.getBookTitle() %></a></td>
							<td><%= cartStock.getBookPrice() %></td>
							<td><%= cartStock.getBookAmount() %></td>
							<td><%= cartStock.getTotalPrice() %></td>								
						</tr>						
					<%
						}
						
						cartDAO.close();
						bookDAO.close();
					%>
						
				</tbody>
			</table>
			<input type="button" class="btn btn-primary" value="구입" onClick="getPost('buy')">
			<input type="button" class="btn btn-primary" value="삭제" onClick="getPost('delete')">	
		</form>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
</body>
</html>