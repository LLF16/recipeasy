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
    })


  };
  // return array
};

// fetch("/ingredients")
//   .then(response => response.json())
//   .then((data) => {
//     console.log(data);
//   });