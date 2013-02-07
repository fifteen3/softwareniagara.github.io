var geocoder = require('geocoder');

var coordinates = function(schema, options) {
  schema.add({
    coordinates: Array
  });

  schema.pre('save', function(next) {
    var self = this;

    return geocoder.geocode(this.fullAddress(), function(err, data) {
      if (data && data.results && data.results.length > 0) {
        var lat = data.results[0].geometry.location.lat 
          , lng = data.results[0].geometry.location.lng;

        self.coordinates = [lat, lng];
      }
      next();
    });
  });
};

module.exports = coordinates;