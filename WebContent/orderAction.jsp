<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="cart.CartDAO"%>
<%@page import="java.sql.SQLException"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
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

	String[] ids=request.getParameterValues("orderList");
	if(ids == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('주문되는 상품이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
	
		CartDAO cartDAO = new CartDAO(); 
		for(String id:ids){
			int bookID = Integer.parseInt(id);		
			int result = cartDAO.order(bookID, userID);
			
			if(result == -1) {
				throw new SQLException("DB 에러");
			}
	    }
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('주문 완료되었습니다.')");
		script.println("location.href='orderComplete.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>