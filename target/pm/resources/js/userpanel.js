/* general js */
var adminDatatable;
var userDatatable;
var adminWorkspaceDatatable;
var $content, $wrapper;
function resizeTablesAdmin() {
	var $content = $('#adminDatatableDiv'), $wrapper = $('#adminDiv');
	function setContentHeight() {
		$wrapper.css('min-height', $content.height() + 640);
	}
	setContentHeight();
	$(window).on("resize", setContentHeight);
}
function resizeTablesAdminWorkspace() {
	var $content = $('#adminWorkspaceDiv'), $wrapper = $('#adminDiv');
	function setContentHeight() {
		$wrapper.css('min-height', $content.height() + 640);
	}
	setContentHeight();
	$(window).on("resize", setContentHeight);
}
function resizeTablesUser() {
	var $content = $('#userDatatableDiv'), $wrapper = $('#userDiv');
	function setContentHeight() {
		$wrapper.css('min-height', $content.height() + 640);
	}
	setContentHeight();
	$(window).on("resize", setContentHeight);
}
$(document).ready(function() {
	$('#toAdminDatatable').hide();
	$('#toUserDatatable').hide();

	$('#toPayment').click();
	$('#toUserDatatable').click();

	adminDatatableRun();
	userDatatableRun();

	$(document).on('click', '.toAdminWorkspace', function() {		
		var tc = $(this).attr('data-tc');
		//var action = $(this).data('insertDebt');
		var action = ctx + '/admin/insert/debt/' + tc;
		$('#formInsertNewDebt').attr('action', action);
		var h1 = tc + "&nbsp;tc'li&nbsp;mükellefin&nbsp;Tahakkuk&nbsp;Listesi";
		var urlToWorkspace = $(this).data('href');
		$('#toAdminDatatable').show();
		$('#adminWorkspaceUserH1').html(h1);
		$('#tcSpanAtDebtInsertForm').text(tc);
		$('#formInsertNewDebt').attr("action", action);
		$('#adminDatatableDiv').animate({
			left : '-100%'
		}, 500, function() {
			$('#adminDatatableDiv').appendTo('#adminDiv');
		});
		$('#adminDatatableDiv').next().animate({
			left : '0%'
		}, 500, function() {
			adminWorkspaceDatatableRun(action, tc, h1, urlToWorkspace);
		});
	});

	resizeTablesAdmin();
	resizeTablesUser();

	$('#formUpload').validate();
	$('#formUpdateAccount').validate();
	$('#formUpdateUser').validate();
	$('#formUpdateDebt').validate();
	$('#formInsertNewUser').validate();
	$('#formInsertNewDebt').validate();

//	$(document).on('focus', '#bakiyeSpanAtDebtInsertForm', function() {
//		var tahakkuk = $('#formInsertNewDebt input[name=tahakkuk]').val();
//		var odenen = $('#formInsertNewDebt input[name=odenen]').val();
//		this.val = tahakkuk - odenen;
//	});
	
});

// $().ready(function() {
// });

$('#modalDelete').on('show.bs.modal', function(e) {
	var data = $(e.relatedTarget).data();
	$('#modalFooterButtonDelete').attr('data-href', data.href);
	$('#modalFooterButtonDelete').attr('data-id', data.id);
	$('#deleteObject').text(data.object);
});
$('#modalUpdateUser').on('show.bs.modal', function(e) {
	var data = $(e.relatedTarget).data();
	$('#modalFooterButtonUpdateUser').attr('data-href', data.href);
	$('#modalFooterButtonUpdateUser').attr('data-id', data.id);
	$('#formUpdateUser input[name=tc]').val(data.tc);
	$('#formUpdateUser input[name=name]').val(data.name);
	$('#formUpdateUser input[name=surname]').val(data.surname);
	$('#formUpdateUser input[name=email]').val(data.email);
	$('#formUpdateUser input[name=phoneNumber]').val(data.phoneNumber);
});
$('#modalUpdateDebt').on('show.bs.modal', function(e) {
	var data = $(e.relatedTarget).data();
	$('#modalFooterButtonUpdateDebt').attr('data-href', data.href);
	$('#modalFooterButtonUpdateDebt').attr('data-id', data.id);
	$('#modalFooterButtonUpdateDebt').attr('data-durum', data.durum);
	$('#formUpdateDebt #serial').val(data.serial);
	$('#formUpdateDebt #donem').val(data.donem);
	$('#formUpdateDebt #parsel').val(data.parsel);
	$('#formUpdateDebt #gelirCinsi').val(data.gelirCinsi);
	$('#formUpdateDebt #aciklama').val(data.aciklama);
	$('#formUpdateDebt #tahakkuk').val(data.tahakkuk);
	$('#formUpdateDebt #odenen').val(data.odenen);
});
$('#modalInsertNewDebt').on('show.bs.modal', function(e) {
	var data = $(e.relatedTarget).data();
	$('#modalFooterButtonInsertNewDebt').attr('data-href', ctx + "/admin/insert/debt/" + tc);
});

