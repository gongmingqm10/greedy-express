var gulp = require('gulp'),
  nodemon = require('gulp-nodemon'),
  plumber = require('gulp-plumber'),
  livereload = require('gulp-livereload'),
  less = require('gulp-less');
  minify = require('gulp-minify');

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

gulp.task('materialize', function () {
  var materialize_path = './node_modules/materialize-css/dist/';
  gulp.src(materialize_path + 'css/materialize.min.css')
    .pipe(gulp.dest('./dist/css'));
  gulp.src(materialize_path + 'js/materialize.min.js')
    .pipe(gulp.dest('./dist/js'));
  gulp.src(materialize_path + 'font/material-design-icons/*')
    .pipe(gulp.dest('./dist/font/material-design-icons'));
  gulp.src(materialize_path + 'font/roboto/*')
    .pipe(gulp.dest('./dist/font/roboto'));
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
  'develop',
  'watch'
]);
