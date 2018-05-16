const webpackConfig = require('./config/webpack/test.js')
module.exports = function(config) {
  config.set({
    basePath: "",
    frameworks: ["jasmine"],
    plugins: [
      "karma-jasmine",
      "karma-webpack",
      "karma-chrome-launcher",
      "karma-spec-reporter",
      "karma-sourcemap-loader"
    ],
    files: [
      "spec/javascript/*.spec.js",
      "spec/javascript/**/*.spec.js"
    ],
    exclude: [],
    webpack: webpackConfig,
    preprocessors: {
      "spec/javascript/*.spec.js": ["webpack", "sourcemap"],
      "spec/javascript/**/*.spec.js": ["webpack", "sourcemap"]
    },
    reporters: ["spec"],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ["ChromeHeadless"],
    singleRun: false
  });
};
