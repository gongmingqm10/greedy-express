mongoose = require 'mongoose'
Schema = mongoose.Schema
modelName = 'Comment'

schema = new Schema({
  _id: String,
  desc: {type: String, required:true},
  commentTime: Date,
  author: {type: Schema.Types.ObjectId, ref: 'User'}
}, {
  timestamps: true
})

mongoose.model modelName, schema
