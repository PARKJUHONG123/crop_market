<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, market.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴 화면</title>
<script type="text/javascript">
	function checkValue() {
		if(!document.deleteform.password.value) {
			alert("비밀번호를 입력하지 않았습니다.");
			return false;
		}
	}
</script>
</head>
<body>
	<br><br>
	<b><font size="6" color="gray">내 정보</font></b>
	<br><br><br>
	
	<form name="deleteform" method="post" action="DeletePro.jsp"
		onsubmit="return checkValue()">
		
		<table>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="password" maxlength="20"></td>
			</tr>
		</table>
		
		<br>
		<input type="button" value="취소" onclick="location.href='Main.jsp'">
		<input type="submit" value="탈퇴" />
	</form>
</body>
</html>