<%@page import="com.iu.qna.QnaDTO"%>
<%@page import="com.iu.qna.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//num, title, writer,contents
	//num으로 부모의 ref 구하고
	//update step1증가
	//insert
	//3번의 쿼리 사용
	QnaDTO qDTO = new QnaDTO();
	qDTO.setTitle(request.getParameter("title"));
	qDTO.setContents(request.getParameter("contents"));
	qDTO.setWriter(request.getParameter("writer"));
	
	
	QnaDAO qnaDAO= new QnaDAO();
	//1. 부모글 조회
	QnaDTO qnaDTO = qnaDAO.selectOne(Integer.parseInt(request.getParameter("num")));
	qDTO.setRef(qnaDTO.getRef());
	qDTO.setStep(qnaDTO.getStep());
	qDTO.setDepth(qnaDTO.getDepth());
	//2. stepUpdate
	qnaDAO.stepUpdate(qnaDTO.getRef(), qnaDTO.getStep());
	//3. reply
	int result = qnaDAO.reply(qDTO);
	
	String message = "reply Fail";
	if(result>0){
		message = "reply Success";
	}
	
	request.setAttribute("message", message);
	request.setAttribute("path","./qnaList.jsp");
	//이동해야할 페이지의 주소
	RequestDispatcher view = request.getRequestDispatcher("../common/result.jsp");
	view.forward(request, response);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>