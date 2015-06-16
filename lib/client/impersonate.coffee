Impersonate = 
	_user: null
	_token: null
	_active: new ReactiveVar false
	route: null

	do: (toUser, cb)->
		params =
			toUser: toUser

		if Impersonate._user
			params.fromUser = Impersonate._user
			params.token = Impersonate._token

		Meteor.call 'impersonate', params,
			(error, response)->
				if error
					console.log "Can't impersonate user: ", error
				else
					if !Impersonate._user
						Impersonate._user = response.fromUser
						Impersonate._token = response.token
					
					Impersonate._active.set true
					Meteor.connection.setUserId(response.toUser)

					Router.go Impersonate.route
				if !!(cb and cb.constructor and cb.apply)
					cb.apply @, [error, response.toUser]

	undo: (cb)->
		Impersonate.do Impersonate._user, (error, response)->
			if !error 
				Impersonate._active.set false
			if !!(cb and cb.constructor and cb.apply)
				cb.apply @, [err, res.toUser]


Template.body.events
	'click [data-impersonate]': (event, template) ->
		userId = $(event.currentTarget).attr "data-impersonate"
		Impersonate.do userId

	'click [data-unimpersonate]': (event, template)->
		Impersonate.undo()

Template.registerHelper "isImpersonating", (userId)->
	Impersonate._active.get() and userId == Impersonate._user