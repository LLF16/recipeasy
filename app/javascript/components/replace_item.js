const lockedLock1 = document.createElement("p");
lockedLock1.textContent = "🔒";

const unlockedLock1 = document.querySelector("#ingredients-index-unlocked-lock-1");
unlockedLock1.addEventListener("click", (event) => {
  const lockField1 = document.querySelector("#ingredients-index-lock-1");
  lockField1.replaceChild(lockedLock1, unlockedLock1);
  lockField1.style.opacity = 1;
});

const lockedLock2 = document.createElement("p");
lockedLock2.textContent = "🔒";

const unlockedLock2 = document.querySelector("#ingredients-index-unlocked-lock-2");
unlockedLock2.addEventListener("click", (event) => {
  const lockField2 = document.querySelector("#ingredients-index-lock-2");
  lockField2.replaceChild(lockedLock2, unlockedLock2);
  lockField2.style.opacity = 1;
});

const lockedLock3 = document.createElement("p");
lockedLock3.textContent = "🔒";

const unlockedLock3 = document.querySelector("#ingredients-index-unlocked-lock-3");
unlockedLock3.addEventListener("click", (event) => {
  const lockField3 = document.querySelector("#ingredients-index-lock-3");
  lockField3.replaceChild(lockedLock3, unlockedLock3);
  lockField3.style.opacity = 1;
});

const lockedLock4 = document.createElement("p");
lockedLock4.textContent = "🔒";

const unlockedLock4 = document.querySelector("#ingredients-index-unlocked-lock-4");
unlockedLock4.addEventListener("click", (event) => {
  const lockField4 = document.querySelector("#ingredients-index-lock-4");
  lockField4.replaceChild(lockedLock4, unlockedLock4);
  lockField4.style.opacity = 1;
});
