/*global jake, task, desc, fail */
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

desc('Build and test');
task('default', ['lint']);

desc('Lint everything');
task('lint', function () {
  "use strict";
  var lint = require('./build/lint/lint_runner.js'),
      files = new jake.FileList();

  files.include("**/*.js");
  files.exclude('node_modules');

  if (!lint.validateFileList(files.toArray(), nodeLintOptions(), {})) {
    fail('Lint failed!');
  }
});

desc('Integrate');
task('integrate', ['default'], function () {
  "use strict";

  console.log('1. Make sure "git status" is clean.');
  console.log('2. Build on the integration box.');
  console.log('   a. Go to integration box.');
  console.log('   b. "git pull" ');
  console.log('   c. jake.bat');
  console.log('3. "git checkout integration"');
  console.log('4. "git merge tdd --no-ff --log"');
  console.log('5. "git checkout tdd"');
});
