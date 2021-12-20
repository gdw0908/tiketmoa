<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html data-ng-app="MyApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>파츠모아 통합관리 시스템</title>
<link href="/lib/css/cmsbase.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/cmsadmin.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/lib/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.form.js"></script>
<script type="text/javascript" src="/lib/js/angular.min.js"></script>
<script type="text/javascript" src="/lib/js/angular-route.min.js"></script>
<script type="text/javascript" src="/lib/js/filters/myFilter.js"></script>
<script type="text/javascript" src="/lib/js/filters/ngRange.js"></script>
<script type="text/javascript" src="/lib/js/services/myCommon.js"></script>
<script type="text/javascript" src="/lib/js/services/dialog-service.js"></script>
<script type="text/javascript" src="/lib/js/directives/myUtil.js"></script>
<script type="text/javascript" src="/lib/js/directives/myPagination.js"></script>
<script type="text/javascript" src="/lib/js/directives/sortable.js"></script>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/lib/js/directives/myNmap.js"></script>
<script type="text/javascript" src="/lib/js/directives/myEditor.js"></script>
<script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=<spring:eval expression="@config['navar.map.key']" />"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myFilter', 'myPagination', 'myCommon', 'ui.sortable', 'myNmap', 'myEditor']);

app.run(function($rootScope){
	var sinceYear = 2015;
	var nowYear = $.datepicker.formatDate('yy', new Date());
	var nowMonth = $.datepicker.formatDate('mm', new Date());
	var Years = [];
	for(var i=sinceYear;i<=nowYear;i++) {
		Years.push(i);
	}
	$rootScope.param = {
		now_date : $.datepicker.formatDate('yymm', new Date()),
		yy : nowYear,
		mm : nowMonth,
		Year : Years,
		select_date : nowYear+nowMonth
	};
	$rootScope.main = {};
});

app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
	$routeProvider
		.when('/list', {controller: 'listCtrl', templateUrl : 'list.do'})
		.when('/write', {controller: 'writeCtrl', templateUrl : 'write.do'})
		.otherwise({redirectTo: '/list' });
}]);
app.controller("mainCtrl", function($scope, $location, $window, ajaxService) {
	$scope.list = function(){
		$location.path("/list");
	}
});

app.controller("listCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getJSON('/admin/system/send/sms/index.do?mode=list&cpage='+n, {jData : JSON.stringify($scope.param)}, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.page_info.totalcount;
			$scope.board.totalPage = data.page_info.totalpage;
		});
	};
	$scope.search = function(){
		var n = parseInt($scope.param.now_date);
		var s = parseInt($scope.param.yy+$scope.param.mm);
		if(n < s){
			alert("현재 년월보다 높게 설정되었습니다.");
			return false;
		}else{
			$scope.param.select_date = $scope.param.yy+$scope.param.mm;
			$scope.board.go(1);
		}
	}
});

app.controller("writeCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	$scope.form = {};
	$scope.save = function(){
		if($scope.frm.$invalid){
			if($scope.frm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		ajaxService.getJSON("/admin/system/send/sms/index.do?mode=sms_write", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}
});
</script>
</head>
<body data-ng-controller="mainCtrl">
  <div data-ng-view data-ng-cloak></div>
</body>
</html>
