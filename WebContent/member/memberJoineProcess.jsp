<%@page import="com.iu.member.MemberDTO"%>
<%@page import="com.iu.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDTO mDTO = new MemberDTO();
MemberDAO mDAO = new MemberDAO();
mDTO.setId(request.getParameter("id"));
mDTO.setPw(request.getParameter("pw"));
mDTO.setName(request.getParameter("name"));
mDTO.setEmail(request.getParameter("email"));
mDTO.setKind(request.getParameter("kind"));
mDTO.setClassmate(request.getParameter("classmate"));

int result = mDAO.insert(mDTO);
String message = "insert Fail";
if(result > 0){
	message = "insert Success";
}

request.setAttribute("message", message);
request.setAttribute("path","../index.jsp");
//이동해야할 페이지의 주소
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