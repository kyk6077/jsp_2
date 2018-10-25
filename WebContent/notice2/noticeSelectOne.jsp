<%@page import="com.iu.member.MemberDTO"%>
<%@page import="com.iu.notice.NoticeDTO"%>
<%@page import="com.iu.notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%NoticeDAO ntDAO = new NoticeDAO();
NoticeDTO ntDTO = ntDAO.selectOne(Integer.parseInt(request.getParameter("num")));
MemberDTO mDTO = (MemberDTO)session.getAttribute("member");
request.setAttribute("dto", ntDTO);

%>    
<jsp:useBean id="dto" class="com.iu.notice.NoticeDTO" scope="request"></jsp:useBean>
<jsp:getProperty property="*" name="dto"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../temp/bootstrap.jsp"></jsp:include>
<script type="text/javascript">
	<%if(ntDTO.getWriter()==null){%>
		alert("Fail");
		location.href="noticeList.jsp";
	<%}%>
</script>
<style type="text/css">

	.container-fluid{
		width: 80%;
		margin-top: 70px;
	}
	#body_title{
		text-align: center;
	}
	.table{
		margin-top:20px;
		text-align: center;
	}
	#content_main{
		margin: 30px;
	}
	//
</style>
</head>
<body>

<jsp:include page="../temp/header.jsp"></jsp:include>

<div class="container-fluid">
	<h1 id="body_title">NOTICE</h1>
	<table class="table">
		<tr class="active"><td>SUBJECT</td><td>NAME</td><td>DATE</td><td>HIT</td></tr>
		<tr><td><%= ntDTO.getTitle() %></td>
		<td><%= ntDTO.getWriter() %></td>
		<td><%= ntDTO.getReg_date() %></td>
		<td><%= ntDTO.getHit() %></td></tr>
	</table>
	<p id ="content_main"><%= ntDTO.getContents() %></p>
	
	<%if(mDTO != null && ntDTO.getWriter().equals(mDTO.getId())){ %>
	<a class="btn btn-primary" href="./noticeUpdateForm.jsp?num=<%= ntDTO.getNum()%>">UPDATE</a>
	<a class="btn btn-primary" href="./noticeDeleteProcess.jsp?num=<%= ntDTO.getNum()%>">DELETE</a>
	<%} %>
</div>
<jsp:include page="../temp/footer.jsp"></jsp:include>

</body>
</html>