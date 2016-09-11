var gulp = require('gulp');
var rename = require("gulp-rename");
var modifyFile = require('gulp-modify-file');

gulp.task('i18n-xlf2ts', function () {
    gulp.src("./src/resources/i18n/*.xlf")
        .pipe(rename(function (path) {
            path.extname = ".ts"
        }))
        .pipe(modifyFile(function (content, path, file) {
            var language = path.split(".")[1].toUpperCase();
            return "export const TRANSLATION_" + language + " = `" + content + "`;";
        }))
        .pipe(gulp.dest("./src/resources/i18n"));
});