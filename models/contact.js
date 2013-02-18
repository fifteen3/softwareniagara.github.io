var mongoose    = require('mongoose')
  , validate    = require('mongoose-validate')
  , timestamps  = require('./plugins/timestamps');

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

module.exports = mongoose.model('Contact', ContactSchema);