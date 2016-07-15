mongoose = require 'mongoose'
Schema   = mongoose.Schema
autoIncrement = require('mongoose-auto-increment')
modelName = 'Topic'

schema = new Schema({
  title: String,
  content: String,
  comments: [{type: Schema.Types.ObjectId, ref: 'Comment'}]
})

schema.plugin(autoIncrement.plugin, modelName)
mongoose.model modelName, schema
