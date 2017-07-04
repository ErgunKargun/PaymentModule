<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="panel-body">
	<div class="row">
		<div class="col-xs-12 col-md-4"></div>
		<div class="col-xs-12 col-md-4">
			<!-- CREDIT CARD FORM STARTS HERE -->
			<div class="panel panel-default credit-card-box">
				<div class="panel-heading display-table">
					<div class="row display-tr">
						<h3 class="panel-title display-td">Ödeme Ayrıntıları</h3>
						<div class="display-td">
							<img class="img-responsive pull-right"
								src="http://i76.imgup.net/accepted_c22e0.png">
						</div>
					</div>
				</div>
				<div class="panel-body">
					<form role="form" id="payment-form" method="POST"
						action="javascript:void(0);">
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<label for="cardNumber">Kart Numaranız</label>
									<div class="input-group">
										<input type="tel" class="form-control" name="cardNumber"
											placeholder="Geçerli kart numarası" required autofocus /> <span
											class="input-group-addon"><i class="fa fa-credit-card"></i></span>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-7 col-md-7">
								<div class="form-group">
									<label for="cardExpiry"><span class="hidden-xs">Son
											Kullanma Tarihi</span><span class="visible-xs-inline">EXP</span> </label> <input
										type="tel" class="form-control" name="cardExpiry"
										placeholder="MM / YY" required />
								</div>
							</div>
							<div class="col-xs-5 col-md-5 pull-right">
								<div class="form-group">
									<label for="cardCVC">CVC</label> <input type="tel"
										class="form-control" name="cardCVC" placeholder="CVC" required />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<ul class="nav nav-pills nav-stacked">
										<li class="active"><a href="#"><span
												class="badge pull-right"><i
													class="fa fa-turkish-lira"></i><span id="totalDebtAmount">0</span></span>
												Ödenecek Tutar</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<button class="subscribe btn btn-success btn-lg btn-block"
									id="paymentButton"
									data-href="<c:url value='/user/debt/payment' />" type="button">Öde</button>
							</div>
						</div>
						<div class="row" style="display: none;">
							<div class="col-xs-12">
								<p class="payment-errors"></p>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- CREDIT CARD FORM ENDS HERE -->
		</div>
		<!-- <div class="col-xs-12 col-md-4"></div> -->
	</div>
</div>