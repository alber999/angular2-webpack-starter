var helpers = require('./helpers');
var webpackMerge = require('webpack-merge');
var testConfig = require('./webpack.test.js');

module.exports = webpackMerge(testConfig, {
    module: {
        rules: [
            {
                enforce: 'post',
                test: /\.(js|ts)$/,
                loader: 'istanbul-instrumenter-loader',
                include: helpers.root('src')
            }
        ]
    }
});


