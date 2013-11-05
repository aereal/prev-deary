module.exports = (grunt) ->
  assetsDirectory = 'app/assets/javascripts'

  grunt.initConfig
    coffee:
      glob_to_multiple:
        expand: true
        flatten: true
        src: ["#{assetsDirectory}/**/*.coffee"]
        dest: assetsDirectory
        ext: '.js'
    concat:
      js:
        src: [
          'bower_components/jquery/jquery.js'
          "#{assetsDirectory}/**/*.js"
        ]
        dest: 'public/javascripts/app.js'

  grunt.loadNpmTasks "grunt-contrib-#{task}" for task in ['coffee', 'concat']

  grunt.registerTask 'js', [
    'coffee'
    'concat:js'
  ]
