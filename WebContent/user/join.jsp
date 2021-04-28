<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<style>
.container .jumbotron{ /*!! 너비 조정 스타일 태그 및 선택자*/
 	position:relative;
 	width:400px;
 	margin-left:30%;
}

</style>

</head>
<html>
<jsp:include page="/include/header.jsp" flush="false"/>
<body>	
	<!-- 회원가입 양식 -->
	<div class="container">		<!-- 하나의 영역 생성 -->
		<!-- <div class="col-lg-4"> -->	<!-- 영역 크기 --> <!-- !!이 태그 생략 -->
			<!-- 점보트론은 특정 컨텐츠, 정보를 두드러지게 하기 위한 큰 박스 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="joinAction.jsp">
					<h3 style="text-align: center;">회원가입 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete="off" value="남자">남자
							</label>
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
							</label>
						</div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="회원가입">
				</form>
			</div>
		<!-- </div>	 -->  <!-- !!이 태그 생략 -->
	</div>
	<jsp:include page="/include/footer.jsp" flush="false"/>
</body>
</html>