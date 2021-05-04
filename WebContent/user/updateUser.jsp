<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
	<style>
		.center_box {
			position: absolute;
			left: 40%;
		}
	</style>
</head>
<jsp:include page="/include/header.jsp" flush="false"/>
<body sytle="text-align: center;">
	<%
		// 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getUser(userID);
	%>
	<!-- 회원가입 양식 -->
	<div class="container center_box">		<!-- 하나의 영역 생성 -->
		<div class="col-lg-4">	<!-- 영역 크기 -->
			<!-- 점보트론은 특정 컨텐츠, 정보를 두드러지게 하기 위한 큰 박스 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="updateUserAction.jsp">
					<h3 style="text-align: center;">회원 정보 수정</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20" value="<%= user.getUserID() %>">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20" value="<%= user.getUserPassword() %>">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20" value="<%= user.getUserName() %>">
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<% 
								if(user.getUserGender().equals("남자")) {
							%>
								<label class="btn btn-primary active">
									<input type="radio" name="userGender" autocomplete="off" value="남자">남자
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
								</label>
							<%
								} else {
							%>
								<label class="btn btn-primary">
									<input type="radio" name="userGender" autocomplete="off" value="남자">남자
								</label>
								<label class="btn btn-primary active">
									<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
								</label>
							<%
								}
							%>
						</div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20" value="<%= user.getUserEmail() %>">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="주소" name="userAddress" maxlength="80" value="<%= user.getUserAddress() %>">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="수정완료">
				</form>
			</div>
		</div>	
	</div>
</body>
</html>