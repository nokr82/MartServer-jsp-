<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="DBerror.jsp"%>
    <%@ page import="java.sql.*" %>
    <%
    request.setCharacterEncoding("UTF-8");
    
    String msg = request.getParameter("MSG");
    System.out.println(msg);//확인용 출력
    
    //DB의 bookinfo테이블 전체검색
    //xml문서로 만들어서 안드로이드로 전송
    String dburl = "jdbc:mysql://localhost:3306/martdb";
    String dbuser = "root";
    String dbpass = "1234";

    Connection conn =null;
    Statement stmt = null;
    
    String query = "select*from orderinfo;";
    try{
    	Class.forName("com.mysql.jdbc.Driver");
    	conn = DriverManager.getConnection(dburl,dbuser,dbpass);
    	
    	if(conn == null)
    		throw new Exception("DB 연결 실패");
    	
    	stmt = conn.createStatement();
    	
    	ResultSet rs = stmt.executeQuery(query);
    	
    	String xmlstr = "";
    	
    	int start = 0;
    	
    	while(rs.next()){
    		int dno = rs.getInt(1);
    		String dorder = rs.getString(2);
    		String dsize = rs.getString(3);
    		String daddress = rs.getString(4);
    		int dprice = rs.getInt(5);
    		String damount = rs.getString(6);
    		String dproduct = rs.getString(7);
    		
    		
    		
    		if(start == 0){
    			xmlstr ="<CONTENT> ";
    		}else{
    			xmlstr +="<CONTENT> ";
    		}
    		xmlstr +="<NO>"+dno+"</NO> ";
    		xmlstr +="<ORDER>"+dorder+"</ORDER> ";
    		xmlstr +="<SIZE>"+dsize+"</SIZE> ";
    		xmlstr +="<ADDRESS>"+daddress+"</ADDRESS> ";
    		xmlstr +="<PRICE>"+dprice+"</PRICE> ";
    		xmlstr +="<AMOUNT>"+damount+"</AMOUNT> ";
    		xmlstr +="<PRODUCT>"+dproduct+"</PRODUCT> ";
    		xmlstr +="</CONTENT> ";
   			start++;
    	}
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