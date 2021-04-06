<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
Hello jSP
한글 테스트
<%
	Connection conn =null;
	String url = "jdbc:oracle:thin:@localhost:1521:xe"; 
	String dbId = "scott";
	String dbPwd = "tiger";
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, dbId, dbPwd);
		out.print("DB Connection Completed");
		System.out.println();
	} catch (Exception e) {
		out.println(e.getMessage());
		e.printStackTrace();		
	}

%>
</body>
</html>