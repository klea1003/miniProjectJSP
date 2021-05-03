<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="book.Book"%>
<%@ page import="book.BookDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<script language=javascript>
	function getPost(mode) { 
		var theForm = document.bookOrder;
		if(mode == "cart") { 
			theForm.method = "post";
			theForm.target = "_self";
			theForm.action = "../cart/cartAction.jsp"; 
		} else if(mode == "directOrder") { 
			theForm.method = "post";
			theForm.target = "_self";
			theForm.action = "../order/directOrderAction.jsp" 
		}
		theForm.submit(); 
	}
</script>
<!-- Product Style sheet -->
<style type="text/css">
	.left {
		width:30%;
	    float:left;
	    text-align: center;
	}
	.info {
		width:30%;
		margin:20px;
	    float:right;
	}
	.info_left {
		width: 40%;
		padding-left: 30px; 
		float: left;
	}
	.info_right {
		width: 60%;
		float: right;
	}
	.info_two_line{
		padding-top: 5px;
	 	height: 30px;
	 	padding: 5px;
	}
	.info_one_line{
		text-align: center;
	}
	.line1{
		border-bottom: 2px solid black;
	}
	.line2{
		border-bottom: 1px solid black;
	}
	.empty1{
		height: 30px;
	}
</style>
<jsp:include page="/include/header.jsp" flush="false"/>
</head>
<body>
	<%
		int bookID = 0;
		if(request.getParameter("bookID") != null) {
			bookID = Integer.parseInt(request.getParameter("bookID"));
		}
		
		if(bookID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		
		BookDAO bookDAO = new BookDAO();
		
		Book book = bookDAO.getBook(bookID);
		
		bookDAO.close();
		
	%>
	<div>
		<div class="left"><img src="<%=request.getContextPath()%>/images/<%= book.getBookImagePath() %>.jpeg"></div>  
		<form name="bookOrder" class="info" method="post">
			<input type="hidden" name="bookID" value=<%= bookID %>>
			<div class="line1"></div>
			<div class="info_one_line"><h2><%= book.getBookTitle()%></h2></div>
			<div class="line2"></div>
			<div class="info_two_line">
				<div class="info_left">판매가</div>
				<div class="info_right"><%= book.getBookPrice()%></div>				
			</div>
			<div class="line2"></div>
			<div class="info_two_line">
				<div class="info_left">출판사</div>
				<div class="info_right"><%= book.getBookPublisher()%></div>				
			</div>
			<div class="line2"></div>
			<div class="info_two_line">
				<div class="info_left">수량</div>
				<div><input name="bookAmount" value="1" type="text" style="width:40px;"></div>				
			</div>
			<div class="empty1"></div>
			<div class="info_one_line">
				<input type="button" class="btn btn-primary" value="장바구니 추가" onClick="getPost('cart')">
				<input type="button" class="btn btn-primary" value="구입" onClick="getPost('directOrder')">	
			</div>
			<div class="empty1"></div>			
			<div class="line1"></div>
		</form>	
	</div>	
</body>
</html>