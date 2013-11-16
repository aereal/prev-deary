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
          "public/stylesheets/app.css": "app/assets/stylesheets/app.scss"
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
    esteWatch:
      options:
        dirs: [
          'app/assets/**/'
        ]
        livereload:
          enabled: false
      scss: (filePath) -> 'css'
      coffee: (filePath) -> 'js'
    copy:
      font:
        files: [
          expand: true
          flatten: true
          src: 'app/assets/fonts/**/*'
          dest: 'public/fonts/'
        ]
    uglify:
      production:
        options:
          mangle: false
          report: true
        files:
          'public/javascripts/app.min.js' : 'public/javascripts/app.js'
    cssmin:
      production:
        files:
          'public/stylesheets/app.min.css' : 'public/stylesheets/app.css'

  grunt.loadNpmTasks "grunt-contrib-#{task}" for task in [
    'coffee'
    'concat'
    'sass'
    'copy'
    'uglify'
    'cssmin'
  ]
  grunt.loadNpmTasks 'grunt-este-watch'

  grunt.registerTask 'js', [
    'coffee'
    'concat:js'
  ]

  grunt.registerTask 'js:production', [
    'js'
    'uglify:production'
  ]

  grunt.registerTask 'css', [
    'sass:dist'
  ]

  grunt.registerTask 'css:production', [
    'css'
    'cssmin:production'
  ]

  grunt.registerTask 'font', [
    'copy:font'
  ]

  grunt.registerTask 'production', [
    'js:production'
    'css:production'
  ]

  grunt.registerTask 'default', [
    'css'
    'js'
    'font'
  ]

  grunt.registerTask 'watch', [
    'esteWatch'
  ]
