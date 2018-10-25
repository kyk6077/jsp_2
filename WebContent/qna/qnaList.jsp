<%@page import="java.util.List"%>
<%@page import="com.iu.qna.QnaDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.iu.qna.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	QnaDAO qnaDAO = new QnaDAO();
	int curPage = 1;
	String kind = request.getParameter("kind");
	String search= request.getParameter("search");
	
	if(kind==null){
		kind="title";
	}
	if(search==null){
		search="";
	}
	try {
		curPage = Integer.parseInt(request.getParameter("curPage"));
	} catch (Exception e) {
	}
	int perPage = 10;
	int startRow = (curPage - 1) * perPage + 1;
	int lastRow = curPage * perPage;
	List<QnaDTO> qnaList = qnaDAO.selectList(startRow, lastRow, kind, search);

	//페이징
	//1. 전체 글의 갯수
	int totalCount = qnaDAO.getCount(kind,search);
	//2. 전체 페이지의 갯수
	int totalPage = totalCount / perPage;
	if (totalCount % perPage != 0) {
		totalPage = totalCount / perPage + 1;
	}
	//3. 전체 블럭의 갯수
	int perBlock = 5;//블럭당 숫자의 갯수
	int totalBlock = totalPage / perBlock;
	if (totalPage % perBlock != 0) {
		// 	totalBlock = totalPage/perBlock+1;
		totalBlock += 1;
	}
	//4. curPage의 번호로 curBlock 구하기
	int curBlock = curPage / perBlock;
	if (curPage % perBlock != 0) {
		curBlock = curPage / perBlock + 1;
	}
	//5. curBlock 번호로  startNum lastNum 구하기
	int startNum = (curBlock - 1) * perBlock + 1;
	int lastNum = curBlock * perBlock;

	if (curBlock == totalBlock) {
		lastNum = totalPage;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../temp/bootstrap.jsp"></jsp:include>
</head>
<body>

<%@ include file="../temp/header.jsp" %>

<div class="container-fluid">
		<div class="row">
			<form class="form-inline" action="./qnaList.jsp">
				<div class="form-group">
					<select class="form-control" id="sel1" name="kind">
						<option>ID</option>
						<option>NAME</option>
					</select>
					<input type="text"
						class="form-control" id="search" placeholder="Enter search" name="search">
				</div>
				<button type="submit" class="btn btn-default">Search</button>
			</form>
		</div>
		<h1 id="body_title">NOTICE</h1>
		<table class="table list_table">
			<tr class="active">
				<td>NUM</td>
				<td>TITLE</td>
				<td>WRITER</td>
				<td>reg_date</td>
				<td>hit</td>
			</tr>
			<%
				for (int a=0; a<qnaList.size();a++) {
			%>
			<tr>
				<td><%=qnaList.get(a).getNum()%></td>
				<td><a href="./qnaSelectOne.jsp?num=<%= qnaList.get(a).getNum()%>">
					<%for(int i=0;i<qnaList.get(a).getDepth();i++){ %>--<%}%>
					<%=qnaList.get(a).getTitle()%></a></td>
				<td><%=qnaList.get(a).getWriter()%></td>
				<td><%=qnaList.get(a).getReg_date()%></td>
				<td><%=qnaList.get(a).getHit()%></td>
				
			</tr>
			<%
				}
			%>
		</table>

	</div>

	<div class="container-fluid">
		<div class="row">
			<ul class="pagination">
				<li><a href="./qnaList.jsp?curPage=<%=1%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-backward"></span></a></li>
				<%if (curBlock > 1) {%>
				<li><a href="./qnaList.jsp?curPage=<%=startNum - 1%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-chevron-left"></span></a></li>
				<%}%>
				<%for (int i = startNum; i <= lastNum; i++) {%>
				<li><a href="./qnaList.jsp?curPage=<%=i%>&kind=<%=kind%>&search=<%=search%>"><%=i%></a></li>
				<%}%>

				<%if (curBlock != totalBlock) {	%>
				<li><a href="./qnaList.jsp?curPage=<%=lastNum + 1%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-chevron-right"></span></a></li>
				<%}%>
				<li><a href="./qnaList.jsp?curPage=<%=totalPage%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-forward"></span></a></li>
			</ul>
		</div>
	</div>
	
	<div class="container-fluid">
		<div class="row">
			<a class="btn btn-warning" href="qnaWriteForm.jsp">Write</a>
		</div>
	</div>
	
<%@ include file="../temp/footer.jsp" %>
</body>
</html>