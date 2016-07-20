express = require 'express'
mongoose = require 'mongoose'
Response = require '../../data/response'
bcrypt = require 'bcrypt'

router = express.Router()
Meeting = mongoose.model 'Meeting'
Topic = mongoose.model 'Topic'
Comment = mongoose.model 'Comment'
User = mongoose.model 'User'

saveTopicToMeeting = (meetingId, topicData, callback) ->
  Topic.create topicData, (err, topic) ->
    if err || !topic
      callback(err, null)
    else
      Meeting.update {_id: meetingId}, {$push: {'topics': topic}}, (error) ->
        callback(error, topic)

module.exports = (app) ->
  currentUser = null

  router.use (req, res, next) ->
    userId = req.headers['userid']
    if userId
      User.findOne {'_id': userId}, (err, user) ->
        if err || !user
          res.json Response.failure('No permission for this api')
        else
          currentUser = user
          next()
    else
      res.json Response.failure('Invalid request params')

  router.get '/', (req, res) ->
    populateOpts = [
      {path: 'topics', select: '_id title'},
      {path: 'comments', select: '_id desc author'}
    ]
    Meeting.find({}).populate(populateOpts).exec (err, meetings) ->
      if err
        res.json Response.failure(err.toString())
      else
        res.json Response.success(meetings)

  router.get '/:id', (req, res) ->
    populateOpts = [
      {path: 'topics', select: '_id title'},
      {path: 'comments', select: '_id desc author'}
    ]
    Meeting.findOne({_id: req.params.id}).populate(populateOpts).exec (err, meeting) ->
      if err
        res.json Response.failure(err.toString())
      else
        Meeting.deepPopulate meeting, 'comments.author', (err, meeting) ->
          if err
            res.json Response.failure(err.toString())
          else
            res.json Response.success(meeting)

  router.post '/', (req, res) ->
    meeting =
      _id: mongoose.Types.ObjectId()
      title: req.body.title,
      desc: req.body.desc,
      room: req.body.room,
      startTime: req.body.startTime,
      endTime: req.body.endTime

    Meeting.create meeting, (err, info) ->
      if err
        res.json Response.failure(err.toString())
      else
        res.json Response.success(_id: info._id)

  router.post '/:id/topics', (req, res) ->
    hashTopic = {
      _id: mongoose.Types.ObjectId(),
      title: req.body.title,
      desc: req.body.desc
    }
    saveTopicToMeeting(req.params.id, hashTopic, (err, topic) ->
      if err
        res.json Response.failure(err.toString())
      else
        res.json Response.success(topic)
    )

  router.post '/:id/comments', (req, res) ->
    commentHash = {
      _id: mongoose.Types.ObjectId(),
      author: currentUser,
      desc: req.body.desc
    }
    Comment.create commentHash, (err, comment) ->
      if err
        res.json Response.failure(err.toString())
      else
        Meeting.update {_id: req.params.id}, {$push: {'comments': comment}}, (error) ->
          if error
            res.json Response.failure(error.toString())
          else
            res.json Response.success(_id: comment._id)

  app.use '/api/meetings', router
