<%@page import="com.iu.member.MemberDTO"%>
<%@page import="com.iu.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
MemberDAO memberDAO = new MemberDAO();
int result = memberDAO.delete(memberDTO.getId());
String s = "Delete Fail";
String path = "../index.jsp";
if(result>0){
	s = "Delete Success";
	session.invalidate();
}
request.setAttribute("message", s);
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
<!-- 회원삭제 -->
<!-- 성공 Delete Success, index로 이동 -->
<!-- 실패 Delete Fail, index로 이동 -->
<body>
</body>
</html>