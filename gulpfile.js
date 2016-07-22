var gulp = require('gulp'),
  nodemon = require('gulp-nodemon'),
  plumber = require('gulp-plumber'),
  livereload = require('gulp-livereload'),
  less = require('gulp-less'),
  minify = require('gulp-minify'),
  del = require('del'),
  zip = require('gulp-zip'),
  install = require('gulp-install'),
  runSequence = require('run-sequence'),
  coffee = require('gulp-coffee');

gulp.task('clean', function() {
  return del(['./dist', './dist.zip']);
});

gulp.task('node-mods', function() {
  return gulp.src('./package.json')
    .pipe(gulp.dest('dist/'))
    .pipe(install({production: true}));
});

gulp.task('zip', function() {
  return gulp.src(['dist/**/*', '!dist/package.json'])
    .pipe(zip('dist.zip'))
    .pipe(gulp.dest('./'));
});

gulp.task('package', function(callback) {
  return runSequence(
    ['clean'],
    [ 'materialize', 'less', 'javascript', 'coffee', 'node-mods'],
    ['zip'],
    callback
  );
});

gulp.task('less', function () {
  gulp.src('./public/css/*.less')
    .pipe(plumber())
    .pipe(less())
    .pipe(gulp.dest('./dist/css'))
    .pipe(livereload());
});

gulp.task('javascript', function () {
  gulp.src('./public/js/*.min.js')
    .pipe(gulp.dest('./dist/js'));
});

gulp.task('coffee', function () {
  gulp.src('./public/js/*.coffee')
    .pipe(coffee({bare: true}))
    .pipe(gulp.dest('./dist/js'))
});

gulp.task('materialize', function () {
  var materialize_path = './node_modules/materialize-css/dist/';
  gulp.src(materialize_path + 'css/materialize.min.css')
    .pipe(gulp.dest('./dist/css'));
  gulp.src(materialize_path + 'js/materialize.min.js')
    .pipe(gulp.dest('./dist/js'));
  gulp.src(materialize_path + 'fonts/material-design-icons/*')
    .pipe(gulp.dest('./dist/fonts/material-design-icons'));
  gulp.src(materialize_path + 'fonts/roboto/*')
    .pipe(gulp.dest('./dist/fonts/roboto'));
});

gulp.task('watch', function() {
  gulp.watch('./public/css/*.less', ['less']);
  gulp.watch('./public/js/*.js', ['javascript'])
});

gulp.task('develop', function () {
  livereload.listen();
  nodemon({
    script: 'app.js',
    ext: 'js coffee jade',
    stdout: false
  }).on('readable', function () {
    this.stdout.on('data', function (chunk) {
      if(/^Express server listening on port/.test(chunk)){
        livereload.changed(__dirname);
      }
    });
    this.stdout.pipe(process.stdout);
    this.stderr.pipe(process.stderr);
  });
});

gulp.task('default', [
  'materialize',
  'less',
  'javascript',
  'coffee',
  'develop',
  'watch'
]);
