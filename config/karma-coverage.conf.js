var webpackConfig = require('./webpack.test.coverage');

module.exports = function (config) {
    var _config = {
        basePath: '.',

        frameworks: ['jasmine'],

        files: [
            {pattern: './config/karma-test-shim.js', watched: false}
        ],

        preprocessors: {
            './config/karma-test-shim.js': ['webpack', 'sourcemap', 'coverage']
        },

        webpack: webpackConfig,

        webpackMiddleware: {
            stats: 'errors-only'
        },

        webpackServer: {
            noInfo: true
        },

        reporters: ['progress', 'coverage'],
        port: 9876,
        colors: true,
        logLevel: config.LOG_INFO,
        autoWatch: false,
        browserNoActivityTimeout: 60000,
        browsers: ['PhantomJS'],
        singleRun: true,

        coverageReporter: {
            type: 'html',
            dir: 'coverage/'
        }
    };

    config.set(_config);
};
