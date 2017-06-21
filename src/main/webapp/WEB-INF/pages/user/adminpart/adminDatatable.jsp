<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<div class="panel-body">
	<div class="row">
		<div class="col-md-12">
			<c:if test="${not empty msg}">
				<div class="alert alert-${css} alert-dismissible" role="alert">
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<strong>${msg}</strong>
				</div>
			</c:if>
		</div>
	</div>
	<sec:authorize access="hasRole('ROLE_AGA')">
		<h4>Admin listesi</h4>
	</sec:authorize>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<h4>Mükellef listesi</h4>
	</sec:authorize>
	<div class="row">
		<div class="col-md-12">
			<div class="table-responsive">
				<table id="adminDatatable"
					class="table table-striped table-bordered table-hover dt-responsive display">
					<thead>
						<tr>
							<th><span class="label label-info"><span
									class="glyphicon glyphicon-info-sign"></span> Bilgi</span></th>
							<th><span class="label label-info">Tc</span></th>
							<th><span class="label label-info">Adı</span></th>
							<th><span class="label label-info">Soyadı</span></th>
							<th><span class="label label-info">Email</span></th>
							<th><span class="label label-info">Telefon</span></th>
							<th><span class="label label-info">Admin Email</span></th>
							<th><span class="label label-primary"><i
									class="fa fa-edit"></i>Güncelle</span></th>
							<th><span class="label label-danger"><i
									class="fa fa-remove"></i>Sil</span></th>
							<th><span class="label label-info"><i
									class="fa fa-eye"></i>Git</span></th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th><span class="label label-default"><span
									class="glyphicon glyphicon-info-sign"></span> Bilgi</span></th>
							<th><span class="label label-default">Tc</span></th>
							<th><span class="label label-default">Adı</span></th>
							<th><span class="label label-default">Soyadı</span></th>
							<th><span class="label label-default">Email</span></th>
							<th><span class="label label-default">Telefon</span></th>
							<th><span class="label label-default">Admin Email</span></th>
							<th><span class="label label-primary"><i
									class="fa fa-edit"></i>Güncelle</span></th>
							<th><span class="label label-danger"><i
									class="fa fa-remove"></i>Sil</span></th>
							<th><span class="label label-info"><i
									class="fa fa-eye"></i>Git</span></th>
						</tr>
					</tfoot>
					<!-- <tbody>
						<c:forEach var="user" items="${userList}">
							<tr id="${user.tc}">
								<td class="details"><button type="button"
										class="btn btn-info btn-sm">
										<span class="glyphicon glyphicon-info-sign"></span>
									</button></td>
								<td>${user.tc}</td>
								<td>${user.name}</td>
								<td>${user.surname}</td>
								<td>${user.email}</td>
								<td>${user.phoneNumber}</td>
								<td>${user.adminEmail}</td>
								<td><button data-toggle="modal"
										data-target="#modalUpdateUser" data-id="${user.tc}"
										data-href="<spring:url value='/admin/update/user/${user.tc}' />"
										data-tc="${user.tc}" data-name="${user.name}"
										data-surname="${user.surname}" data-email="${user.email}"
										data-phone-number="${user.phoneNumber}"
										class="btn btn-primary buttonUpdateUser" >
										<i class="fa fa-edit"></i>
									</button></td>
								<td><button data-toggle="modal" data-target="#modalDelete"
										data-href="<spring:url value='/admin/delete/user/${user.tc}' />"
										data-id="${user.tc}"
										data-object="Tc'si ${user.tc} olan kullanıcı"
										class="btn btn-danger buttonDeleteUser">
										<i class="fa fa-remove"></i>
									</button></td>
								<td><button
										data-href="<spring:url value='/admin/workspace/${user.tc}' />"
										data-tc="${user.tc}"
										class="btn btn-info toAdminWorkspace">
										<span class="badge pull-right"><span
											class="glyphicon glyphicon-arrow-right"></span></span>
									</button></td>
							</tr>
						</c:forEach>
					</tbody> -->
				</table>
			</div>
		</div>
	</div>
</div>