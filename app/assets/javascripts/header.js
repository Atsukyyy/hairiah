$(document).ready(function() {
  $(".hamburger-open-btn").on("click", ()=> {
      $(".hamburger-menu").slideToggle(500);
      $(".hamburger-close-btn").css("display", "inline-block");
      $(".hamburger-open-btn").css("display", "none")
  });

  $(".hamburger-close-btn").on("click", ()=> {
    $(".hamburger-menu").slideToggle(500);
    $(".hamburger-open-btn").css("display", "inline-block");
    $(".hamburger-close-btn").css("display", "none")
  });
});
