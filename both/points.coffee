#-------------------------------------------------------------#
#  Mongo Collection                                           #
#-------------------------------------------------------------# 
@Points = new Mongo.Collection 'points'

#-------------------------------------------------------------#
#  Schema Definition                                          #
#-------------------------------------------------------------#

Schemas = {}

Schemas.Point = new SimpleSchema
	owner:
		type: String
		index: true
	
	name:
		type: String
		index: true
		label: "Full Name"
		max: 100

	address:
		type: Object
		label: "Address"

	"address.addressline1":
		type: String
		label: "Address Line 1"

	"address.addressline2":
		type: String
		optional: true
		label: "Address Line 2"

	"address.city":
		type: String
		label: "City"

	"address.state":
		type: String
		label: "State"
		allowedValues: states

	"address.postalcode":
		type: Number
		label: "Postal Code"
		optional: true

	org:
		type: Object
		label: "Organization"	
		optional: true

	"org.orgname":
		type: String
		label:"Organization Name"
		optional: true

	"org.contactno":
		type: Number
		label: "Contact Number"
		optional: true 
						

	"org.contactemail":
		type: String
		regEx: SimpleSchema.RegEx.Email
		label: "Contact Email"
		optional: true

	"org.location":
		type: String
		label: "City/Town"
		optional: true
		
	form:
		type: Object
		label: "Forms"	

	"form.formsgiven":
		type: String
		label: "Forms Given"
		allowedValues: [
			"Chargeable"
			"Free Of Cost"
		]

	"form.formquantity":
		type: Number
		label: "Quantity"
		min: 1
		max: 100000				
		
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

Points.attachSchema Schemas.Point

#-------------------------------------------------------------#
#  Meteor Allow and Deny Rule                                 #
#-------------------------------------------------------------#
Points.allow
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
	submitPoint: (point) ->
		check point, Schemas.Point

		validuser = Resousers.findOne({'_id':point.owner})

		if validuser?
			Points.insert point
		else
			return "error"
	
	deletePoint: (id, owner) ->
		check id, String
		check owner, String

		validuser = Resousers.findOne({'_id':owner})
		validowner = Points.findOne({'_id':id,'owner':owner})

		if validowner? and validuser?
			Points.remove({'_id':id})
		else
			throw new Meteor.Error 'Authentication-Error', 'You can only delete Activities created by you'
		
			