$('#adminDatatable').on('length.dt', function(e, settings, len) {
	resizeTablesAdmin();
});

$('#adminWorkspaceDatatable').on('length.dt', function(e, settings, len) {
	resizeTablesAdminWorkspace();
});

$('#userDatatable').on('length.dt', function(e, settings, len) {
	resizeTablesUser();
});

// userDatatable = $('#userDatatable').DataTable({
// 'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'Hepsi' ] ],
// retrieve : true,
// "language" : {
// "lengthMenu" : "Sayfa başına _MENU_ kayıt göster",
// "zeroRecords" : "Hiçbir şey bulunamadı - üzgünüm",
// "info" : "_PAGES_ sayfadan _PAGE_ sayfa gösteriliyor",
// "infoEmpty" : "Kayıt yok veya henüz yapılmamış olabilir",
// "infoFiltered" : "(Toplam _MAX_ kayıttan filtrelendi)",
// "emptyTable" : "Henüz Kayıtlı veriniz bulunmamaktadır",
// "loadingRecords" : "Yükleniyor...",
// "processing" : "İşlem gerçekleştiriliyor...",
// "search" : "Ara:",
// "paginate" : {
// "first" : "İlk",
// "last" : "Son",
// "next" : "Sonraki",
// "previous" : "Önceki"
// }
// },
// responsive : true
// });

$('#toPayment').click(function() {
	$('#toUserDatatable').show();
	$('#userDatatableDiv').animate({
		left : '-100%'
	}, 500, function() {
		$('#userDatatableDiv').appendTo('#userDiv');
	});
	$('#userDatatableDiv').next().animate({
		left : '0%'
	}, 500);
});

$('#toUserDatatable').click(function() {
	$('#toUserDatatable').hide();
	$('#paymentDiv').animate({
		left : '100%'
	}, 500, function() {
		$('#userDatatableDiv').prependTo('#userDiv');
	});
	$('#userDatatableDiv').animate({
		left : '0%'
	}, 500, function() {
		userDatatableRun();
	});
});

