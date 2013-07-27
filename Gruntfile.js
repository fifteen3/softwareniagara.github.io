module.exports = function(grunt) {
  grunt.initConfig({
     pkg: grunt.file.readJSON('package.json'),
     concat: {
         options: {
             separator: ';'
         },
         dist: {
            src: [
                'assets/js/_src/custom.modernizr.js',
                'assets/js/_src/jquery.js',
                'assets/js/_src/foundation.min.js',
                'assets/js/_src/parsley.min.js',
                'assets/js/_src/scrollit.patched.js',
                'assets/js/_src/main.js'
            ],
            dest: 'assets/js/_<%= pkg.name %>.js'
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