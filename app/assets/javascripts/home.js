document.addEventListener("turbolinks:load", function() {
  var TargetClassName = "first-view-text";
  // 表示の速さ
  var DisplaySpeedMiliSec = 200;
  // カーソルアイコン
  var CursorIcon = "|";

  window.onload = displayLikeTypeWriter;

  function displayLikeTypeWriter() {
    var counter = 0;
    var elements = document.getElementsByClassName(TargetClassName);
    for(var i = 0; i < elements.length; i++) {
      var element = elements[i];
      element.style.visibility = "visible";
      display(element, element.innerHTML, counter);
    }
  }

  function display(element, message, counter) {
    element.innerHTML = message.substring(0, counter) + CursorIcon;
    counter++;
    setTimeout(function() {
      display(element, message, counter);
    }, DisplaySpeedMiliSec);
    if (counter > message.length) {
      // 最後はカーソルアイコン表示を上書きする
      element.innerHTML = message;
    }
  }
});
