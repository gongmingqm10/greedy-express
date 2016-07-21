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

meetingPopulateOpts = [
  {path: 'topics', select: '_id title'},
  {path: 'comments', select: '_id desc author'},
  {path: 'advisors', select: '_id username email'}
]

module.exports = (app) ->
  currentUser = null

  router.use (req, res, next) ->
    userId = req.headers['userid']
    if userId
      User.findOne {'_id': userId}, (err, user) ->
        if err || !user
          res.json 401, Response.failure('No permission for this api')
        else
          currentUser = user
          next()
    else
      res.json 400, Response.failure('Invalid request params')

  router.get '/', (req, res) ->
    Meeting.find({}).populate(meetingPopulateOpts).exec (err, meetings) ->
      if err
        res.json 500, Response.failure(err.toString())
      else
        res.json Response.success(meetings)

  router.get '/:id', (req, res) ->
    Meeting.findOne({_id: req.params.id}).populate(meetingPopulateOpts).exec (err, meeting) ->
      if err
        res.json Response.failure(err.toString())
      else
        Meeting.deepPopulate meeting, 'comments.author', (err, meeting) ->
          if err
            res.json 500, Response.failure(err.toString())
          else
            res.json Response.success(meeting)

  router.post '/', (req, res) ->
    title = req.body.title
    return res.json 400, Response.failure('Required filed missing: title') unless title

    meeting =
      _id: mongoose.Types.ObjectId()
      title: title,
      desc: req.body.desc,
      room: req.body.room,
      startTime: req.body.startTime,
      endTime: req.body.endTime

    Meeting.create meeting, (err, info) ->
      if err
        res.json 500, Response.failure(err.toString())
      else
        res.json Response.success(_id: info._id)

  router.post '/:id/topics', (req, res) ->
    title = req.body.title
    return res.json 400, Response.failure('Required filed missing: title') unless title

    hashTopic = {
      _id: mongoose.Types.ObjectId(),
      title: title,
      desc: req.body.desc
    }
    saveTopicToMeeting(req.params.id, hashTopic, (err, topic) ->
      if err
        res.json 500, Response.failure(err.toString())
      else
        res.json Response.success(topic)
    )

  router.post '/:id/comments', (req, res) ->
    desc = req.body.desc
    return res.json 400, Response.failure('Required filed missing: title') unless desc

    commentHash = {_id: mongoose.Types.ObjectId(), author: currentUser, desc: desc}

    Comment.create commentHash, (err, comment) ->
      if err
        res.json 500, Response.failure(err.toString())
      else
        Meeting.update {_id: req.params.id}, {$push: {'comments': comment}}, (error) ->
          if error
            res.json 500, Response.failure(error.toString())
          else
            res.json Response.success(_id: comment._id)

  router.post '/:id/advisors', (req, res) ->
    return res.json 403, Response.failure('Only leader or secretary have access to update advisors') unless currentUser.isAdmin
    advisors = req.body.advisors
    User.find({role: 'Advisor', _id: {$in: advisors}}, (err, users) ->
      if err
        res.json 500, Response.failure(err.toString())
      else
        Meeting.update({_id: req.params.id}, {advisors: users}, (error) ->
          if error
            res.json 500, Response.failure(error.toString())
          else
            res.json Response.success('Success updated meeting\'s advisors')
        )
    )

  app.use '/api/meetings', router
