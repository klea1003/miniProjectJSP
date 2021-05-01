<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="notice.Notice"%>
<%@ page import="notice.NoticeDAO"%>
<!DOCTYPE html>
<html>
<head>
	<style>
		#container {
			width: 1000px;
			float: right;
		}
	</style>
</head>
<jsp:include page="/include/header.jsp" flush="false"/>
<body>
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
		int noticeID = 0;
		if(request.getParameter("noticeID") != null){
			noticeID = Integer.parseInt(request.getParameter("noticeID"));
		}
		if(noticeID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='notice.jsp'");
			script.println("</script>");
		}
		//해당 'noticeID'에 대한 게시글을 가져온 다음 세션을 통하여 작성자 본인이 맞는지 체크한다
		NoticeDAO noticeDAO = new NoticeDAO();
		Notice notice = noticeDAO.getNotice(noticeID);
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getUser(userID);
		int admin = user.getAdmin();
		if(!userID.equals(notice.getUserID()) || admin == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='notice.jsp'");
			script.println("</script>");
		}
		
		noticeDAO.close();
	%>
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div id="container">
		<div class="row">
			<form method="post" action="updateNoticeAction.jsp?noticeID=<%=noticeID%>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<!-- 테스트 코드 -->
							<tr>
								<td><input type="text" class="form-control" placeholder="글 제목" name="noticeTitle" maxlength="50" value="<%=notice.getNoticeTitle() %>"></td>
							</tr>
							<tr>
								<td><textarea class="form-control" placeholder="글 내용" name="noticeContent" maxlength="2048" style="height: 350px;"><%=notice.getNoticeContent() %></textarea></td>
							</tr>							
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="수정하기">
			</form>
		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->


	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>