# This is a helper function to check values of two helpers. this is the place to register this kind of functionality
Template.registerHelper 'equal', (a,b) ->
	a==b


Template.registerHelper 'counting', (a,b,c,d,e,f) ->
	a==b==c==d==e==f==0


Template.registerHelper 'titlecase', (str) ->
	toTitleCase(str)


# the root = exports ? this makes the function global. Otherwise in coffeescript it is difficult to do so
root = exports ? this

root.modalAlert = (title,message) ->
	bootbox.dialog
		title: title
		message: message
		onEscape: true
		backdrop: true
	Meteor.setTimeout(()->bootbox.hideAll()
	3000)

root.toTitleCase = (str) ->
	if str?	
	  str.replace /\w\S*/g, (txt) ->
	    txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

root.toTitleCaseObject = (obj) ->
	for key of obj
		if obj[key] == 'typeofLeaflets' or 'typeofInsertions'
			return
		else if typeof obj[key] == 'object'
			toTitleCaseObject(obj[key])
		else 
			if typeof obj[key] == 'string'
				obj[key] = toTitleCase(obj[key])
	# for key of obj
	# 	if typeof obj[key] == 'object'
	# 		toTitleCaseObject(obj[key])
	# 	else 
	# 		if typeof obj[key] == 'string'
	# 			obj[key] = toTitleCase(obj[key])	

hooksObject = {
	before: 
		method: (doc) ->
			doc.owner = Session.get 'userid'
			doc
			
	formToDoc: (doc)->
		if doc isnt undefined
			toTitleCaseObject(doc)

		# if navigator.onLine is false
		# 	title = "Connection Problems"
		# 	message = "Please check your connection"
		# 	modalAlert(title,message)
		# 	return	
		doc

	
	onSuccess: (method,result) ->
		if result is 'error'
			title = 'Authentication Error'
			message = 'Please login. Routing to Homepage'
			modalAlert(title,message)
			Meteor.setTimeout(()-> Router.go('home')
			3000)
			Session.clear()
			return

		title = 'Insertion Added'
		message = 'Thanks for your update. Routing to Homepage'
		modalAlert(title,message)
		Meteor.setTimeout(()-> Router.go('home')
		3000)
		

	onError: (method,error) ->
		if this.validationContext._invalidKeys?
			return

		title = 'Insertion Not Added'
		message = 'Seems some problem. Please contact Admin. Routing to Homepage'
		modalAlert(title,message)
		Meteor.setTimeout(()-> Router.go('home')
		3000)	
		
}

AutoForm.addHooks(['insertInsertion','insertLeaflet','insertPoint','insertSchoolvisit','insertSeminar','insertTutionclasses', 'insertResouser'],hooksObject)
			