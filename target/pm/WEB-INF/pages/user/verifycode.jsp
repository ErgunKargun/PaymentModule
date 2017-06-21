 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<html>

<head>
<title>Online Ödeme | Verify Code</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="icon" type="image/png"
	href="<c:url value='/resources/images/favicon.png' />">
<link rel="stylesheet" href="<c:url value="/resources/css/login.css" />">
</head>

<body>

	<div id="login-box">
		<c:if test="${not empty codeError}">
			<div class="error">${codeError}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="msg">${msg}</div>
		</c:if>
		<form id='verifyCodeForm' action="<c:url value="/user/verifycode" />" method='POST'>

			<div class="container">
				<label><b>Kod</b></label> <input type="text"
					placeholder="Kodu giriniz" name="code" required>

				<button type="submit" form="verifyCodeForm">Gönder</button>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</div>
		</form>
		<button id="resend" onclick="location.href='<c:url value="/user" />';"
			style="width: auto 0;">Yeni Kod Gönder</button>
	</div>

</body>

</html>
