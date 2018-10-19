<%@page import="com.iu.notice.NoticeDTO"%>
<%@page import="com.iu.notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%NoticeDAO ntDAO = new NoticeDAO();
NoticeDTO ntDTO = ntDAO.selectOne(Integer.parseInt(request.getParameter("num")));
ntDTO.setTitle(request.getParameter("title"));
ntDTO.setContents(request.getParameter("contents"));
int result = ntDAO.update(ntDTO);
String message = "Update Fail";
if(result>0){
	message = "Update Success";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	alert('<%= message %>');
	location.href="noticeList.jsp";
</script>
</head>
<body>

</body>
</html>