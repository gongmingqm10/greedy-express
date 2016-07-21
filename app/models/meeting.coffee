mongoose = require 'mongoose'
Schema = mongoose.Schema
deepPopulate = require('mongoose-deep-populate')(mongoose)
modelName = 'Meeting'

schema = new Schema({
  _id: String,
  title: {type: String, required: true},
  desc: String,
  room: String,
  startTime: Date,
  endTime: Date,
  topics: [{type: Schema.Types.ObjectId, ref: 'Topic'}],
  comments: [{type: Schema.Types.ObjectId, ref: 'Comment'}],
  advisors: [{type: Schema.Types.ObjectId, ref: 'User'}]
}, {
  timeStamps: true
})
schema.plugin(deepPopulate)
mongoose.model modelName, schema
