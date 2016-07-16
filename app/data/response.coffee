module.exports =
  success: (data) ->
    result: 1,
    data: data
  failure: (msg) ->
    result: 0,
    error: msg
