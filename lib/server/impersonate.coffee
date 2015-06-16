Impersonate = 
	admins: ['admin']
	adminGroups: []

Meteor.startup ()->
	return

Meteor.methods
	impersonate: (params)->
		if !Impersonate.route? 
			throw new Meteor.Error 404, "No redirect route specified for impersonating"

		console.log "Route to impersonate: ", Impersonate.route
		
		check @userId, String
		check params, Object
		check params.toUser, String

		if params.fromUser || params.token
			check params.fromUser, String
			check params.token, String

		if Meteor.users.findOne params.toUser
			allowImpersonate = false

			if Impersonate.admins?.length?
				allowImpersonate = Roles.userIsInRole @userId, Impersonate.admins
			else
				if Impersonate.adminGroups
					i = 0
					while i < Impersonate.adminGroups.length
					  roleGroup = Impersonate.adminGroups[i]
					  allowImpersonate = Roles.userIsInRole @userId, roleGroup.role, roleGroup.group
					  if roleAllow
					    break
					  i++

			if !allowImpersonate and !params.token
				throw new Meteor.Error 403, "Permission denied. Need to be admin to impersonate."
			
			if params.token
				selector = 
					_id: params.fromUser
					"services.impersonate.token": params.token

				isValid = !!Meteor.users.findOne selector
				if !isValid
					throw new Meteor.Error 403, "Permission denied. Can't impersonate with this token."
			else
				user = Meteor.users.findOne({ _id: @userId }) || {}
				params.token = Meteor._get(user, "services", "resume", "loginTokens", 0, "hashedToken")
				
			@setUserId params.toUser
			# Set session variable to impersonating

			{ fromUser: @userId, toUser: params.toUser, token: params.token }

		else
			throw new Meteor.Error 404, "User not found. Can't impersonate nil"