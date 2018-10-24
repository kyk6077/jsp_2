<%@page import="com.iu.member.MemberDAO"%>
<%@page import="com.iu.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDAO memberDAO = new MemberDAO();
MemberDTO memberDTO = new MemberDTO();
memberDTO.setId(request.getParameter("id"));
memberDTO.setPw(request.getParameter("pw"));
memberDTO.setName(request.getParameter("name"));
memberDTO.setEmail(request.getParameter("email"));
int result = memberDAO.update(memberDTO);
if(result>0){
	MemberDTO s = (MemberDTO)session.getAttribute("member");
	s.setName(memberDTO.getName());
	s.setEmail(memberDTO.getEmail());
	response.sendRedirect("../index.jsp");
}else{
	request.setAttribute("message", "Update Fail");
	request.setAttribute("path", "../index.jsp");
	RequestDispatcher view = request.getRequestDispatcher("../common/result.jsp");
	view.forward(request, response);
}

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