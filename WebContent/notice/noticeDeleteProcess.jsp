<%@page import="com.iu.notice.NoticeDAO"%>
<%@page import="com.iu.notice.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%NoticeDAO ntDAO = new NoticeDAO();
int num = Integer.parseInt(request.getParameter("num"));
int result = ntDAO.delete(num);
String message ="Delete Fail";
if(result>0){
	message="Delete Success";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	alert('<%= message%>');
	location.href = "noticeList.jsp"
</script>
</head>
<body>

</body>
</html>