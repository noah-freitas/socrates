/*global jake, task, desc */
/*jslint console: true, node: true */

var nodeLintOptions = function () {
  "use strict";

  return {
    bitwise:true,
    curly:false,
    eqeqeq:true,
    forin:true,
    immed:true,
    latedef:true,
    newcap:true,
    noarg:true,
    noempty:true,
    nonew:true,
    regexp:true,
    undef:true,
    strict:true,
    trailing:true,
    node:true
  };
};

task('default', ['lint']);

desc('Lint everything');
task('lint', function () {
  "use strict";
  var lint = require('./build/lint/lint_runner.js'),
      files = new jake.FileList();

  files.include("**/*.js");
  files.exclude('node_modules');

  lint.validateFileList(files.toArray(), nodeLintOptions(), {});
});
