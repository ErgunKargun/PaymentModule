<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!-- Update existing user -->
<div class="modal fade" id="modalUpdateUser" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h4 class="modal-title">Kullanıcı Güncelle</h4>
			</div>
			<div class="modal-body">
				<form:form id="formUpdateUser" class="form-horizontal" method="post"
					modelAttribute="formUpdateUser">

					<form:hidden path="tc" name="tc" class="tc" />

					<!-- <div class="form-group">
						<label class="col-sm-3 control-label">Tc</label>
						<div class="col-sm-9">
							<form:input path="tc" name="tc" type="tel"
								placeholder="Tc giriniz (Örn. 10000000146)" class="form-control"
								minlength="11" maxlength="11" data-rule-digit="true" required="required" />
						</div>
					</div> -->

					<div class="form-group">
						<label class="col-sm-3 control-label">Ad</label>
						<div class="col-sm-9">
							<form:input path="name" name="name" type="text"
								placeholder="Ad giriniz (Örn. Adem)" class="form-control name"
								minlength="3" required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Soyad</label>
						<div class="col-sm-9">
							<form:input path="surname" name="surname"
								type="text" placeholder="Soyad giriniz (Örn. Tok)"
								class="form-control surname" minlength="3" required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Email</label>
						<div class="col-sm-9">
							<form:input path="email" name="email" type="email"
								placeholder="Email giriniz (Örn. ademtok@gmail.com)"
								class="form-control email" required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Telefon</label>
						<div class="col-sm-9">
							<form:input path="phoneNumber" name="phoneNumber"
								type="tel"
								placeholder="Telefon giriniz (Örn. 5551234567)"
								class="form-control phoneNumber" minlength="10" maxlength="10"
								data-rule-digit="true" required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Admin email</label>
						<div class="col-sm-9">
							<span class="label label-primary">${admin.email}</span>
							<form:hidden path="adminEmail" name="adminEmail"
								class="adminEmail" value="${admin.email}" />
							<!-- <form:hidden path="enabled" name="enabled"
								value="1" />
							<form:hidden path="countryCode" name="countryCode"
								value="90" /> -->
						</div>
					</div>
				</form:form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal">İptal</button>
				<button class="btn btn-danger" id="modalFooterButtonUpdateUser"
					onclick="updateUser(this)">Kaydet</button>
			</div>
		</div>
	</div>
</div>

<!-- Update existing debt -->
<div class="modal fade" id="modalUpdateDebt" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h4 class="modal-title">Tahakkuk borcunu güncelle</h4>
			</div>
			<div class="modal-body">
				<form:form id="formUpdateDebt" class="form-horizontal" method="post"
					modelAttribute="formUpdateDebt">

					<form:hidden path="serial" name="serial" />

					<div class="form-group">
						<label class="col-sm-3 control-label">Dönem</label>
						<div class="col-sm-9">
							<form:input path="donem" name="donem" type="text"
								class="form-control" placeholder="Dönem giriniz (Örn. 2017/05)"
								required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Parsel</label>
						<div class="col-sm-9">
							<form:input path="parsel" name="parsel" type="text"
								class="form-control" placeholder="Parsel giriniz (Örn. 102)"
								required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Gelir Cinsi</label>
						<div class="col-sm-9">
							<form:input path="gelirCinsi" name="gelirCinsi"
								type="text" class="form-control"
								placeholder="Gelir cinsi giriniz (Örn. Gecikme Cezası)"
								required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Açıklama</label>
						<div class="col-sm-9">
							<form:input path="aciklama" name="aciklama"
								type="text" class="form-control" minlength="4"
								placeholder="Açıklama giriniz (Örn. Sulama Cezası)"
								required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Tahakkuk</label>
						<div class="col-sm-9">
							<form:input path="tahakkuk" name="tahakkuk"
								type="number" class="form-control"
								placeholder="Tahakkuk giriniz (Örn. 27.25 veya 102.3 gibi)"
								data-rule-number="true" required="required" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Ödenmiş miktar</label>
						<div class="col-sm-9">
							<form:input path="odenen" name="odenen" type="number"
								class="form-control"
								placeholder="Ödenmiş miktar var ise giriniz (Örn. 0 veya 12.5 gibi)"
								data-rule-number="true" required="required" />
						</div>
					</div>
				</form:form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal">İptal</button>
				<button class="btn btn-danger" id="modalFooterButtonUpdateDebt"
					onclick="updateDebt()">Kaydet</button>
			</div>
		</div>
	</div>
</div>