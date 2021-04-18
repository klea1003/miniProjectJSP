<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="book.Book"%>
<%@ page import="book.BookDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width" , initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
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
	#div-box1 .faceul{
	    width: 85%;   
	    height: 550px;
	    /*Make ul automatically center horizontally*/
	    margin:20px auto 0 auto;
	}
	#div-box1 li{
	    /*Remove the style in front of li*/
	    list-style-type:none;
	    width: 200px;
	    height: 240px;    
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
	    color:black;
	    text-decoration:none;
	}
	.faceul a:hover{
	    color:red;
	    text-decoration:underline;
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
</style>
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	<nav class="navbar navbar-default">
		<!-- 네비게이션 -->
		<div class="navbar-header">
			<!-- 네비게이션 상단 부분 -->
			<!-- 네비게이션 상단 박스 영역 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null) {
			%>
				<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a> <!-- 드랍다운 아이템 영역 -->
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul></li>
				</ul>
			<%
				} else {
			%>
				<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a> <!-- 드랍다운 아이템 영역 -->
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul></li>
				</ul>
			<%
				}
			%>
			
		</div>
	</nav>
	<!-- 네비게이션 영역 끝 -->
	
	
	<div id="div-box2">
    	<p style="font-size:28px">Category</p>
   	</div>
     
    <div id="div-box1">    	
	
	    <ul class="faceul">
	    	<% 
	    	BookDAO bookDAO = new BookDAO();
			
			ArrayList<Book> list = bookDAO.getList(0);
	    	
	    		for(int i=0; i<list.size(); i++) {
	    	%>
	    		<%Book book = list.get(i); %>
	    		<li><img src="images/<%= book.getBookImagePath() %>.jpg">
	    		<span><a href="product.jsp?bookID=<%= book.getBookID()%>"><%=book.getBookTitle() %></a></span>
	        	<div class="line"></div><span class="number"><%=book.getBookPrice() %></span></li>
	    	<%
	    		}
	    	%>
	    </ul>
	</div>	

	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>