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
  console.log("hello from shuffle");
  let array = [];
  let ingredients = document.querySelectorAll('input.form-control');
  let locked_ingredients = ingredients.forEach((item) => {
    console.log(item);
    if(item.disabled) {
      array.push(item.defaultValue);
    } else {
      array.push("empty");
    };
    console.log(array)
  });
});



document.body.onkeyup = function(e){
  let array = [];
  if(e.keyCode == 32){
    let ingredients = document.querySelectorAll('input.form-control');
    let locked_ingredients = ingredients.forEach((item) => {
      if(item.disabled) {
        array.push(item.defaultValue);
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
      console.log("result", data);
      console.log(data.first.name);
      document.querySelector('.first-text-tag').value = data.first.name;
      document.querySelector('.second-text-tag').value = data.second.name;
      document.querySelector('.third-text-tag').value = data.third.name;
      document.querySelector('.fourth-text-tag').value = data.fourth.name;
    })


  };
  // return array
};

// fetch("/ingredients")
//   .then(response => response.json())
//   .then((data) => {
//     console.log(data);
//   });
