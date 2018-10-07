<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="DBerror.jsp"%>
    <%@ page import="java.sql.*" %>
    <%
    request.setCharacterEncoding("UTF-8");
    //안드로이드 osw에 입력한스트링배열과 같게 
    String title = request.getParameter("TITLE");
    String cate = request.getParameter("CATE");
    String size = request.getParameter("SIZE");
    String price = request.getParameter("PRICE");
    String intro = request.getParameter("INTRO");
    
    System.out.println(title);
    
    String dburl = "jdbc:mysql://localhost:3306/martdb";
    String dbuser = "root";
    String dbpass = "1234";

    Connection conn =null;
    Statement stmt = null;
    
    String query = String.format("insert into productinfo values (null,'%s','%s','%s',%s,'%s');"
    ,title,cate,size,price,intro);
    try{
    	Class.forName("com.mysql.jdbc.Driver");
    	conn = DriverManager.getConnection(dburl,dbuser,dbpass);
    	
    	if(conn == null)
    		throw new Exception("DB 연결 실패");
    	
    	stmt = conn.createStatement();
    	
    	int rowCnt = stmt.executeUpdate(query);
    	
    	if(rowCnt <1){
    		throw new Exception("추가실패");
    	}else{
    		String xmlstr = "<CONTENT> ";
    		xmlstr +="<STATE>추가성공</STATE> ";
    		xmlstr +="</CONTENT>";
    		
    		out.print(xmlstr);
    		
    	}
    	
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
