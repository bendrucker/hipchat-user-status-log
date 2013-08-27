request		= require 'request'
Q			= require 'q'
mongoose	= require 'mongoose'

credentials = require './credentials.json'
StatusCheck = require './status-check'

mongoose.connect credentials.mongoUri

getUserList = () ->
	deferred = Q.defer();
	request "https://api.hipchat.com/v1/users/list?auth_token=#{credentials.hipchatApiKey}", (err, res, body) ->
		unless err
			deferred.resolve JSON.parse(body).users
		else
			deferred.reject err

	return deferred.promise

parseUserList = (users) ->
	parsed = []
	users.forEach (user) ->
		parsed.push createStatusEntry(user)
	return parsed

createStatusEntry = (user) ->
	statusCheck = 
		userId: user.user_id
		status: user.status

	return statusCheck
	
userListPromise = getUserList()

userListPromise.then (users) ->
	return parseUserList users
.then (users) ->
	statusCheck = new StatusCheck
		users: users

	statusCheck.save (err) ->
		unless err
			console.log "Status check successfully recorded"
		else
			console.log "Status check failed:"
			console.log err

		mongoose.disconnect()
	return