function adminWorkspaceDatatableRun(action, tc, h1, urlToWorkspace) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	adminWorkspaceDatatable = $('#adminWorkspaceDatatable').DataTable(
			{
				'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'All' ] ],
				dom : 'flBrtip',
				processing : true,
				ajax : {
					url : urlToWorkspace,
					type : 'POST',
					beforeSend : function(request) {
						request.setRequestHeader(header, token);
					},
					dataSrc : "data"
				},
				"columns" : [ {
					"data" : "Bilgi",
					"className" : "details"
				}, {
					"data" : "Serial"
				}, {
					"data" : "Dönem"
				}, {
					"data" : "Parsel"
				}, {
					"data" : "Gelir Cinsi"
				}, {
					"data" : "Açıklama"
				}, {
					"data" : "Tahakkuk"
				}, {
					"data" : "Ödenen"
				}, {
					"data" : "Bakiye"
				}, {
					"data" : "Durum"
				}, {
					"data" : "Güncelle"
				}, {
					"data" : "Sil"
				} ],
				buttons : [
						'colvis',
						'copy',
						'csv',
						'excel',
						'pdf',
						'print',
						{
							text : 'Yeni',
							action : function(e, dt, node, config) {
								$('#modalInsertNewDebt').modal('show');
//								$('#modalFooterButtonInsertNewDebt').attr(
//										'data-href',
//										ctx + "/admin/insert/debt/" + tc);
//								$('#formInsertNewDebt').attr('action', action);
							}
						} ],
				retrieve : true,
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
					},
					buttons : {
						colvis : 'Kolon',
						copy : 'Kopyala',
						print : 'Yazdır'
					}
				},
				"columnDefs" : [ {
					"width" : "12%",
					"targets" : [ 0, 2, 3, 6, 7, 8, 9, 10, 11 ]
				}, {
					"targets" : [ 1, 4, 5 ],
					"visible" : false
				} ],
				"createdRow" : function(row, data, index) {
					// Add
					// identity
					// if
					// it
					// specified
					if (data.hasOwnProperty("id")) {
						row.id = data.id;
						$(row).find('td').eq(0).addClass('details');
					}
				},
				responsive : true
			});	
	adminWorkspaceDatatable.ajax.url( urlToWorkspace ).load();
	resizeTablesAdminWorkspace();	
	$('#adminWorkspaceDatatable tbody').on(
			'click',
			'td.details',
			function() {
				var data = adminWorkspaceDatatable.row(this).data();
				swal({
					title : 'Ayrıntılar',
					type : 'info',
					html : '<b>Serial</b>' + ' : ' + '<i>' + data["Serial"]
							+ '</i>' + '</br>' + '<b>Dönem</b>' + ' : ' + '<i>'
							+ data["Dönem"] + '</i>' + '</br>'
							+ '<b>Parsel</b>' + ' : ' + '<i>' + data["Parsel"]
							+ '</i>' + '</br>' + '<b>Gelir Cinsi</b>' + ' : '
							+ '<i>' + data["Gelir Cinsi"] + '</i>' + '</br>'
							+ '<b>Açıklama</b>' + ' : ' + '<i>'
							+ data["Açıklama"] + '</i>' + '</br>'
							+ '<b>Tahakkuk</b>' + ' : ' + '<i>'
							+ data["Tahakkuk"] + '</i>' + '</br>'
							+ '<b>Ödenen</b>' + ' : ' + '<i>' + data["Ödenen"]
							+ '</i>' + '</br>' + '<b>Bakiye</b>' + ' : '
							+ '<i>' + data["Bakiye"] + '</i>' + '</br>'
							+ '<b>Durum</b>' + ' : ' + '<i>' + data["Durum"]
							+ '</i>' + '</br>',
					showCloseButton : true,
					confirmButtonText : 'Tamam'
				});
			});
}

function userDatatableRun() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	userDatatable = $('#userDatatable').DataTable({
//		'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'All' ] ],
//		dom : 'flBrtip',
		processing : true,
		ajax : {
			url : ctx + '/user/datatable',
			type : 'POST',
			beforeSend : function(request) {
				request.setRequestHeader(header, token);
			},
			dataSrc : "data"
		},
		"columns" : [ {
			"data" : "Bilgi",
			"className" : "details"
		}, {
			"data" : "Serial"
		}, {
			"data" : "Dönem"
		}, {
			"data" : "Parsel"
		}, {
			"data" : "Gelir Cinsi"
		}, {
			"data" : "Açıklama"
		}, {
			"data" : "Tahakkuk"
		}, {
			"data" : "Ödenen"
		}, {
			"data" : "Bakiye"
		}, {
			"data" : "Durum"
		}, {
			"data" : "Seç"
		} ],
		retrieve : true,
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
		},
		"columnDefs" : [ {
			"width" : "9%",
			"targets" : [ 0, 2, 3, 6, 7, 8, 9, 10 ]
		}, {
			"targets" : [ 1, 4, 5 ],
			"visible" : false
		} ],
		responsive : true
	});
	userDatatable.ajax.url( ctx + '/user/datatable' ).load();
	resizeTablesUser();	
	$('#userDatatable tbody').on(
			'click',
			'td.details',
			function() {
				var data = userDatatable.row(this).data();
				swal({
					title : 'Ayrıntılar',
					type : 'info',
					html : '<b>Serial</b>' + ' : ' + '<i>' + data["Serial"]
							+ '</i>' + '</br>' + '<b>Dönem</b>' + ' : ' + '<i>'
							+ data["Dönem"] + '</i>' + '</br>'
							+ '<b>Parsel</b>' + ' : ' + '<i>' + data["Parsel"]
							+ '</i>' + '</br>' + '<b>Gelir Cinsi</b>' + ' : '
							+ '<i>' + data["Gelir Cinsi"] + '</i>' + '</br>'
							+ '<b>Açıklama</b>' + ' : ' + '<i>'
							+ data["Açıklama"] + '</i>' + '</br>'
							+ '<b>Tahakkuk</b>' + ' : ' + '<i>'
							+ data["Tahakkuk"] + '</i>' + '</br>'
							+ '<b>Ödenen</b>' + ' : ' + '<i>' + data["Ödenen"]
							+ '</i>' + '</br>' + '<b>Bakiye</b>' + ' : '
							+ '<i>' + data["Bakiye"] + '</i>' + '</br>'
							+ '<b>Durum</b>' + ' : ' + '<i>' + data["Durum"]
							+ '</i>' + '</br>',
					showCloseButton : true,
					confirmButtonText : 'Tamam'
				});
			});
}

