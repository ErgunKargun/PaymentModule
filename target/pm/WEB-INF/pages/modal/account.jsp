<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!-- Account Info modal -->
<div class="modal fade" id="modalAccount" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h4 class="modal-title" id="modalAccountTitle">Hesap
					Ayrıntıları</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-sm-5"></div>
					<label class="col-sm-1">TC</label>
					<div class="col-sm-1">${admin.tc}</div>
					<div class="col-sm-5"></div>
				</div>
				<div class="row">
					<div class="col-sm-5"></div>
					<label class="col-sm-1">Ad</label>
					<div class="col-sm-1">${admin.name}</div>
					<div class="col-sm-5"></div>
				</div>
				<div class="row">
					<div class="col-sm-5"></div>
					<label class="col-sm-1">Soyad</label>
					<div class="col-sm-1">${admin.surname}</div>
					<div class="col-sm-5"></div>
				</div>
				<div class="row">
					<div class="col-sm-5"></div>
					<label class="col-sm-1">Email</label>
					<div class="col-sm-1">${admin.email}</div>
					<div class="col-sm-5"></div>
				</div>
				<div class="row">
					<div class="col-sm-5"></div>
					<label class="col-sm-1">Telefon</label>
					<div class="col-sm-1">${admin.countryCode}-${admin.phoneNumber}</div>
					<div class="col-sm-5"></div>
				</div>
				<div class="row">
					<div class="col-sm-5"></div>
					<label class="col-sm-1">Admin Email</label>
					<div class="col-sm-1">${admin.adminEmail}</div>
					<div class="col-sm-5"></div>
				</div>
				<sec:authorize access="hasRole('ROLE_USER')">
					<div class="row">
						<div class="col-sm-5"></div>
						<label class="col-sm-2"><span class="label label-info">Bilgilerinizi
								Güncellemek için admininizle görüşünüz.</span></label>
						<div class="col-sm-5"></div>
					</div>
				</sec:authorize>
			</div>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal">Kapat</button>
					<button class="btn btn-primary" data-toggle="modal"
						data-dismiss="modal" data-target="#modalUpdateAccount">
						<i class="fa fa-edit"></i> Güncelle
					</button>
				</div>
			</sec:authorize>
		</div>
	</div>
</div>

<!-- Account Update modal -->
<div class="modal fade" id="modalUpdateAccount" tabindex="-1"
	role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h4 class="modal-title" id="modalAccountTitle">Hesap Güncelle</h4>
			</div>
			<div class="modal-body">
				<form:form id="formUpdateAccount" class="form-horizontal"
					method="post" modelAttribute="formUpdateAccount"
					action="${urlUpdateAccount}">				

					<form:input hidden path="tc" name="tc" id="tc" value="${admin.tc}" />

					<!-- <div class="form-group">
						<label class="col-sm-2 control-label">Tc</label>
						<div class="col-sm-10">
							<form:input path="tc" name="tc" type="tel"
								placeholder="Tc giriniz (Örn. 10000000146)" value="${admin.tc}"
								class="form-control" minlength="11" maxlength="11"
								data-rule-digit="true" required />
							<form:errors path="tc" class="control-label" />
						</div>
					</div> -->

					<div class="form-group">
						<label class="col-sm-2 control-label">Ad</label>
						<div class="col-sm-10">
							<form:input path="name" name="name" type="text"
								placeholder="Ad giriniz (Örn. Adem)" value="${admin.name}"
								class="form-control" minlength="3" required />
							<form:errors path="name" class="control-label" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Soyad</label>
						<div class="col-sm-10">
							<form:input path="surname" name="surname" type="text"
								placeholder="Soyad giriniz (Örn. Tok)" value="${admin.surname}"
								class="form-control" minlength="3" required />
							<form:errors path="surname" class="control-label" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Email</label>
						<div class="col-sm-10">
							<form:input path="email" name="email" type="email"
								placeholder="Email giriniz (Örn. ergunkargun@gmail.com)"
								value="${admin.email}" class="form-control" required />
							<form:errors path="email" class="control-label" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Telefon</label>
						<div class="col-sm-10">
							<form:input path="phoneNumber" name="phoneNumber" type="tel"
								placeholder="Telefon giriniz (Örn. 5551234567)"
								value="${admin.phoneNumber}" class="form-control" minlength="10"
								maxlength="10" data-rule-digit="true" required />
							<form:errors path="phoneNumber" class="control-label" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Admin email</label>
						<div class="col-sm-10">
							<span class="label label-primary">${admin.adminEmail}</span>
							<form:input hidden path="adminEmail" name="adminEmail"
								value="${admin.adminEmail}" />
							<!--<form:input hidden path="enabled" name="enabled"
								id="enabled" value="1" />
							<form:input hidden path="countryCode" name="countryCode"
								id="countryCode" value="90" /> -->
						</div>
					</div>
				</form:form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal">İptal</button>
				<button class="btn btn-danger" id="modalFooterButtonUpdateAccount"
					type="submit" value="submit" onclick="updateAccount()">Kaydet</button>
			</div>
		</div>
	</div>
</div>