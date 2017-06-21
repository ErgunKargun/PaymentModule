<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<div id="userDatatableDiv" class="slidable">
	<jsp:include page="userDatatable.jsp" />
</div>

<div id="paymentDiv" class="slidable">
	<jsp:include page="payment.jsp" />
</div>





