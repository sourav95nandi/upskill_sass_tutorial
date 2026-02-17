/* global Stripe */
$(document).on('turbo:load', function() {
    var theForm = $('#pro_form');
    var submitBtn = $('#pro_submit');

    // Set Stripe public key
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

    submitBtn.on('click', function(event) {
        event.preventDefault();
        submitBtn.val('Processing...').prop('disabled', true);

        var ccNum = $('#card_number').val(),
            cvcNum = $('#card_cvc').val(),
            expMonth = $('#exp_month').val(),
            expYear = $('#exp_year').val();
        var error=false;


        if(!Stripe.card.validateCardNumber(ccNum)) {
            error=true;
            alert('The credit card number appears to be invalid.');
        }
        if(!Stripe.card.validateCVC(cvcNum)) {
            error=true;
            alert('The CVC number appears to be invalid.');
        }
        if(!Stripe.card.validateExpiry(expMonth, expYear)) {
            error=true;
            alert('The expiration date appears to be invalid.');
        }
        if(error) {
            submitBtn.val('Sign Up').prop('disabled', false);
            return false;
        }
        else{
        
            Stripe.card.createToken({
                number: ccNum,
                cvc: cvcNum,
                exp_month: expMonth,
                exp_year: expYear
            }, stripeResponseHandler);
        }
        return false;
    });
    function stripeResponseHandler(status, response) {
        if (response.error) {
            alert(response.error.message);
            submitBtn.val('Sign Up').prop('disabled', false);
        } else {
            var token = response.id;
            theForm.append($('<input type="hidden" name="stripe_card_token" />').val(token));
            theForm.get(0).submit();
        }
    }
});