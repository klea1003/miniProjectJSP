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

.side {
	width: 11%;
	height: 85%;
	/* background: #80cbc4; */
	background:  #80cbc4, #FFFFFF ;
	color: white;
	float: left;
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
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		Util util = new Util();
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
			<a class="navbar-brand" href="<%=request.getContextPath()%>/product/MainCategoryView.jsp">INDIEBOOK</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
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
	</nav>
	<!-- 네비게이션 영역 끝 -->


	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
</head>

<div class="fix1">
<aside class="side">
	<div>
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
		
		
	</div>
</aside>
</div>
</html>