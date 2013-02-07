var mongoose    = require('mongoose')
  , timestamps  = require('./plugins/timestamps')
  , coordinates = require('./plugins/coordinates')
  , md2html     = require('node-markdown').Markdown;

var EventSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  organizer: {
    type: String,
    default: 'Software Niagara'
  },
  organizerUrl: {
    type: String,
    default: 'http://www.softwareniagara.com'
  },
  url: {
    type: String,
    required: true
  },
  fee: {
    type: Number,
    required: true,
    default: 0
  }
  venue: {
    type: String,
    required: true
  },
  address: {
    type: String,
    required: true
  },
  summary: {
    type: String,
    required: true
  }
});

EventSchema.fullAddress = function() {
  return this.address;
};

EventSchema.methods.formattedSummary = function() {
  return md2html(this.summary);
};

EventSchema.plugin(timestamps, {});
EventSchema.plugin(coordinates, {});

module.exports = mongoose.model('Event', EventSchema);