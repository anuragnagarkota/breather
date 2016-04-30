Tracker.autorun () -> 
	if Session.get('username')
		Meteor.subscribe 'resousers', Session.get('username'), ->
			logger = Resousers.findOne({username: Session.get('username')})
			if logger?
				userid = logger._id
			else 
				userid = ""

			if userid
				Session.setPersistent 'userid', userid
				Router.go('home')
			else
				Session.update 'signin', false
				$('#emailid').val('')
				$('#password').val('')
				title = 'User Team Error'
				message = 'Please ask your manager to add you to the Application'
				modalAlert(title,message)

			if logger.role is "admin"
				Meteor.subscribe 'allresousers'	

	

