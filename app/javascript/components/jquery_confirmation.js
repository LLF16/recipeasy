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

