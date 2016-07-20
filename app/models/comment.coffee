mongoose = require 'mongoose'
Schema = mongoose.Schema
deepPopulate = require('mongoose-deep-populate')(mongoose)
modelName = 'Comment'

schema = new Schema({
  _id: String,
  desc: {type: String, required:true},
  author: {type: Schema.Types.ObjectId, ref: 'User'}
}, {
  timestamps: true
})

schema.plugin(deepPopulate)
mongoose.model modelName, schema
