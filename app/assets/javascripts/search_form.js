document.addEventListener("turbolinks:load", function() {

  var state = false;
  var scrollpos;

  $(".search-hamburger-open-btn").on("click", ()=> {
    scrollpos = $(window).scrollTop();
      $('body').addClass('fixed').css({'top': -scrollpos});
      $(".find-users").slideToggle(150);
      $(".search-hamburger-close-btn").css("display", "inherit");
      $(".search-hamburger-open-btn").css("display", "none");
      // $(".header-fix").css("position", "fixed");
      state = true;
  });

  $(".search-hamburger-close-btn").on("click", ()=> {
    $('body').removeClass('fixed').css({'top': 0});
      window.scrollTo( 0 , scrollpos );
    $(".find-users").slideToggle(150);
    $(".search-hamburger-open-btn").css("display", "inherit");
    $(".search-hamburger-close-btn").css("display", "none");
    // $(".header-fix").css("position", "inherit");
    state = false;
  });
});
