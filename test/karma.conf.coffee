module.exports = (config) ->
    config.set
        # base path, that will be used to resolve files and exclude
        basePath: '../'
        files: [
          "bower_components/angular/angular.js"
          "bower_components/angular-route/angular-route.js"
          "bower_components/angular-mocks/angular-mocks.js"
          "dist/myapp.js"
          "dist/myapp-views.js"
          "test/unit/**/*Spec.coffee"
        ]
        preprocessors:
            '**/*.coffee': 'coffee'
        exclude: []
        reporters: ['progress']
        colors: yes
        autoWatch: true
        browsers: ["Chrome"]
        frameworks: ["jasmine"]
        plugins: [
          "karma-chrome-launcher"
          "karma-firefox-launcher"
          "karma-jasmine"
          "karma-junit-reporter"
          "karma-coffee-preprocessor"
        ]
        junitReporter:
          outputFile: "test_out/unit.xml"
          suite: "unit"
