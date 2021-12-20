<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html data-ng-app="MyApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=10" />
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
		board_seq : "2",
		group_code : "1"
	};
	$rootScope.main = {};
});

app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
	$routeProvider
		.when('/list/:group_code/:cate_seq', {controller: 'listCtrl', templateUrl : 'list.do'})
		.when('/write', {controller: 'writeCtrl', templateUrl : 'write.do'})
		.when('/modify/:seq', {controller: 'modifyCtrl', templateUrl : 'modify.do'})
		.otherwise({redirectTo: '/list/1/0' });
}]);
app.controller("mainCtrl", function($scope, $location, $window, ajaxService) {
	ajaxService.getJSON('/json/list/article.categoryList.do', $scope.param, function(data){
		$scope.main.group =data; 
	});
	$scope.list = function(){
		$location.path("/list");
	}
});


app.controller("listCtrl", function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService) {
	$scope.param.cate_seq = $routeParams.cate_seq;
	$scope.board = {};
	$scope.group = {};

	$scope.board.go = function(n){
		$scope.group.list = $scope.main.group;
		ajaxService.getJSON('/json/list/article.list_category.do?cpage='+n, $scope.param, function(data){
			$scope.board.list = data;
		});
		ajaxService.getJSON('/json/request/article.page_info_category.do', $scope.param, function(data){
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.totalcount;
			$scope.board.totalPage = data.totalpage;
		});
		
	};
	
	$scope.categoryWrite = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "650",
				height: "auto",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("categoryDialog","/lib/js/partials/QAcategoryWrite.html", {}, options)
		.then(
			function(result) {},
			function(error) {}
		);
	}
	
	$scope.categoryModify = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "750",
				height: "700",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("categoryDialog","/lib/js/partials/QAcategoryModify.html", {group : $scope.group.list}, options)
		.then(
			function(result) {
			},
			function(error) {}
		);
	}
	
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
			ajaxService.getJSON("/admin/system/board/QA/index.do?mode=del", {jData : '{"article_seq" : "'+del_seq+'"}'}, function(data){
				$scope.list();
			});
		}
	}
});

app.controller("writeCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	$scope.form = {
		board_seq : $rootScope.param.board_seq,
		files : []
	};
	
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
		$scope.form.cate_group_code = $scope.param.group_code;
		ajaxService.getJSON("/admin/system/board/QA/index.do?mode=write", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();	
		});
	}
});


app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {
			files : []
	};
	ajaxService.getJSON("/admin/system/board/QA/index.do?mode=view", {article_seq : $routeParams.seq, board_seq : $scope.param.board_seq}, function(data){
		$scope.form = data.view;
		$scope.form.files = data.files;
		$scope.form.removeFiles = [];
	});
	
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
		ajaxService.getJSON("/admin/system/board/QA/index.do?mode=modify", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}
	
	$scope.del = function(){
		if(confirm("삭제하시겠습니까?")){
			ajaxService.getJSON("/admin/system/board/QA/index.do?mode=del", {jData : JSON.stringify($scope.form)}, function(data){
				$scope.list();
			});
		}
	}
});

app.controller('categoryCtrl', function($scope, $window, $location, ajaxService, dialogService) {
	$scope.data = $scope.model.group;
	$scope.categorySave = function() {
		if($scope.categoryFrm.$invalid){
			if($scope.categoryFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#cFrm .ng-invalid")[0].focus();
			return false;
		}
		$scope.categoryFrm.group_code = $scope.param.group_code;
		ajaxService.getJSON("/admin/system/board/QA/index.do?mode=categoryWrite", {jData : JSON.stringify($scope.categoryFrm)}, function(data){
			ajaxService.getJSON('/json/list/article.categoryList.do', $scope.param, function(data2){
				$scope.main.group =data2;
				alert("등록이 완료 되었습니다.");
				dialogService.close("categoryDialog", $scope.data);
				$location.path("/list");
			});
		});
	};
	
	$scope.categoryUpdate = function(seq) {
		$scope.categoryModify = {};
		$scope.categoryModify = $scope.data[seq];
		if($scope.categoryFrm.$invalid){
			if($scope.categoryFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#cFrm .ng-invalid")[0].focus();
			return false;
		}
		ajaxService.getJSON("/admin/system/board/QA/index.do?mode=categoryModify", {jData : JSON.stringify($scope.categoryModify)}, function(data){
			ajaxService.getJSON('/json/list/article.categoryList.do', $scope.param, function(data2){
				$scope.main.group =data2;
				alert("수정이 완료되었습니다.");
				$location.path("/list");
			});
		});
	};
	
	$scope.categoryDel = function(seq) {
		$scope.categoryModify = {};
		$scope.categoryModify = $scope.data[seq];
		$scope.categoryModify.del_yn = 'Y';
		ajaxService.getJSON("/admin/system/board/QA/index.do?mode=categoryModify", {jData : JSON.stringify($scope.categoryModify)}, function(data){
			ajaxService.getJSON('/json/list/article.categoryList.do', $scope.param, function(data2){
				alert("삭제가 완료되었습니다.");
				$scope.data.splice(seq, 1);
				$scope.main.group =data2;
				$location.path("/list");
			});
		});
	};
	
	$scope.dialogClose = function(){
		dialogService.cancel("categoryDialog");
		$location.path("/list");
	}
});

</script>
</head>
<body data-ng-controller="mainCtrl">
  <div data-ng-view data-ng-cloak></div>
</body>
</html>
