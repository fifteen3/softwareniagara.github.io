(function($) {
	var enhanceEventNav = function() {
		$('.event-listing').each(function() {
			var self = $(this) 
				, height = self.parent().height();

			self.css({height: height + 'px'});
		});
	};

	$(window).load(function() {
		enhanceEventNav();
	});

	$(window).resize(function() {
		enhanceEventNav();
	});
})(jQuery);