@Resousers = new Mongo.Collection 'resousers'

Schemas = {}

Schemas.Resouser = new SimpleSchema
	owner:
		type: String
		label: "Added by"
		optional: true
	firstname:
		type: String
		index: true
		label: "Firstname"

	surname:
		type: String
		index: true
		label: "Surname"

	username:
		type: String
		index: true
		label: "Reso EmailId"
		
	role:
		type: String
		index: true
		label: "Role"

	location:
		type: String
		index: true
		label: "Location"

	createdAt:
		optional: true
		type: Date 
		autoValue: ->
			if this.isInsert
				new Date
			else if this.isUpsert
				setOnInsert: new Date
			else
				this.unset()

Resousers.attachSchema Schemas.Resouser








		# ...
