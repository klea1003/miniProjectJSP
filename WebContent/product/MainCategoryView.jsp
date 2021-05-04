<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="book.Book"%>
<%@ page import="book.BookDAO"%>
<%@ page import="book.Util" %>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<!-- Product Style sheet -->
<style type="text/css">	
	#div-box1{
	    margin:20px auto 0 auto;
	    text-align: center;
	}
	#div-box1 .main{  
	    height: 500px;
	    /*Make ul automatically center horizontally*/
	    margin:20px auto 0 auto;
	}
	#div-box1 li{
	    /*Remove the style in front of li*/
	    list-style-type:none;
	    width: 283px;
	    height: 500px;    
	    /* border:1px solid red; */
	    /*To put li in a row, use left and left float*/
	    float:left; 
	    margin:20px 0 0 10px;  
	}
	.main img{
	    width: 283px;	    
	}
	.main span{
	    display: block;         
	}
	.main a:link{
	    color:black;
	    text-decoration:none;
	}
	.main a:hover{
	    color:red;
	    text-decoration:underline;
	}
	.line{
		width: 283px;
		border-bottom: 1px solid #e0e0e0;
		position: absolute;
	}
	.number{
		font-size: 12px;
		color: #333333;
		font-weight: bold;
	}
	#div-box2{
	    width: 72%;
	    margin:20px auto 0 auto;
	}
	.text_box{
		margin:10px 25px 10px 25px; 
		height:30px;
	}
</style>
<jsp:include page="/include/header.jsp" flush="false"/>
</head>
<body>
	<% 
		int categoryNumber = 1;
		if (request.getParameter("categoryNumber") != null) {
			categoryNumber = Integer.parseInt(request.getParameter("categoryNumber"));
		}
	
		BookDAO bookDAO = new BookDAO();
		Util util = new Util();
	%>
	<div id="div-box2">
    	<p style="font-size:28px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;장르별 베스트 셀러</p>
   	</div>
    <div id="div-box1">    	
	
	    <ul class="main">
	    	<% 
	    		for(int i=0; i<util.getCategoryLength(); i++){
	    	%>
	    		<%
	    			ArrayList<Book> list = bookDAO.getList(i, 1);
	    			Book book = list.get(0);
	    		%>
	    		<li style="text-align:center">
	    			<p><h4><%= util.getCategoryName(i)%></h4></p>
		    		<a href="product.jsp?bookID=<%= book.getBookID()%>"><img src="<%=request.getContextPath()%>/images/<%= book.getBookImagePath() %>.jpeg"></a>
		    		<p class="text_box"><a href="product.jsp?bookID=<%= book.getBookID()%>"><%=book.getBookTitle() %></a></p>
		        	<div class="line"></div>
		        	<span class="number"><%=book.getBookPrice() %></span>
	        	</li>
	    	<%
	    		}
	    	
	    	bookDAO.close();
	    	%>
	    </ul>
	</div>
</body>
</html>