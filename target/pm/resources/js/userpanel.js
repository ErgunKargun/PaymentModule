/* general js */
var adminDatatable;
var userDatatable;
var adminWorkspaceDatatable;
$(document).ready(function() {

	$('#modalDelete').on('show.bs.modal', function(e) {
		var data = $(e.relatedTarget).data();
		$('#modalFooterButtonDelete').attr('data-href', data.href);
		$('#deleteObject').text(data.object);
	});
	$('#modalUpdateUser').on('show.bs.modal', function(e) {
		var data = $(e.relatedTarget).data();
		$('#modalFooterButtonUpdateUser').attr('data-href', data.href);
		$('#tc').attr('value', data.tc);
		$('#name').attr('value', data.name);
		$('#surname').attr('value', data.surname);
		$('#email').attr('value', data.email);
		$('#phoneNumber').attr('value', data.phoneNumber);
	});
	$('#modalUpdateDebt').on('show.bs.modal', function(e) {
		var data = $(e.relatedTarget).data();
		$('#modalFooterButtonUpdateDebt').attr('data-workspace', data.workspace);
		$('#modalFooterButtonUpdateDebt').attr('data-href', data.href);
		$('#serial').attr('value', data.serial);
		$('#donem').attr('value', data.donem);
		$('#parsel').attr('value', data.parsel);
		$('#gelirCinsi').attr('value', data.gelirCinsi);
		$('#aciklama').attr('value', data.aciklama);
		$('#tahakkuk').attr('value', data.tahakkuk);
		$('#odenen').attr('value', data.odenen);
	});

	$('#bakiyeSpanAtDebtInsertForm').focus(function() {
		var tahakkuk = $('.tahakkuk').val();
		var odenen = $('.odenen').val();
		if (tahakkuk && odenen && !this.value) {
			this.value = tahakkuk - odenen;
		}
	});

	$('#formUpdateAccount').validate();
	$('#formUpdateUser').validate();
	$('#formUpdateDebt').validate();
	$('#formInsertNewUser').validate();
	$('#formInsertNewDebt').validate();

	adminDatatable = $('#adminDatatable').DataTable({
		"language" : {
			"lengthMenu" : "Sayfa başına _MENU_ kayıt göster",
			"zeroRecords" : "Hiçbir şey bulunamadı - üzgünüm",
			"info" : "_PAGES_ sayfadan _PAGE_ sayfa gösteriliyor",
			"infoEmpty" : "Kayıt yok veya henüz yapılmamış olabilir",
			"infoFiltered" : "(Toplam _MAX_ kayıttan filtrelendi)",
			"emptyTable" : "Henüz Kayıtlı veriniz bulunmamaktadır",
			"loadingRecords" : "Yükleniyor...",
			"processing" : "İşlem gerçekleştiriliyor...",
			"search" : "Ara:",
			"paginate" : {
				"first" : "İlk",
				"last" : "Son",
				"next" : "Sonraki",
				"previous" : "Önceki"
			}
		}
	});
	userDatatable = $('#userDatatable').DataTable({
		"language" : {
			"lengthMenu" : "Sayfa başına _MENU_ kayıt göster",
			"zeroRecords" : "Hiçbir şey bulunamadı - üzgünüm",
			"info" : "_PAGES_ sayfadan _PAGE_ sayfa gösteriliyor",
			"infoEmpty" : "Kayıt yok veya henüz yapılmamış olabilir",
			"infoFiltered" : "(Toplam _MAX_ kayıttan filtrelendi)",
			"emptyTable" : "Henüz Kayıtlı veriniz bulunmamaktadır",
			"loadingRecords" : "Yükleniyor...",
			"processing" : "İşlem gerçekleştiriliyor...",
			"search" : "Ara:",
			"paginate" : {
				"first" : "İlk",
				"last" : "Son",
				"next" : "Sonraki",
				"previous" : "Önceki"
			}
		}
	});
	adminWorkspaceDatatable = $('#adminWorkspaceDatatable').DataTable({
		"language" : {
			"lengthMenu" : "Sayfa başına _MENU_ kayıt göster",
			"zeroRecords" : "Hiçbir şey bulunamadı - üzgünüm",
			"info" : "_PAGES_ sayfadan _PAGE_ sayfa gösteriliyor",
			"infoEmpty" : "Kayıt yok veya henüz yapılmamış olabilir",
			"infoFiltered" : "(Toplam _MAX_ kayıttan filtrelendi)",
			"emptyTable" : "Henüz Kayıtlı veriniz bulunmamaktadır",
			"loadingRecords" : "Yükleniyor...",
			"processing" : "İşlem gerçekleştiriliyor...",
			"search" : "Ara:",
			"paginate" : {
				"first" : "İlk",
				"last" : "Son",
				"next" : "Sonraki",
				"previous" : "Önceki"
			}
		}
	});

	/*
	 * $('#adminDatatable tbody').on( 'click', '.buttonDeleteUser', function() {
	 * adminDatatable.row($(this).parents('tr')).remove() .draw(); });
	 * $('#adminWorkspaceDatatable tbody').on( 'click', '.buttonDeleteDebt',
	 * function() { adminWorkspaceDatatable.row($(this).parents('tr'))
	 * .remove().draw(); });
	 */

	$('#toPayment').click(function() {
		$('#userDatatableDiv').animate({
			left : '-50%'
		}, 500, function() {
			$('#userDatatableDiv').css('left', '150%');
			$('#userDatatableDiv').appendTo('#container');
		});
		$('#userDatatableDiv').next().animate({
			left : '50%'
		}, 500);
	});

	$('#toUserDatatable').click(function() {
		$('#paymentDiv').animate({
			left : '+150%'
		}, 500, function() {
			$('#userDatatableDiv').prependTo('#container');
		});
		$('#userDatatableDiv').css('left', '-50%');
		$('#userDatatableDiv').animate({
			left : '+50%'
		}, 500, function() {
			$.ajax({
				type : "GET",
				cache : false,
				url : '${urlUserDatatable}',
				success : function(response) {
					$('#userDatatableDiv').html(response);
				}
			});
		});
	});

	$('#toAdminDatatable').click(function() {
		$('#adminDatatableDiv').animate({
			left : '-50%'
		}, 500, function() {
			$('#adminDatatableDiv').css('left', '150%');
			$('#adminDatatableDiv').appendTo('#container');
		});
		$('#adminDatatableDiv').next().animate({
			left : '50%'
		}, 500, function() {
			$.ajax({
				type : "GET",
				cache : false,
				url : '${urlAdminDatatable}',
				success : function(response) {
					$('#adminDatatableDiv').html(response);
				}
			});
		});
	});

	$('.toAdminWorkspace').click(function() {
		$('#adminWorkspaceDiv').animate({
			left : '+150%'
		}, 500, function() {
			$('#adminDatatableDiv').prependTo('#container');
		});
		$('#adminDatatableDiv').css('left', '-50%');
		$('#adminDatatableDiv').animate({
			left : '+50%'
		}, 500, function() {
			$.ajax({
				type : "GET",
				cache : false,
				url : $('this').data('href'),
				success : function(response) {
					$('#adminWorkspaceDiv').html(response);
				}
			});
		});
	});
});

