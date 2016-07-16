mongoose = require 'mongoose'
Schema   = mongoose.Schema
autoIncrement = require('mongoose-auto-increment')
modelName = 'Topic'

schema = new Schema({
  _id: String,
  title: String,
  content: String,
  comments: [{type: Schema.Types.ObjectId, ref: 'Comment'}]
})

mongoose.model modelName, schema
