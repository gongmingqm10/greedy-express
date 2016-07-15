mongoose = require 'mongoose'
Schema   = mongoose.Schema
autoIncrement = require('mongoose-auto-increment')
modelName = 'User'

schema = new Schema({
  username: String,
  email: String,
  password: String,
  department: String,
  role: {
    type: String,
    enum: ['Leader', 'Secretary', 'Advisor']
  }
})

schema.plugin(autoIncrement.plugin, modelName)
mongoose.model modelName, schema
