import "jquery-confirm"

function amazingConfirmation () {

$("#test-id").confirm({
    columnClass: 'col-md-4 col-md-offset-4',
    // boxWidth: '30%',
    useBootstrap: false,
    title: 'What is up?',
    content: 'Here goes a little content',
    type: 'green',
    buttons: {
        ok: {
            text: "ok!",
            btnClass: 'btn-primary',
            keys: ['enter'],
            action: function(){
                 console.log('the user clicked confirm');
            }
        },
        cancel: {
            text: "dude",
            method: "post",
            btnClass: 'btn-danger',
            keys: [ 'esc'],
            action: function(){
                console.log('the user clicked cancel');
        }
      }
    }
});
};

export { amazingConfirmation };

function addToSl () {

$("#add-to-shopping-list").confirm({
    columnClass: 'col-md-4 col-md-offset-4',
    // boxWidth: '30%',
    useBootstrap: false,
    title: 'What is up?',
    content: 'Here goes a little content',
    theme: 'modern',
    type: 'green',
    buttons: {
        ok: {
            text: "ok!",
            btnClass: 'btn-primary',
            keys: ['enter'],
            action: function(){
              // post request
              // measurement
              fetch($("#add-to-shopping-list").data('path'), {
                method: 'post',
                body: JSON.stringify(),
                headers: {
                  'Content-Type': 'application/json',
                  'X-CSRF-Token': Rails.csrfToken()
                },
                credentials: 'same-origin'
              }).then(function(response) {
                if (response.ok) {
                  var amount =  $("#shopping-list-amount").data('amount');
                  amount++
                  $("#shopping-list-amount").text(`Shopping list (${amount})`);

                }
              })
            }
        },
        cancel: {
            text: "dude",
            method: "post",
            btnClass: 'btn-danger',
            keys: [ 'esc'],
            action: function(){
              // do nothing
        }
      }
    }
});
};

export { addToSl };