$(document).on('click', '#toAdminDatatable', function() {
	$('#toAdminDatatable').hide();
	$('#adminWorkspaceDiv').animate({
		left : '100%'
	}, 500, function() {
		$('#adminDatatableDiv').prependTo('#adminDiv');
	});
	$('#adminDatatableDiv').animate({
		left : '0%'
	}, 500, function() {
		// setTimeout(function() {
		// window.location.replace("pm/user/userpanel")
		// }, 1000);
		adminDatatableRun();
	});
});

function adminDatatableRun() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	adminDatatable = $('#adminDatatable').DataTable({
		'lengthMenu' : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, 'All' ] ],
		dom : 'flBrtip',
		processing : true,
		ajax : {
			url : ctx + '/admin/datatable',
			type : 'POST',
			beforeSend : function(request) {
				request.setRequestHeader(header, token);
			},
			dataSrc : "data"
		},
		"columns" : [ {
			"data" : "Bilgi",
			"className" : "details"
		}, {
			"data" : "Tc"
		}, {
			"data" : "Adı"
		}, {
			"data" : "Soyadı"
		}, {
			"data" : "Email"
		}, {
			"data" : "Telefon"
		}, {
			"data" : "Admin Email"
		}, {
			"data" : "Güncelle"
		}, {
			"data" : "Sil"
		}, {
			"data" : "Git"
		} ],
		buttons : [ 'colvis', 'copy', 'csv', 'excel', 'pdf', 'print', {
			text : 'Yeni',
			action : function(e, dt, node, config) {
				$('#modalInsertNewUser').modal('show');
			}
		} ],
		retrieve : true,
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
			},
			buttons : {
				colvis : 'Kolon',
				copy : 'Kopyala',
				print : 'Yazdır'
			}
		},
		"columnDefs" : [ {
			"width" : "12%",
			"targets" : [ 1, 2, 3, 5, 7 ]
		}, {
			"width" : "22%",
			"targets" : [ 4 ]
		}, {
			"width" : "10%",
			"targets" : [ 0, 8, 9 ]
		}, {
			targets : [ 4 ],
			render : function(data, type, row) {
				return data.length > 30 ? data.substr(0, 30) + '…' : data;
			}
		}, {
			"targets" : [ 6 ],
			"visible" : false
		} ],
		"createdRow" : function(row, data, index) {
			// Add identity
			// if it
			// specified
			if (data.hasOwnProperty("id")) {
				row.id = data.id;
				$(row).find('td').eq(0).addClass('details');
			}
		}
	});	
	adminDatatable.ajax.url( ctx + '/admin/datatable' ).load();
	resizeTablesAdmin();
	$('#adminDatatable tbody').on(
			'click',
			'td.details',
			function() {
				var data = adminDatatable.row(this).data();
				swal({
					title : 'Ayrıntılar',
					type : 'info',
					html : '<b>Tc</b>' + ' : ' + '<i>' + data['Tc'] + '</i>'
							+ '</br>' + '<b>Ad</b>' + ' : ' + '<i>' + data['Adı']
							+ '</i>' + '</br>' + '<b>Soyad</b>' + ' : ' + '<i>'
							+ data['Soyadı'] + '</i>' + '</br>' + '<b>Email</b>'
							+ ' : ' + '<i>' + data['Email'] + '</i>' + '</br>'
							+ '<b>Telefon</b>' + ' : ' + '<i>' + data['Telefon']
							+ '</i>' + '</br>' + '<b>Admin Email</b>' + ' : '
							+ '<i>' + data['Admin Email'] + '</i>' + '</br>',
					showCloseButton : true,
					confirmButtonText : 'Tamam'
				});
			});
}

