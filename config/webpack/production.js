process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environments')

module.exports = environment.toWebpackConfig()
