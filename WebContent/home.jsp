<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Good place</title>
	<link rel="stylesheet" href="/style.css" />
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<body>
	<div id="divPage">
		<div id="divTop">
			<div id="divMenu1">
				<div class="title"><a href="/home"><b>Good place</b></a></div>
				<jsp:include page="/menu.jsp" />
			</div>
			<div id="divMenu2">
				<a href="/home"><img src="/main.jpg" style="width:1000px; margin:0px auto;"/></a>
			</div>
		</div>
		<div id="divCenter">			
			<div id="divContent">
				<jsp:include page="${pageName}" />
			</div>
		</div>
		<div id="divBottom">
			<h4>Copyright © Good place All Rights Reserved.</h4>
		</div>
	</div>
</body>
<!-- <script src="script.js"></script> -->
</html>