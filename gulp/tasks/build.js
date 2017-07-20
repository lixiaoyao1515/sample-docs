var exec = require('child_process').exec,
     execSync = require('child_process').execSync;

module.exports = function(gulp, options) {
  var IS_STAGING = options.isStaging;
  gulp.task("nanoc:compile", function (cb) {
    var command;
    if (IS_STAGING) {
      command = "nanoc compile"
    }
    else {
      command = "nanoc compile"
    }
    exec(command, {maxBuffer: 1024 * 1000}, function (err, stdout, stderr) {
      console.log(stdout);
      console.log(stderr);
      cb(err);
    });
  });
}
