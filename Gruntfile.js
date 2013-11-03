module.exports = function (grunt) {
  grunt.initConfig({
    concat: {
      js: {
        src: [
          'bower_components/jquery/jquery.js',
          'app/assets/javascripts/**/*.js',
        ],
        dest: 'public/javascripts/app.js'
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-concat');

  grunt.registerTask('js', [
    'concat:js',
  ]);
};