var urlPayment;
var serialParam;
function handle(checkboxElem) {
	serialParam = [];
	var total = 0;
	var checkboxElems = document.getElementsByTagName("input");
	document.getElementById("toPayment").disabled = true;
	for (var i = 0; i < checkboxElems.length; i++) {
		if (checkboxElems[i].type == 'checkbox') {
			if (checkboxElems[i].checked) {
				document.getElementById("toPayment").disabled = false;
				total += Number(checkboxElems[i].getAttribute("value")); //.toFixed(2)
				serialParam.push(checkboxElems[i].getAttribute("data-serial"));
			}
		}
	}
	document.getElementById("paymentButtonSpan").innerHTML = String(total);
	document.getElementById("totalDebtAmount").innerHTML = String(total);
	urlPayment = $('#paymentButton').data('href');
//	urlPayment += jQuery.param({
//		serial : parameters
//	});
}

function updateAccount() {
	console.log("test");
	$('#modalUpdateAccount').addClass('loading');
	var options = {
		type : 'POST',
		dataType : 'json',
		success : function showSuccessResponse(response) {
			$('#modalUpdateAccount').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				$.toast({
					heading : 'Başarılı',
					text : 'Güncelleme işlemi Başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});
				setTimeout(function() {
					window.location.replace("pm/user/userpanel")
				}, 5000);
			} else if (response.status == "ERROR") {
				$.toast({
					heading : 'Başarısız',
					text : 'Bir sorun var! ' + response.result,
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'warning'
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("pm/user/userpanel");
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
	$('#formUpdateAccount').ajaxSubmit(options);
}

function deleteObject(e) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$('#modalDelete').addClass('loading');
	var urlDelete = $('#modalFooterButtonDelete').attr('data-href');
	$.ajax({
		type : "DELETE",
		beforeSend : function(request) {
			request.setRequestHeader(header, token);
		},
		cache : false,
		url : urlDelete,
		dataType : 'json',
		success : function(response) {
			$('#modalDelete').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				if (urlDelete.includes("debt")) {
					adminWorkspaceDatatable.row(
							document.getElementById($(e).attr('data-id')))
							.remove().draw();
				} else {
					adminDatatable.row(
							document.getElementById($(e).attr('data-id')))
							.remove().draw();
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
				window.location.replace("pm/user/userpanel");
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
	// $.toast({
	// heading : 'Yükleniyor..',
	// text : 'İşleminiz gerçekleştiriliyor.',
	// showHideTransition : 'slide',
	// position : 'top-right',
	// allowToastClose : false,
	// hideAfter : 5000,
	// icon : 'info'
	// });
	$('#modalInsertNewDebt').addClass('loading');
	var options = {
		type : 'POST',
		//url : e.getAttribute('data-href'),
		dataType : 'json',
		success : function showSuccessResponse(response) {
			$('#modalInsertNewDebt').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				var infoButton = "<td class=\"details\"><button type=\"button\" class=\"btn btn-info btn-sm\"> <span class=\"glyphicon glyphicon-info-sign\"></span></button></td>"
				var serial = response.result.serial;
				var donem = response.result.donem;
				var parsel = response.result.parsel;
				var gelirCinsi = response.result.gelirCinsi;
				var aciklama = response.result.aciklama;
				var tahakkuk = response.result.tahakkuk;
				var odenen = response.result.odenen;
				var bakiye = response.result.bakiye;
				var durum = response.result.durum;
				var updateButton = "<td><button data-toggle='modal' data-target='#modalUpdateDebt' data-href=\""
						+ ctx
						+ "/admin/update/debt/"
						+ serial
						+ "\" "
						+ "data-serial='"
						+ serial
						+ "' "
						+ "data-donem='"
						+ donem
						+ "' "
						+ "data-parsel='"
						+ parsel
						+ "' "
						+ "data-gelir-cinsi='"
						+ gelirCinsi
						+ "' "
						+ "data-aciklama='"
						+ aciklama
						+ "' "
						+ "data-tahakkuk='"
						+ tahakkuk
						+ "' "
						+ "data-odenen='"
						+ odenen
						+ "' "
						+ "data-bakiye='"
						+ bakiye
						+ "' "
						+ "data-durum='"
						+ durum
						+ "' "
						+ "class='"
						+ "btn btn-primary buttonUpdateDebt' "
						+ ">"
						+ "<i class=\"fa fa-edit\"></i></button></td>";
				var deleteButton = "<td><button data-toggle='modal' data-target='#modalDelete' data-href=\""
						+ ctx
						+ "/admin/delete/debt/"
						+ serial
						+ "\" "
						+ "data-id='"
						+ serial
						+ "' "
						+ "data-object=\""
						+ serial
						+ " seri numaralı tahakkuk\" "
						+ "class='"
						+ "btn btn-danger buttonDeleteDebt' "
						+ ">"
						+ "<i class=\"fa fa-remove\"></i></button></td>";
				var data = [ infoButton, serial, donem, parsel, gelirCinsi,
						aciklama, tahakkuk, odenen, bakiye, durum,
						updateButton, deleteButton ];
				data = {
					"Bilgi" : infoButton,
					"Serial" : serial,
					"Dönem" : donem,
					"Parsel" : parsel,
					"Gelir Cinsi" : gelirCinsi,
					"Açıklama" : aciklama,
					"Tahakkuk" : tahakkuk,
					"Ödenen" : odenen,
					"Bakiye" : bakiye,
					"Durum" : durum,
					"Güncelle" : updateButton,
					"Sil" : deleteButton
				}
				data.id = serial;
				adminWorkspaceDatatable.row.add(data).draw();
				resizeTablesAdminWorkspace();
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
				window.location.replace("pm/user/userpanel");
			}
		},
		error : function showErrorResponse(response) {
			$('#modalInsertNewDebt').modal('hide').removeClass('loading');
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
	$('#formInsertNewDebt').ajaxSubmit(options);
}

function insertNewUser(e) {
	$('#modalInsertNewUser').addClass('loading');
	var options = {
		type : 'POST',
		dataType : 'json',
		success : function showSuccessResponse(response) {
			$('#modalInsertNewUser').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				$.toast({
					heading : 'Başarılı',
					text : 'Ekleme işlemi başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});
				var infoButton = "<td class=\"details\"><button type=\"button\" class=\"btn btn-info btn-sm\"> <span class=\"glyphicon glyphicon-info-sign\"></span></button></td>"
				var tc = $('#formInsertNewUser input[name=tc]').val();
				var name = $('#formInsertNewUser input[name=name]').val();
				var surname = $('#formInsertNewUser input[name=surname]').val();
				var email = $('#formInsertNewUser input[name=email]').val();
				var phoneNumber = $(
						'#formInsertNewUser input[name=phoneNumber]').val();
				var adminEmail = $('#formInsertNewUser input[name=adminEmail]')
						.val();
				var updateButton = "<td><button data-toggle='modal' data-target='#modalUpdateUser' data-href=\""
						+ ctx
						+ "/admin/update/user/"
						+ tc
						+ "\" "
						+ "data-tc='"
						+ tc
						+ "' "
						+ "data-name='"
						+ name
						+ "' "
						+ "data-surname='"
						+ surname
						+ "' "
						+ "data-email='"
						+ email
						+ "' "
						+ "data-phone-number='"
						+ phoneNumber
						+ "' "
						+ "class='"
						+ "btn btn-primary buttonUpdateUser' "
						+ ">"
						+ "<i class=\"fa fa-edit\"></i></button></td>";
				var deleteButton = "<td><button data-toggle='modal' data-target='#modalDelete' data-href=\""
						+ ctx
						+ "/admin/delete/user/"
						+ tc
						+ "\" "
						+ "data-id='"
						+ tc
						+ "' "
						+ "data-object=\"Tc'si "
						+ tc
						+ " olan kullanıcı\""
						+ "' "
						+ "class='"
						+ "btn btn-danger buttonDeleteUser' "
						+ ">"
						+ "<i class=\"fa fa-remove\"></i></button></td>"
				var seeButton = "<td><button data-href=\""
						+ ctx
						+ "/admin/workspace/"
						+ tc
						+ "\" "
						+ "data-tc=\""
						+ tc
						+ "\" "
						+ "class='"
						+ "btn btn-info toAdminWorkspace' "
						+ ">"
						+ "<span class=\"badge pull-right\"><span class=\"glyphicon glyphicon-arrow-right\"></span></span></button></td>"
				var data = [ infoButton, tc, name, surname, email, phoneNumber,
						adminEmail, updateButton, deleteButton, seeButton ];
				data = {
					"Bilgi" : infoButton,
					"Tc" : tc,
					"Adı" : name,
					"Soyadı" : surname,
					"Email" : email,
					"Telefon" : phoneNumber,
					"Admin Email" : adminEmail,
					"Güncelle" : updateButton,
					"Sil" : deleteButton,
					"Git" : seeButton
				}
				data.id = tc;
				adminDatatable.row.add(data).draw();
				resizeTablesAdmin();
				// setTimeout(function() {
				// window.location.replace("pm/user/userpanel")
				// }, 5000);
			} else if (response.status == "ERROR") {
				$.toast({
					heading : 'Başarısız',
					text : 'Bir sorun var! ' + response.result,
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'warning'
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("pm/user/userpanel");
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
	$('#formInsertNewUser').ajaxSubmit(options);
}

function updateDebt(e) {
	$('#modalUpdateDebt').addClass('loading');
	var options = {
		type : 'POST',
		dataType : 'json',
		success : function showSuccessResponse(response) {
			$('#modalUpdateDebt').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				$.toast({
					heading : 'Başarılı',
					text : 'Güncelleme işlemi Başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});

				var serial = $('#formUpdateDebt input[name=serial]').val();
				var donem = $('#formUpdateDebt input[name=donem]').val();
				var parsel = $('#formUpdateDebt input[name=parsel]').val();
				var gelirCinsi = $('#formUpdateDebt input[name=gelirCinsi]')
						.val();
				var aciklama = $('#formUpdateDebt input[name=aciklama]').val();
				var tahakkuk = $('#formUpdateDebt input[name=tahakkuk]').val();
				var odenen = $('#formUpdateDebt input[name=odenen]').val();
				var bakiye = tahakkuk - odenen;
				var durum = $('#modalFooterButtonUpdateDebt')
						.attr('data-durum');

				var updateButton = "<td><button data-toggle='modal' data-target='#modalUpdateDebt' data-href=\""
						+ ctx
						+ "/admin/update/debt/"
						+ serial
						+ "\" "
						+ "data-serial='"
						+ serial
						+ "' "
						+ "data-donem='"
						+ donem
						+ "' "
						+ "data-parsel='"
						+ parsel
						+ "' "
						+ "data-gelir-cinsi='"
						+ gelirCinsi
						+ "' "
						+ "data-aciklama='"
						+ aciklama
						+ "' "
						+ "data-tahakkuk='"
						+ tahakkuk
						+ "' "
						+ "data-odenen='"
						+ odenen
						+ "' "
						+ "data-bakiye='"
						+ bakiye
						+ "' "
						+ "data-durum='"
						+ durum
						+ "' "
						+ "class='"
						+ "btn btn-primary buttonUpdateDebt' "
						+ ">"
						+ "<i class=\"fa fa-edit\"></i></button></td>";

				var rowData = adminWorkspaceDatatable.row(
						document.getElementById(serial)).data();

				rowData["Dönem"] = donem;
				rowData["Parsel"] = parsel;
				rowData["Gelir Cinsi"] = gelirCinsi;
				rowData["Açıklama"] = aciklama;
				rowData["Tahakkuk"] = tahakkuk;
				rowData["Ödenen"] = odenen;
				rowData["Bakiye"] = bakiye;
				rowData["Güncelle"] = updateButton;

				adminWorkspaceDatatable.row(document.getElementById(serial))
						.data(rowData).draw();
			} else if (response.status == "ERROR") {
				$.toast({
					heading : 'Başarısız',
					text : 'Bir sorun var! ' + response.result,
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'warning'
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("pm/user/userpanel");
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
	$('#formUpdateDebt').ajaxSubmit(options);
}

function updateUser(e) {
	$('#modalUpdateUser').addClass('loading');
	var options = {
		type : 'POST',
		dataType : 'json',
		success : function showSuccessResponse(response) {
			$('#modalUpdateUser').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				$.toast({
					heading : 'Başarılı',
					text : 'Güncelleme işlemi Başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});
				// setTimeout(function() {
				// window.location.replace("pm/user/userpanel")
				// }, 5000);
				var tc = $('#formUpdateUser input[name=tc]').val();
				var name = $('#formUpdateUser input[name=name]').val();
				var surname = $('#formUpdateUser input[name=surname]').val();
				var email = $('#formUpdateUser input[name=email]').val();
				var phoneNumber = $('#formUpdateUser input[name=phoneNumber]')
						.val();

				var updateButton = "<td><button data-toggle='modal' data-target='#modalUpdateUser' data-href=\""
						+ ctx
						+ "/admin/update/user/"
						+ tc
						+ "\" "
						+ "data-tc='"
						+ tc
						+ "' "
						+ "data-name='"
						+ name
						+ "' "
						+ "data-surname='"
						+ surname
						+ "' "
						+ "data-email='"
						+ email
						+ "' "
						+ "data-phone-number='"
						+ phoneNumber
						+ "' "
						+ "class='"
						+ "btn btn-primary buttonUpdateUser' "
						+ ">"
						+ "<i class=\"fa fa-edit\"></i></button></td>";

				var rowData = adminDatatable.row(document.getElementById(tc))
						.data();

				rowData["Adı"] = name;
				rowData["Soyadı"] = surname;
				rowData["Email"] = email;
				rowData["Telefon"] = phoneNumber;
				rowData["Güncelle"] = updateButton;

				adminDatatable.row(document.getElementById(tc)).data(rowData)
						.draw();

			} else if (response.status == "ERROR") {
				$.toast({
					heading : 'Başarısız',
					text : 'Bir sorun var! ' + response.result,
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'warning'
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("pm/user/userpanel");
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
	$('#formUpdateUser').ajaxSubmit(options);
}

function upload() {
	$('#modalUpdoad').addClass('loading');
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var options = {
		type : 'POST',
		beforeSend : function(request) {
			request.setRequestHeader(header, token);
		},
		dataType : 'json',
		success : function showSuccessResponse(response) {
			$('#modalUpload').modal('hide').removeClass('loading');
			if (response.status == "SUCCESS") {
				$.toast({
					heading : 'Başarılı',
					text : 'Yükleme işlemi Başarılı.',
					showHideTransition : 'slide',
					position : 'top-right',
					icon : 'success'
				});
				setTimeout(function() {
					window.location.replace("pm/user/userpanel")
				}, 5000);
			} else if (response.status == "ERROR") {
				var errorInfo = "";
				for (i = 0; i < response.result.length; i++) {// "<span
					// class=\"label
					// label-danger\">"+
					// +
					// "</span></br>"
					errorInfo += response.result[i];
				}
				swal({
					title : "Başarısız",
					text : errorInfo,
					type : "error",
					width : 1250,
					confirmButtonColor : "#DD6B55",
					confirmButtonText : "Tamam!",
					closeOnConfirm : false
				}, function() {
					swal.close();
				});
			} else if (response.status == "REDIRECT") {
				window.location.replace("pm/user/userpanel");
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
	$('#formUpload').ajaxSubmit(options);
}