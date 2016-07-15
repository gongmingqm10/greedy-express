mongoose = require 'mongoose'
Schema = mongoose.Schema
autoIncrement = require('mongoose-auto-increment')
modelName = 'Request'

schema = new Schema({
  meeting: {type: Schema.Types.ObjectId, ref: 'Meeting'},
  advisor: {type: Schema.Types.ObjectId, ref: 'User'},
  status: {type: String, enum: ['Waiting', 'Confirmed', 'Closed']},
  requestTime: Date
})

schema.plugin(autoIncrement.plugin, modelName)
mongoose.model modelName, schema
