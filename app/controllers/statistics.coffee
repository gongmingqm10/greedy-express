express = require 'express'
router = express.Router()

module.exports = (app) ->
  router.get '/', (req, res, next) ->
    res.render 'statistics'
  app.use '/statistics', router
