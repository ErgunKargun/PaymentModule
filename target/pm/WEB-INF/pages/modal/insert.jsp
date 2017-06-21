<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!-- Insert new user -->
<div class="modal fade" id="modalInsertNewUser" tabindex="-1"
	role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h4 class="modal-title">Yeni Kullanıcı</h4>
			</div>
			<div class="modal-body">
				<form:form id="formInsertNewUser" class="form-horizontal"
					method="post" modelAttribute="formInsertNewUser"
					action="${urlInsertNewUser}">

					<div class="form-group">
						<label class="col-sm-2 control-label">Tc</label>
						<div class="col-sm-10">
							<form:input path="tc" name="tc" type="tel"
								placeholder="Tc giriniz (Örn. 10000000146)" class="form-control"
								minlength="11" maxlength="11" data-rule-digit="true" required />
							<form:errors path="tc" class="control-label" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Ad</label>
						<div class="col-sm-10">
							<form:input path="name" name="name" type="text"
								placeholder="Ad giriniz (Örn. Adem)" class="form-control"
								minlength="3" required />
							<form:errors path="name" class="control-label" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Soyad</label>
						<div class="col-sm-10">
							<form:input path="surname" name="surname" type="text"
								placeholder="Soyad giriniz (Örn. Tok)" class="form-control"
								minlength="3" required />
							<form:errors path="surname" class="control-label" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Email</label>
						<div class="col-sm-10">
							<form:input path="email" name="email" type="email"
								placeholder="Email giriniz (Örn. ademtok@gmail.com)"
								class="form-control" required />
							<form:errors path="email" class="control-label" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Telefon</label>
						<div class="col-sm-10">
							<form:input path="phoneNumber" name="phoneNumber" type="tel"
								placeholder="Telefon giriniz (Örn. 5551234567)"
								class="form-control" minlength="10" maxlength="10"
								data-rule-digit="true" required />
							<form:errors path="phoneNumber" class="control-label" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Admin email</label>
						<div class="col-sm-10">
							<span class="label label-primary">${admin.email}</span>
							<form:input hidden path="adminEmail" name="adminEmail"
								value="${admin.email}" />							
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
				<button class="btn btn-danger" id="modalFooterButtonInsertNewUser"
					onclick="insertNewUser()">Kaydet</button>
			</div>
		</div>
	</div>
</div>