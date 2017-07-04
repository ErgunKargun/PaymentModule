<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<h4>Tahakkuk Listesi</h4>
	<div class="row">
		<div class="col-md-12">
			<div class="table-responsive">
				<table id="userDatatable"
					class="table table-striped table-bordered table-hover dt-responsive display">
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
							<th><i class="fa fa-credit-card"></i>Seç</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th><span class="label label-default"><span
									class="glyphicon glyphicon-info-sign"></span> Bilgi</span></th>
							<th><span class="label label-info">#Serial</span></th>
							<th><span class="label label-default">Dönem</span></th>
							<th><span class="label label-default">Parsel</span></th>
							<th><span class="label label-default">Gelir Cinsi</span></th>
							<th><span class="label label-default">Açıklama</span></th>
							<th><span class="label label-default">Tahakkuk</span></th>
							<th><span class="label label-default">Ödenen</span></th>
							<th><span class="label label-default">Bakiye</span></th>
							<th><span class="label label-default">Durum</span></th>
							<th>
								<button id="toPayment" class="btn btn-primary" disabled>
									<span class="badge pull-left"><i
										class="fa fa-turkish-lira"></i><span id="paymentButtonSpan">&nbsp;
											0 &nbsp;</span></span> &nbsp; <span class="badge pull-right">&nbsp;<span
										class="glyphicon glyphicon-arrow-right"></span>&nbsp;
									</span>
								</button>
							</th>
						</tr>
					</tfoot>
					<!-- <c:forEach var="debt" items="${debtList}">
						<tr>
							<td>${debt.donem}</td>
							<td>${debt.parsel}</td>
							<td>${debt.gelirCinsi}</td>
							<td>${debt.aciklama}</td>
							<td>${debt.tahakkuk}</td>
							<td>${debt.odenen}</td>
							<td>${debt.bakiye}</td>
							<td>${debt.durum}</td>
							<td><label><input type='checkbox'
									data-serial="${debt.serial}" value="${debt.bakiye}"
									onclick="handle(this);" /></label></td>
						</tr>
					</c:forEach>-->
				</table>
			</div>
		</div>
	</div>
</div>