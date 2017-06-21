<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
				<spring:url value="/admin/insert/user" var="urlInsertNewUser" />
				<form:form id="formInsertNewUser" class="form-horizontal"
					method="post" modelAttribute="formInsertNewUser"
					action="${urlInsertNewUser}">

					<div class="form-group">
						<label class="col-sm-3 control-label">Tc</label>
						<div class="col-sm-9">
							<spring:bind path="tc">
								<form:input path="tc" name="tc" type="tel"
									placeholder="Tc giriniz (Örn. 10000000146)"
									class="form-control tc" minlength="11" maxlength="11"
									data-rule-digit="true" required="required" />
							</spring:bind>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Ad</label>
						<div class="col-sm-9">
							<spring:bind path="name">
								<form:input path="name" name="name" type="text"
									placeholder="Ad giriniz (Örn. Adem)" class="form-control name"
									minlength="3" required="required" />
							</spring:bind>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Soyad</label>
						<div class="col-sm-9">
							<spring:bind path="surname">
								<form:input path="surname" name="surname" type="text"
									placeholder="Soyad giriniz (Örn. Tok)"
									class="form-control surname" minlength="3" required="required" />
							</spring:bind>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Email</label>
						<div class="col-sm-9">
							<spring:bind path="email">
								<form:input path="email" name="email" type="email"
									placeholder="Email giriniz (Örn. ademtok@gmail.com)"
									class="form-control email" required="required" />
							</spring:bind>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Telefon</label>
						<div class="col-sm-9">
							<spring:bind path="phoneNumber">
								<form:input path="phoneNumber" name="phoneNumber" type="tel"
									placeholder="Telefon giriniz (Örn. 5551234567)"
									class="form-control phoneNumber" minlength="10" maxlength="10"
									data-rule-digit="true" required="required" />
							</spring:bind>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Admin email</label>
						<div class="col-sm-9">
							<spring:bind path="adminEmail">
								<span class="label label-primary">${admin.email}</span>
								<form:hidden path="adminEmail" name="adminEmail"
									class="adminEmail" value="${admin.email}" />
							</spring:bind>
							<!--<form:hidden path="enabled" name="enabled"
								id="enabled" value="1" />
							<form:hidden path="countryCode" name="countryCode"
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

<!-- Insert new debt -->
<div class="modal fade" id="modalInsertNewDebt" tabindex="-1"
	role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h4 class="modal-title">Yeni Tahakkuk</h4>
			</div>
			<div class="modal-body">
				<form:form id="formInsertNewDebt" class="form-horizontal"
					method="post" modelAttribute="formInsertNewDebt">

					<div class="form-group">
						<label class="col-sm-3 control-label">Dönem</label>
						<div class="col-sm-9">
							<spring:bind path="donem">
								<form:input path="donem" name="donem" type="text"
									class="form-control donem"
									placeholder="Dönem giriniz (Örn. 2017/05)" required="required" />
							</spring:bind>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Parsel</label>
						<div class="col-sm-9">
							<spring:bind path="parsel">
								<form:input path="parsel" name="parsel" type="text"
									class="form-control parsel"
									placeholder="Parsel giriniz (Örn. 102)" required="required" />
							</spring:bind>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Gelir Cinsi</label>
						<div class="col-sm-9">
							<spring:bind path="gelirCinsi">
								<form:input path="gelirCinsi" name="gelirCinsi" type="text"
									class="form-control gelirCinsi"
									placeholder="Gelir cinsi giriniz (Örn. Gecikme Cezası)"
									required="required" />
							</spring:bind>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Açıklama</label>
						<div class="col-sm-9">
							<spring:bind path="aciklama">
								<form:input path="aciklama" name="aciklama" type="text"
									class="form-control aciklama" minlength="4"
									placeholder="Açıklama giriniz (Örn. Sulama Cezası)"
									required="required" />
							</spring:bind>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Tahakkuk</label>
						<div class="col-sm-9">
							<spring:bind path="tahakkuk">
								<form:input path="tahakkuk" name="tahakkuk" type="number"
									class="form-control tahakkuk"
									placeholder="Tahakkuk giriniz (Örn. 27.25 gibi)"
									data-rule-number="true" required="required" />
							</spring:bind>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Ödenen</label>
						<div class="col-sm-9">
							<spring:bind path="odenen">
								<form:input path="odenen" name="odenen" type="number"
									class="form-control odenen"
									placeholder="Ödeme giriniz (Örn. 7.2 gibi)"
									data-rule-number="true" required="required" />
							</spring:bind>
						</div>
					</div>

					<%-- <div class="form-group">
						<label class="col-sm-3 control-label">Bakiye</label>
						<div class="col-sm-9">
							<!-- <span id="bakiyeSpanAtDebtInsertForm" class="label label-info"></span> -->
							<form:input path="bakiye" name="bakiye" type="number" id="bakiyeSpanAtDebtInsertForm" />
						</div>
					</div> --%>

					<div class="form-group">
						<label class="col-sm-3 control-label">Durum</label>
						<div class="col-sm-9">
							<span id="durumSpanAtDebtInsertForm" class="label label-info">ODENMEDI</span>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Mükellef Tc</label>
						<div class="col-sm-9">
							<span id="tcSpanAtDebtInsertForm" class="label label-primary"></span>
						</div>
					</div>
				</form:form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal">İptal</button>
				<button class="btn btn-danger" id="modalFooterButtonInsertNewDebt"
					onclick="insertNewDebt(this)">Kaydet</button>
			</div>
		</div>
	</div>
</div>