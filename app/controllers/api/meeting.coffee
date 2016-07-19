express = require 'express'
mongoose = require 'mongoose'
Response = require '../../data/response'
bcrypt = require 'bcrypt'

router = express.Router()
Meeting = mongoose.model 'Meeting'
Topic = mongoose.model 'Topic'

saveTopicToMeeting = (meetingId, topicData, callback) ->
  Topic.create topicData, (err, topic) ->
    if err || !topic
      callback(err, null)
    else
      Meeting.update {_id: meetingId}, {$push: {'topics': topic}}, (error) ->
        callback(error, topic)

module.exports = (app) ->
  router.get '/', (req, res) ->
    Meeting.find({}).populate('topics').exec (err, meetings) ->
      if err
        res.json Response.failure(err.toString())
      else
        res.json Response.success(meetings)

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

  app.use '/api/meetings', router
