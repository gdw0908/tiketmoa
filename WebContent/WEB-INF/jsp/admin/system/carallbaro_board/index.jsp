<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html data-ng-app="MyApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=8" />
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
	$rootScope.param = {
			set_type : '2',
			type_state : '1'
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
	$scope.list = function(){
		$location.path("/");
	}
});
app.controller("listCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getJSON('/admin/system/carallbaro/carallbaro_list.do?cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	
	$scope.listDel = function(){
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
			ajaxService.getJSON("/admin/system/carallbaro/carallbaro_delete.do", {jData : '{"seq" : "'+del_seq+'"}'}, function(data){
				$scope.list();
			});
		}
	}
});

app.controller("writeCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	$scope.form = {
		set_type : $rootScope.param.set_type,
		type_state : $rootScope.param.type_state,
		nation : $rootScope.param.type_state == '1' ? '' : $rootScope.param.type_state == '2' ? 'N' : 'Y',
		files : []
	};
	
	$scope.changeNationYN = function(){
		$scope.form.nation = $scope.form.type_state == '1' ? '' : $scope.form.type_state == '2' ? 'N' : 'Y';
	}
	$scope.changeNation = function(){
		ajaxService.getAsyncJSON("/json/list/old_code.carmaker.do", $scope.form, function(data){
			$scope.carmaker = data;
		});
	}

	$scope.uploadFile = function(){
		var filename = $("#file").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename == ""){
			return false;
		}
		/*if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
			alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
			return false;
		}
		*/
    	$("#wFrm").ajaxSubmit({
    		url : '/ajaxUpload.do',
    		iframe: true,
    		dataType : "json",
    		uploadProgress : function(event, position, total, percentComplete){
    		},
    		success : function(data){
    			$scope.addFile(data);
    		},
    		error: function(e){
    			alert(e.responseText);
    		}
    	});
	}
	
	$scope.addFile = function(data){
		$scope.$apply(function(){
			$scope.form.files.push(data);
		});
	}
	
	$scope.removeFile = function(idx){
		$scope.form.files.splice(idx, 1);
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
		try{
			var content = $scope.form.content;
			var img_array = $(content).find('img');
			$scope.form.thumb = "";
			var domain = "http://" + document.domain;
			$.each(img_array, function(idx){
				if($scope.form.thumb != "") return;
				if(this.src.indexOf(domain) == -1) return;
				$scope.form.thumb = this.src.substring(domain.length);
				return false;
			});
		}catch(e){
			;
		}
		ajaxService.getJSON("/admin/system/carallbaro/carallbaro_insert.do", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}
});

app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {};
	ajaxService.getJSON("/admin/system/carallbaro/carallbaro_view.do", {seq : $routeParams.seq}, function(data){
		$scope.form = data.view;
		$scope.form.files = data.files;
		$scope.form.removeFiles = [];
	});
	
	$scope.changeNationYN = function(){
		$scope.form.nation = $scope.form.type_state == '1' ? '' : $scope.form.type_state == '2' ? 'N' : 'Y';
	}
	$scope.changeNation = function(){
		ajaxService.getAsyncJSON("/json/list/old_code.carmaker.do", $scope.form, function(data){
			$scope.carmaker = data;
		});
	}
	
	$scope.removeFile = function(idx){
		$scope.form.removeFiles.push($scope.form.files[idx]);
		$scope.form.files.splice(idx, 1);
	}
	
	$scope.addFile = function(data){
		$scope.$apply(function(){
			$scope.form.files.push(data);
		});
	}
	
	$scope.uploadFile = function(){
		var filename = $("#file").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename == ""){
			return false;
		}
		/*wif($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
			alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
			return false;
		}
		*/
    	$("#wFrm").ajaxSubmit({
    		url : '/ajaxUpload.do',
    		iframe: true,
    		dataType : "json",
    		uploadProgress : function(event, position, total, percentComplete){
    		},
    		success : function(data){
    			$scope.addFile(data);
    		},
    		error: function(e){
    			alert(e.responseText);
    		}
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
		try{
			var content = $scope.form.content;
			var img_array = $(content).find('img');
			$scope.form.thumb = "";
			var domain = "http://" + document.domain;
			$.each(img_array, function(idx){
				if($scope.form.thumb != "") return;
				if(this.src.indexOf(domain) == -1) return;
				$scope.form.thumb = this.src.substring(domain.length);
				return false;
			});
		}catch(e){
			;
		}
		ajaxService.getJSON("/admin/system/carallbaro/carallbaro_modify.do", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}

	$scope.del = function(){
		if(confirm("삭제하시겠습니까?")){
			ajaxService.getJSON("/admin/system/carallbaro/carallbaro_delete.do", {jData : JSON.stringify($scope.form)}, function(data){
				$scope.list();
			});
		}
	}
});
</script>
</head>
<body data-ng-controller="mainCtrl">
  <div data-ng-view data-ng-cloak></div>
</body>
</html>
