<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<div id="adminDatatableDiv" class="slidable">
	<jsp:include page="adminDatatable.jsp" />
</div>

<div id="adminWorkspaceDiv" class="slidable">
	<jsp:include page="adminWorkspace.jsp" />
</div>





