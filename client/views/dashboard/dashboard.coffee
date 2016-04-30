Template.dashboard.onRendered () ->
    $('.show-calendar').hide()
    $('#datetimepicker12').datetimepicker({
        inline: true
        useCurrent: false
        format: "DD.MM.YYYY"
        extraFormats: [ 'DD.MM.YY' ]
    }).on('dp.change', (e) ->
            d = e.date._d
            date = moment(d).format('DD-MM-YYYY')
            d_starttime = moment(d).toJSON()
            d_endtime = moment(d).add(1,'d').subtract(1,'ms').toJSON()
            $('#datetimepicker12').datetimepicker().hide()
            Session.set 'ownerid', Session.get 'userid' 
            Session.set 'sdatevalue', d_starttime
            Session.set 'edatevalue', d_endtime
            Router.go('activities','date': date)
        )

Template.activities.helpers
    Insertion : () -> Insertions.find({
        owner: Session.get 'ownerid'
        createdAt:{
                "$gte" : new Date(Session.get 'sdatevalue') 
                "$lte" : new Date(Session.get 'edatevalue')
        }
    })

    Leaflet : () -> Leaflets.find({
        owner: Session.get 'ownerid'
        createdAt:{
                "$gte" : new Date(Session.get 'sdatevalue') 
                "$lte" : new Date(Session.get 'edatevalue')
        }
    })

    Point : () -> Points.find({
        owner: Session.get 'ownerid'
        createdAt:{
                "$gte" : new Date(Session.get 'sdatevalue') 
                "$lte" : new Date(Session.get 'edatevalue')
        }
    })

    Schoolvisit: () -> Schoolvisits.find({
        owner: Session.get 'ownerid'
        createdAt:{
                "$gte" : new Date(Session.get 'sdatevalue') 
                "$lte" : new Date(Session.get 'edatevalue')
        }
    })
    Seminar: () -> Seminars.find({
        owner: Session.get 'ownerid'
        createdAt:{
                "$gte" : new Date(Session.get 'sdatevalue') 
                "$lte" : new Date(Session.get 'edatevalue')
        }
    })
    Tutionclass: () -> Tutionclasses.find({
        owner: Session.get 'ownerid'
        createdAt:{
                "$gte" : new Date(Session.get 'sdatevalue') 
                "$lte" : new Date(Session.get 'edatevalue')
        }
    })

    currentDate: () -> moment().format('DD-MM-YYYY')
        


Template.activities.events
    'click .deleteInsertion': (e, Template) ->
        e.preventDefault()
        if @owner is Session.get 'userid'
            Meteor.call 'deleteInsertion', @_id, @owner, (error, result) ->
                if error and error.error is 'Authentication-Error'
                    title = error.error
                    message = error.reason
                    modalAlert(title,message)
                else if error
                    title = 'Deletion Error'
                    message = 'The Activity is not deleted. Please contact admin'
                    modalAlert(title,message)
        else
            title = 'Authentication Error'
            message = 'You can only delete Activities created by you'
            modalAlert(title,message)

    'click .deleteLeaflet': (e, Template) ->
        e.preventDefault()
        if @owner is Session.get 'userid'
            Meteor.call 'deleteLeaflet', @_id, @owner, (error, result) ->
                if error and error.error is 'Authentication-Error'
                    title = error.error
                    message = error.reason
                    modalAlert(title,message)
                else if error
                    title = 'Deletion Error'
                    message = 'The Activity is not deleted. Please contact admin'
                    modalAlert(title,message)
        else
            title = 'Authentication Error'
            message = 'You can only delete Activities created by you'
            modalAlert(title,message)

    'click .deletePoint': (e, Template) ->
        e.preventDefault()
        if @owner is Session.get 'userid'
            Meteor.call 'deletePoint', @_id, @owner, (error, result) ->
                if error and error.error is 'Authentication-Error'
                    title = error.error
                    message = error.reason
                    modalAlert(title,message)
                else if error
                    title = 'Deletion Error'
                    message = 'The Activity is not deleted. Please contact admin'
                    modalAlert(title,message)
        else
            title = 'Authentication Error'
            message = 'You can only delete Activities created by you'
            modalAlert(title,message)
     

    'click .deleteSchoolvisit': (e, Template) ->
        e.preventDefault()
        if @owner is Session.get 'userid'
            Meteor.call 'deleteSchoolvisit', @_id, @owner, (error, result) ->
                if error and error.error is 'Authentication-Error'
                    title = error.error
                    message = error.reason
                    modalAlert(title,message)
                else if error
                    title = 'Deletion Error'
                    message = 'The Activity is not deleted. Please contact admin'
                    modalAlert(title,message)

        else
            title = 'Authentication Error'
            message = 'You can only delete Activities created by you'
            modalAlert(title,message)
    

    'click .deleteSeminar': (e, Template) ->
        e.preventDefault()
        if @owner is Session.get 'userid'
            Meteor.call 'deleteSeminar', @_id, @owner, (error, result) ->
                if error and error.error is 'Authentication-Error'
                    title = error.error
                    message = error.reason
                    modalAlert(title,message)
                else if error
                    title = 'Deletion Error'
                    message = 'The Activity is not deleted. Please contact admin'
                    modalAlert(title,message)
        else
            title = 'Authentication Error'
            message = 'You can only delete Activities created by you'
            modalAlert(title,message)
             

    'click .deleteTutionclass': (e, Template) ->
        e.preventDefault()
        if @owner is Session.get 'userid'
            Meteor.call 'deleteTutionclass', @_id, @owner, (error, result) ->
                if error and error.error is 'Authentication-Error'
                    title = error.error
                    message = error.reason
                    modalAlert(title,message)
                else if error
                    title = 'Deletion Error'
                    message = 'The Activity is not deleted. Please contact admin'
                    modalAlert(title,message)
        else
            title = 'Authentication Error'
            message = 'You can only delete Activities created by you'
            modalAlert(title,message)                 


Template.pointactivity.events
    'click .backtoactivity': () ->
        d = moment(@.createdAt).format('DD-MM-YYYY')
        Router.go('activities','date': d)
                        
        
Template.schoolvisitactivity.events
    'click .backtoactivity': () ->
        d = moment(@.createdAt).format('DD-MM-YYYY')
        Router.go('activities','date': d)

Template.seminaractivity.events
    'click .backtoactivity': () ->
        d = moment(@.createdAt).format('DD-MM-YYYY')
        Router.go('activities','date': d)

Template.tutionactivity.events
    'click .backtoactivity': () ->
        d = moment(@.createdAt).format('DD-MM-YYYY')
        Router.go('activities','date': d)        



