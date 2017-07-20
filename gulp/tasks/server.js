module.exports = function(gulp, port, root, output_fallback) {
  gulp.task("server", function() {
    connect = require("gulp-connect");
    connect.server({
      port: port,
      root: root,
      fallback: output_fallback
    });
  });
}
