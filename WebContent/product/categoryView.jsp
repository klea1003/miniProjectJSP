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
	    width:90%;
	    text-align: center;
	    float: center;
	}
	#div-box1 .faceul{
	    height: 1000px;
	    /*Make ul automatically center horizontally*/
	}
	#div-box1 li{
	    /*Remove the style in front of li*/
	    list-style-type:none;
	    width: 200px;
	    height: 300px;    
	    /* border:1px solid red; */
	    /*To put li in a row, use left and left float*/
	    float:left; 
	    margin:10px 0 0 10px;  
	}
	.faceul img{
	    width: 200px;	    
	}
	.faceul span{
	    display: block;         
	}
	.faceul a:link{
	    color: #4f83cc;
	    text-decoration:none;
	}
	.faceul a:visited{
	    color: #4f83cc;
	}
	.faceul a:hover{
	    color:red;
	    text-decoration:underline;
	}
	.text_box{
		margin:10px 25px 10px 25px; 
		height:30px;
	}
	.line{
		width: 200px;
		border-bottom: 1px solid #e0e0e0;
		position: absolute;
	}
	.number{
		font-size: 12px;
		color: #333333;
		font-weight: bold
	}
	#div-box2{
	    width: 72%;
	    margin:20px auto 0 auto;
	}
	.page_box{
		display:block;
		text-align: center;
	}
	.page_box a{
	    color:black;
	    text-decoration:none;
	    
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
		
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	
		BookDAO bookDAO = new BookDAO();
		ArrayList<Book> list = bookDAO.getList(categoryNumber, pageNumber);		
		Util util = new Util();
	%>

	<div>
    	<p style="font-size:28px"><%= util.getCategoryName(categoryNumber) %></p>
   	</div>

	<div id="div-box1">    	
	
	    <ul class="faceul">
	    	<% 
	    	
	    	
	    		for(int i=0; i<list.size(); i++) {
	    	%>
	    		<%Book book = list.get(i); %>
	    		<li class="item"><a href="product.jsp?bookID=<%= book.getBookID()%>"><img src="<%=request.getContextPath()%>/images/<%= book.getBookImagePath() %>.jpeg"></a>
	    		
	    		<span class="text_box"><a href="product.jsp?bookID=<%= book.getBookID()%>"><%=book.getBookTitle() %></a></span>
	        	
	        	<span class="line"></span><br><span class="number"><%=book.getBookPrice() %></span></li>
	    	<%
	    		}
	    	%>
	    </ul>
	</div>
	
	<div class="page_box">
		<% 
			int numPage = 1;
			while (true) {
				
				if(bookDAO.nextPage(categoryNumber, numPage) == false)
					break;
		%>
				<a href="categoryView.jsp?categoryNumber=<%=categoryNumber%>&pageNumber=<%=numPage%>" class="btn btn-default"><%=numPage%></a>
		<%			
				numPage += 1;				
			}
			
			bookDAO.close();
		%>
	</div>
</body>
</html>