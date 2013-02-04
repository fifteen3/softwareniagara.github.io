var Contact = require('./../models/contact');

/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: 'Software Niagara', messages: req.flash(), user: req.user });
};

exports.contact = function(req, res) {
	var contact = new Contact({
		name: req.body.name,
		email: req.body.email,
		subject: req.body.subject,
		message: req.body.message
	});
	
	contact.save(function(err) {
		if (err) {
			req.flash('error', 'Please enter a valid email address, subject and message.');
		} else {
			req.flash('success', 'Thank you for contacting Software Niagara.');
		}
		return res.redirect(req.url);
	});
};