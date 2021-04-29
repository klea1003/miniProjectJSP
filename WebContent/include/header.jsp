<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="book.Book"%>
<%@ page import="book.BookDAO"%>
<%@ page import="book.Util" %>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>

body {
	width: 1500px;
	margin: 0 auto;
}

#main_header {
	postion: relative;
	height: 120px;
}

#main_header>div.login_menu {
	position: absolute;
	top: 10px;
	right: 100px;
}

#main_aside {
	width: 300px;
	height: 1500px;
	float: left;
	margin-left: 200px;
}

.inaside{
    /*Remove the style in front of li*/
    list-style-type:none;
    height: 50px;
    padding: 15px;
}

</style>
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width" , initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
<title>인디북</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		Util util = new Util();
	%>
</head>
<body>
	<header id="main_header">
		<div class="login_menu">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">고객센터<span class="caret"></span></a> <!-- 드랍다운 아이템 영역 -->
					<ul class="dropdown-menu">
						<li><a href="<%=request.getContextPath()%>/notice/notice.jsp">공지사항</a></li>
						<li><a href="<%=request.getContextPath()%>/faq/faq.jsp">FAQ</a></li>
					</ul>
				</li>
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">마이페이지<span class="caret"></span></a> <!-- 드랍다운 아이템 영역 -->
					<ul class="dropdown-menu">
						<li><a href="<%=request.getContextPath()%>/cart/cart.jsp">장바구니</a></li>
						<li><a href="<%=request.getContextPath()%>/user/updateUser.jsp">정보수정</a></li>
					</ul>
				</li>
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">마이페이지<span class="caret"></span></a> <!-- 드랍다운 아이템 영역 -->
					<ul class="dropdown-menu">
						<li><a href="<%=request.getContextPath()%>/cart/cart.jsp">장바구니</a></li>
						<li><a href="<%=request.getContextPath()%>/user/updateUser.jsp">정보수정</a></li>
					</ul>
				</li>
			</ul>	
		</div>
	</header>
	

		<nav id="main_aside">
			<ul>
				<li class="inaside" style=" font-family:굴림; font-weight:700 " ><a href="<%=request.getContextPath()%>/product/MainCategoryView.jsp">장르별 베스트 셀러</a></li>
				<% 
					for(int i=0; i<util.getCategoryLength(); i++){
				%>
					<li class="inaside" style=" font-family:굴림; font-weight:700 ">				
						<a href="<%=request.getContextPath()%>/product/categoryView.jsp?categoryNumber=<%=i%>&pageNumber=1"><%= util.getCategoryName(i)%></a>				
					</li>
	
				<%
					}
				%>
			</ul>	
			
		</nav>

</body>
</html>