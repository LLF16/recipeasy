const unlockedLock1 = document.querySelector("#ingredients-index-1 .fas");
unlockedLock1.addEventListener("click", (event) => {
  const text_field = document.querySelector("#ingredient_1");
  if (unlockedLock1.dataset.locked === 'false') {
    unlockedLock1.dataset.locked = 'true';
    unlockedLock1.classList.add("fa-lock");
    unlockedLock1.classList.remove("fa-lock-open");
    text_field.setAttribute("disabled", "true");
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

document.body.onkeyup = function(e){
    if(e.keyCode == 32){
        console.log("hello from the spacebar")
    }
}
