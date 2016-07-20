mongoose = require 'mongoose'
Schema = mongoose.Schema
modelName = 'Meeting'

schema = new Schema({
  _id: String,
  title: {type: String, required: true},
  desc: String,
  room: String,
  startTime: Date,
  endTime: Date,
  topics: [{type: Schema.Types.ObjectId, ref: 'Topic'}],
  comments: [{type: Schema.Types.ObjectId, ref: 'Comment'}]
}, {
  timeStamps: true
})

mongoose.model modelName, schema
