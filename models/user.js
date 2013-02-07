 var mongoose   = require('mongoose')
   , timestamps = require('./plugins/timestamps');

var UserSchema = new mongoose.Schema({
   uid: {
      type: String 
   },
   name: {
      type: String
   },
   network: {
      type: String
   },
   profile: {}
});

UserSchema.plugin(timestamps);

module.exports = mongoose.model('User', UserSchema);