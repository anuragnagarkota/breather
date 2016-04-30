Template.admin.events
	'click .arrow-icon': (e, Template) ->
		$('.admin-sidebar').toggleClass('admin-sidebar-open')
		$('.arrow-icon i').toggleClass('arrow-icon-rotate')
		$('.admin-side-container').toggleClass('admin-side-container-push')

	'click .addmember': (e, Template) ->
		e.preventDefault()
		
		$('.admin-sidebar').toggleClass('admin-sidebar-open')
		$('.arrow-icon i').toggleClass('arrow-icon-rotate')
		$('.admin-side-container').toggleClass('admin-side-container-push')
		Router.go('addmember')
	
Template.addmember.events
	'click .arrow-icon': (e,Template) ->
		$('.admin-sidebar').toggleClass('admin-sidebar-open')
		$('.arrow-icon i').toggleClass('arrow-icon-rotate')
		$('.admin-side-container').toggleClass('admin-side-container-push')