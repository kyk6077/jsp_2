<%@page import="com.iu.member.MemberDTO"%>
<%@page import="com.iu.notice.NoticeDTO"%>
<%@page import="com.iu.notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%NoticeDAO ntDAO = new NoticeDAO();
NoticeDTO ntDTO = ntDAO.selectOne(Integer.parseInt(request.getParameter("num")));
MemberDTO mDTO = (MemberDTO)session.getAttribute("member");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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

<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="noticeList.jsp">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="./noticeList.jsp">NOTICE</a></li>
        <li><a href="#services">SERVICES</a></li>
        <li><a href="#portfolio">PORTFOLIO</a></li>
        <li><a href="#pricing">PRICING</a></li>
        <li><a href="#contact">CONTACT</a></li>
      </ul>
    </div>
  </div>
</nav>

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

</body>
</html>