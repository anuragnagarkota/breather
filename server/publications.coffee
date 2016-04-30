Meteor.publish 'resousers', (user) ->
	if user?
		check user, String
		return Resousers.find({'username':user})
	else
		check user, null
		return false

Meteor.publish 'allresousers', () -> Resousers.find()		
	
Meteor.publish "activities", (owner) ->
	if owner?
		check owner, String
		return [
			Insertions.find({owner:owner}),
			Leaflets.find({owner:owner}),
			Points.find({owner:owner}),
			Schoolvisits.find({owner:owner}),
			Seminars.find({owner:owner}),
			Tutionclasses.find({owner:owner})
		]
	else
	 	check owner, null 
		return false	

