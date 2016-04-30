Template.navigationbar.helpers
	ResoUser: () -> Resousers.findOne({"_id": Session.get 'userid'})
	Storageuser: () -> Session.get 'userid'
		# ...
Template.navigationbar.events
	'click .signout': (e,Template) ->
		e.preventDefault()
		Session.clear()
		title = 'Successful Logout'
		message = 'You are logged Out'
		modalAlert(title, message)
			
		# ...


Template.invaliduser.onRendered () ->
	console.log 'invaliduser render'
	console.log Session.clear()
	


	