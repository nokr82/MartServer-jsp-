<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="DBerror.jsp"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

String name = request.getParameter("NAME");
String id = request.getParameter("ID");
String pass = request.getParameter("PASS");

//확인용 출력
System.out.println(name+","+id+","+pass);

String dburl = "jdbc:mysql://localhost:3306/martdb";
String dbuser = "root";
String dbpass = "1234";

Connection conn =null;
Statement stmt = null;

//중복 검사용 쿼리
String query = String.format("select userid from userinfo where userid='%s';",id);


try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(dburl,dbuser,dbpass);
	
	if(conn == null)
		throw new Exception("DB 연결 실패");
	
	stmt = conn.createStatement();
	
	ResultSet rs = stmt.executeQuery(query);
	
	String xmlstr = "<CONTENT> ";
	if(rs.next()){//중복아이디
		xmlstr += "<REG>ID중복</REG> ";
	}else{//중복없음
		//DB에 입력 처리
		query = String.format("insert into userinfo values ('%s','%s','%s');",id,name,pass);
	
		int rowCnt = stmt.executeUpdate(query);
		
		if(rowCnt <1){//입력실패
			xmlstr +="<REG>입력실패</REG> ";
		}else{//insert 성공
			xmlstr +="<REG>등록성공</REG> ";
		}
	}
	xmlstr +="</CONTENT>";
	
	out.print(xmlstr);//안드로이드로 전송
	
	rs.close();
}finally{
	try{
		
		if(stmt != null)
			stmt.close();
		if(conn != null)
			conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
}



%>