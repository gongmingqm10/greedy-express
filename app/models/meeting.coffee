mongoose = require 'mongoose'
Schema = mongoose.Schema
autoIncrement = require('mongoose-auto-increment')
modelName = 'Meeting'

schema = new Schema({
  title: String,
  content: String,
  room: String,
  startTime: Date,
  endTime: Date,
  topics: [{type: Schema.Types.ObjectId, ref: 'Topic'}],
  comments: [{type: Schema.Types.ObjectId, ref: 'Comment'}]
})

schema.plugin(autoIncrement.plugin, modelName)
mongoose.model modelName, schema
