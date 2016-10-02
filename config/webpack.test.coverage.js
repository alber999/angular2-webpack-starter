var helpers = require('./helpers');
var webpackMerge = require('webpack-merge');
var testConfig = require('./webpack.test.js');

module.exports = webpackMerge(testConfig, {
    module: {
        postLoaders: [
            {
                test: /\.ts$/,
                include: helpers.root('src'),
                loader: 'istanbul-instrumenter'
            }
        ]
    }
});
