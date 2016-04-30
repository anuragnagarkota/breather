#-------------------------------------------------------------#
#  Mongo Collection                                           #
#-------------------------------------------------------------# 
@Seminars = new Mongo.Collection 'seminars'

#-------------------------------------------------------------#
#  Schema Definition                                          #
#-------------------------------------------------------------#

Schemas = {}

Schemas.Seminar = new SimpleSchema
	owner:
		type: String
		index: true
	seminartopic:
		type: String
		label: "Seminar Topic"
	seminarpresentor:
		type: String
		label: "Presentor Full Name"
	seminaraddress:
		type:Object
		label: "Seminar Venue"
	"seminaraddress.addressline1":
		type: String
		label: "Address Line 1"
	"seminaraddress.addressline2":
		type: String
		label: "Address Line 2"
		optional: true
	"seminaraddress.city":
		type: String
		label: "City"
		
	"seminaraddress.state":
		type: String
		label: "State"
		allowedValues: states
	"seminaraddress.postalcode":
		type: Number
		label: "Postal Code"

	seminarcontactno:
		type: Number
		label: "Contact No."

	seminarinfo:
		type: Object
		label: "Seminar Information"

	"seminarinfo.attendees":
		type: Number
		label: "No. of Attendees"

	"seminarinfo.studentDataCollection":
		type: String
		label: "Student Data Collected"	
		allowedValues: [
			"Yes"
			"No"
		]	
		
	"seminarinfo.enquiries":
		type: Number
		label: "No. of Enquiries"
	"seminarinfo.formsold":
		type: Number
		label: "No. of Forms Sold"		

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

Seminars.attachSchema Schemas.Seminar

#-------------------------------------------------------------#
#  Meteor Allow and Deny Rule                                 #
#-------------------------------------------------------------#
Seminars.allow
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
	submitSeminar: (seminar) ->
		check seminar, Schemas.Seminar
		
		validuser = Resousers.findOne({'_id':seminar.owner})

		if validuser?
			Seminars.insert seminar
		else
			return "error"
		
		

	deleteSeminar: (id, owner) ->
		check id, String
		check owner, String

		validuser = Resousers.findOne({'_id':owner})
		validowner = Seminars.findOne({'_id':id,'owner':owner})

		if validowner? and validuser?
			Seminars.remove({'_id':id})
		else
			throw new Meteor.Error 'Authentication-Error', 'You can only delete Activities created by you'
		