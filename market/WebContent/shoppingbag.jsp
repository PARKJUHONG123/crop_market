<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="market.*" %>
<!DOCTYPE html>
<html>
<head>

<style>
	#topMenu
	{ 
	height: 30px; /* 메인 메뉴의 높이 */
	width: 850px; /* 메인 메뉴의 넓이 */ 
	}
	
	#topMenu ul 
	{ 
	/* 메인 메뉴 안의 ul을 설정함: 상위메뉴의 ul+하위 메뉴의 ul */ 
	list-style-type: none; /* 메인 메뉴 안의 ul 내부의 목록 표시를 없애줌 */ 
	margin: 0px; /* 메인 메뉴 안의 ul의 margin을 없앰 */ 
	padding: 0px; /* 메인 메뉴 안의 ul의 padding을 없앰 */ 
	}
	
	#topMenu ul li { 
	/* 메인 메뉴 안에 ul 태그 안에 있는 li 태그의 스타일 적용(상위/하위메뉴 모두) */ 
	color: white; /* 글씨 색을 흰색으로 설정 */ 
	background-color: #2d2d2d; /* 배경 색을 RGB(2D2D2D)로 설정 */ 
	float: left; /* 왼쪽으로 나열되도록 설정 */ 
	line-height: 30px; /* 텍스트 한 줄의 높이를 30px로 설정 */ 
	vertical-align: middle; /* 세로 정렬을 가운데로 설정 */ 
	text-align: center; /* 텍스트를 가운데로 정렬 */ 
	position: relative; /* 해당 li 태그 내부의 top/left 포지션 초기화 */ 
	} 
	
	.menuLink, .submenuLink { 
	/* 상위 메뉴와 하위 메뉴의 a 태그에 공통으로 설정할 스타일 */ 
	text-decoration:none; /* a 태그의 꾸밈 효과 제거 */ 
	display: block; /* a 태그의 클릭 범위를 넓힘 */ 
	width: 150px; /* 기본 넓이를 150px로 설정 */ 
	font-size: 12px; /* 폰트 사이즈를 12px로 설정 */ 
	font-weight: bold; /* 폰트를 굵게 설정 */
	font-family: "Trebuchet MS", Dotum; /* 기본 폰트를 영어/한글 순서대로 설정 */ 
	}
	
	.menuLink { 
	/* 상위 메뉴의 글씨색을 흰색으로 설정 */ 
	color: white; 
	} 
	
	.topMenuLi:hover .menuLink { 
	/* 상위 메뉴의 li에 마우스오버 되었을 때 스타일 설정 */ 
	color: red; /* 글씨 색 빨간색 */ 
	background-color: #4d4d4d; /* 배경색을 밝은 회색으로 설정 */ 
	} 
	
	.submenuLink {
	 /* 하위 메뉴의 a 태그 스타일 설정 */ 
	 color: #2d2d2d; /* 글씨 색을 RGB(2D2D2D)로 설정 */ 
	 background-color: white; /* 배경색을 흰색으로 설정 */ 
	 border: solid 1px black; /* 테두리를 설정 */ 
	 margin-top: -1px; /* 위 칸의 하단 테두리와 아래칸의 상단 테두리가 겹쳐지도록 설정 */ 
	 } 
	 
	 .longLink { 
	 /* 좀 더 긴 메뉴 스타일 설정 */ 
	 width: 190px; /* 넓이는 190px로 설정 */ 
	 } 
	 
	 .submenu { 
	 /* 하위 메뉴 스타일 설정 */ 
	 position: absolute; /* html의 flow에 영향을 미치지 않게 absolute 설정 */ 
	 height: 0px; /* 초기 높이는 0px로 설정 */ 
	 overflow: hidden; /*실 내용이 높이보다 커지면 해당 내용 감춤 */ 
	 transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(기본) */ 
	 -webkit-transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(구버전 크롬/사파라ㅣ) */ 
	 -moz-transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(구버전 파폭) */ 
	 -o-transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(구버전 오페라) */ 
	 } 
	 
	 .topMenuLi:hover .submenu {
	  /* 상위 메뉴에 마우스 모버한 경우 그 안의 하위 메뉴 스타일 설정 */
	  height: 93px; /* 높이를 93px로 설정 */ 
	  /*overflow: visible;*/
	  }
	  
	   .submenuLink:hover { 
	   /* 하위 메뉴의 a 태그의 마우스 오버 스타일 설정 */ 
	   color: red; /* 글씨색을 빨간색으로 설정 */ 
	   background-color: #dddddd; /* 배경을 RGB(DDDDDD)로 설정 */
	   } 
	   
	   </style>

