<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="cart.Cart"%>
<%@page import="cart.CartDAO"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="cart" class="cart.Cart" scope="page" />
<jsp:setProperty name="cart" property="bookID" />
<jsp:setProperty name="cart" property="bookAmount" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		// 현재 세션 상태를 체크한다
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='../user/login.jsp'");
			script.println("</script>");
		}else{

			CartDAO cartDAO = new CartDAO();
			int orderID = cartDAO.directOrder(cart.getBookID(), userID, cart.getBookAmount());
			// 데이터베이스 오류인 경우
			if(orderID == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('상품 구매 실패하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			
			String orderString = String.format("location.href='orderComplete.jsp?orderID=%d'", orderID);
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('주문 완료되었습니다.')");
			script.println(orderString);
			script.println("</script>");
			
			cartDAO.close();

		}
	
	%>
</body>
</html>