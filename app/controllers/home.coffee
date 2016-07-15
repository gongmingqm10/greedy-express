express = require 'express'
mongoose = require 'mongoose'

router = express.Router()
Article  = mongoose.model 'Article'

module.exports = (app) ->
  router.get '/', (req, res, next) ->
    Article.find (err, articles) ->
      return next(err) if err
      res.render 'index',
        title: 'Generator-Express MVC'
        articles: articles

  app.use('/', router)
