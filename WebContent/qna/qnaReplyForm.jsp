<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../temp/bootstrap.jsp"></jsp:include>
<% int num = Integer.parseInt(request.getParameter("num")); %>
<style type="text/css">
	.body_title{
		text-align: center;
	}
</style>
</head>
<body>

<%@ include file="../temp/header.jsp" %>

<div class="container-fluid">
	<div class="row">
  <h2 class="body_title">Reply Form</h2>
  <form class="form-horizontal" action="./qnaReplyProcess.jsp">
  	<input type="hidden" name="num" value="<%= num%>">
    <div class="form-group">
      <label class="control-label col-sm-2">Title:</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" name="title">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2">Contents:</label>
      <div class="col-sm-10">          
        <textarea rows="15" cols="" class="form-control" name="contents"></textarea>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2">Writer:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" name="writer">
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default">Submit</button>
        <a href="qnaList.jsp" class="btn btn-default">List</a>
      </div>
    </div>
  </form>
  </div>
</div>

<%@ include file="../temp/footer.jsp" %>
</body>
</html>