<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="faq.Faq"%>
<%@ page import="faq.FaqDAO"%>
<!DOCTYPE html>
<html>
<jsp:include page="header.jsp" flush="false"/>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	// bbsID를 초기화 시키고
	// bbsID라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다.
	int faqID = 0;
	if(request.getParameter("faqID") != null) {
		faqID = Integer.parseInt(request.getParameter("faqID"));
	}
	
	if(faqID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}
	
	Faq faq = new FaqDAO().getFaq(faqID);
	%>
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%= faq.getFaqTitle()  %></td> 
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= faq.getUserID()  %></td> 
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%= faq.getFaqDate()  %></td> 
						</tr>	
						<tr>
							<td>내용</td>
							<td colspan="2" style="height: 200px; text-align: left;"><%= faq.getFaqContent().replaceAll(" ", "&nbsp;")
							.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td> 
						</tr>					
					</tr>
				</tbody>
			</table>
			<a href="faq.jsp" class="btn btn-primary">목록</a>
			
			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
			<%
				if(userID != null && userID.equals(faq.getUserID())){
			%>
					<a href="update.jsp?bbsID=<%= faqID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href=
						"deleteAction.jsp?bbsID=<%= faqID %>" class="btn btn-primary">삭제</a>
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