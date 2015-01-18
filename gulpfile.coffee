browserify = require 'gulp-browserify'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
gulp = require 'gulp'
gutil = require 'gulp-util'
imagemin = require 'gulp-imagemin'
pngquant = require 'imagemin-pngquant'
minify = require 'gulp-minify-css'
plumber = require 'gulp-plumber'
prefix = require 'gulp-autoprefixer'
stylus = require 'gulp-stylus'
uglify = require 'gulp-uglify'

src =
  coffee: ['**/*.coffee', '!node_modules/**/*']
  coffee_index: ['private/coffee/index.coffee']
  images: 'private/images/**/*'
  stylus: ['**/*.styl', '!node_modules/**/*.styl']
  stylus_index: 'private/stylus/index.styl'

dest =
  coffee: 'public/js/'
  images: 'public/images/'
  stylus: 'public/css/'

gulp.task 'build', ['coffee', 'images', 'stylus']

gulp.task 'coffee', ->
  # Lint
  console.log '\nLinting coffeescript...\n'
  gulp.src src.coffee
    .pipe coffeelint()
    .pipe coffeelint.reporter()

  # Browserify
  gulp.src src.coffee_index
    .pipe plumber()
    .pipe coffee().on 'error', gutil.log
    .pipe browserify
      transform: ['coffeeify']
      extensions: ['.coffee']
      insertGlobals: true
    .pipe uglify()
    .pipe gulp.dest dest.coffee

gulp.task 'stylus', ->
  gulp.src src.stylus_index
    .pipe stylus()
    .pipe prefix()
    .pipe minify()
    .pipe gulp.dest dest.stylus

gulp.task 'images', ->
  gulp.src src.images
    .pipe imagemin
      progressive: true
      svgoPlugins: [removeViewBox: false]
      use: [pngquant()]
    .pipe gulp.dest dest.images

gulp.task 'watch', ->
  gulp.watch src.coffee, ['coffee']
  gulp.watch src.images, ['images']
  gulp.watch src.stylus, ['stylus']

gulp.task 'default', ['build', 'watch']