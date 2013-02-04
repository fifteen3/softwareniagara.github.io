/**
 * Dependencies
 */
var express   = require('express')
  , passport  = require('passport')
  , http      = require('http')
  , path      = require('path')
  , flash     = require('connect-flash')
  , mongoose  = require('mongoose')
  , stylus    = require('stylus')
  , nib       = require('nib')
  , GitHubStrategy = require('passport-github').Strategy;

/**
 * Routes
 */
var routes    = require('./routes/routes')
  , pages     = require('./routes/pages');

/**
 * Config
 */
var settings  = require('./config/application')
  , secrets   = require('./config/secrets')
  , db        = require('./config/database');

/**
 * Helpers
 */
var mh        = require('./lib/menu_helper')
  , ah        = require('./lib/auth_helper');

/**
 * Models
 */
var User      = require('./models/user');

var app = express();

/**
 * Establish database connection
 */
mongoose.connect(db[app.settings.env]);

/**
 * Local variables
 */
app.set('about', settings.about);
app.set('domain', settings.domain);
app.set('name', settings.name);
app.set('networks', settings.networks);
app.set('organizers', settings.organizers);
app.set('events', settings.events);
app.set('description', settings.description);
app.set('keywords', settings.keywords);
app.set('menu', mh.generate('./views/pages'));
app.set('getTitle', function(title) {
  if (title) return title + ' | ' + app.settings.name;
  return app.settings.name;
});

/**
 * Authentication helper functions
 */
passport.serializeUser(function(user, done) {
  done(null, user.id);
});

passport.deserializeUser(function(id, done) {
  User.findById(id, function(err, user) {
    done(err, user);
  });
});

passport.use(new GitHubStrategy({
  clientID: secrets['providers']['github']['id'],
  clientSecret: secrets['providers']['github']['secret'],
  callbackURL: app.settings.env === 'production' ? 'http://' + settings.domain + '/auth/github/callback' : 'http://127.0.0.1:3000/auth/github/callback'
}, function(accessToken, refreshToken, profile, done) {
  User.find({uid: profile.id, network: 'github'}, function(err, users) {
    if (err) throw err;

    if (users.length > 0) {
      return done(err, users[0]);
    } else {
      var user = new User();
      user.network = 'github';
      user.uid = profile.id;
      user.name = profile.first_name || profile.name;
      user.profile = profile;
      user.save(function(err) {
        if (err) throw err;
        return done(err, user);
      });
    }
  });
}));


/**
 * Stylus Middleware
 */
function stylusCompiler(str, path) {
  return stylus(str).set('filename', path).set('compress', true).use(nib()).import('nib');
}

/**
 * Error Middleware
 */

function errorHandler(err, req, res, next) {
  res.status(500);

  if (req.accepts('html')) {
    res.render('500', {title: '500 Application Error', error: err, user: req.user});
    return;
  }

  if (req.accepts('json')) {
    res.send({error: 'Application error'});
  }

  res.type('txt').send('Application error');
}

function notFoundHandler(req, res, next) {
  res.status(400);

  if (req.accepts('html')) {
    res.render('404', {title: '404 Not Found', error: req.uri + ' was not found on the server.', user: req.user});
    return;
  }

  if (req.accepts('json')) {
    res.send({error: 'Not found'});
  }

  res.type('txt').send('Not found');
}

/**
 * Authentication Middleware
 */
function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated() && ah.authorize(req)) { return next(); }
  req.flash('error', 'Access denied. You are not authorized to access that resource.');
  res.redirect('/')
}

/**
 * Middleware
 */
app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser(secrets['cookies']['key']));
  app.use(express.session());
  app.use(flash());
  app.use(passport.initialize());
  app.use(passport.session());
  app.use(app.router);
  app.use(stylus.middleware({
    src: __dirname + '/public',
    compile: stylusCompiler
  }));
  app.use(express.static(path.join(__dirname, 'public')));
  app.use(notFoundHandler);
  app.use(errorHandler);
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

/** 
 * Routes
 */
require('./routes/auth')(app, passport);
app.post('/contact', routes.contact);
app.get('/', pages.page);
app.get('/:page', pages.page);

/*
app.get('/account', ensureAuthenticated, function(req, res){
  res.render('account', { user: req.user });
});
*/

/**
 * Server
 */
var port = process.env.PORT || 5000;
http.createServer(app).listen(port, function(){
  console.log("Express server listening on port " + port);
});