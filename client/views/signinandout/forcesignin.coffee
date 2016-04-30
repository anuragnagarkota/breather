Template.forcesignin.onRendered () ->
	# Session.clear()
	# Session.set 'username', ""


Template.forcesignin.events
	'click .signin': (e, Template) ->
		e.preventDefault()
		useremail = Template.$('#emailid').val()
		password = Template.$('#password').val()
		user = useremail.replace("@resonance.ac.in","").toLowerCase()

		if user and password
			Session.setPersistent 'signin', true

			Meteor.call "authenticate", user, password, (error, result) -> 
				if error
					# console.log result
				else
					if result.AuthenticateUserResult.Result
						Session.setPersistent 'username', user
					else
						Session.update 'signin', false
						$('#emailid').val('')
						$('#password').val('')
						title = 'User Authentication Error'
						message = 'Your Email and password combination is incorrect'
						modalAlert(title,message)
				
		else
			title = 'User Signin Error'
			message = 'Please enter user and password'
			modalAlert(title,message)
			