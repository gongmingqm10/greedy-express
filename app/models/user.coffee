mongoose = require 'mongoose'
Schema   = mongoose.Schema
autoIncrement = require('mongoose-auto-increment')
modelName = 'User'

schema = new Schema({
  _id: String
  username: String,
  email: String,
  password: String,
  department: String,
  role: {
    type: String,
    enum: ['Leader', 'Secretary', 'Advisor']
  }
})

mongoose.model modelName, schema
