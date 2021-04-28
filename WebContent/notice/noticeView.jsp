<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.Notice"%>
<%@ page import="notice.NoticeDAO"%>
<!DOCTYPE html>
<html>
<jsp:include page="/include/header.jsp" flush="false"/>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	int noticeID = 0;
	if(request.getParameter("noticeID") != null) {
		noticeID = Integer.parseInt(request.getParameter("noticeID"));
	}
	
	if(noticeID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='notice.jsp'");
		script.println("</script>");
	}
	
	Notice notice = new NoticeDAO().getNotice(noticeID);
	%>
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">공지사항 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%= notice.getNoticeTitle()  %></td> 
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= notice.getUserID()  %></td> 
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%= notice.getNoticeDate()  %></td> 
						</tr>	
						<tr>
							<td>내용</td>
							<td colspan="2" style="height: 200px; text-align: left;"><%= notice.getNoticeContent().replaceAll(" ", "&nbsp;")
							.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td> 
						</tr>					
					</tr>
				</tbody>
			</table>
			<a href="notice.jsp" class="btn btn-primary">목록</a>
			
			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
			<%
				if(userID != null && userID.equals(notice.getUserID())){
			%>
					<a href="updateNotice.jsp?bbsID=<%= noticeID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href=
						"deleteNoticeAction.jsp?bbsID=<%= noticeID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->


	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>