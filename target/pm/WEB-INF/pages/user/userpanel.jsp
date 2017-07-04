<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<html>
<jsp:include page="../fragments/header.jsp" />

<spring:url value="/admin/datatable" var="urlAdminDatatable" />
<div style="margin-top: 70px;" class="container">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_AGA')">
				<span class="badge pull-left" id="toAdminDatatable"
					data-href="${urlAdminDatatable}"><span
					class="glyphicon glyphicon-arrow-left"></span> &nbsp;Geri&nbsp; </span>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_USER')">
				<span class="badge pull-left" id="toUserDatatable"><span
					class="glyphicon glyphicon-arrow-left"></span> &nbsp;Geri&nbsp; </span>
			</sec:authorize>
			&nbsp;Kullanıcı Paneli&nbsp;
		</div>
		<jsp:include page="../modal/account.jsp" />
		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_AGA')">
			<jsp:include page="../modal/delete.jsp" />
			<jsp:include page="../modal/update.jsp" />
			<jsp:include page="../modal/upload.jsp" />
			<jsp:include page="../modal/insert.jsp" />
			<div id="adminDiv">
				<div id="adminDatatableDiv" class="slidable">
					<jsp:include page="adminpart/adminDatatable.jsp" />
				</div>
				<div id="adminWorkspaceDiv" class="slidable">
					<jsp:include page="adminpart/adminWorkspace.jsp" />
				</div>
			</div>
		</sec:authorize>

		<sec:authorize access="hasRole('ROLE_USER')">
			<div id="userDiv">
				<div id="userDatatableDiv" class="slidable">
					<jsp:include page="userpart/userDatatable.jsp" />
				</div>
				<div id="paymentDiv" class="slidable">
					<jsp:include page="userpart/payment.jsp" />
				</div>
			</div>
		</sec:authorize>

		<div class="panel-footer">
			<footer>
				<p style="text-align: center;">&copy; Arma Bilgisayar | 2017</p>
				<p style="text-align: center;">Destek için
					arma@armabilgisayar.net'a yazın!</p>
			</footer>
		</div>
	</div>
</div>
<jsp:include page="../fragments/footer.jsp" />
</html>