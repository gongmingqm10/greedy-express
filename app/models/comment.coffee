mongoose = require 'mongoose'
Schema = mongoose.Schema
autoIncrement = require('mongoose-auto-increment')
modelName = 'Comment'

schema = new Schema({
  content: String,
  commentTime: Date,
  author: {type: Schema.Types.ObjectId, ref: 'User'}
})

schema.plugin(autoIncrement.plugin, modelName)
mongoose.model modelName, schema
