/**
 * Created by doublemalt on 12/3/13.
 */
var app = angular.module('cockpit', ['ngResource', 'xeditable']);

app.run(function(editableOptions) {
    editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});

angular.module('cockpit').controller('CockpitCtrl', function ($scope, $http) {

    $scope.isAdmin = true;

    $scope.refreshCurrentUser = function()
    {
        "use strict";
        $http.get("/api/v1/currentUser").success(function(data){
            $scope.currentUser = data;
            console.log(data);
        });
    };
    $scope.refreshCurrentUser();

    $scope.login = function(){
        $http({
            method: 'POST',
            url: '/login',
            data: $.param({
                'username': $scope.username,
                'password': $scope.password
            }),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        }).success(function ()
            {
                $scope.refreshCurrentUser();
            });
    };

});

angular.module('cockpit').controller('UserCtrl', function ($scope, $http, $resource) {
    var usersCollection = $resource("/api/v1/users/");
    var usersResource = $resource("/api/v1/users/:id", {id: '@id'});

    $scope.users = usersCollection.query(function(){});
    $scope.newUserId = "";

    $scope.addUser = function() {
        var newUser = {id:$scope.newUserId, firstName:"", lastName:"", isAdmin: false};
        usersResource.save(newUser);
        $scope.users.push(newUser);
        $scope.newUserId = "";
    };

    $scope.saveUser = function(data, user) {
        //$scope.user not updated yet
        angular.extend(user, data);
        return usersResource.save(user);
    };

});

