##Meteor Impersonate##
Impersonating a user as an Admin

This package was written with inspiration from meteor add [gwendall:impersonate](https://github.com/gwendall/meteor-impersonate) . With a big appreciation to the code base.

With some improvements

## Installation ##

```shell
meteor add philip100:impersonate
```

##Configuration ##
You'd need to configure the

You'd need to tell impersonate the route to move to and start impersonating. This is suggested to be the path to the users dashboard.

```javascript
/** both  **/
// example
Impersonate.route = 'dashboard';

```

### Server ###
By default impersonate grants users in the 'admin' group through alanning the ability to impersonate users. You can also set any of the following to define you own impersonation roles.

* User Role
```javascript
Impersonate.admins = ['masters', 'su'];

```

* User Group
```javascript
Impersonate.adminGroups = [
	{role: 'masters', group: 'A'},
	{role: 'su', group: 'B'}
];
```


### Client ###

###TODO###


###Note###
__And that's it! Simply hit refresh or manually change the URL to stop impersonating.__

### Server ###