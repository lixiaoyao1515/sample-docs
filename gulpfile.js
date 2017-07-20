require('app-module-path').addPath("node_modules/docs-builder-npm/node_modules");
var gulp   = require("gulp");

gulp.task("watch:nanoc", function() {
  gulp.watch([
    "nanoc.yaml",
    "Rules",
    "content/**/*",
    "layouts/**/*",
    "lib/**/*"
  ], ["nanoc:compile"]);
});

require('./gulp/tasks/build')(gulp, { isStaging: true });
require('./gulp/tasks/server')(gulp, 4000, ["output"], "output/404.html");


gulp.task("build", [ "nanoc:compile" ]);
gulp.task("serve", [ "server", "watch:nanoc" ]);
gulp.task("default", [ "build", "serve" ]);
