<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.io.PrintWriter"%>
<%@ page import="log.LogDAO"%>
<%@ page import="log.Log"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>MQTT 환자관리 웹 사이트</title>
<style type="text/css">

	a, a:hover {
			color: #000000;
			text-decoration: none;
	}
</style>
</head>
<body>
<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">MQTT 환자관리 웹 사이트</a>
		</div>		
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="log.jsp">로그</a></li>
			</ul>
			<%
				if(userID == null) {
			%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"> 
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>
			<%
				} else {
			%>	
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"> 
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>
				</ul>	 
			<%
				}
			%>	
		</div>
	</nav>
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">번호</th>
							<th style="background-color: #eeeeee; text-align: center;">제목</th>
							<th style="background-color: #eeeeee; text-align: center;">작성자</th>
							<th style="background-color: #eeeeee; text-align: center;">작성일</th>							
						</tr>
					</thead>
					<tbody>
						<%
							LogDAO logDAO = new LogDAO();
							ArrayList<Log> list = logDAO.getList(pageNumber);
							for(int i = 0; i < list.size(); i++) {
						%>
						<tr>
							<td><%= list.get(i).getLogID() %></td>
							<td><a href="view.jsp?logID=<%= list.get(i).getLogID() %>"><%= list.get(i).getLogTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
							<td><%= list.get(i).getPatientID() %></td>
							<td><%= list.get(i).getLogDate().substring(0,11) + list.get(i).getLogDate().substring(11,13) + "시 " + list.get(i).getLogDate().substring(14,16) + "분 " %></td>
						</tr>
						<%
							}
						%>				
					</tbody>
				</table>
				<%
					if(pageNumber != 1) {
				%>
					<a href="log.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
				<%
					} if(logDAO.nextPage(pageNumber + 1)) {
				%>
					<a href="log.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-right">다음</a>
				<%
					}
				%>
				
				<!-- <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a> -->
		</div>
	</div>
	
	
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>