module.exports = (router) ->
  router.get '/statistics', (req, res, next) ->
    res.render 'statistics'
