<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<div class="panel panel-primary">
	<div style="text-align: center;" class="panel-heading">
		<span class="badge pull-left"><span id="toAdminDatatable"
			class="glyphicon glyphicon-arrow-left"></span></span>Admin Paneli
	</div>
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
					<h1>${user.name}${user.surname}adlımükellefinTahakkukListesi</h1>
					<table id="adminWorkspaceDatatable"
						class="table table-striped table-bordered">
						<thead>
							<tr>
								<th><span class="label label-default">#ID</span></th>
								<th><span class="label label-default">Dönem</span></th>
								<th><span class="label label-default">Parsel</span></th>
								<th><span class="label label-default">Gelir Cinsi</span></th>
								<th><span class="label label-default">Açıklama</span></th>
								<th><span class="label label-default">Tahakkuk</span></th>
								<th><span class="label label-default">Ödenen</span></th>
								<th><span class="label label-default">Bakiye</span></th>
								<th><span class="label label-default">Durum</span></th>
								<th><span class="label label-primary"><i
										class="fa fa-edit"></i> Güncelle</span></th>
								<th><span class="label label-danger"><i
										class="fa fa-remove"></i> Sil</span></th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th><span class="label label-default">#ID</span></th>
								<spring:url value="/admin/insert/debt/${user.tc}"
									var="urlInsertNewDebt" />
								<form:form id="formInsertNewDebt" class="form-horizontal"
									method="post" modelAttribute="formInsertNewDebt"
									action="${urlInsertNewDebt}">
									<th><form:input path="donem" name="donem" type="text"
											class="form-control donem"
											placeholder="Dönem giriniz (Örn. 2017/05)" required /></th>
									<th><form:input path="parsel" name="parsel" type="text"
											class="form-control parsel"
											placeholder="Parsel giriniz (Örn. 102)" required /></th>
									<th><form:input path="gelirCinsi" name="gelirCinsi"
											type="text" class="form-control gelirCinsi"
											placeholder="Gelir cinsi giriniz (Örn. Gecikme Cezası)"
											required /></th>
									<th><form:input path="aciklama" name="aciklama"
											type="text" type="text" class="form-control aciklama"
											minlength="4"
											placeholder="Açıklama giriniz (Örn. Sulama Cezası)" required /></th>
									<th><form:input path="tahakkuk" name="tahakkuk"
											type="number" class="form-control tahakkuk"
											placeholder="Tahakkuk giriniz (Örn. 27.25 veya 102.3 gibi)"
											data-rule-number=”true” required /></th>
									<th><form:input path="odenen" name="odenen" type="number"
											class="form-control odenen"
											placeholder="Ödenmiş miktar var ise giriniz (Örn. 0 veya 12.5 gibi)"
											data-rule-number=”true” required /></th>
									<th><span id="bakiyeSpanAtDebtInsertForm"
										class="label label-info"></span></th>
									<th><span id="durumSpanAtDebtInsertForm"
										class="label label-info">ODENMEDI</span></th>
									<th><span id="tcSpanAtDebtInsertForm"
										class="label label-primary">${user.tc}</span></th>
									<th><button class="btn btn-danger"
											data-workspace="<c:url value='/admin/workspace/${user.tc}' />"
											id="buttonInsertNewDebt" onclick="insertNewDebt(this)">Kaydet</button></th>
								</form:form>
							</tr>

						</tfoot>
						<c:forEach var="debt" items="${debtList}">
							<tr>
								<td>${debt.serial}</td>
								<td>${debt.donem}</td>
								<td>${debt.parsel}</td>
								<td>${debt.gelirCinsi}</td>
								<td>${debt.aciklama}</td>
								<td>${debt.tahakkuk}</td>
								<td>${debt.odenen}</td>
								<td>${debt.bakiye}</td>
								<td>${debt.durum}</td>
								<td><button data-toggle="modal"
										data-target="#modalUpdateDebt"
										data-workspace="<c:url value='/admin/workspace/${user.tc}' />"
										data-href="<c:url value='/admin/update/debt/${debt.serial}' />"
										data-serial="${debt.serial}" data-donem="${debt.donem}"
										data-parsel="${debt.parsel}"
										data-gelir-cinsi="${debt.gelirCinsi}"
										data-aciklama="${debt.aciklama}"
										data-tahakkuk="${debt.tahakkuk}" data-odenen="${debt.odenen}"
										class="btn btn-primary buttonUpdateDebt">
										<i class="fa fa-edit"></i> Güncelle
									</button></td>
								<td><button data-toggle="modal" data-target="#modalDelete"
										data-href="<c:url value='/admin/delete/debt/${debt.serial}' />"
										data-object="${debt.serial} tahakkuk"
										class="btn btn-danger buttonDeleteDebt">
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