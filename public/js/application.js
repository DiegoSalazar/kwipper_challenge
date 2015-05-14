$(function() {
  $("[data-confirm]").confirmPrompt();
});

//
// Plugins
//

$.fn.confirmPrompt = function() {
  return this.each(function() {
    var $this = $(this),
        question = $this.data("confirm");

    $this.click(function(e) {
      if (confirm(question)) {
        return true;
      } else {
        e.preventDefault();
        return false;
      }
    });
  });
}