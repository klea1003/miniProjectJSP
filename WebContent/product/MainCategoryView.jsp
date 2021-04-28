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
	*{
	    /*Remove the margins of all elements*/
	    /*You can remove the left margin of li in ul to make it beautiful*/
	    margin:0;
	    padding:0;
	}
	
	#div-box1{
	    width: 90%;
	    margin:20px auto 0 auto;
	    text-align: center;
	}
	#div-box1 .main{
	    width: 85%;   
	    height: 550px;
	    /*Make ul automatically center horizontally*/
	    margin:20px auto 0 auto;
	}
	#div-box1 li{
	    /*Remove the style in front of li*/
	    list-style-type:none;
	    width: 400px;
	    height: 500px;    
	    /* border:1px solid red; */
	    /*To put li in a row, use left and left float*/
	    float:left; 
	    margin:20px 0 0 10px;  
	}
	.main img{
	    width: 400px;	    
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
		width: 400px;
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
	.fix2{
	width:1500px;
	margin-left:200px;
	}
	.fix3{
	width:1000px;
	margin-left:50px;
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
	<div class="fix3">
	<div id="div-box2">
    	<p style="font-size:28px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;장르별 베스트 셀러</p>
   	</div>
   	</div>
     <div class="fix2">
    <div id="div-box1">    	
	
	    <ul class="main">
	    	<% 
	    		for(int i=0; i<util.getCategoryLength(); i++){
	    	%>
	    		<%
	    			ArrayList<Book> list = bookDAO.getList(i);
	    			Book book = list.get(0);
	    		%>
	    		<li style="text-align:center">
	    			<p><h4><%= util.getCategoryName(i)%></h4></p>
		    		<a href="product.jsp?bookID=<%= book.getBookID()%>"><img src="<%=request.getContextPath()%>/images/<%= book.getBookImagePath() %>.jpeg"></a>
		    		<p><a href="product.jsp?bookID=<%= book.getBookID()%>"><%=book.getBookTitle() %></a></p>
		        	<div class="line"></div>
		        	<span class="number"><%=book.getBookPrice() %></span>
	        	</li>
	    	<%
	    		}
	    	%>
	    </ul>
	</div>
	</div>	
</body>
</html>