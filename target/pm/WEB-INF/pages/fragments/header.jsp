<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<head>
<title>Online Ödeme</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png"
	href="<c:url value='/resources/images/favicon.png' />">

<!-- In general bootstrap css stylesheet -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!--
<link rel="stylesheet"
	 href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"> -->

<!-- Font awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Datatable css stylesheet -->
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap.min.css">

<!-- Form Validation css stylesheet -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/jquery.formvalidation/0.6.1/css/formValidation.min.css">

<!-- Jquery Toast css stylesheet -->
<link rel="stylesheet"
	href="<c:url value='/resources/css/jquery.toast.min.css' />">

<!-- Sweetalert2 css stylesheet -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.4/sweetalert2.min.css">
<!-- Sweetalert Bootstrap css stylesheet
<link rel="stylesheet"
	href="<c:url value='/resources/css/sweetalert.css' />"> -->

<!-- Local css stylesheets -->
<link rel="stylesheet"
	href="<c:url value='/resources/css/payment.css' />">
<link rel="stylesheet"
	href="<c:url value='/resources/css/userpanel.css' />">

</head>

<body>
	<spring:url value="/user/userpanel" var="urlHome" />
	<spring:url value="/logout" var="urlLogout" />

	<spring:url value="/user/datatable" var="urlUserDatatable" />
	<spring:url value="/admin/datatable" var="urlAdminDatatable" />

	<spring:url value="/admin/update/account" var="urlUpdateAccount" />
	<spring:url value="/admin/insert/user" var="urlInsertNewUser" />	
	<spring:url value="/admin/upload" var="urlUpload" />

	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="${urlHome}">Arma Bilgisayar</a>
			</div>
			<div id="navbar">
				<ul class="nav navbar-nav navbar-right">
					<sec:authorize
						access="hasRole('ROLE_ADMIN') or hasRole('ROLE_AGA')">
						<div class="dropdown">
							<button class="btn btn-primary dropdown-toggle" type="button"
								data-toggle="dropdown">
								<!-- glyphicon-folder-open -->
								<span class="glyphicon glyphicon-upload"></span> Yükle <span
									class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li class="dropdown-header">Form ile yükle</li>
								<li><a class="btn btn-default" data-toggle="modal"
									data-target="#modalInsertNewUser"> <i
										class="fa fa-user-plus"></i> Form
								</a></li>
								<li class="divider"></li>
								<li class="dropdown-header">CSV ile yükle</li>
								<li><a class="btn btn-default" data-toggle="modal"
									data-target="#modalUpload"> <span
										class="glyphicon glyphicon-folder-open"></span> CSV
								</a></li>
							</ul>
						</div>
					</sec:authorize>
					<li>
						<div class="dropdown">
							<button class="btn btn-primary dropdown-toggle" type="button"
								data-toggle="dropdown">
								<span class="glyphicon glyphicon-user"></span> Hesap <span
									class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li class="dropdown-header">Hesap Özeti</li>
								<li><a class="btn btn-default" data-toggle="modal"
									data-target="#modalAccount"> <span
										class="glyphicon glyphicon-info-sign"></span> Hesap
								</a></li>
								<li class="divider"></li>
								<li class="dropdown-header">Çıkış</li>
								<li><a href="${urlLogout}" class="btn btn-default"> <span
										class="glyphicon glyphicon-log-out"></span> Çıkış
								</a></li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</nav>	