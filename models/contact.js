var mongoose    = require('mongoose')
  , validate    = require('mongoose-validate')
  , timestamps  = require('./plugins/timestamps')
  , config      = require('./../config/secrets')
  , mandrill    = require('node-mandrill')(config['mandrill']['key']);

var ContactSchema = new mongoose.Schema({
  name: {
    type: String
  },
  email: {
    type: String,
    required: true,
    validate: [validate.email, 'Invalid email address']
  },
  subject: {
    type: String,
    required: true
  },
  message: {
    type: String,
    required: true
  }
});

ContactSchema.plugin(timestamps, {});

ContactSchema.post('save', function(doc) {
  mandrill('/messages/send', {
    message: {
      to: config['emails']['to'],
      from_email: doc.email,
      from_name: doc.name,
      text: doc.message,
      html: doc.message,
      subject: doc.subject
    }
  }, function(err, res) {
    if (err) console.log(JSON.stringify(error));
    console.log(res);
  });
});

module.exports = mongoose.model('Contact', ContactSchema);