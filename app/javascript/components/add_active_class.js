function addActiveClassNav () {
  const nav_link1 = document.querySelector(".navbar-food-link_1")
  const nav_link2 = document.querySelector(".navbar-food-link_2")
  const nav_link3 = document.querySelector(".navbar-wagon-link")
    nav_link1.addEventListener("click", (event) => {
      nav_link1.classList.toggle("active-nav")
    });
};

export { addActiveClassNav };
