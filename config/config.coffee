path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'greedy-express'
    port: 3000
    db: 'mongodb://localhost/greedy-express-development'

  test:
    root: rootPath
    app:
      name: 'greedy-express'
    port: 3000
    db: 'mongodb://localhost/greedy-express-test'

  production:
    root: rootPath
    app:
      name: 'greedy-express'
    port: 3000
    db: 'mongodb://localhost/greedy-express-production'

module.exports = config[env]
