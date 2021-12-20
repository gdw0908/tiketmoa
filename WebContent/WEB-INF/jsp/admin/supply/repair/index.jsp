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
	$rootScope.param = {
	};
	$rootScope.main = {};
});
app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
	$routeProvider
		.when('/list', {controller: 'listCtrl', templateUrl : 'list.do'})
		.when('/write', {controller: 'writeCtrl', templateUrl : 'write.do'})
		.when('/modify/:seq', {controller: 'modifyCtrl', templateUrl : 'modify.do'})
		.otherwise({redirectTo: '/list' });
}]);
app.controller("mainCtrl", function($scope, $location, $window, ajaxService) {
	ajaxService.getAsyncJSON("/json/list/code.codeList.do", {code_group_seq : '5'}, function(data){
		$scope.main.tel1 = data;
	});
	$scope.main.openAddr = function(){
		var param = "";
		if(arguments[0]){
			param = "?fun="+arguments[0];
		}
		$window.open("/addr/road.jsp"+param,"addr","width=570,height=420");
	}
	$scope.list = function(){
		$location.path("/list");
	}
});
app.controller("listCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.param.cpage = $scope.param.cpage||1;
	$scope.board = {};
	$scope.board.go = function(n){
		$scope.param.cpage=n;
		ajaxService.getJSON('/json/list/repair.list.do?cpage='+n, $scope.param, function(data){
			$scope.board.list = data;
		});
		ajaxService.getJSON('/json/request/repair.pagination.do', $scope.param, function(data){
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.totalcount;
			$scope.board.totalPage = data.totalpage;
		});
	};
	$scope.del = function(item){
		if(!confirm("정말 하시겠습니까?")){
			return false;
		}
		ajaxService.getJSON("/admin/supply/repair/index.do?mode=del", item, function(data){
			if(data.rst == '1'){
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
});
app.controller("writeCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {
		x_coord : "126.8150584",
		y_coord : "37.6920599"
	};
	
	ajaxService.getAsyncJSON("/json/list/repair.cooperationList.do", {}, function(data){
		$scope.cooperationList = data;
		$scope.form.parent_seq = data[0].seq;
	});
	
	ajaxService.getAsyncJSON("/json/list/code.sido.do", {}, function(data){
		$scope.sido = data;
		$scope.changeSido();
	});
	$scope.changeSido = function(){
		$scope.form.sigungu_cd="";
		ajaxService.getAsyncJSON("/json/list/code.sigungu.do", {sido : $scope.form.sido_cd}, function(data){
			$scope.sigungu = data;
			$scope.changeSigungu();
		});
	}
	$scope.changeSigungu = function(){
		$scope.form.dong_cd="";
		ajaxService.getAsyncJSON("/json/list/code.dong.do", {sido : $scope.form.sido_cd, sigungu : $scope.form.sigungu_cd}, function(data){
			$scope.dong = data;
		});
	}
	
	$window.setAddr = function(roadAddrPart1, addrDetail, zipNo, jibunAddr) {
		var zip = zipNo.split("-");
		$scope.$apply(function(){
			$scope.form.zip1 = zip[0];
			$scope.form.zip2 = zip[1];
			$scope.form.addr1 = jibunAddr;
			$scope.form.addr2 = addrDetail;
		});
		$scope.mapUpdate(jibunAddr);
    }
	
	$scope.mapUpdate = function(jibun){
		if(!jibun){
			return false;
		}
		ajaxService.getXML("/addr/AjaxRequestXML.jsp", {"getUrl" : "http://openapi.map.naver.com/api/geocode.php?key=<spring:eval expression="@config['navar.map.key']" />&encoding=utf-8&coord=LatLng&query=" + encodeURI(jibun)}, function(data){
			var xml = $(data);
			var x = xml.find("x");
			var y = xml.find("y");
			if(x.length == 0){
				alert("선택한 주소에 대한 좌표가 존재하지 않습니다.");
				return;
			}
			$scope.form.x_coord = $(x[0]).text();
			$scope.form.y_coord = $(y[0]).text();
			$scope.$broadcast("updatePosition", $scope.form);
		});
	}
	
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
		
		ajaxService.getJSON("/admin/supply/repair/index.do?mode=write", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}
});
app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {};
	ajaxService.getJSON("/admin/supply/repair/index.do?mode=view", {seq : $routeParams.seq}, function(data){
		$scope.form = data.view;
	});
	
	ajaxService.getAsyncJSON("/json/list/repair.cooperationList.do", {seq : $routeParams.seq}, function(data){
		$scope.cooperationList = data;
	});
	
	ajaxService.getAsyncJSON("/json/list/code.sido.do", {}, function(data){
		$scope.sido = data;
		$scope.changeSido();
	});
	$scope.changeSido = function(){
// 		$scope.form.sigungu_cd="";
		ajaxService.getAsyncJSON("/json/list/code.sigungu.do", {sido : $scope.form.sido_cd}, function(data){
			$scope.sigungu = data;
			$scope.changeSigungu();
		});
	}
	$scope.changeSigungu = function(){
// 		$scope.form.dong_cd="";
		ajaxService.getAsyncJSON("/json/list/code.dong.do", {sido : $scope.form.sido_cd, sigungu : $scope.form.sigungu_cd}, function(data){
			$scope.dong = data;
		});
	}
	
	$window.setAddr = function(roadAddrPart1, addrDetail, zipNo, jibunAddr) {
		var zip = zipNo.split("-");
		$scope.$apply(function(){
			$scope.form.zip1 = zip[0];
			$scope.form.zip2 = zip[1];
			$scope.form.addr1 = jibunAddr;
			$scope.form.addr2 = addrDetail;
		});
		$scope.mapUpdate(jibunAddr);
    }
	
	$scope.mapUpdate = function(jibun){
		if(!jibun){
			return false;
		}
		ajaxService.getXML("/addr/AjaxRequestXML.jsp", {"getUrl" : "http://openapi.map.naver.com/api/geocode.php?key=<spring:eval expression="@config['navar.map.key']" />&encoding=utf-8&coord=LatLng&query=" + encodeURI(jibun)}, function(data){
			var xml = $(data);
			var x = xml.find("x");
			var y = xml.find("y");
			if(x.length == 0){
				alert("선택한 주소에 대한 좌표가 존재하지 않습니다.");
				return;
			}
			$scope.form.x_coord = $(x[0]).text();
			$scope.form.y_coord = $(y[0]).text();
			$scope.$broadcast("updatePosition", $scope.form);
		});
	}
	
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
		
		ajaxService.getJSON("/admin/supply/repair/index.do?mode=modify", {jData : JSON.stringify($scope.form)}, function(data){
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
