module.exports = function(grunt) {
  var gruntConfig = require('./grunt-config.json');

  grunt.loadNpmTasks('grunt-css');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-cssmin');

  grunt.initConfig(gruntConfig);

  grunt.registerTask('default', ['concat', 'cssmin', 'uglify']);
}