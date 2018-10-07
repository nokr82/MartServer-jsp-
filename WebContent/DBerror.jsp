<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
    
    <%
    response.setStatus(200);
    String msg = exception.getMessage();
    
    /*
    <CONTENT>
    	<STATE>xmlmsg</STATE>
    </CONTENT>
    */
    
    //<CONTENT> <STATE>xmlmsg</STATE> </CONTENT>
    
    String xmlmsg = "<CONTENT> ";
    xmlmsg +="<STATE>"+msg+"</STATE> </CONTENT>";
    
    
    out.print(xmlmsg);
    
    
    
    
    %>