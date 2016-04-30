#-------------------------------------------------------------#
#  Mongo Collection                                           #
#-------------------------------------------------------------# 
@Leaflets = new Mongo.Collection 'leaflets'

#-------------------------------------------------------------#
#  Schema Definition                                          #
#-------------------------------------------------------------#

Schemas = {}

Schemas.Leaflet = new SimpleSchema
	owner:
		type: String
		index: true
	typeofLeaflets:
		type: String
		label: "Type of Leaflet"
		allowedValues: modesallowedValues
		autoform: modesautoformValues

	numberOfLeaflets:
		type: Number
		label: "No. of Leaflets"
		min: 1
		max: 100000
	location:
		type: String
		label: "Leaflet City/Town"

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

Leaflets.attachSchema Schemas.Leaflet

#-------------------------------------------------------------#
#  Meteor Allow and Deny Rule                                 #
#-------------------------------------------------------------#
Leaflets.allow
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
	submitLeaflet: (leaflet) ->
		check leaflet, Schemas.Leaflet
		
		validuser = Resousers.findOne({'_id':leaflet.owner})

		if validuser?
			Leaflets.insert leaflet
		else
			return "error"	

	deleteLeaflet: (id, owner) ->
		check id, String
		check owner, String

		validuser = Resousers.findOne({'_id':owner})
		validowner = Leaflets.findOne({'_id':id,'owner':owner})

		if validowner? and validuser?
			Leaflets.remove({'_id':id})
		else
			throw new Meteor.Error 'Authentication-Error', 'You can only delete Activities created by you'
			

			