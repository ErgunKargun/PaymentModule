<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Online Ödeme | Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="icon" type="image/png"
	href="<c:url value='/resources/images/favicon.png' />">
<link rel="stylesheet" href="<c:url value='/resources/css/login.css' />">

</head>

<body>
	<div id="login-box">
		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="msg">${msg}</div>
		</c:if>
		<button id="loginButton" style="width: 100%" class="btn btn-primary"
			onclick="document.getElementById('loginModal').style.display='block'"
			style="width: auto 0;">Giriş Yap</button>
	</div>
	<div id="loginModal" class="modal">

		<form class="modal-content animate" id='loginForm'
			action="<c:url value='/login' />" method='POST'>
			<div class="imgcontainer">
				<span
					onclick="document.getElementById('loginModal').style.display='none'"
					class="close" title="Vazgeç">&times;</span> <img
					src="<c:url value="/resources/images/login_avatar.png" />"
					alt="Avatar" class="avatar">
			</div>

			<div class="container">
				<label><b>İsim</b></label> <input type="text"
					placeholder="Adınızı giriniz (Örn. Adem)" name="name" required> <label><b>Tc
						kimlik</b></label> <input type="text" placeholder="Tc giriniz (Örn. 10000000146)" name="tc"
					required>

				<button 
					onclick="formLoginSubmit()">Giriş</button>

				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</div>

			<div class="container" style="background-color: #f1f1f1">
				<button type="button"
					onclick="document.getElementById('loginModal').style.display='none'"
					class="cancelbtn">İptal</button>
			</div>
		</form>
	</div>

</body>

<script src="<c:url value="/resources/js/login.js" />"></script>

</html>
