mongoose = require 'mongoose'

statusCheckSchema = new mongoose.Schema
	timestamp:
			type:		Date
			default:	Date.now

	users: [{
		userId:			String
		status:			String
	}]

StatusCheck = mongoose.model 'StatusCheck', statusCheckSchema

exports = module.exports = StatusCheck