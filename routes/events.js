exports.index = function(req, res, next) {

};

exports.show = function(req, res, next) {

};

exports.new = function(req, res, next) {

};

exports.create = function(req, res, next) {
	var event = new Event({
		name: req.body.name,
		organizer: req.body.organizer,
		organizerUrl: req.body.organizerUrl,
		url: req.body.url,
		fee: req.body.fee,
		venue: req.body.venue,
		address: req.body.address,
		summary: req.body.summary
	});

	event.save(function(err) {
		if (err) {
			req.flash('error', 'There are errors with your event. Please correct them.');
		} else {
			req.flash('success', 'Your event was created.');
		}
		return res.redirect('/events');
	});
};

exports.edit = function(req, res, next) {

};

exports.update = function(req, res, next) {

};

exports.destroy = function(req, res, next) {

};