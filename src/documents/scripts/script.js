;(function($, window, undefined) {
  'use strict';

  var $doc      = $(document)
    , Modernizr = window.Modernizr;

  $doc.ready(function() {
    $doc.foundation();

    $('#header-menu').waypoint(function(direction) {
       if (direction === 'down') {
         $('#toolbar-menu li').each(function() {
           var $this = $(this);
           if ($this.hasClass('toggle-visibility')) {
             $this.removeClass('show-for-small');
           }
         });
       } else {
         $('#toolbar-menu li').each(function() {
           var $this = $(this);
           if ($this.hasClass('toggle-visibility')) {
             $this.addClass('show-for-small');
           }
         });
       }
    }, {
      offset: -30
    });

    // Hide address bar on mobile devices (except if #hash present, so we don't mess up deep linking).
    if (Modernizr.touch && !window.location.hash) {
      $(window).load(function () {
        setTimeout(function () {
          window.scrollTo(0, 1);
        }, 0);
      });
    }
  });
})($, this);




