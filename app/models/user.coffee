mongoose = require 'mongoose'
Schema   = mongoose.Schema
autoIncrement = require('mongoose-auto-increment')
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
})

mongoose.model modelName, schema
