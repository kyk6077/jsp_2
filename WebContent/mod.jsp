<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <%@ include file="./module.jsp" %> --%>
	<jsp:include page="./module.jsp">
		<jsp:param value="iu" name="id"/>
	</jsp:include>
	<h1>Mod Page</h1>
</body>
</html>