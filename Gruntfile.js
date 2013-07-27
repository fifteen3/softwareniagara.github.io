module.exports = function(grunt) {
  grunt.initConfig({
     pkg: grunt.file.readJSON('package.json'),
     concat: {
         options: {
             separator: ';'
         },
         dist: {
            src: [
                'assets/js/src/custom.modernizr.js',
                'assets/js/src/jquery.js',
                'assets/js/src/foundation.min.js',
                'assets/js/src/parsley.min.js',
                'assets/js/src/scrollit.patched.js',
                'assets/js/src/main.js'
            ],
            dest: 'assets/js/<%= pkg.name %>.js'
         }
     },
     uglify: {
         options: {
             banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
         },
         dist: {
             files: {
                 'assets/js/<%= pkg.name %>.min.js': ['<%= concat.dist.dest %>']
             }
         }
     }
  });

  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-concat');

  grunt.registerTask('default', ['concat', 'uglify']);
};