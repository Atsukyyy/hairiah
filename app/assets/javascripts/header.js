$(document).ready(function() {
  var state = false;
  var scrollpos;

  $(".hamburger-open-btn").on("click", ()=> {
    scrollpos = $(window).scrollTop();
      $('body').addClass('fixed').css({'top': -scrollpos});
      $(".hamburger-menu").slideToggle(150);
      $(".hamburger-close-btn").css("display", "inline-block");
      $(".hamburger-open-btn").css("display", "none")
      $(".header-fix").css("position", "fixed");
      state = true;
  });

  $(".hamburger-close-btn").on("click", ()=> {
    $('body').removeClass('fixed').css({'top': 0});
      window.scrollTo( 0 , scrollpos );
    $(".hamburger-menu").slideToggle(150);
    $(".hamburger-open-btn").css("display", "inline-block");
    $(".hamburger-close-btn").css("display", "none")
    $(".header-fix").css("position", "inherit");
    state = false;
  });
});
