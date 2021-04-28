<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="book.Book"%>
<%@ page import="book.BookDAO"%>
<%@ page import="book.Util"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<!-- Product Style sheet -->
<style type="text/css">
* {
	/*Remove the margins of all elements*/
	/*You can remove the left margin of li in ul to make it beautiful*/
	margin: 0;
	padding: 0;
}



#div-box1 .faceul {
	width: 85%;
	height: 550px;
	/*Make ul automatically center horizontally*/
	margin: 20px auto 0 auto;	/* !!수정 부분 */
}

#div-box1 li {
	/*Remove the style in front of li*/
	list-style-type: none;
	width: auto;
	height: 260px;
	/* border:1px solid red; */
	/*To put li in a row, use left and left float*/
	float: left;
	margin: 10px 0 0 10px;		/* !!수정 부분 */
}

.faceul img {
	width: 200px;
}

.faceul span {
	display: block;
}

.faceul a:link {
	color: black;
	text-decoration: none;
}

.faceul a:hover {
	color: red;
	text-decoration: underline;
}

.line {
	width: 200px;
	border-bottom: 1px solid #e0e0e0;
	position: absolute;
}

.number {
	font-size: 12px;
	color: #333333;
	font-weight: bold
}

#div-box2 {
	width: 72%;
	margin: 20px auto 0 auto;
}
#div-box1 {
	/* width: 90%; */
	width: 95%;
	margin: 20px auto 0 auto;
	text-align: center;
	position:relative;	/* !!수정 부분 */
}
.container2 {
	display: grid;
	grid-template-rows: repeat(6, 3fr);
	grid-template-columns: repeat(5, 1fr);
	/* row-gap: 20px;
	column-gap: 10px; */
	width:800px;
	position:absolute;	/* !!수정 부분 */
	left:180px;			/* !!수정 부분 */
}

</style>
<jsp:include page="/include/header.jsp" flush="false" />
</head>
<body>
	<%
		int categoryNumber = 1;
	if (request.getParameter("categoryNumber") != null) {
		categoryNumber = Integer.parseInt(request.getParameter("categoryNumber"));
	}

	BookDAO bookDAO = new BookDAO();
	ArrayList<Book> list = bookDAO.getList(categoryNumber);
	Util util = new Util();
	%>

	<div id="div-box2">
		<p style="font-size: 28px">
			&nbsp;&nbsp;&nbsp;<%=util.getCategoryName(categoryNumber)%></p>
	</div>

	<%-- <div id="div-box1">    	
	
	    <ul class="faceul">
	    	<% 
	    	
	    	
	    		for(int i=0; i<list.size(); i++) {
	    	%>
	    		<%Book book = list.get(i); %>
	    		<li>
	    		<a href="product.jsp?bookID=<%= book.getBookID()%>"><img src="images/<%= book.getBookImagePath() %>.jpeg"></a>
	    		<span><a href="product.jsp?bookID=<%= book.getBookID()%>"><%=book.getBookTitle() %></a></span>
	        	<div class="line"></div><span class="number"><%=book.getBookPrice() %></span>
	        	</li>
	    	<%
	    		}
	    	%>
	    </ul>
	</div>	 --%>
	<div id="div-box1">

		<div class="faceul container2">
			<%
				for (int i = 0; i < list.size(); i++) {
			%>
			<%
				Book book = list.get(i);
			%>
			<div class="wrap">
			<div class="item2">
				<a href="product.jsp?bookID=<%=book.getBookID()%>"> <img
					src="<%=request.getContextPath()%>/images/<%=book.getBookImagePath()%>.jpeg"></a>
				<div style="height: 20px">
					<a href="product.jsp?bookID=<%=book.getBookID()%>"><%=book.getBookTitle()%></a>
				</div>
				<br> 
				<span class="line" style="margin-left:20px;"> </span>
				<span class="number"><%=book.getBookPrice()%>원</span>
			</div>
			</div>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>