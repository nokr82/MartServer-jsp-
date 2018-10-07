<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="DBerror.jsp"%>
    <%@page import="java.sql.*" %>
    
    <%
    request.setCharacterEncoding("UTF-8");
    
    String id = request.getParameter("ID");
    String pass = request.getParameter("PASS");
    
    //연결상태 확인용 문장 출력(안해도상관 없음 확인용)
    System.out.println("id: "+id+", pass: "+pass);
    
    
    //DB접속 및 id,pass검색 후 결과 전송
   	String dburl = "jdbc:mysql://localhost:3306/martdb";
    String dbuser = "root";
    String dbpass = "1234";
    
    Connection conn = null;
    Statement stmt = null;
    
    String query = String.format("select*from userinfo where userid='%s';",id);
    
    try{
    	Class.forName("com.mysql.jdbc.Driver");
    	
    	conn=DriverManager.getConnection(dburl,dbuser,dbpass);
    	
    	if(conn==null)
    		throw new Exception("DB연결 실패!!");
    	
    	stmt=conn.createStatement();
    	
    	ResultSet rs =stmt.executeQuery(query);
    	
    	if(rs.next()){//id에 해당하는 데이터가 있음
    		String name = rs.getString("name");
    		String dpass = rs.getString("pass");
    		String apass = rs.getString("pass");
    		apass = "111";
    		String xmlstr="<CONTENT> ";//전송 결과를 xml로 작성
    		
    		if(pass.equals(apass)==true){
    			xmlstr += "<LOGIN>성공</LOGIN> <NAME>"+name+"</NAME> ";
    			
    		
    		}else if(pass.equals(dpass)==true){
    			xmlstr += "<LOGIN>고객성공</LOGIN> <NAME>"+name+"</NAME> ";
    			
    			
    		}
    		else{
    			xmlstr="<LOGIN>실패</LOGIN> ";
    		}
    		xmlstr+="</CONTENT>";
    		
    		out.print(xmlstr);//안드로이드 앱으로 전송
    		
    	}else{//DB에 데이터가 없다
    		throw new Exception("ID가 없습니당!~");
    	}
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