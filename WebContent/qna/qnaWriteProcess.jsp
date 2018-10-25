<%@page import="com.iu.qna.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="qnaDTO" class="com.iu.qna.QnaDTO"></jsp:useBean>
<jsp:setProperty property="*" name="qnaDTO"/>
<%
QnaDAO qnaDAO = new QnaDAO();
int result = qnaDAO.insert(qnaDTO);
String r = "Write Fail";
if(result>0){
	r= "Write Success";
}
request.setAttribute("message", r);
request.setAttribute("path","./qnaList.jsp");
%>
<jsp:forward page="../common/result.jsp"></jsp:forward>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>