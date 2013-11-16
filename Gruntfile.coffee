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

  grunt.loadNpmTasks "grunt-contrib-#{task}" for task in [
    'coffee'
    'concat'
    'sass'
    'copy'
    'uglify'
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

  grunt.registerTask 'font', [
    'copy:font'
  ]

  grunt.registerTask 'production', [
    'js:production'
  ]

  grunt.registerTask 'default', [
    'css'
    'js'
    'font'
  ]

  grunt.registerTask 'watch', [
    'esteWatch'
  ]
