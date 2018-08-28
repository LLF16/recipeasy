

document.querySelectorAll('input.form-control')[0].addEventListener("change", (event) => {
// if (document.querySelectorAll('input.form-control')[0].value !== "") {

  const unlockedLock1 = document.querySelector("#ingredients-index-1 .fas");
  unlockedLock1.addEventListener("click", (event) => {
    const text_field = document.querySelector("#ingredient_1");



  if (unlockedLock1.dataset.locked === 'false') {
    unlockedLock1.dataset.locked = 'true';
    unlockedLock1.classList.add("fa-lock");
    unlockedLock1.classList.remove("fa-lock-open");
    text_field.setAttribute("disabled", "true");


// here below is the shuffle function

    let array = [];
    let ingredients = document.querySelectorAll('input.form-control');
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



// end of the shuffle function


  } else {
    unlockedLock1.dataset.locked = 'false';
    unlockedLock1.classList.remove("fa-lock");
    unlockedLock1.classList.add("fa-lock-open");
    text_field.removeAttribute("disabled");
  }
});

const unlockedLock2 = document.querySelector("#ingredients-index-2 .fas");
unlockedLock2.addEventListener("click", (event) => {
  const text_field = document.querySelector("#ingredient_2");
  if (unlockedLock2.dataset.locked === 'false') {
    unlockedLock2.dataset.locked = 'true';
    unlockedLock2.classList.add("fa-lock");
    unlockedLock2.classList.remove("fa-lock-open");
    text_field.setAttribute("disabled", "true");
  } else {
    unlockedLock2.dataset.locked = 'false';
    unlockedLock2.classList.remove("fa-lock");
    unlockedLock2.classList.add("fa-lock-open");
    text_field.removeAttribute("disabled");
  }
});

const unlockedLock3 = document.querySelector("#ingredients-index-3 .fas");
unlockedLock3.addEventListener("click", (event) => {
  const text_field = document.querySelector("#ingredient_3");
  if (unlockedLock3.dataset.locked === 'false') {
    unlockedLock3.dataset.locked = 'true';
    unlockedLock3.classList.add("fa-lock");
    unlockedLock3.classList.remove("fa-lock-open");
    text_field.setAttribute("disabled", "true");
  } else {
    unlockedLock3.dataset.locked = 'false';
    unlockedLock3.classList.remove("fa-lock");
    unlockedLock3.classList.add("fa-lock-open");
    text_field.removeAttribute("disabled");
  }
});

const unlockedLock4 = document.querySelector("#ingredients-index-4 .fas");
unlockedLock4.addEventListener("click", (event) => {
  const text_field = document.querySelector("#ingredient_4");
  if (unlockedLock4.dataset.locked === 'false') {
    unlockedLock4.dataset.locked = 'true';
    unlockedLock4.classList.add("fa-lock");
    unlockedLock4.classList.remove("fa-lock-open");
    text_field.setAttribute("disabled", "true");
  } else {
    unlockedLock4.dataset.locked = 'false';
    unlockedLock4.classList.remove("fa-lock");
    unlockedLock4.classList.add("fa-lock-open");
    text_field.removeAttribute("disabled");
  }
});

});




