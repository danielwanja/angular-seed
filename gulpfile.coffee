gulp = require("gulp")

angularFilesort = require "gulp-angular-filesort"
templates       = require 'gulp-angular-templatecache'
coffee          = require "gulp-coffee"
hamlc           = require "gulp-haml-coffee"
concat          = require "gulp-concat"
inject          = require "gulp-inject"
uglify          = require "gulp-uglify"
rimraf          = require "gulp-rimraf"
mainBowerFiles  = require 'main-bower-files'
# dev server
connect         = require 'gulp-connect'
history         = require 'connect-history-api-fallback'

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
  target = gulp.src('app/index.html')
  bowerFiles = gulp.src(mainBowerFiles(), {read: false})
  # angularFiles = gulp.src(['./dist/**/*.js'], {read: false}).pipe(angularFilesort())
  target.pipe(inject(bowerFiles, starttag: '<!-- inject:bower:{{ext}} -->', ignorePath: 'bower_components'))
        # .pipe(inject(angularFiles, ignorePath: 'dist'))
        .pipe(gulp.dest('./dist'))
        .pipe(connect.reload())

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
