<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="market.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>TMI :: TooMuchItem</title>
	</head>
	<body>
		<h2>TMI :: TooMuchItem</h2>
		
	<%
		Connection conn = DBUtil.getMySQLConnection();
		PreparedStatement pstmt;
		ResultSet rs;
		
		////////query1///////
		String id = request.getParameter("ID");
		String pw = request.getParameter("PW"); //사용자가 login.html에서 입력한 id, 비밀번호
		String query = "select * from CUSTOMER where Id = ?";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, id);
		rs=pstmt.executeQuery();
		String password = "";
		String name = "";
		while(rs.next()){
			password = rs.getString("PW");
			name = rs.getString("Name");
		}
	
		pstmt.close();
		conn.close(); //비밀번호 정보를 가져왔으므로 디비 연결 종료  
		
		if(password.equals(pw)){
			out.println("<script> alert('로그인 되었습니다. 환영합니다. :)'); </script>");
			session.setAttribute("s_id", id);
			session.setAttribute("userSession", name);
			response.sendRedirect("Main.jsp");
			
		}else{
			out.println("<script> alert(\"회원 정보가 없습니다\"); history.back(); </script>");
		}
	%>
	</body>
</html>