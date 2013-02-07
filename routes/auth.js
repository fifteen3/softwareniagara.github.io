var ah  = require('./../lib/auth_helper');

module.exports = function(app, passport) {
	/**
	 * Route middleware for authentication.
	 */
	app.get('/auth/github', passport.authenticate('github'));

	app.get('/auth/github/callback', 
	  passport.authenticate('github', {failureRedirect: '/auth/github/handshake', successRedirect: '/auth/github/handshake'}));

	app.get('/auth/github/handshake', function(req, res) {
	  var authorized = ah.authorize(req);

	  if (authorized === true) {
	    req.flash('success', 'Successfully logged in. You have administrative access.');
	  } else {
	    req.flash('error', 'Access denied. Your GitHub account is not authorized.');
	  }

	  return res.redirect('/');
	});

	app.get('/logout', function(req, res) {
	  req.logout();
	  req.flash('info', 'You are logged out.');
	  res.redirect('/');
	});
};