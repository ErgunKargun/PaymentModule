var $form = $('#payment-form');
$form.find('.subscribe').on('click', payWithStripe);

/* If you're using Stripe for payments */
function payWithStripe(e) {
    e.preventDefault();
    
    /* Abort if invalid form data */
    if (!validator.form()) {
        return;
    }

    /* Visual feedback */
    $form.find('.subscribe').html('Değerlendiriliyor <i class="fa fa-spinner fa-pulse"></i>').prop('disabled', true);

    var PublishableKey = 'pk_test_M1owfmoZFJCeFATT3NxUHDbd';
    Stripe.setPublishableKey(PublishableKey);
    
    /* Create token */
    var expiry = $form.find('[name=cardExpiry]').payment('cardExpiryVal');
    var ccData = {
        number: $form.find('[name=cardNumber]').val().replace(/\s/g,''),
        cvc: $form.find('[name=cardCVC]').val(),
        exp_month: expiry.month, 
        exp_year: expiry.year
    };
    
    Stripe.card.createToken(ccData, function stripeResponseHandler(status, response) {
        if (response.error) {
            /* Visual feedback */
            $form.find('.subscribe').html('Tekrar dene.').prop('disabled', false);
            /* Show Stripe errors on the form */
            $form.find('.payment-errors').text(response.error.message);
            $form.find('.payment-errors').closest('.row').show();
        } else {
            /* Visual feedback */
            $form.find('.subscribe').html('İşleniyor <i class="fa fa-spinner fa-pulse"></i>');
            /* Hide Stripe errors on the form */
            $form.find('.payment-errors').closest('.row').hide();
            $form.find('.payment-errors').text("");
            // response contains id and card, which contains additional card details            
            console.log(response.id);
            console.log(response.card);
            var token = response.id;
            var tokenForCSRF = $("meta[name='_csrf']").attr("content");
        	var headerForCSRF = $("meta[name='_csrf_header']").attr("content");
        	var jsonData = { json : JSON.stringify({ "token" : token, "serials" : serialParam }) };
            // AJAX - you would send 'token' to your server here.
        	$.ajax({
        		type : "POST",
        		beforeSend : function(request) {
        			request.setRequestHeader(headerForCSRF, tokenForCSRF);
        		},
        		cache : false,
        		data : jsonData,
        		url : urlPayment,
        		dataType : 'json',
        		success : function(response) {
        			$('#modalDelete').modal('hide').removeClass('loading');
        			if (response.status == "SUCCESS") {
        				$.toast({
        					heading : 'Başarılı',
        					text : 'Ödeme işlemi başarılı.',
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
        	})
//            $.post(urlPayment, {
//                    token: token,
//                    serials: serialParam
//                })
                // Assign handlers immediately after making the request,
                .done(function(data, textStatus, jqXHR) {
                    $form.find('.subscribe').html('Ödeme Başarılı <i class="fa fa-check"></i>');
                    swal({
    					title : "Başarılı",
    					text : "Faturanız mail adresinize gönderilmiştir. Lütfen kontrol ediniz.",
    					type : "info",
    					confirmButtonColor : "#DD6B55",
    					confirmButtonText : "Tamam!",
    					closeOnConfirm : false
    				}, function() {
    					swal.close();
    				});
                })
                .fail(function(jqXHR, textStatus, errorThrown) {
                    $form.find('.subscribe').html('Bir sorun çıktı!').removeClass('success').addClass('error');
                    /* Show Stripe errors on the form */
                    $form.find('.payment-errors').text('Sayfayı yenile ve yeniden dene.');
                    $form.find('.payment-errors').closest('.row').show();
                });
        }
    });
}
/* Fancy restrictive input formatting via jQuery.payment library*/
$('input[name=cardNumber]').payment('formatCardNumber');
$('input[name=cardCVC]').payment('formatCardCVC');
$('input[name=cardExpiry').payment('formatCardExpiry');

/* Form validation using Stripe client-side validation helpers */
jQuery.validator.addMethod("cardNumber", function(value, element) {
    return this.optional(element) || Stripe.card.validateCardNumber(value);
}, "Lütfen geçerli bir kart numarası giriniz.");

jQuery.validator.addMethod("cardExpiry", function(value, element) {    
    /* Parsing month/year uses jQuery.payment library */
    value = $.payment.cardExpiryVal(value);
    return this.optional(element) || Stripe.card.validateExpiry(value.month, value.year);
}, "Geçersiz sona erme tarihi.");

jQuery.validator.addMethod("cardCVC", function(value, element) {
    return this.optional(element) || Stripe.card.validateCVC(value);
}, "Geçersiz CVC.");

validator = $form.validate({
    rules: {
        cardNumber: {
            required: true,
            cardNumber: true            
        },
        cardExpiry: {
            required: true,
            cardExpiry: true
        },
        cardCVC: {
            required: true,
            cardCVC: true
        }
    },
    highlight: function(element) {
        $(element).closest('.form-control').removeClass('success').addClass('error');
    },
    unhighlight: function(element) {
        $(element).closest('.form-control').removeClass('error').addClass('success');
    },
    errorPlacement: function(error, element) {
        $(element).closest('.form-group').append(error);
    }
});

paymentFormReady = function() {
    if ($form.find('[name=cardNumber]').hasClass("success") &&
        $form.find('[name=cardExpiry]').hasClass("success") &&
        $form.find('[name=cardCVC]').val().length > 1) {
        return true;
    } else {
        return false;
    }
}

$form.find('.subscribe').prop('disabled', true);
var readyInterval = setInterval(function() {
    if (paymentFormReady()) {
        $form.find('.subscribe').prop('disabled', false);
        clearInterval(readyInterval);
    }
}, 250);