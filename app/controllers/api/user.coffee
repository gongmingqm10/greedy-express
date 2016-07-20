express = require 'express'
mongoose = require 'mongoose'
Response = require '../../data/response'
bcrypt = require 'bcrypt'

router = express.Router()
User  = mongoose.model 'User'
saltRounds = 10

encryptPassword = (plainText) ->
  salt = bcrypt.genSaltSync saltRounds
  bcrypt.hashSync plainText, salt

module.exports = (app) ->

  currentUser = null
  router.use (req, res, next) ->
    userId = req.headers['userid']
    User.findOne {'_id': userId}, (err, user) ->
      currentUser = user
      next()

  router.get '/', (req, res) ->
    role = req.query.role
    return res.json 400, Response.failure('Missing query param: role') unless role
    return res.json 401, Response.failure('Advisors do not have permission to list users') if user && user.role isnt 'Advisor'
    return res.json 403, Response.failure('Try to list leaders information, contact administrators') if role isnt 'Advisor'
    User.find(role: 'Advisor').exec (err, users) ->
      if err
        res.json 500, Response.failure(err.toString())
      else
        res.json Response.success(users)

  router.post '/', (req, res) ->
    email = req.body.email
    password = req.body.password
    role = req.body.role
    username = req.body.username

    return res.json 400, Response.failure("Missing required params") unless email && password && role && username

    user =
      _id: mongoose.Types.ObjectId()
      username: req.body.username,
      email: req.body.email,
      role: req.body.role,
      password: encryptPassword req.body.password,
      department: req.body.department

    User.create user, (err, info) ->
      if err
        res.json 500, Response.failure(err.toString())
      else
        res.json Response.success(_id: info._id)

  router.post '/login', (req, res) ->
    email = req.body.email
    password = req.body.password
    return res.json 400, Response.failure('Email or password are required') unless email && password
    User.findOne({email: email}).select('+password').exec (err, user) ->
      if user && user.password && bcrypt.compareSync(password, user.password)
        res.json Response.success(
          _id: user._id,
          email: user.email,
          department: user.department,
          username: user.username,
          role: user.role
        )
      else
        res.json 401, Response.failure("Email or password is not valid")

  app.use '/api/users', router
