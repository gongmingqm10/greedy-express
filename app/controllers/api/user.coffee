mongoose = require 'mongoose'
Article  = mongoose.model 'Article'

module.exports = (router) ->
  router.get('/api/users', (req, res) ->
    res.json({"text": "Hello world"})
  )
