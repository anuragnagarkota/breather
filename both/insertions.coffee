#-------------------------------------------------------------#
#  Mongo Collection                                           #
#-------------------------------------------------------------# 
@Insertions = new Mongo.Collection 'insertions'

#-------------------------------------------------------------#
#  Schema Definition                                          #
#-------------------------------------------------------------#

Schemas = {}

Schemas.Insertion = new SimpleSchema
	owner:
		type: String
		index: true

	typeofInsertions:
		type: String
		label: "Type of Insertion"
		allowedValues: modesallowedValues
		autoform: modesautoformValues

	numberOfInsertions:
		type: Number
		label: "No. of Insertions"
		min: 1
		max: 100000

	location:
		type: String
		label: "Insertion City/Town"

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

Insertions.attachSchema Schemas.Insertion

#-------------------------------------------------------------#
#  Meteor Allow and Deny Rule                                 #
#-------------------------------------------------------------#
Insertions.allow
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
	submitInsertion: (insertion) ->
		check insertion, Schemas.Insertion
		
		validuser = Resousers.findOne({'_id':insertion.owner})
		
		if validuser?
			Insertions.insert insertion
		else
			return "error"


	deleteInsertion: (id,owner) ->
		check id, String
		check owner, String

		validuser = Resousers.findOne({'_id':owner})
		validowner = Insertions.findOne({'_id':id,'owner':owner})

		if validowner? and validuser?
			Insertions.remove({'_id':id})
		else
			throw new Meteor.Error 'Authentication-Error', 'You can only delete Activities created by you'













			