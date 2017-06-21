<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!-- Upload csv -->
<div class="modal fade" id="modalUpload" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h4 class="modal-title">Yükle</h4>
			</div>
			<div class="modal-body">
				<form:form id="formUpload" class="form-horizontal" method="post"
					action="${urlUpload}" enctype="multipart/form-data">
					<div class="form-group">
						<label class="col-sm-2 control-label"><span
							class="label label-warning">Dikkat!</span></label>
						<div class="col-sm-10">
							<span class="label label-info">CSV dosyanın <span
								class="label label-danger">txt</span> uzantılı olmasına,
								boyutunun <span class="label label-danger">10</span>mb'ı
								geçmemesine ve <span class="label label-danger">'|'</span>
								karakteri kullanılarak değerlerin ayrılmasına lütfen dikkat
								ediniz!
							</span>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Dosya seç</label>
						<div class="col-sm-10">
							<form:input type="file" name="file" id="file" path="file" />
						</div>
					</div>
				</form:form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal">İptal</button>
				<button class="btn btn-danger" id="modalFooterButtonUpload"
					onclick="upload()">Yükle</button>
			</div>
		</div>
	</div>
</div>