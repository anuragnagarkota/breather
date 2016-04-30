#-------------------------------------------------------------#
#  Mongo Collection                                           #
#-------------------------------------------------------------# 
@Schoolvisits = new Mongo.Collection 'schoolvisits'

#-------------------------------------------------------------#
#  Schema Definition                                          #
#-------------------------------------------------------------#

Schemas = {}

Schemas.Schoolvisit = new SimpleSchema
	owner:
		type: String
		index: true
	school:
		type: Object
		label: "School Information"
	"school.name":
		type: String
		label: "School Name"	
	"school.address":
		type: Object
		label: "Address"
	"school.address.addressline1":
		type: String
		label: "Address Line 1"
	"school.address.addressline2":
		type: String
		label: "Address Line 2"
		optional: true
	"school.address.city":
		type: String
		label: "City"
		
	"school.address.state":
		type: String
		label: "State"
		allowedValues: states
	"school.address.postalcode":
		type: Number
		label: "Postal Code"

		

	"school.email":
		type: String
		regEx: SimpleSchema.RegEx.Email
		label: "Email"

	"school.contactno":
		type: Number
		label: "Contact No."

	"school.enrolledstart":
		type: String
		label: "Enrolled in Start"
		allowedValues: [
			"Yes"
			"No"
		]

	principal:
		type: Object
		label: "Principal Information"
	"principal.name":
		type: String
		label: "Principal Full Name"
		max: 100
	"principal.email":
		type: String
		regEx: SimpleSchema.RegEx.Email
		label: "Email"
	"principal.contactno":
		type: Number
		label: "Contact No."

	coordinator:
		type: Object
		label: "Coordinator Information"
	"coordinator.name":
		type: String
		label: "Coordinator Full Name"
	"coordinator.email":
		type: String
		regEx: SimpleSchema.RegEx.Email
		label: "Email"
	"coordinator.contactno":
		type: Number
		label: "Contact No."


	createdAt:
		type: Date
		index:true
		optional: true
		autoValue: ->
			if this.isInsert
				new Date
			else if this.isUpsert
				setOnInsert: new Date
			else
				this.unset()

Schoolvisits.attachSchema Schemas.Schoolvisit

#-------------------------------------------------------------#
#  Meteor Allow and Deny Rule                                 #
#-------------------------------------------------------------#
Schoolvisits.allow
	insert: (userId, doc) ->
		doc and doc.owner = userId
		# ...
	update: (userId, doc, fields, modifier) ->
		doc and doc.owner = userId
		# ...
	remove: (userId, doc) ->
		doc and doc.owner = userId
		# ...
	
#-------------------------------------------------------------#
#  Meteor Methods                                             #
#-------------------------------------------------------------#

Meteor.methods
	submitSchoolvisit: (schoolvisit) ->
		
		check schoolvisit, Schemas.Schoolvisit

		validuser = Resousers.findOne({'_id':schoolvisit.owner})

		if validuser?
			Schoolvisits.insert schoolvisit
		else
			return "error"
		
		

	deleteSchoolvisit: (id, owner) ->
		check id, String
		check owner, String

		validuser = Resousers.findOne({'_id':owner})
		validowner = Schoolvisits.findOne({'_id':id,'owner':owner})

		if validowner? and validuser?
			Schoolvisits.remove({'_id':id})	
		else
			throw new Meteor.Error 'Authentication-Error', 'You can only delete Activities owned by you'
		

			