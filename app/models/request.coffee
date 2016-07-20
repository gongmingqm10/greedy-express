mongoose = require 'mongoose'
Schema = mongoose.Schema
deepPopulate = require('mongoose-deep-populate')(mongoose)
modelName = 'Request'

schema = new Schema({
  _id: String
  meeting: {type: Schema.Types.ObjectId, ref: 'Meeting'},
  advisor: {type: Schema.Types.ObjectId, ref: 'User'},
  status: {type: String, enum: ['Waiting', 'Confirmed', 'Closed']},
  requestTime: Date
}, {
  timeStamps: true
})
schema.plugin(deepPopulate)
mongoose.model modelName, schema
