<%@page import="java.io.PrintWriter"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@page import="faq.FaqDAO"%>
<%@page import="faq.Faq"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		// 현재 세션 상태를 체크한다
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		int faqID = 0;
		if(request.getParameter("faqID") != null){
			faqID = Integer.parseInt(request.getParameter("faqID"));
		}
		if(faqID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='faq.jsp'");
			script.println("</script>");
		}
		
		//해당 'faqID'에 대한 게시글을 가져온 다음 세션을 통하여 작성자 본인이 맞는지 체크한다
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getUser(userID);
		int admin = user.getAdmin();
		FaqDAO faqDAO = new FaqDAO();
		Faq faq = faqDAO.getFaq(faqID);
		if(!userID.equals(faq.getUserID())  || admin == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='faq.jsp'");
			script.println("</script>");
		} else{
			// 입력이 안 됐거나 빈 값이 있는지 체크한다
			if(request.getParameter("faqTitle") == null || request.getParameter("faqContent") == null
				|| request.getParameter("faqTitle").equals("") || request.getParameter("faqContent").equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				// 정상적으로 입력이 되었다면 글 수정 로직을 수행한다
				int result = faqDAO.update(faqID, request.getParameter("faqTitle"), request.getParameter("faqContent"));
				// 데이터베이스 오류인 경우
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정하기에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				// 글 수정이 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
				}else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정하기 성공')");
					script.println("location.href='faq.jsp'");
					script.println("</script>");
				}
			}
		}
		faqDAO.close();
		userDAO.close();
	
	%>
</body>
</html>