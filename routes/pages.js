var path   = require('path')
  , fs     = require('fs')
  , th     = require('./../lib/template_helper')
  , dir    = __dirname + './../views/pages'
  , ext    = '.jade';

/**
 * This router has one function that takes a page name as a parameter.
 * It will check that a file exists in the /views/pages directory with
 * the same name. If it does, it will extract the page title and meta
 * data from the file and then render it. If the file does not exist, 
 * it will allow the middleware to continue to handle the request.
 */

exports.page = function(req, res, next) {
  fileName = req.params.page || 'index';

  var fileName = fileName + ext 
    , file = path.join(dir, fileName);

  fs.lstat(file, function(err, stats) {
    if (err || stats.isDirectory()) return next(); // Trigger 404 not found.
    
    fs.readFile(file, function(err, data) {
      if (err) return next(err); // Trigger 500 application error.
      data = th.readComments(data);
      data.messages = req.flash();
      data.user = req.user;
      res.render(file, data);
    });
  });
};

