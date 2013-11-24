(function() {
  var DearyApp;

  DearyApp = angular.module('DearyApp', []);

  DearyApp.config([
    '$httpProvider', function($httpProvider) {
      var httpMethod, unindempotentMethods, _i, _len, _results;
      unindempotentMethods = ['post', 'patch', 'put', 'delete'];
      _results = [];
      for (_i = 0, _len = unindempotentMethods.length; _i < _len; _i++) {
        httpMethod = unindempotentMethods[_i];
        _results.push($httpProvider.defaults.headers[httpMethod] = {
          'X-From': window.location.origin
        });
      }
      return _results;
    }
  ]);

  DearyApp.controller('HubCtrl', [
    '$scope', function($scope) {
      return $scope.showNewEntry = false;
    }
  ]);

  DearyApp.controller('SessionCtrl', [
    '$scope', '$http', function($scope, $http) {
      $scope.logout = function() {
        if (confirm('Logout?')) {
          return $http({
            method: 'DELETE',
            url: '/-/sessions'
          }).success(function() {
            return window.location.pathname = '/';
          });
        }
      };
      return $scope.login = function(user) {
        return $http({
          method: 'POST',
          url: '/-/sessions',
          data: user,
          headers: {
            'Content-Type': 'application/json'
          }
        }).success(function() {
          return window.location.pathname = '/';
        }).error(function() {
          return $scope.loginForm.$error.invalidAuthentication = true;
        });
      };
    }
  ]);

  DearyApp.controller('EditEntryCtrl', [
    '$scope', '$http', function($scope, $http) {
      $scope.showEditor = false;
      $scope.edit = function(path) {
        return $http.get("" + path + ".json").success(function(data) {
          $scope.entry = data;
          $scope.path = path;
          return $scope.showEditor = true;
        });
      };
      return $scope.save = function(entry) {
        return $http({
          method: 'PATCH',
          url: $scope.path,
          data: entry,
          headers: {
            'Content-Type': 'application/json'
          }
        }).success(function() {
          return window.location.reload();
        });
      };
    }
  ]);

  DearyApp.controller('NewEntryCtrl', [
    '$scope', '$http', function($scope, $http) {
      $scope.$watch("$parent.showNewEntry", function(val) {
        return $scope.showEditor = val;
      });
      $scope.$watch("showEditor", function(val) {
        return $scope.$parent.showNewEntry = val;
      });
      $scope.showEditor = false;
      $scope.path = '/-/entries';
      $scope.edit = function() {
        return $scope.showEditor = true;
      };
      return $scope.save = function(entry) {
        return $http({
          method: 'POST',
          url: $scope.path,
          data: entry,
          headers: {
            'Content-Type': 'application/json'
          }
        }).success(function() {
          return window.location.reload();
        });
      };
    }
  ]);

}).call(this);
