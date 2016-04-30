Template.pagenotfound.helpers
	notFoundMessage: () -> 
		title = 'Page Not Found'
		message = 'Seems your page does not exist - Rerouting to Home page'
		modalAlert(title,message)
		Meteor.setTimeout(()-> Router.go('home')
		3000)
		