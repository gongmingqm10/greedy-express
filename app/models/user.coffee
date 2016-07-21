mongoose = require 'mongoose'
Schema   = mongoose.Schema
deepPopulate = require('mongoose-deep-populate')(mongoose)
modelName = 'User'

schema = new Schema({
  _id: String
  username: {type: String, required:true},
  email: {type: String, unique : true, required : true, dropDups: true},
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

schema.virtual('isAdmin').get () ->
  this.role is 'Leader' or this.role is 'Secretary'

schema.plugin(deepPopulate)
mongoose.model modelName, schema
