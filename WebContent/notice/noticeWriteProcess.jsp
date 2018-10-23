<%@page import="com.iu.notice.NoticeDTO"%>
<%@page import="com.iu.notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
NoticeDAO ntDAO = new NoticeDAO();
NoticeDTO ntDTO = new NoticeDTO();
ntDTO.setTitle(request.getParameter("title"));
ntDTO.setContents(request.getParameter("contents"));
ntDTO.setWriter(request.getParameter("writer"));
int result = ntDAO.insert(ntDTO);
String message = "Insert Fail";
if(result>0){
	message = "Insert Success";
}
request.setAttribute("message", message);
request.setAttribute("path","./noticeList.jsp");
RequestDispatcher view = request.getRequestDispatcher("../common/result.jsp");
view.forward(request, response);

//redirect
// response.sendRedirect("../index.jsp");//이동해야할 주소

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
</script>
</head>
<body>

</body>
</html>