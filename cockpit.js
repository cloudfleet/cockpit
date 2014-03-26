var user_store_json = require('musterroll-userstore-json');
var musterroll_ldap = require('musterroll-ldap');
var musterroll_api = require('musterroll-api');
var express = require('express');
var http = require('http');
var request = require('request');

var userStore = user_store_json.createUserStore({});

var ldapServer = musterroll_ldap.createServer({userStore: userStore});
ldapServer.listen(1389, function() {
    console.log('LDAP server listening at ' + ldapServer.url);
});

var webServer = musterroll_api.createServer({
    userStore: userStore,
    user_store_initializer: function(username, password, userStore, callback, error_callback){

        var success = function() {
            var user = {
                "id":username,
                "isAdmin":true
            };
            userStore.updateUser(user);
            userStore.setPassword(user["id"], password);
            callback(user);
        };
        var failure = error_callback;

        request.post(
            "https://cloudfleet.herokuapp.com/auth/",
            {
                form: {
                    username: username,
                    password: password
                }
            },
            function(err, resp, body) {
                console.log(body);
                if(!err && JSON.parse(body).authenticated)
                {
                    success();
                }
                else
                {

                    console.log(JSON.stringify(err));
                    failure();
                }
            }
        );


    }
});
webServer.use("/", express.static(__dirname + '/public'));
webServer.listen(3000, function(){
    "use strict";
    console.log('API server listening on port 3000');
});


