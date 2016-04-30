Meteor.methods
	authenticate: (user,password) ->
		check user, String
		check password, String
		url = 'http://mail.resonance.ac.in/Services/svcUserAdmin.asmx?WSDL'
		args = {
			UserName: user
			DomainName: 'mail.resonance.ac.in'
			Password: password
		}

		try
			client = Soap.createClient(url)
			result = client.AuthenticateUser(args)
			result
		catch err
			console.log err
			if err.error is 'soap-creation'
				return 'SOAP Client creation failed'
			else if err.error is 'soap-method'
				return 'SOAP Method call failed'	
			# ...
	


		