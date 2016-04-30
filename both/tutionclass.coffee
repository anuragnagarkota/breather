#-------------------------------------------------------------#
#  Mongo Collection                                           #
#-------------------------------------------------------------# 
@Tutionclasses = new Mongo.Collection 'tutionclasses'

#-------------------------------------------------------------#
#  Schema Definition                                          #
#-------------------------------------------------------------#

Schemas = {}

Schemas.Tutionclass = new SimpleSchema
	owner:
		type: String
		index: true

	institute:
		type: Object
		label: "Institute Information"
	"institute.name":
		type: String
		label: "Institute Name"	
	"institute.stream":
		type: String
		label: "Streams"
		allowedValues: streams
	"institute.classes":
		type: String
		label: "Classes"
		allowedValues: classes
	"institute.email":
		type: String
		regEx: SimpleSchema.RegEx.Email
		label: "Email"			
	"institute.contactno":
		type: Number
		label: "Contact No."
	"institute.city":
		type: String
		label: "City/Town"	

	ownerinfo:
		type: Object
		label: "Owner Information"
		optional: true
	"ownerinfo.name":
		type: String
		label: "Institute Owner Name"	
		optional: true
	"ownerinfo.owneremail":
		type: String
		regEx: SimpleSchema.RegEx.Email
		label: "Owner's Email"
		optional: true

	contactperson:
		type: Object
		label: "Contact Person"
	"contactperson.name":
		type: String
		label: "Full Name"
	"contactperson.email":
		type: String
		regEx: SimpleSchema.RegEx.Email
		label: "Email"
	"contactperson.contactno":
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

Tutionclasses.attachSchema Schemas.Tutionclass

#-------------------------------------------------------------#
#  Meteor Allow and Deny Rule                                 #
#-------------------------------------------------------------#
Tutionclasses.allow
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
	submitTutionclass: (tutionclass) ->
		check tutionclass, Schemas.Tutionclass
		
		validuser = Resousers.findOne({'_id':tutionclass.owner})

		if validuser?
			Tutionclasses.insert tutionclass
		else
			return "error"

	deleteTutionclass: (id, owner) ->
		check id, String
		check owner, String

		validuser = Resousers.findOne({'_id':owner})
		validowner = Tutionclasses.findOne({'_id':id,'owner':owner})

		if validowner? and validuser?
			Tutionclasses.remove({'_id':id})
		else
			throw new Meteor.Error 'Authentication-Error', 'You can only delete Activities created by you'
			

			