mongoose = require 'mongoose'
Schema   = mongoose.Schema
deepPopulate = require('mongoose-deep-populate')(mongoose)
modelName = 'Topic'

schema = new Schema({
  _id: String,
  title: String,
  desc: String,
  comments: [{type: Schema.Types.ObjectId, ref: 'Comment'}]
}, {
  timeStamps: true
})
schema.plugin(deepPopulate)
mongoose.model modelName, schema
