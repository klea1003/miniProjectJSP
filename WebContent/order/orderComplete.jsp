<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<style>
.orderComplete {
	width: 1000px;
	height: 550px;
	/*Make ul automatically center horizontally*/
	margin: 120px 100px 0 270px; /* !!수정 부분 */
}
.arrange{
	margin:auto 200px auto 200px;
	text-align:center;
}
</style>
</head>
<jsp:include page="/include/header.jsp" flush="false" />
<body>
	<%
		// 현재 세션 상태를 체크한다
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	<h2>&nbsp;&nbsp;&nbsp;&nbsp;주문 완료되었습니다.</h2>
	<div class="orderComplete">
		<table class="table table-striped"
			style="text-align: center; border: 1px solid gray">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center; border: 1px solid gray">받는
						사람</th>
					<th style="background-color: #eeeeee; text-align: center;  border: 1px solid gray;">주소</th>
				</tr>
			</thead>
			<tbody>
				<%
					UserDAO userDAO = new UserDAO();
				User user = userDAO.getUser(userID);
				%>
				<tr>
					<td style="border: 1px solid black"><%=user.getUserName()%></td>
					<td>주소 블라블라</td>
				</tr>

			</tbody>
		</table>
		<div class="right">
			<a href="main.jsp" class="btn btn-primary">메인으로</a>
		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
	<jsp:include page="/include/footer.jsp" flush="false"/>
</body>
</html>