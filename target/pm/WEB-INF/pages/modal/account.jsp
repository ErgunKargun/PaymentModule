<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
					<label class="col-sm-3">TC</label> <label class="col-sm-9">${admin.tc}</label>
				</div>
				<div class="row">
					<label class="col-sm-3">Ad</label> <label class="col-sm-9">${admin.name}</label>
				</div>
				<div class="row">
					<label class="col-sm-3">Soyad</label> <label class="col-sm-9">${admin.surname}</label>
				</div>
				<div class="row">
					<label class="col-sm-3">Email</label> <label class="col-sm-9">${admin.email}</label>
				</div>
				<div class="row">
					<label class="col-sm-3">Telefon</label> <label class="col-sm-9">${admin.countryCode}-${admin.phoneNumber}</label>
				</div>
				<div class="row">
					<label class="col-sm-3">Admin email</label> <label class="col-sm-9">${admin.adminEmail}</label>
				</div>
				<sec:authorize access="hasRole('ROLE_USER')">
					<div class="row">
						<div class="col-sm-3"></div>
						<label class="col-sm-6"><span class="label label-info">Bilgilerinizi
								Güncellemek için admininizle görüşünüz.</span></label>
						<div class="col-sm-3"></div>
					</div>
				</sec:authorize>
			</div>
			<sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_AGA')">
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
				<spring:url value="/admin/update/account" var="urlUpdateAccount" />
				<form:form id="formUpdateAccount" class="form-horizontal"
					method="post" modelAttribute="formUpdateAccount"
					action="${urlUpdateAccount}">

					<form:hidden path="tc" name="tc" value="${admin.tc}" />

					<!-- <div class="form-group">
						<label class="col-sm-3 control-label">Tc</label>
						<div class="col-sm-9">
							<form:input path="tc" name="tc" type="tel"
								placeholder="Tc giriniz (Örn. 10000000146)" value="${admin.tc}"
								class="form-control" minlength="11" maxlength="11"
								data-rule-digit="true" required="required" />
						</div>
					</div> -->

					<div class="form-group">
						<label class="col-sm-3 control-label">Ad</label>
						<div class="col-sm-9">
							<form:input path="name" name="name" type="text"
								placeholder="Ad giriniz (Örn. Adem)" value="${admin.name}"
								class="form-control" minlength="3" required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Soyad</label>
						<div class="col-sm-9">
							<form:input path="surname" name="surname" type="text"
								placeholder="Soyad giriniz (Örn. Tok)" value="${admin.surname}"
								class="form-control" minlength="3" required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Email</label>
						<div class="col-sm-9">
							<form:input path="email" name="email" type="email"
								placeholder="Email giriniz (Örn. ergunkargun@gmail.com)"
								value="${admin.email}" class="form-control" required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Telefon</label>
						<div class="col-sm-9">
							<form:input path="phoneNumber" name="phoneNumber" type="tel"
								placeholder="Telefon giriniz (Örn. 5551234567)"
								value="${admin.phoneNumber}" class="form-control" minlength="10"
								maxlength="10" data-rule-digit="true" required="required" />
						</div>
					</div>
										
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<div class="form-group">
							<label class="col-sm-3 control-label">Banka Hesap</label>
							<div class="col-sm-9">
								<spring:bind path="stripe">
									<form:input path="stripe" name="stripe" type="text"
										placeholder="stripe live key"
										class="form-control stripe"/>
								</spring:bind>
							</div>
						</div>
					</sec:authorize>

					<div class="form-group">
						<label class="col-sm-3 control-label">Admin email</label>
						<div class="col-sm-9">
							<span class="label label-primary">${admin.adminEmail}</span>
							<form:hidden path="adminEmail" name="adminEmail"
								value="${admin.adminEmail}" />
							<!--<form:hidden path="enabled" name="enabled"
								value="1" />
							<form:hidden path="countryCode" name="countryCode"
								value="90" /> -->
						</div>
					</div>
				</form:form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal">İptal</button>
				<button class="btn btn-danger" id="modalFooterButtonUpdateAccount"
					onclick="updateAccount()" >Kaydet</button>
			</div>
		</div>
	</div>
</div>