/*jslint exports: true */

var server = require('./server');

exports.testNothing = function (test) {
  "use strict";
  test.equals(3, server.number(), 'number');
  test.done();
};
