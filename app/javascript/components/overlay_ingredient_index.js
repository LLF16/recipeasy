if (document.cookie.includes("overlay")) {
  document.getElementById("overlay").style.display = "none";
};

document.getElementById("overlay").addEventListener("click", () => {
  document.getElementById("overlay").style.display = "none";
  document.cookie = "overlay=seen";
});
