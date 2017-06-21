<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
	
<html>
<jsp:include page="../fragments/header.jsp" />

<div id="userpanelDiv">

	<div style="margin-top: 50px" class="container">
	
		<jsp:include page="../modal/account.jsp" />
		
		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_AGA')">

			<jsp:include page="../modal/delete.jsp" />
			<jsp:include page="../modal/update.jsp" />
			<jsp:include page="../modal/upload.jsp" />
			<jsp:include page="../modal/insert.jsp" />

			<div id="adminDiv">
				<jsp:include page="adminpart/admin.jsp" />
			</div>

		</sec:authorize>

		<sec:authorize access="hasRole('ROLE_USER')">

			<div id="userDiv">
				<jsp:include page="userpart/user.jsp" />
			</div>

		</sec:authorize>
	</div>

</div>

<jsp:include page="../fragments/footer.jsp" />
</html>