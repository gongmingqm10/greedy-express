mongoose = require 'mongoose'
Schema   = mongoose.Schema
deepPopulate = require('mongoose-deep-populate')(mongoose)
modelName = 'User'

schema = new Schema({
  _id: String
  username: {type: String, required:true},
  email: {type: String, required:true},
  password: {type: String, required:true, select: false},
  department: String,
  role: {
    type: String,
    required: true,
    enum: ['Leader', 'Secretary', 'Advisor']
  }
}, {
  timeStamps: true
})
schema.plugin(deepPopulate)
mongoose.model modelName, schema
