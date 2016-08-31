"use strict";
require('core-js/es6');
require('core-js/es7/reflect');
require('reflect-metadata');
require('zone.js/dist/zone');
require('zone.js/dist/async-test');
require('zone.js/dist/fake-async-test');
require('zone.js/dist/sync-test');
Error.stackTraceLimit = Infinity;
var appContext = require.context('../src', true, /\.spec\.ts/);
appContext.keys().forEach(appContext);
var testing = require('@angular/core/testing');
var browser = require('@angular/platform-browser-dynamic/testing');
testing.TestBed.initTestEnvironment(browser.BrowserDynamicTestingModule, browser.platformBrowserDynamicTesting());
//# sourceMappingURL=karma-test-shim.js.map