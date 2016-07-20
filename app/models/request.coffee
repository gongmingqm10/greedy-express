mongoose = require 'mongoose'
Schema = mongoose.Schema
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

mongoose.model modelName, schema
