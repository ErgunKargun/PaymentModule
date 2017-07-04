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
			<h4 id="adminWorkspaceUserH1">&nbsp;tc'li&nbsp;mükellefin&nbsp;tahakkuk&nbsp;listesi</h4>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="table-responsive">
				<table id="adminWorkspaceDatatable"
					class="table table-striped table-hover dt-responsive display">
					<thead>
						<tr>
							<th><span class="label label-info"><span
									class="glyphicon glyphicon-info-sign"></span>Bilgi</span></th>
							<th><span class="label label-info">#Serial</span></th>
							<th><span class="label label-info">Dönem</span></th>
							<th><span class="label label-info">Parsel</span></th>
							<th><span class="label label-info">Gelir Cinsi</span></th>
							<th><span class="label label-info">Açıklama</span></th>
							<th><span class="label label-info">Tahakkuk</span></th>
							<th><span class="label label-info">Ödenen</span></th>
							<th><span class="label label-info">Bakiye</span></th>
							<th><span class="label label-info">Durum</span></th>
							<th><span class="label label-primary"><i
									class="fa fa-edit"></i> Güncelle</span></th>
							<th><span class="label label-danger"><i
									class="fa fa-remove"></i> Sil</span></th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th><span class="label label-default"><span
									class="glyphicon glyphicon-info-sign"></span> Bilgi</span></th>
							<th><span class="label label-default">#Serial</span></th>
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
					</tfoot>

					<!-- 
					<tbody>
						<c:forEach var="debt" items="${debtList}">
							<tr id="${debt.serial}">
								<td class="details"><button type="button"
										class="btn btn-info btn-sm">
										<span class="glyphicon glyphicon-info-sign"></span>
									</button></td>
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
										data-target="#modalUpdateDebt" data-id="${debt.serial}"
										data-workspace="<spring:url value='/admin/workspace/${user.tc}' />"
										data-href="<spring:url value='/admin/update/debt/${debt.serial}' />"
										data-serial="${debt.serial}" data-donem="${debt.donem}"
										data-parsel="${debt.parsel}"
										data-gelir-cinsi="${debt.gelirCinsi}"
										data-aciklama="${debt.aciklama}"
										data-tahakkuk="${debt.tahakkuk}" data-odenen="${debt.odenen}"
										class="btn btn-primary buttonUpdateDebt">
										<i class="fa fa-edit"></i> Güncelle
									</button></td>
								<td><button data-toggle="modal" data-target="#modalDelete"
										data-id="${debt.serial}"
										data-href="<spring:url value='/admin/delete/debt/${debt.serial}' />"
										data-serial="${debt.serial}"
										data-object="${debt.serial} seri numaralı tahakkuk"
										class="btn btn-danger buttonDeleteDebt">
										<i class="fa fa-remove"></i> Sil
									</button></td>
							</tr>
						</c:forEach>
					</tbody> -->
				</table>
			</div>
		</div>
	</div>
</div>