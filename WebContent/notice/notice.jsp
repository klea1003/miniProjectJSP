<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="notice.Notice"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<style> /* !! css 수정 부분 */
 .wrap{
	position:relative;
	/* width:1000px; */
	margin-right:0;
}
.container{
	position:absolute;
	top:40px;
	left:200px;
	width:1000px;
}
.fix{
	margin-left:0;
	margin-right:0;
}
.row > .table > thead > tr > th,
.row > .table > tbody > tr > th,
.row > .table > tfoot > tr > th,
.row > .table > thead > tr > td,
.row > .table > tbody > tr > td,
.row > .table > tfoot > tr > td {
 /*  padding: 8px; */ /* !!수정 부분 */
  line-height: 1.42857143;
  vertical-align: top;
  border-top: 1px solid #ddd;
} 


</style>
</head>
<jsp:include page="/include/header.jsp" flush="false"/>
<body>
	<%
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="wrap">  <!-- !!수정 부분 -->
	<div class="container">
		<div class="fix">
	    	<p style="font-size:28px">공지사항</p>
	   	</div>
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						NoticeDAO noticeDAO = new NoticeDAO();
						ArrayList<Notice> list = noticeDAO.getList(pageNumber);
						for(Notice notice: list) {
					%>
						<tr>
							<td><%= notice.getNoticeID() %></td>
							<td><a href="noticeView.jsp?noticeID=<%= notice.getNoticeID() %>">
							<%= notice.getNoticeTitle() %></a></td>
							<td><%= notice.getUserID() %></td>
							<td><%= notice.getNoticeDate() %></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href="notice.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%		
				}
				if(noticeDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="notice.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
			
			<a href="writeNotice.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	</div>
	<jsp:include page="/include/footer.jsp" flush="false"/>
	<!-- 게시판 메인 페이지 영역 끝 -->
</body>
</html>