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
	$rootScope.param = {};
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
	$scope.list = function(){
		$location.path("/list");
	}
});


app.controller("listCtrl", function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService) {
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getJSON('/admin/system/send/email/send/index.do?mode=send_list&cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pageinfo.totalcount;
			$scope.board.totalPage = data.pageinfo.totalpage;
		});
	};
	
	$scope.send_del = function(seq){
		if(confirm("삭제하시겠습니까?")){
			$scope.del(seq);
		}
	}

	$scope.list_del = function(){
		var del_seq = "";
		$($("#boardList input[type=checkbox]:checked").get().reverse()).each(function(){
			del_seq += $(this).val()+",";
		});
		if(del_seq == ""){
			alert("삭제하실 게시물을 선택해 주십시오.");
			return false;
		}
		del_seq = del_seq.substr(0,del_seq.length-1);
		if(confirm("삭제하시겠습니까?")){
			$scope.del(del_seq);
		}
	}
	
	$scope.del = function(seq){
		ajaxService.getJSON("/admin/system/send/email/send/index.do?mode=send_delete", {"sd_seq" : seq}, function(data){
			$scope.board.go(1);
		});
	}
	
	$scope.sending = function(seq){
		if(confirm("발송하시겠습니까?\n발송중일 경우 중복 발송이 될수 있습니다.")){
			ajaxService.getAsyncJSON("/admin/system/send/email/send/index.do?mode=sending", {"sd_seq" : seq}, function(data){});
			alert("발송이 시작되었습니다.");
			$scope.board.go(1);
		}
	}
	
	
	
});

app.controller("writeCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	$scope.form = {
		send_cnt: 0,
		tg_seq : "",
		tg_title : "",
		tp_seq : "",
		tp_title : ""
	};
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
		if($scope.form.tg_seq == ""){
			alert("타겟을 선택해 주십시오.");
			return false;
		}
		if($scope.form.tp_seq == ""){
			alert("템플릿을 선택해 주십시오.");
			return false;
		}
		ajaxService.getJSON("/admin/system/send/email/send/index.do?mode=send_write", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}
	
	$scope.targetSearch = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "800",
			height: "700",
			close: function(event, ui) {}
		};
		dialogService.open("targetSearch","/lib/js/partials/targetSearch.html", "", options).then(
			function(result) {
				$scope.form.tg_seq = result.tg_seq;				
				$scope.form.tg_title = result.title;
				$scope.form.send_cnt = result.cnt;
			},
			function(error) {}
		);
	}
	
	$scope.templateSearch = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "800",
			height: "700",
			close: function(event, ui) {}
		};
		dialogService.open("templateSearch","/lib/js/partials/templateSearch.html", "", options).then(
			function(result) {
				$scope.form.tp_seq = result.tp_seq;				
				$scope.form.tp_title = result.title;
			},
			function(error) {}
		);
	}
});


app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {};
	ajaxService.getJSON("/admin/system/send/email/send/index.do?mode=send_view", {sd_seq : $routeParams.seq}, function(data){
		$scope.form = data.view;
	});

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
		if($scope.form.tg_seq == ""){
			alert("타겟을 선택해 주십시오.");
			return false;
		}
		if($scope.form.tp_seq == ""){
			alert("템플릿을 선택해 주십시오.");
			return false;
		}
		ajaxService.getJSON("/admin/system/send/email/send/index.do?mode=send_modify", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}

	$scope.targetSearch = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "800",
			height: "700",
			close: function(event, ui) {}
		};
		dialogService.open("targetSearch","/lib/js/partials/targetSearch.html", "", options).then(
			function(result) {
				$scope.form.tg_seq = result.tg_seq;				
				$scope.form.tg_title = result.title;
				$scope.form.send_cnt = result.cnt;
			},
			function(error) {}
		);
	}
	
	$scope.templateSearch = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "800",
			height: "700",
			close: function(event, ui) {}
		};
		dialogService.open("templateSearch","/lib/js/partials/templateSearch.html", "", options).then(
			function(result) {
				$scope.form.tp_seq = result.tp_seq;				
				$scope.form.tp_title = result.title;
			},
			function(error) {}
		);
	}
	

});




app.controller("targetCtrl", function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService) {
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getJSON('/admin/system/send/email/target/index.do?mode=target_list&cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pageinfo.totalcount;
			$scope.board.totalPage = data.pageinfo.totalpage;
		});
	};

	$scope.targetSelect = function(seq,tit,count){
		var result ={
				tg_seq : seq,
				title : tit,
				cnt : count
		} 
		dialogService.close("targetSearch", result);
	}
});


app.controller("templateCtrl", function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService) {
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getJSON('/admin/system/send/email/template/index.do?mode=template_list&cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pageinfo.totalcount;
			$scope.board.totalPage = data.pageinfo.totalpage;
		});
	};

	$scope.templateSelect = function(seq,tit){
		var result ={
				tp_seq : seq,
				title : tit
		} 
		dialogService.close("templateSearch", result);
	}
});
</script>
</head>
<body data-ng-controller="mainCtrl">
  <div data-ng-view data-ng-cloak></div>
</body>
</html>
