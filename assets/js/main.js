(function($) {
    $(document).foundation();

    $(document).ready(function() {
        $('[data-scroll]').smoothScroll({
            offset: -106,
            beforeScroll: function() {
                $('.dropdown').removeClass('open').removeAttr('style');
            }
        });
    });
})($);