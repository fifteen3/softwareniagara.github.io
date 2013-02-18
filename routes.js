/**
 *  Custom routes for DocPad Server
 *  Loaded via require in the serverExtend event in docpad.coffee configuration file
 */
module.exports = function(server, docpad) {
  var config      = docpad.getConfig()
    , mongoose    = require('mongoose')
    , Contact     = require('./models/contact')
    , mandrill    = require('node-mandrill')(config.appData.mandrillKey);

  mongoose.connect(config.appData.database[process.env.NODE_ENV]);

  var oldUrls = config.templateData.site.oldUrls || []
    , newUrl  = config.templateData.site.url;

  // Plugin some middleware to redirect from old urls to new site url.
  
  server.use(function(req, res, next) {
  	if (oldUrls.indexOf(req.headers.host) >= 0) {
  		res.redirect(newUrl + req.url, 301);
  	} else {
  		next();
  	}
  });

  server.post('/contact', function(req, res, next) {
  	var contact = new Contact({
  		name: req.body.name,
  		email: req.body.email,
  		subject: req.body.subject,
  		message: req.body.message
  	});

  	contact.save(function(err) {
  		if (err) {
  			req.templateData = {
          messageType: "alert",
  				message: "Please enter a valid email address, subject and message."
  			};
  		} else {
  			req.templateData = {
          messageType: "success",
  				message: "Thank you for contacting us."
  			}
        mandrill('/messages/send', {
        message: {
            to: config.appData.emails.to,
            from_email: contact.email,
            from_name: contact.name,
            text: contact.message,
            html: contact.message,
            subject: contact.subject
          }
        }, function(err, res) {
          if (err) console.log(JSON.stringify(err));
          console.log(res);
        });
  		}
  		var document = docpad.getFile({relativePath: 'contact.html.eco'});
  		return docpad.serveDocument({document: document, req: req, res: res, next: next});
  	});
  });
};