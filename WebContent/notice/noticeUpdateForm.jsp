<%@page import="com.iu.notice.NoticeDTO"%>
<%@page import="com.iu.notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%NoticeDAO ntDAO = new NoticeDAO();
NoticeDTO ntDTO = ntDAO.selectOne(Integer.parseInt(request.getParameter("num")));

%>    

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.main-content{
		margin-top: 100px;
	}
	.main-form input{
		width: 80%;
	}
	#content-input{
		height: 300px;
	}
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

<div class="col-sm-10 main-content">
	<form action="noticeUpdateProcess.jsp" class="main-form">
		<input type="hidden" name="num" value="<%= ntDTO.getNum() %>">
		<p>Title : <input type="text" name="title" value="<%= ntDTO.getTitle() %>"></p>
		<p>Contents : <input type="text" name="contents" value="<%= ntDTO.getContents() %>" id="contents-input"></p>
		<button class="btn btn-primary">OK</button>
	</form>

</div>
</body>
</html>