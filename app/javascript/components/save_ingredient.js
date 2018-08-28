// document.body.onkeyup = function(e){
//   let array = [];
//   if(e.keyCode == 32){
//     let locked = document.querySelectorAll('input:disabled');
//     let locked_ingredients = locked.forEach((item) => {
//       array.push(item.defaultValue);
//     });
//   };
//   console.log(array)
//   return array
// };

// document.body.onkeyup = function(e){
//   let array = [];
//   if(e.keyCode == 32){
//     let ingredients = document.querySelectorAll('input.form-control');
//     let locked_ingredients = ingredients.forEach((item) => {
//       if(item.disabled) {
//         array.push(item.defaultValue);
//       } else {
//         array.push("");
//       };
//     });
//   };
//   console.log(array)
//   let url =
//   fetch("/ingredients")
//   return array
// };


let shuffleButton = document.querySelector(".ingredients-shuffle-button");
shuffleButton.addEventListener("click", (event) => {
  let array = [];
  // let first_ingredient = document.querySelectorAll('.form-control')[0].value
  let ingredients = document.querySelectorAll('.form-control');
  console.log(ingredients)
  let ingredientNames = document.querySelectorAll('.slot-ingredient-name');
  let locked_ingredients = ingredients.forEach((item) => {
    if(item.disabled) {
      array.push(item.value);
    } else {
      array.push("empty");
    };
  });
  console.log(array)
  let url = `search/ingredients?first=${array[0]}&second=${array[1]}&third=${array[2]}&fourth=${array[3]}`;
  console.log(url);
  fetch(url)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      let data_array = [];
      let backgrounds = document.querySelectorAll('.ingredients-index-bar');
      data_array.push(data.first);
      data_array.push(data.second);
      data_array.push(data.third);
      data_array.push(data.fourth);

      let counter = 0;
      ingredientNames.forEach((item) => {
        item.innerText = data_array[counter].name;
        counter ++;
      });

      // old logic that changes the value inside the text input. Need to keep it
      // cause the locking mechanism still works on the input field (that are just hidden)
      let counter_1 = 0;
      ingredients.forEach((item) => {
        item.value = data_array[counter_1].name;
        counter_1 ++;
      });



      let second_counter = 0;
      backgrounds.forEach((item) => {
        console.log(second_counter);
        // item.style.backgroundImage = `"url('${data_array[second_counter].photo.url}')"`;
        item.style.backgroundImage = 'url(' + data_array[second_counter].photo.url + ')';

        console.log(item.style.backgroundImage);
        second_counter ++;
      });
    });
});


document.body.onkeyup = function(e){
  let array = [];
  if(e.keyCode == 32){
    let ingredients = document.querySelectorAll('.form-control');
    let locked_ingredients = ingredients.forEach((item) => {
      // console.log(item)
      // console.log(item.defaultValue)
      if(item.disabled) {
        array.push(item.value);
      } else {
        array.push("empty");
      };
    });

  console.log(array)
  let url = `search/ingredients?first=${array[0]}&second=${array[1]}&third=${array[2]}&fourth=${array[3]}`
  console.log(url);
  fetch(url)
    .then(response => response.json())
    .then((data) => {
      let data_array = [];
      let ingredientNames = document.querySelectorAll('.slot-ingredient-name');
      let backgrounds = document.querySelectorAll('.ingredients-index-bar');
      console.log(data);
      data_array.push(data.first);
      data_array.push(data.second);
      data_array.push(data.third);
      data_array.push(data.fourth);

      let counter = 0;
      ingredientNames.forEach((item) => {
        item.innerText = data_array[counter].name;
        counter ++;
      });

      // old logic that changes the value inside the text input. Need to keep it
      // cause the locking mechanism still works on the input field (that are just hidden)
      let counter_1 = 0;
      ingredients.forEach((item) => {
        item.value = data_array[counter_1].name;
        counter_1 ++;
      });



      let second_counter = 0;
      backgrounds.forEach((item) => {
      console.log(second_counter);
        // item.style.backgroundImage = `"url('${data_array[second_counter].photo.url}')"`;
        item.style.backgroundImage = 'url(' + data_array[second_counter].photo.url + ')';

        console.log(item.style.backgroundImage);
        second_counter ++;
      });
    });


  };
  // return array
};

// fetch("/ingredients")
//   .then(response => response.json())
//   .then((data) => {
//     console.log(data);
//   });


// document.querySelector('#index-bar-first').style.backgroundImage =  "url('https://res.cloudinary.com/decmti7fk/image/upload/v1535201319/Recipeasy/ricotta.jpg')"
