/*global jake, task, desc */
/*jslint console: true, node: true */

task('default', ['lint']);

desc('Lint everything');
task('lint', function () {
  "use strict";
  var lint = require('./build/lint/lint_runner.js'),
      files = new jake.FileList();

  files.include("**/*.js");
  files.exclude('node_modules');

  var options = {
    node: true
  };

  lint.validateFileList(files.toArray(), options, {});
});
