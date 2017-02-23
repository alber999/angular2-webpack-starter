var webpackConfig = require('./webpack.test.coverage');

module.exports = function (config) {
    var _config = {
        basePath: '',

        frameworks: ['jasmine'],

        files: [
            {pattern: './config/karma-test-shim.js', watched: false}
        ],

        preprocessors: {
            './config/karma-test-shim.js': ['coverage', 'webpack', 'sourcemap']
        },

        webpack: webpackConfig,

        coverageReporter: {
            type: 'in-memory'
        },

        remapCoverageReporter: {
            'text-summary': null,
            json: './coverage/coverage.json',
            html: './coverage/html'
        },

        webpackMiddleware: {
            stats: 'errors-only'
        },

        webpackServer: {
            noInfo: true
        },

        reporters: ['progress', 'coverage', 'remap-coverage'],
        port: 9876,
        colors: true,
        logLevel: config.LOG_INFO,
        autoWatch: false,
        browserNoActivityTimeout: 60000,
        browsers: ['PhantomJS'],
        singleRun: true
    };

    config.set(_config);
};
