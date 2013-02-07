var contributors = require('./../config/secrets')['contributors'];

module.exports = {
	authorize: function(req) {
		if (req.isAuthenticated()) {
			var nid = req.user.network + '_' + req.user.uid;
			return (contributors.indexOf(nid) >= 0);
		}
		return false;
	}
};