mongoose = require 'mongoose'
Schema   = mongoose.Schema
modelName = 'User'

schema = new Schema({
  _id: String
  username: {type: String, required:true},
  email: {type: String, required:true},
  password: {type: String, required:true},
  department: String,
  role: {
    type: String,
    required: true,
    enum: ['Leader', 'Secretary', 'Advisor']
  }
}, {
  timeStamps: true
})

mongoose.model modelName, schema
