<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.iu.member.MemberDAO"%>
<%@page import="com.iu.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%MemberDAO mDAO = new MemberDAO();
int curPage = 1;
String kind = "";
String search ="";

kind = request.getParameter("kind");
if(kind== null || kind.equals("")){
	kind="id";
}
search = request.getParameter("search");
if(search==null){
	search = "";
}
try{
	curPage = Integer.parseInt(request.getParameter("curPage"));
}catch(Exception e){
}
int perPage = 10;
int perBlock = 5;
//1. startLow, lastLow
int startRow = (curPage-1)*perPage+1;
int lastRow = curPage*perPage;
List<MemberDTO> mList = mDAO.memberList(startRow, lastRow,kind,search);
//전체 갯수
int totalCount = mDAO.getCount(kind,search);
//전체 페이지 갯수
int totalPage = totalCount/perPage;
if(totalCount%10 != 0){
	totalPage++;
}
//전체 블럭수
int totalBlock = totalPage/perBlock;
if(totalPage%perBlock != 0){
	totalBlock++;
}
//curPage로 curBlock 번호 구하기
int curBlock = curPage/perBlock;
if(curPage%perBlock != 0){
	curBlock++;
}

//curBlock으로 startNum lastNum 구하기
int lastNum = curBlock*perBlock;
int startNum = (curBlock-1)*perBlock+1;

//curBlock 마지막Block(totalBlock) 일때
if(curBlock == totalBlock){
	lastNum = totalPage;
}

%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../temp/bootstrap.jsp"></jsp:include>
<style type="text/css">
	.container{
		width: 90%;
	}
	.container-fluid{
		margin-top: 80px;
	}
	.body_title{
		margin-top: 80px;
		margin-bottom: 30px;
		text-align: center;
	}
	
</style>
</head>
<body>

<jsp:include page="../temp/header.jsp"></jsp:include>


<div class="container-fluid">
		<div class="row">
			<form class="form-inline" action="./memberList.jsp">
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
				<td>ID</td>
				<td>NAME</td>
				<td>KIND</td>
			</tr>
			<%
				for (int a=0; a<mList.size();a++) {
			%>
			<tr>
				<td><%=a+1%></td>
				<td><%=mList.get(a).getId()%></td>
				<td><%=mList.get(a).getName()%></td>
				<td><%=mList.get(a).getKind()%></td>
			</tr>
			<%
				}
			%>
		</table>

	</div>

	<div class="container-fluid">
		<div class="row">
			<ul class="pagination">
				<li><a href="./memberList.jsp?curPage=<%=1%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-backward"></span></a></li>
				<%if (curBlock > 1) {%>
				<li><a href="./memberList.jsp?curPage=<%=startNum - 1%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-chevron-left"></span></a></li>
				<%}%>
				<%for (int i = startNum; i <= lastNum; i++) {%>
				<li><a href="./memberList.jsp?curPage=<%=i%>&kind=<%=kind%>&search=<%=search%>"><%=i%></a></li>
				<%}%>

				<%if (curBlock != totalBlock) {	%>
				<li><a href="./memberList.jsp?curPage=<%=lastNum + 1%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-chevron-right"></span></a></li>
				<%}%>
				<li><a href="./memberList.jsp?curPage=<%=totalPage%>&kind=<%=kind%>&search=<%=search%>"><span
						class="glyphicon glyphicon-forward"></span></a></li>
			</ul>
		</div>
	</div>
	
	<%
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
	%>
	
	<div class="container-fluid">
		<div class="row">
			<%if(memberDTO != null){ %>
				<h3><%= memberDTO.getId() %> 님 환영합니다.</h3>
				<a href="./memberLogout.jsp">LogOut</a>
				<a href="./memberMyPage.jsp">MyPage</a>
			<%}else {%>
			<a class="btn btn-warning" href="memberJoin.jsp">Join</a>
			<a class="btn btn-warning" href="./memberLogin.jsp">Login</a>
			<%}%>
		</div>
	</div>
</body>
</html>