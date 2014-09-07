gulp = require("gulp")

angularFilesort = require "gulp-angular-filesort"
coffee          = require "gulp-coffee"
concat          = require "gulp-concat"
connect         = require 'gulp-connect'
hamlc           = require "gulp-haml-coffee"
history         = require 'connect-history-api-fallback'
inject          = require "gulp-inject"
karma           = require "gulp-karma"
mainBowerFiles  = require 'main-bower-files'
protractor      = require("gulp-protractor").protractor
rimraf          = require "gulp-rimraf"
templates       = require 'gulp-angular-templatecache'
uglify          = require "gulp-uglify"

gulp.task "compile", ["clean", "compile-styles", "compile-scripts", "compile-views"]

gulp.task "clean", ->
  gulp.src(["./dist/*.js", "./dist/*.css"],
    read: false
  ).pipe rimraf()

# TODO: use scss?
gulp.task "compile-styles", ->
  gulp.src("./app/**/*.css")
      .pipe gulp.dest("./dist/")

gulp.task "compile-scripts", ->
  gulp.src([
    "./app/js/**/*.coffee"
  ]).pipe(coffee(bare: true))
    .pipe(angularFilesort())
    .pipe(concat("myapp.js"))
    # .pipe(uglify())   # ENABLE: uglification
    .pipe gulp.dest("./dist/")

gulp.task "compile-views", ->
  gulp.src("./app/views/**/*.hamlc")
      .pipe(hamlc())
      .pipe(templates(standalone: false, root: '/', module: 'myApp.views'))
      .pipe(concat("myapp-views.js"))
      .pipe(gulp.dest("./dist"))

gulp.task 'index.html', [ 'compile' ], ->
  target = gulp.src('app/index.hamlc')
  bowerFiles = gulp.src(mainBowerFiles(), {read: false})
  # angularFiles = gulp.src(['./dist/**/*.js'], {read: false}).pipe(angularFilesort())
  target.pipe(hamlc())
        .pipe(inject(bowerFiles, starttag: '<!-- inject:bower:{{ext}} -->', ignorePath: 'bower_components'))
        # .pipe(inject(angularFiles, ignorePath: 'dist'))
        .pipe(gulp.dest('./dist'))
        .pipe(connect.reload())


gulp.task "test", ["compile"], ->
  gulp.src("./test/unit/**.coffe").pipe(karma(
    configFile: "./test/karma.conf.coffee"
    action: "run"
  )).on "error", (err) ->
    # Make sure failed tests cause gulp to exit non-zero
    throw err

gulp.task "test:watch", ["compile"], ->
  gulp.src("./test/unit/**.coffe").pipe(karma(
    configFile: "./test/karma.conf.coffee"
    action: "watch"
  ))

gulp.task "protractor", ->
  gulp.src(["./test/e2e/**/scenarios.coffee"]).pipe(protractor(
    configFile: "test/protractor.conf.js"
    args: [
      "--baseUrl"
      "http://127.0.0.1:8000/"
    ]
  ))

gulp.task 'dev-server', ->
  connect.server
    root: [
      './dist'
      './bower_components'
    ]
    port: 8000,
    livereload: true
    # Need a proxy?
    # middleware: (connect, opt) ->
    #   [history, (->
    #     url     = require 'url'
    #     proxy   = require 'proxy-middleware'
    #     options = url.parse 'http://localhost:3000/api'
    #     options.route = '/rest/api'
    #     proxy options
    #   )()]

gulp.task 'watch', ->
  gulp.watch('app/index.html', ['index.html'])
  gulp.watch(['app/**/*.coffee','app/**/*.hamlc', 'app/**/*.css'], ['compile', 'index.html'])

gulp.task 'build',   ['index.html', 'watch']
gulp.task 'dev', ['dev-server', 'build']
gulp.task "default", ['test']
