/*jslint console */

task('default', [], function () {
  "use strict";
  console.log('default');
});

desc('Example!');
task('example', ['dependency'], function () {
  "use strict";
  console.log('example task');
});

task('dependency', function () {
  "use strict";
  console.log('dependency!');
});