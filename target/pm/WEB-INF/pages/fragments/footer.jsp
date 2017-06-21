<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="panel-footer">
	<footer>
		<p style="text-align: center;">&copy; Arma Bilgisayar | 2017</p>
		<p style="text-align: center;">Destek için
			armabilgisayar@armabilgisayar.net'a yazın!</p>
	</footer>
</div>

</body>

<!-- For General -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- For validating forms -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.16.0/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>
<script type="text/javascript"
	src="<c:url value='/resources/js/messages_tr.js' />"></script>

<!-- Ajax Form submit -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.1/jquery.form.min.js"></script>

<!-- <script type="text/javascript"
	src="https://cdn.jsdelivr.net/g/jquery.formvalidation@0.6.1(js/language/tr_TR.js+js/formValidation.min.js)"></script> -->

<!-- For Payment -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery.payment/3.0.0/jquery.payment.min.js"></script>

<!-- If you're using Stripe for payments -->
<script type="text/javascript" src="https://js.stripe.com/v2/"></script>

<!-- Datatable -->
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap.min.js"></script>

<!-- Jquery Toast -->
<script type="text/javascript"
	src="<c:url value='/resources/js/jquery.toast.min.js' />"></script>

<!-- Sweetalert2 -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.4/sweetalert2.common.min.js"></script>
<!-- Sweetalert Bootstrap 
<script type="text/javascript"
	src="<c:url value='/resources/js/sweetalert.js' />"></script> -->

<!-- Locally scripts -->
<script type="text/javascript"
	src="<c:url value='/resources/js/payment.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/resources/js/userpanel.js' />"></script>