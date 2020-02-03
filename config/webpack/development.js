process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environments')

module.exports = environment.toWebpackConfig()
