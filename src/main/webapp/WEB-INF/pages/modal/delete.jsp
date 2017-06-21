<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!-- Confirm delete -->
<div class="modal fade" id="modalDelete" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h4 class="modal-title">Emin misin?</h4>
			</div>
			<div class="modal-body">
				<p>
					Bunu yaparak <b><i id="deleteObject"></i></b> kaydı ile alakalı
					herşeyi silmiş olacaksın ve bu işlem geri döndürülemez.
				</p>
				<p>Devam etmek istiyor musun?</p>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal">İptal</button>
				<button class="btn btn-danger" id="modalFooterButtonDelete" onclick="deleteObject(this)">Sil</button>
			</div>
		</div>
	</div>
</div>