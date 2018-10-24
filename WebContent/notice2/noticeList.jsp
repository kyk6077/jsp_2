<%@page import="com.iu.member.MemberDTO"%>
<%@page import="com.iu.notice.NoticeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.iu.notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	NoticeDAO nDAO = new NoticeDAO();
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
	ArrayList<NoticeDTO> ntList = nDAO.selectList(startRow, lastRow, kind, search);

	//페이징
	//1. 전체 글의 갯수
	int totalCount = nDAO.getCount(kind,search);
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
<html lang="en">
<head>
<!-- Theme Made By www.w3schools.com - No Copyright -->
<title>Bootstrap Theme Company Page</title>
<meta charset="utf-8">
<jsp:include page="../temp/bootstrap.jsp"></jsp:include>


</head>
<body id="myPage" data-spy="scroll" data-target=".navbar"
	data-offset="60">

	<%@ include file="../temp/header.jsp" %>



	<div class="container-fluid">
		<div>
			<form class="form-inline" action="./noticeList.jsp">
				<div class="form-group">
					<select class="form-control" id="sel1" name="kind">
						<option>Title</option>
						<option>Contents</option>
						<option>Writer</option>
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
				<td>NO</td>
				<td>SUBJECT</td>
				<td>NAME</td>
				<td>DATE</td>
				<td>HIT</td>
			</tr>
			<%
				for (int a = 0; a < ntList.size(); a++) {
			%>
			<tr>
				<td><%=ntList.get(a).getNum()%></td>
				<td id="td_title"><a
					href="noticeSelectOne.jsp?num=<%=ntList.get(a).getNum()%>"> <%=ntList.get(a).getTitle()%></a></td>
				<td><%=ntList.get(a).getWriter()%></td>
				<td><%=ntList.get(a).getReg_date()%></td>
				<td><%=ntList.get(a).getHit()%></td>
			</tr>
			<%
				}
			%>
		</table>

	</div>

	<div class="container-fluid">
		<div class="row">
			<ul class="pagination">
				<li><a href="./noticeList.jsp?curPage=<%=1%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-backward"></span></a></li>
				<%if (curBlock > 1) {%>
				<li><a href="./noticeList.jsp?curPage=<%=startNum - 1%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-chevron-left"></span></a></li>
				<%}%>
				<%for (int i = startNum; i <= lastNum; i++) {%>
				<li><a href="./noticeList.jsp?curPage=<%=i%>&kind=<%=kind%>&search=<%=search%>"><%=i%></a></li>
				<%}%>

				<%if (curBlock != totalBlock) {	%>
				<li><a href="./noticeList.jsp?curPage=<%=lastNum + 1%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-chevron-right"></span></a></li>
				<%}%>
				<li><a href="./noticeList.jsp?curPage=<%=totalPage%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-forward"></span></a></li>
			</ul>
		</div>
	</div>
	

	<div class="container-fluid">
		<div class="row">
			<a class="btn btn-warning" href="noticeWriteForm.jsp">Write</a>
		</div>
	</div>
	
	<jsp:include page="../temp/footer.jsp"></jsp:include>
</body>
</html>