var urlPayment;
function handle(checkboxElem) {
	var parameters = [];
	var total = 0;
	var checkboxElems = document.getElementsByTagName("input");
	document.getElementById("toPayment").disabled = true;
	for (var i = 0; i < checkboxElems.length; i++) {
		if (checkboxElems[i].type == 'checkbox') {
			if (checkboxElems[i].checked) {
				document.getElementById("toPayment").disabled = false;
				total += parseInt(checkBoxElems[i].getAttribute("value"));
				parmeters.push(checkBoxElems[i].getAttribute("data-serial"));
			}
		}
	}
	document.getElementById("paymentButtonSpan").innerHTML = String(total);
	document.getElementById("totalDebtAmount").innerHTML = String(total);
	urlPayment = $('#paymentButton').data('href');
	urlPayment += jQuery.param({
		serial : parameters
	});
}

function updateAccount() {
	$('#modalUpdateAccount').addClass('loading');
	var options = {
		type : 'POST',
		dataType : 'json',
		success : function showSuccessResponse(response) {
			$('#modalUpdateAccount').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				$.ajax({
					type : "GET",
					cache : false,
					url : '${urlHome}',
					success : function(response) {
						$("html").html(response);
					}
				});
				$.toast({
					heading : 'Başarılı',
					text : 'Güncelleme işlemi Başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});
			}

			else if (response.status == "ERROR") {
				$.toast({
					heading : 'Başarısız',
					text : 'Bir sorun var! ' + response.result,
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'warning'
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("<%=request.getContextPath() %>");
			}
		},
		error : function showErrorResponse(response) {
			$('#modalUpdateAccount').modal('hide').removeClass('loading');
			$.toast({
				heading : 'Hata',
				text : 'Ciddi bir sorun var! ' + response,
				showHideTransition : 'slide',
				position : 'top-right',
				hideAfter : false,
				icon : 'error'
			});
		}
	};
	$('#formUpdateAccount').ajaxForm(options);
}

function deleteObject() {
	$('#modalDelete').addClass('loading');
	var urlDelete = $('#modalFooterButtonDelete').attr('data-href');
	$.ajax({
		type : "DELETE",
		cache : false,
		url : urlDelete,
		dataType : 'json',
		success : function(response) {
			$('#modalDelete').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				if (urlDelete.contains("debt")) {
					adminWorkspaceDatatable.row($(this).parents('tr')).remove()
							.draw();
				} else {
					adminDatatable.row($(this).parents('tr')).remove().draw();
				}
				$.toast({
					heading : 'Başarılı',
					text : 'Silme işlemi başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});
			} else if (response.status == "ERROR") {
				$.toast({
					heading : 'Başarısız',
					text : 'Bir sorun var! ' + response.result,
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'warning'
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("<%=request.getContextPath() %>");
			}
		},
		error : function showErrorResponse(response) {
			$('#modalDelete').modal('hide').removeClass('loading');
			$.toast({
				heading : 'Hata',
				text : 'Ciddi bir sorun var! ' + response,
				showHideTransition : 'slide',
				position : 'top-right',
				hideAfter : false,
				icon : 'error'
			});
		}
	});
}

function insertNewDebt(e) {
	$.toast({
		heading : 'Yükleniyor..',
		text : 'İşleminiz gerçekleştiriliyor.',
		showHideTransition : 'slide',
		position : 'top-right',
		allowToastClose : false,
		hideAfter : 5000,
		icon : 'info'
	});
	var options = {
		type : 'POST',
		dataType : 'json',
		success : function showSuccessResponse(response) {
			if (response.status == "SUCCESS") {
				$.ajax({
					type : "GET",
					cache : false,
					url : e.data('workspace'),
					success : function(response) {
						$("adminWorkspaceDiv").html(response);
					}
				});
				$.toast({
					heading : 'Başarılı',
					text : 'Ekleme işlemi başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});
			} else if (response.status == "ERROR") {
				$.toast({
					heading : 'Başarısız',
					text : 'Bir sorun var! ' + response.result,
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'warning'
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("<%=request.getContextPath() %>");
			}
		},
		error : function showErrorResponse(response) {
			$.toast({
				heading : 'Hata',
				text : 'Ciddi bir sorun var! ' + response,
				showHideTransition : 'slide',
				position : 'top-right',
				hideAfter : false,
				icon : 'error'
			});
		}
	};
	$('#formInsertNewDebt').ajaxForm(options);
}

function insertNewUser() {
	$('#modalInsertNewUser').addClass('loading');
	var options = {
		type : 'POST',
		dataType : 'json',
		success : function showSuccessResponse(response) {
			$.ajax({
				type : "GET",
				cache : false,
				url : '${urlAdminDatatable}',
				success : function(response) {
					$('#adminDatatableDiv').html(response);
				}
			});
			$('#modalInsertNewUser').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				$.toast({
					heading : 'Başarılı',
					text : 'Ekleme işlemi başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});
			} else if (response.status == "ERROR") {
				$.toast({
					heading : 'Başarısız',
					text : 'Bir sorun var! ' + response.result,
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'warning'
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("<%=request.getContextPath() %>");
			}
		},
		error : function showErrorResponse(response) {
			$('#modalInsertNewUser').modal('hide').removeClass('loading');
			$.toast({
				heading : 'Hata',
				text : 'Ciddi bir sorun var! ' + response,
				showHideTransition : 'slide',
				position : 'top-right',
				hideAfter : false,
				icon : 'error'
			});
		}
	};
	$('#formInsertNewUser').ajaxForm(options);
}

function updateDebt(e) {
	$('#modalUpdateDebt').addClass('loading');
	var options = {
		type : 'POST',
		dataType : 'json',
		success : function showSuccessResponse(response) {
			$('#modalUpdateDebt').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				$.ajax({
					type : "GET",
					cache : false,
					url : e.data('workspace'),
					success : function(response) {
						$("adminWorkspaceDiv").html(response);
					}
				});
				$.toast({
					heading : 'Başarılı',
					text : 'Güncelleme işlemi Başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});
			}
			else if (response.status == "ERROR") {
				$.toast({
					heading : 'Başarısız',
					text : 'Bir sorun var! ' + response.result,
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'warning'
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("<%=request.getContextPath() %>");
			}
		},
		error : function showErrorResponse(response) {
			$('#modalUpdateDebt').modal('hide').removeClass('loading');
			$.toast({
				heading : 'Hata',
				text : 'Ciddi bir sorun var! ' + response,
				showHideTransition : 'slide',
				position : 'top-right',
				hideAfter : false,
				icon : 'error'
			});
		}
	};
	$('#formUpdateDebt').attr('action',
			$('#modalFooterButtonUpdateDebt').attr('data-href'));
	$('#formUpdateDebt').ajaxForm(options);
}

function updateUser() {
	$('#modalUpdateUser').addClass('loading');
	var options = {
		type : 'POST',
		dataType : 'json',
		success : function showSuccessResponse(response) {
			$.ajax({
				type : "GET",
				cache : false,
				url : '${urlAdminDatatable}',
				success : function(response) {
					$('#adminDatatableDiv').html(response);
				}
			});
			$('#modalUpdateUser').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				$.toast({
					heading : 'Başarılı',
					text : 'Güncelleme işlemi Başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});
			}

			else if (response.status == "ERROR") {
				$.toast({
					heading : 'Başarısız',
					text : 'Bir sorun var! ' + response.result,
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'warning'
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("<%=request.getContextPath() %>");
			}
		},
		error : function showErrorResponse(response) {
			$('#modalUpdateUser').modal('hide').removeClass('loading');
			$.toast({
				heading : 'Hata',
				text : 'Ciddi bir sorun var! ' + response,
				showHideTransition : 'slide',
				position : 'top-right',
				hideAfter : false,
				icon : 'error'
			});
		}
	};
	$('#formUpdateUser').attr('action',
			$('#modalFooterButtonUpdateUser').attr('data-href'));
	$('#formUpdateUser').ajaxForm(options);
}

function upload() {
	$('#modalUpdoad').addClass('loading');
	var options = {
		type : 'POST',
		dataType : 'json',
		success : function showSuccessResponse(response) {
			$.ajax({
				type : "GET",
				cache : false,
				url : '${urlAdminDatatable}',
				success : function(response) {
					$('#adminDatatableDiv').html(response);
				}
			});
			$('#modalUpload').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				$.toast({
					heading : 'Başarılı',
					text : 'Yükleme işlemi Başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});
			} else if (response.status == "ERROR") {
				var errorInfo = "";
				for (i = 0; i < response.result.length; i++) {
					errorInfo += (i + 1) + ". " + response.result[i];
				}
				swal({
					title : "Başarısız",
					text : errorInfo,
					type : "error",
					confirmButtonColor : "#DD6B55",
					confirmButtonText : "Tamam!",
					closeOnConfirm : false
				}, function() {
					swal.close();
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("<%=request.getContextPath() %>");
			}
		},
		error : function showErrorResponse(response) {
			$('#modalUpload').modal('hide').removeClass('loading');
			$.toast({
				heading : 'Hata',
				text : 'Ciddi bir sorun var! ' + response,
				showHideTransition : 'slide',
				position : 'top-right',
				hideAfter : false,
				icon : 'error'
			});
		}
	};
	$('#formUpload').ajaxForm(options);
}