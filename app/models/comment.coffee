mongoose = require 'mongoose'
Schema = mongoose.Schema
modelName = 'Comment'

schema = new Schema({
  _id: String,
  content: String,
  commentTime: Date,
  author: {type: Schema.Types.ObjectId, ref: 'User'}
})

mongoose.model modelName, schema
