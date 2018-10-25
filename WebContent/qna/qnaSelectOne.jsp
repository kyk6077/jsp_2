<%@page import="com.iu.qna.QnaDTO"%>
<%@page import="com.iu.qna.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
QnaDAO qnaDao = new QnaDAO();
int num = Integer.parseInt(request.getParameter("num"));
QnaDTO qnaDTO = qnaDao.selectOne(num);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../temp/bootstrap.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../temp/header.jsp"></jsp:include>

	<div class="container-fluid">
		<h1 id="body_title">NOTICE</h1>
		<table class="table">
			<tr class="active">
				<td>NUM</td><td>TITLE</td><td>WRITER</td>
			</tr>
			<tr>
				<td><%=qnaDTO.getNum()%></td>
				<td><%=qnaDTO.getTitle()%></td>
				<td><%=qnaDTO.getWriter()%></td>
			</tr>
		</table>
		<p id="content_main"><%=qnaDTO.getContents()%></p>
		
		<a class="btn btn-primary" href="./qnaList.jsp?num=<%=qnaDTO.getNum()%>">List</a> 
		<a class="btn btn-primary" href="./qnaUpdate.jsp?num=<%=qnaDTO.getNum()%>">Update</a>
		<a class="btn btn-primary" href="./qnaDelete.jsp?num=<%=qnaDTO.getNum()%>">Delete</a>
		<a class="btn btn-primary" href="./qnaReplyForm.jsp?num=<%=qnaDTO.getNum()%>">Reply</a>

	</div>
	<jsp:include page="../temp/footer.jsp"></jsp:include>
</body>
</html>