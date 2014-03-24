var userStore = require('musterroll-userstore-json').createUserStore({});
var musterroll_ldap = require('musterroll-ldap');
var musterroll_api = require('musterroll-api');
var express = require('express');



var ldapServer = musterroll_ldap.createServer({userStore: userStore});
ldapServer.listen(389, function() {
    console.log('LDAP server listening at ' + ldapServer.url);
});

var webServer = musterroll_api.createServer({
    userStore: userStore,
    user_store_initializer: function(username, password, userStore){

        //FIXME check spire for credentials
        var user = {
            "id":username,
            "isAdmin":true
        };
        userStore.updateUser(user);
        userStore.setPassword(user["id"], password);
    }
});
webServer.use("/", express.static(__dirname + '/public'));
webServer.listen(3000, function(){
    "use strict";
    console.log('API server listening on port 3000');
});


