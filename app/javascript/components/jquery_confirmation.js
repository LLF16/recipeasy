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
  var recipe = $("#recipe-title").data('recipe');
  // const recipe = document.getElementById("recipe-title").dataset.recipe;
  // console.log(recipe);
  var button = $("#add-to-shopping-list")
    // console.log(button.data('saved'));
    button.confirm({
      columnClass: 'col-md-4 col-md-offset-4',
      // boxWidth: '30%',
      useBootstrap: false,
      title: 'Confirmation',
      content: `Success. You added ${recipe} to your shopping list.` ,
      theme: 'modern',
      autoClose: 'Enjoy|4000',
      buttons: {
          Enjoy: {
              text: '<a href="https://google.com" target="_blank">Enjoy</a>'
          },
        },
      type: 'green',
      onContentReady: function(){
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
                    $("#add-to-shopping-list").addClass('hidden');

                  }
                })
              }


      });

};


export { addToSl };

// -------------------------------------

function sendEmailSL () {
  // var recipe = $("#recipe-title").data('recipe');
  // const recipe = document.getElementById("recipe-title").dataset.recipe;
  // console.log(recipe);
  var button = $("#email-send")
  var shoppingList = $('.temp_information').data('shopping_list')
  var ingredients = $('.temp_information').data('ingredients')
  console.log(ingredients)
    // console.log(button.data('saved'));
    button.confirm({
      columnClass: 'col-md-8 col-md-offset-2',
      // boxWidth: '30%',
      useBootstrap: false,
      title: 'Shopping List',
      content: ingredients,
      theme: 'modern',
      // autoClose: 'Enjoy|4000',
      buttons: {
          send: {
              text: 'send',
              action: function(){
                fetch($("#email-send").data('path'), {
                  method: 'get',
                  body: JSON.stringify(),
                  headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': Rails.csrfToken()
                  },
                  credentials: 'same-origin'
                })
              }
          },
          cancel: {
              text: 'cancel'
          }
        },
      type: 'green',


      });

};


export { sendEmailSL };


function startCookingMode () {
  var btn = $("#cook-now")
    // console.log(button.data('saved'));
    btn.confirm({
      // columnClass: 'col-md-4 col-md-offset-4',
      // boxWidth: '30%',
      useBootstrap: false,
      icon: 'fa fa-spinner fa-spin',
      escapeKey: 'Ok',
      backgroundDismiss: true,
      title: 'Cooking Mode is launching...',
      content: `<div style="font-size: 14px;">Press <strong style="font-size: 20px;">ESC</strong> to launch cooking mode. <br><br>Press <br> <strong style="font-size: 30px;"> -> </strong> <br>to mark cooking step as finished.</div>` ,
      theme: 'supervan',
      buttons: {
          Ok: {
              text: 'Cook Now',
              action: function(){
                  window.scrollTo({
                    top: 800,
                    behavior: "smooth"
                  });
              }
          },
        },
      type: 'green'
    });
};


export { startCookingMode };

function finishCookingMode () {
  var finished = $("#finished-cooking")
    // console.log(button.data('saved'));
    $("#finished-cooking").confirm({
      // columnClass: 'col-md-4 col-md-offset-4',
      // boxWidth: '30%',
      useBootstrap: false,
      // icon: 'fa fa-spinner fa-spin',
      escapeKey: 'Ok',
      backgroundDismiss: true,
      title: 'Finished Cooking',
      content: 'Enjoy your meal.',
      theme: 'modern',
      buttons: {
          Ok: {
              text: 'Enjoy!',
              action: function(){
                  window.scrollTo({
                    top: 0,
                    behavior: "smooth"
                  });
              }
          },
        },
      type: 'green'
    });
};


export { finishCookingMode };
