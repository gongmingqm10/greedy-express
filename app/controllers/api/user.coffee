express = require 'express'
mongoose = require 'mongoose'

router = express.Router()
Article  = mongoose.model 'Article'

module.exports = (app) ->
  router.get '/', (req, res) ->
    res.json({"text": "Hello world"})

  app.use '/api/users', router
