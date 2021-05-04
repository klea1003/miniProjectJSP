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

.font-face{
	font-size:30px;
	position: absolute;
	left: 200px;
	padding: 50px;
}

.font-face a:hover{
	color:grey;
	text-decoration:none;
}

.font-face a{
	color:#424242;
}

#footer{ 
	position:fixed;
	bottom:0;
  	width:100%;
 	background:#f4f4f4;
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
	<p class="font-face"><a href="<%=request.getContextPath()%>/product/MainCategoryView.jsp">INDIEBOOK</a></p>
		
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
			
			<%
				if(userID == null) {
			%>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="<%=request.getContextPath()%>/user/join.jsp">회원가입</a></li>
					</ul>
					
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">로그인<span class="caret"></span></a> <!-- 드랍다운 아이템 영역 -->
							<ul class="dropdown-menu">
								<li><a href="<%=request.getContextPath()%>/user/login.jsp">로그인</a></li>
								<li><a href="<%=request.getContextPath()%>/user/Adminlogin.jsp">관리자 로그인</a></li>
							</ul>
						</li>
					</ul>
			<%
				} else {
			%>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="<%=request.getContextPath()%>/user/logoutAction.jsp">로그아웃</a></li>
					</ul>
					
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#"><%= userID %> 님 환영합니다</a></li>
					</ul>
			<%
				}
			%>
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
	<div class="wrapper">
		<header></header>
		<div id="container"></div>
		<div id="footer">
			<h4>COMPANY INFO</h4>
			<p class="h4_line"></p>
			<ul>
				<li><strong>회사명</strong> <span>인디북</span> <strong>대표</strong> <span>김루트</span>
					<strong>대표전화</strong> <span>124-1234-1234</span> <strong>팩스</strong>
					<span>1234-2222-3333</span></li>
				<li><strong>주소</strong> <span>12345 서울 글로벌구 아이티로 12-34</span></li>
				<li><strong>사업자 등록번호</strong> <span>123-45-12345</span> <strong>개인정보관리책임자</strong>
					<span>홍길동</span></li>
			</ul>
		</div>
	</div>
</body>
</html>