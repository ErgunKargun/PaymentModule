<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<div class="panel panel-primary">
	<div style="text-align: center;" class="panel-heading">Admin
		Paneli</div>
	<div class="panel-body">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-md-12">
					<c:if test="${not empty msg}">
						<div class="alert alert-${css} alert-dismissible" role="alert">
							<button type="button" class="close" data-dismiss="alert"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<strong>${msg}</strong>
						</div>
					</c:if>
					<sec:authorize access="hasRole('ROLE_AGA')">
						<h1>Admin Listesi</h1>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<h1>Mükellef Listesi</h1>
					</sec:authorize>
					<table id="adminDatatable"
						class="table table-striped table-bordered">
						<thead>
							<tr>
								<th><span class="label label-default">Tc</span></th>
								<th><span class="label label-default">Adı</span></th>
								<th><span class="label label-default">Soyadı</span></th>
								<th><span class="label label-default">Email</span></th>
								<th><span class="label label-default">Telefon</span></th>
								<th><span class="label label-default">Admin Email</span></th>
								<sec:authorize access="hasRole('ROLE_AGA')">
									<th><span class="label label-primary"><i
											class="fa fa-edit"></i> Admin Bilgilerini Güncelle</span></th>
									<th><span class="label label-danger"><i
											class="fa fa-remove"></i> Admini sil</span></th>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<th><span class="label label-info"><i
											class="fa fa-eye"></i> Tahakkuk listesine Git</span></th>
									<th><span class="label label-primary"><i
											class="fa fa-edit"></i> Mükellef Bilgilerini Güncelle</span></th>
									<th><span class="label label-danger"><i
											class="fa fa-remove"></i> Mükellefi sil</span></th>
								</sec:authorize>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th><span class="label label-default">Tc</span></th>
								<th><span class="label label-default">Adı</span></th>
								<th><span class="label label-default">Soyadı</span></th>
								<th><span class="label label-default">Email</span></th>
								<th><span class="label label-default">Telefon</span></th>
								<th><span class="label label-default">Admin Email</span></th>
								<sec:authorize access="hasRole('ROLE_AGA')">
									<th><span class="label label-primary"><i
											class="fa fa-edit"></i> Admin Bilgilerini Güncelle</span></th>
									<th><span class="label label-danger"><i
											class="fa fa-remove"></i> Admini sil</span></th>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<th><span class="label label-info"><i
											class="fa fa-eye"></i> Tahakkuk listesine Git</span></th>
									<th><span class="label label-primary"><i
											class="fa fa-edit"></i> Mükellef Bilgilerini Güncelle</span></th>
									<th><span class="label label-danger"><i
											class="fa fa-remove"></i> Mükellefi sil</span></th>
								</sec:authorize>
							</tr>
						</tfoot>
						<c:forEach var="user" items="${userList}">
							<tr>
								<td>${user.tc}</td>
								<td>${user.name}</td>
								<td>${user.surname}</td>
								<td>${user.email}</td>
								<td>${user.phoneNumber}</td>
								<td>${user.adminEmail}</td>
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<td><button
											data-href="<c:url value='/admin/workspace/${user.tc}' />"
											class="btn btn-info toAdminWorkspace">
											<i class="fa fa-eye"></i> <span class="badge pull-right"><span
												class="glyphicon glyphicon-arrow-right"></span></span>Git
										</button></td>
								</sec:authorize>
								<td><button data-toggle="modal"
										data-target="#modalUpdateUser"
										data-href="<c:url value='/admin/update/user/${user.tc}' />"
										data-tc="${user.tc}" data-name="${user.name}"
										data-surname="${user.surname}"
										data-email="${user.email}"
										data-phone-number="${user.phoneNumber}"
										class="btn btn-primary buttonUpdateUser">
										<i class="fa fa-edit"></i> Güncelle
									</button></td>
								<td><button data-toggle="modal"
										data-target="#modalDelete"
										data-href="<c:url value='/admin/delete/user/${user.tc}' />"
										data-object="${user.tc} kullanıcı" class="btn btn-danger buttonDeleteUser">
										<i class="fa fa-remove"></i> Sil
									</button></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>