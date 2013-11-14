module.exports = (grunt) ->
  assetsDirectory = 'app/assets/javascripts'

  grunt.initConfig
    sass:
      dist:
        options:
          loadPath: [
            'bower_components/modularized-normalize-scss'
          ]
        files:
          "public/stylesheets/style.css": "app/assets/stylesheets/style.scss"
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
          'bower_components/angular/angular.js'
          "#{assetsDirectory}/**/*.js"
        ]
        dest: 'public/javascripts/app.js'

  grunt.loadNpmTasks "grunt-contrib-#{task}" for task in ['coffee', 'concat', 'sass']

  grunt.registerTask 'js', [
    'coffee'
    'concat:js'
  ]

  grunt.registerTask 'css', [
    'sass:dist'
  ]

  grunt.registerTask 'default', [
    'css'
    'js'
  ]