<meta charset="UTF-8">
<title>TMI :: TooMuchItem</title>
</head>
<body>
	<h2>TMI :: TooMuchItem</h2>
	<div class = "greetID">
		<%	// 세션 가져와서 이름 띄우기
			Statement stmt = null;
			String name = session.getAttribute("userSession") + "";
			String id = session.getAttribute("s_id") + "";
			Connection conn = null;
			String sql = "";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			sql = "";
		%>
		<a href="Main.jsp" style="float:left;"> HOME </a>
		<b> <%=name%>님 &nbsp; </b>
		
		<% if(id.equals("admin")) { %>
		<a href="Page_admin.jsp"> 관리자 </a> |	<%} %>
		<a href="my_page.jsp">마이페이지</a>
		<a href="shoppingbag.jsp">장바구니</a>
		<a href="_logout.jsp"> 로그아웃 </a>
		
	</div>
	
	<form action = "search.jsp">
	<input type = "search" name = "searchitem"/>
	<input type= "submit" value = "SEARCH"/>
	</form>
	
	<nav id="topMenu" >
		<ul>
		<%
			conn = DBUtil.getMySQLConnection();
			stmt = conn.createStatement();
			sql = "select distinct Main_category from CATEGORY";
			rs = stmt.executeQuery(sql);
			String Maincate;
			int count = 0;
			while(rs.next()){
			Maincate = rs.getString("Main_category");
			if(count != 0)
				out.println("<li>|</li>");
		%>
		<li class="topMenuLi">
		<a class="menuLink"><%=Maincate%></a>
		<ul class="submenu">
		<%
			Connection conn1 = DBUtil.getMySQLConnection();
			String sql1 = "select distinct Sub_category from CATEGORY where Main_category = ?";
			pstmt = conn1.prepareStatement(sql1);
			pstmt.setString(1, Maincate);
			ResultSet rs1=pstmt.executeQuery();
			String subcate1;
			while(rs1.next()){
				subcate1 = rs1.getString("Sub_category");
				String subcate = java.net.URLEncoder.encode(subcate1, "UTF-8");
		%>
			<li>
			<a class="submenuLink" href="cateresult.jsp?subcate=<%=subcate%>"><%=subcate1%></a>
			</li>
			<%
			}
			DBUtil.close(conn1); conn1 = null;
			DBUtil.close(pstmt); pstmt = null;
			DBUtil.close(rs1); rs1 = null;
			sql1 = "";
			%>
		</ul>
		</li>
	<%
	count++;}
	DBUtil.close(conn); conn = null;
	DBUtil.close(stmt); stmt = null;
	DBUtil.close(rs); rs = null;
	sql = "";
	%>
	</ul>
	</nav>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	<h3>장바구니</h3>
		<%
		conn = DBUtil.getMySQLConnection();
		sql = "select I.Item_number, I.Item_image,  I.Item_name, B.Quantity, I.Price " + 
		"FROM SHOPPINGBAG B, CUSTOMER C, ITEM I WHERE C.Id = ? "+
		"AND C.Id = B.Customer_id AND I.Item_number = B.Purchase_item";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		String image = "";
		String Ino = "";
		String Itemname = "";
		int quan = 0;
		int Itemprice = 0;
		int totalprice = 0;%>
		상품이미지 | 상품번호 | 상품이름 | 담은수량 | 가격
		<br><br>
		<%
		while(rs.next()){
			image = rs.getString("Item_image");
			Ino = rs.getString("Item_number");
			Itemname = rs.getString("Item_name");
			quan = rs.getInt("Quantity");
			Itemprice = rs.getInt("Price");
			totalprice = Itemprice * quan;
		%>
			<div class="image-box">
				<a href="board.jsp?Ino=<%=Ino %>">
					<img src="<%=image%>" width="50" height="50">
				</a>
			</div>
			<div class="box-itemnumber">
			    	<%=Ino%>
			</div>
			<div class="box-itemname">
			    	<%=Itemname%>
			</div>
		<form action="_shoppingbag.jsp?id=<%=id%>&Ino=<%=Ino%>" method="post">
            <div class="box-itemquan">
				 <input type="number" name="num" value="<%=quan%>" min="1">개
				 <input type="submit" value="수량수정">
				 <a href="dropitem.jsp?id=<%=id%>&Ino=<%=Ino%>&num=<%=quan%>">X</a>
			</div>
		</form>
            <div class="box-itemprice">
				 	<%=totalprice%>원
			</div>
		<%}
		
		DBUtil.close(conn); conn = null;
		DBUtil.close(stmt); stmt = null;
		DBUtil.close(pstmt); pstmt = null;
		DBUtil.close(rs); rs = null;
		sql = "";%>
		
		<form action="purchase.jsp?id=<%=id%>" method="post">
		<input type="submit" value="구매하기">
		</form>
		
</body>
</html>