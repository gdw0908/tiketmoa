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
		ajaxService.getJSON('/admin/system/send/email/target/index.do?mode=target_list&cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pageinfo.totalcount;
			$scope.board.totalPage = data.pageinfo.totalpage;
		});
	};
	
	$scope.del = function(seq1){
		if(confirm("삭제하시겠습니까?")){
			ajaxService.getJSON("/admin/system/send/email/target/index.do?mode=target_delete", {"tg_seq" : seq1}, function(data){
				$scope.board.go(1);
			});
		}
	}
	
	$scope.target_write = function(){
		ajaxService.getJSON("/admin/system/send/email/target/index.do?mode=target_write_form", "", function(data){
			$location.path("/write");
		});
	}
});

app.controller("writeCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	$scope.form = {
		tg_xls_file_nm : ""
	};
		
	$scope.uploadFile = function(){
		var filename = $("#file").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename == ""){
			$scope.$apply(function(){
				$scope.form.tg_xls_file_nm = "";
			})
			return false;
		}
		if(filename != "xls"){
			$("#file").replaceWith($("#file").clone(true));
			$scope.$apply(function(){
				$scope.form.tg_xls_file_nm = "";
			})
			alert("xls 파일만 올려주시기 바랍니다.");
			return false;
		}
		
		$("#wFrm").ajaxSubmit({
    		url : '/excelUpload.do',
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
			$scope.form.tg_xls_file_nm = data.attach_nm;
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
		if($scope.form.target_cd == '1'){
			if($scope.form.tg_xls_file_nm == ''){
				alert("엑셀파일을 선택해 주십시오.");
				return false;
			}
		}
		
		if($scope.form.target_cd == '4'){
			var check = 0;
			for(var i in $scope.form.tg_chk_cd){
				if($scope.form.tg_chk_cd[i] == true){
					check++;
				}	
			}
			if(check == 0){
				alert("대상그룹을 선택해 주십시오.");
				return false;	
			}
		}
		ajaxService.getJSON("/admin/system/send/email/target/index.do?mode=target_write", {jData : JSON.stringify($scope.form)}, function(data){
			if(data.rst == 0){
				alert(data.message);
			}
			$scope.list();
		});
	}
});

app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {
		tg_chk_cd : [],
		tg_xls_file_nm : "",
		old_tg_xls_file_nm : ""
	};
	ajaxService.getJSON("/admin/system/send/email/target/index.do?mode=target_view", {tg_seq : $routeParams.seq}, function(data){
		$scope.form = data.view;
		if(data.view.tg_chk_cd != null){
			$scope.form.tg_chk_cd = {
					0 : (data.view.tg_chk_cd.indexOf(0) > -1 ? true : false),
					2 : (data.view.tg_chk_cd.indexOf(2) > -1 ? true : false),
					3 : (data.view.tg_chk_cd.indexOf(3) > -1 ? true : false),
					4 : (data.view.tg_chk_cd.indexOf(4) > -1 ? true : false)
			}
		}
		if(data.view.tg_xls_file_nm != null){
			$scope.form.old_tg_xls_file_nm = data.view.tg_xls_file_nm; 
		}
	});
			
	$scope.uploadFile = function(){
		var filename = $("#file").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename == ""){
			$scope.$apply(function(){
				$scope.form.tg_xls_file_nm = $scope.form.old_tg_xls_file_nm;
			})
			return false;
		}
		if(filename != "xls"){
			$("#file").replaceWith($("#file").clone(true));
			$scope.$apply(function(){
				$scope.form.tg_xls_file_nm = $scope.form.old_tg_xls_file_nm;
			})
			alert("xls 파일만 올려주시기 바랍니다.");
			return false;
		}
		
		$("#wFrm").ajaxSubmit({
    		url : '/excelUpload.do',
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
			$scope.form.tg_xls_file_nm = data.attach_nm;
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
		if($scope.form.target_cd == '1'){
			if($scope.form.tg_xls_file_nm == ''){
				alert("엑셀파일을 선택해 주십시오.");
				return false;
			}
		}
		
		if($scope.form.target_cd == '4'){
			var check = 0;
			for(var i in $scope.form.tg_chk_cd){
				if($scope.form.tg_chk_cd[i] == true){
					check++;
				}	
			}
			if(check == 0){
				alert("대상그룹을 선택해 주십시오.");
				return false;	
			}
		}
		ajaxService.getJSON("/admin/system/send/email/target/index.do?mode=target_modify", {jData : JSON.stringify($scope.form)}, function(data){
			if(data.rst == 0){
				alert(data.message);
			}
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
