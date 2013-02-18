/*global jake */
/*jslint console: true, node: true */

task('default', ['lint']);

desc('Example!');
task('example', ['dependency'], function () {
  "use strict";
  console.log('example task');
});

task('dependency', function () {
  "use strict";
  console.log('dependency!');
});