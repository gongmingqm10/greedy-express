mongoose = require 'mongoose'
Schema   = mongoose.Schema
modelName = 'Topic'

schema = new Schema({
  _id: String,
  title: String,
  desc: String,
  comments: [{type: Schema.Types.ObjectId, ref: 'Comment'}]
})

mongoose.model modelName, schema
