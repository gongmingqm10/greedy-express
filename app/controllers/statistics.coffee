express  = require 'express'
router = express.Router()

module.exports = (app) ->
  app.use '/statistics', router

  app.get '/statistics', (req, res, next) ->
    res.render 'statistics'
