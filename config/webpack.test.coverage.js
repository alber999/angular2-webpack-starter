var helpers = require('./helpers');
var webpackMerge = require('webpack-merge');
var testConfig = require('./webpack.test.js');

module.exports = webpackMerge(testConfig, {
    module: {
        postLoaders: [
            {
                test: /\.ts$/,
                include: helpers.root('src'),
                loader: 'istanbul-instrumenter-loader'
            }
        ]
    },
    reporters: [ 'progress', 'coverage-istanbul' ],
    coverageIstanbulReporter: {
        reports: [ 'text-summary' ],
        fixWebpackSourcePaths: true
    },
});
