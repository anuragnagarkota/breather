Router.configure
	layoutTemplate: 'applicationLayout'
	loadingTemplate: 'applicationLoadingLayout'

requireLogin = -> 
		validUser = Session.get 'userid'
		loggingin = Session.get 'signin'

		if validUser is false
			loggingin = false

		if loggingin 
			if validUser
				@next() # this was very important to remove the warning message
			else 
				@render('applicationLoadingLayout')	
		else
			@render('forcesignin')


Router.route('/',{
	name: 'home'
	path: '/'
	template: 'home'
})

Router.route('/signin', {
	name: 'signin'
	path: '/signin'
	template: 'forcesignin'
})

Router.route('/insertion',{
	name: 'insertion'
	path: '/insertion'
	tempalte: 'insertion'

})

Router.route('/leaflet',{
	name: 'leaflet'
	path: '/leaflet'
	tempalte: 'leaflet'

})

Router.route('/school-visit',{
	name: 'schoolVisit'
	path: '/school-visit'
	tempalte: 'schoolVisit'

})

Router.route('/seminar',{
	name: 'seminar'
	path: '/seminar'
	tempalte: 'seminar'

})

Router.route('/point-of-sale',{
	name: 'pointOfSale'
	path: '/point-of-sale'
	tempalte: 'pointOfSale'

})


Router.route('/tution-class',{
	name: 'tutionClass'
	path: '/tution-class'
	tempalte: 'tutionClass'

})

Router.route('/dashboard',{
	name: 'dashboard'
	path: '/dashboard'
	tempalte: 'dashboard'

})

Router.route('/activities/:date',{
	name: 'activities'
	path: '/activities/:date'
	template: 'activities'
	data: () -> date = @params.date
	waitOn: () -> Meteor.subscribe('activities', Session.get 'userid')
})



Router.route('/admin', {
	name: 'admin'
	path: '/admin'
	template: 'admin'
})

Router.route('/admin/addmember',{
	name: 'addmember'
	path: '/admin/addmember'
	template: 'addmember'
})

Router.route('activities/point-of-sale/:_id',{
	name: 'pointactivity'
	path: 'activities/point-of-sale/:_id'
	template: 'pointactivity'
	data: () -> Points.findOne({'_id': @params._id})
	waitOn: () -> Meteor.subscribe('activities', Session.get 'userid')
})

Router.route('activities/school-visit/:_id',{
	name: 'schoolvisitactivity'
	path: 'activities/school-visit/:_id'
	template: 'schoolvisitactivity'
	data: () -> Schoolvisits.findOne({'_id': @params._id})
	waitOn: () -> Meteor.subscribe('activities', Session.get 'userid')
})

Router.route('activities/seminar/:_id',{
	name: 'seminaractivity'
	path: 'activities/seminar/:_id'
	template: 'seminaractivity'
	data: () -> Seminars.findOne({'_id': @params._id})
	waitOn: () -> Meteor.subscribe('activities', Session.get 'userid')
})

Router.route('activities/tution-class/:_id',{
	name: 'tutionactivity'
	path: 'activities/tution-class/:_id'
	template: 'tutionactivity'
	data: () -> Tutionclasses.findOne({'_id': @params._id})
	waitOn: () -> Meteor.subscribe('activities', Session.get 'userid')
})



# Plugin for routes which should not be there applicable for data
Router.plugin('dataNotFound', {notFoundTemplate: 'pagenotfound'})

# route for the remaining
Router.route('/(.*)', () ->
	@render('pagenotfound')
	@next()
) 

Router.onBeforeAction(requireLogin)
