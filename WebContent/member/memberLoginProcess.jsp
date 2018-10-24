<%@page import="com.iu.member.MemberDAO"%>
<%@page import="com.iu.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDTO memberDTO = new MemberDTO();
memberDTO.setId(request.getParameter("id"));
memberDTO.setPw(request.getParameter("pw"));
String remember = request.getParameter("remember");

if(remember != null){
	Cookie c = new Cookie("remember",memberDTO.getId());//이름(String),값(String)
	c.setMaxAge(60*60*24*365);//
// 	c.setDomain("/localhost/jsp_2");
	response.addCookie(c);
}else{
	Cookie c = new Cookie("remember","");
	c.setMaxAge(0);
	response.addCookie(c);
}
MemberDAO memberDAO = new MemberDAO();
memberDTO = memberDAO.selectOne(memberDTO);
String result = "Login Fail";
String path = "./memberLogin.jsp";
if(memberDTO != null){
	result = "Login Success";
	path ="../index.jsp";
	session.setAttribute("member",memberDTO);
	session.setMaxInactiveInterval(60*10);
	
}
request.setAttribute("message", result);
request.setAttribute("path", path);

RequestDispatcher view = request.getRequestDispatcher("../common/result.jsp");
view.forward(request, response);

%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>