process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

environment.plugins.get('Manifest').opts.writeToFileEmit = process.env.NODE_ENV !== 'test'
environment.config.set('devtool', 'inline-source-map')

module.exports = environment.toWebpackConfig()
