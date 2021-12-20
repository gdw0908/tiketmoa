<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
var app = angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myFilter', 'myPagination', 'myCommon', 'ui.sortable', 'myNmap', 'myEditor', 'ngRange']);
app.run(function($rootScope){
	$rootScope.param = {
			<c:if test="${sessionScope.member.group_seq eq '3'}">
			com_seq : "${sessionScope.member.com_seq}"
			</c:if>			
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
	
	$scope.main.year = function(){
		return new Date().getFullYear();
	}
});
app.controller("listCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService) {
	
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getJSON('/admin/system/selfcamera/index.do?mode=list&cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
		ajaxService.getAsyncJSON("/json/list/code.sido.do", {}, function(data){
			$scope.sido = data;
		});
	};
	
	$scope.changeSido = function(){
		$scope.param.sigungu_cd = "";
		ajaxService.getAsyncJSON("/json/list/code.sigungu.do", {sido : $scope.param.sido_cd}, function(data){
			$scope.sigungu = data;
		});
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
			ajaxService.getJSON("/admin/system/selfcamera/index.do?mode=del", {jData : '{"seq" : "'+del_seq+'"}'}, function(data){
				$scope.list();
			});
		}
	}
});

app.controller("writeCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	$scope.form = {
		com_seq : "",
		files : [],
		content : "차량명 : <br/>연  식 : <br/>비  고 : <br/>"
	};
	$scope.cooperation_list = {}
	ajaxService.getAsyncJSON("/json/list/seller.all_cooperation.do", {}, function(data){
	  <c:choose>
		<c:when test="${sessionScope.member.group_seq eq '3'}">
			$.each(data,function(i,v){
	  			if(v.seq == "${sessionScope.member.com_seq}"){
	  				$scope.form.com_seq = v.seq;
	  				$scope.cooperation_list = [v];
	  			}
	  		});
      	</c:when>
      	<c:otherwise>
      		$scope.form.com_seq = data[0].seq;
      		$scope.cooperation_list = data;
      	</c:otherwise>
      </c:choose>
	});
	
	$scope.changeNation = function(){
		ajaxService.getAsyncJSON("/json/list/old_code.carmaker.do", $scope.form, function(data){
			$scope.carmaker = data;
			$scope.carmodel = "";
			$scope.cargrade = "";
			$scope.changeCarmaker();
		});
	}
	$scope.changeCarmaker = function(){
		ajaxService.getJSON("/json/list/old_code.carmodel.do", $scope.form, function(data){
			$scope.carmodel = data;
			$scope.cargrade = "";
			$scope.changeCarmodel();
		});
	}
	$scope.changeCarmodel = function(){
		ajaxService.getJSON("/json/list/old_code.cargrade.do", $scope.form, function(data){
			$scope.cargrade = data;
		});
	}
	
	$scope.uploadFile = function(){
		var filename = $("#file").val();
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if(filename == ""){
			return false;
		}
		if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
			alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
			return false;
		}
		if($scope.form.files.length >= 6){
			alert("이미지는 최대 6개까지 가능합니다.");
			return false;
		}
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
		ajaxService.getJSON("/admin/system/selfcamera/index.do?mode=write", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}
});

app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {};
	$scope.cooperation_list = {}
	ajaxService.getAsyncJSON("/json/list/seller.all_cooperation.do", {}, function(data){
	  <c:choose>
		<c:when test="${sessionScope.member.group_seq eq '3'}">
		$.each(data,function(i,v){
  			if(v.seq == "${sessionScope.member.com_seq}"){
  				$scope.cooperation_list = [v];
  			}
  		});
      	</c:when>
      	<c:otherwise>
    	$scope.cooperation_list = data;
     	</c:otherwise>
      </c:choose>
	});
	
	ajaxService.getJSON("/admin/system/selfcamera/index.do?mode=view", {seq : $routeParams.seq}, function(data){
		$scope.form = data.view;
		$scope.form.files = data.files;
		$scope.form.removeFiles = [];
	});
	
	$scope.changeNation = function(){
		ajaxService.getAsyncJSON("/json/list/old_code.carmaker.do", $scope.form, function(data){
			$scope.carmaker = data;
			$scope.carmodel = "";
			$scope.cargrade = "";
			$scope.changeCarmaker();
		});
	}
	$scope.changeCarmaker = function(){
		ajaxService.getJSON("/json/list/old_code.carmodel.do", $scope.form, function(data){
			$scope.carmodel = data;
			$scope.cargrade = "";
			$scope.changeCarmodel();
		});
	}
	$scope.changeCarmodel = function(){
		ajaxService.getJSON("/json/list/old_code.cargrade.do", $scope.form, function(data){
			$scope.cargrade = data;
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
		if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
			alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
			return false;
		}
		if($scope.form.files.length >= 6){
			alert("이미지는 최대 6개까지 가능합니다.");
			return false;
		}
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
		ajaxService.getJSON("/admin/system/selfcamera/index.do?mode=modify", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}

	$scope.del = function(){
		if(confirm("삭제하시겠습니까?")){
			ajaxService.getJSON("/admin/system/selfcamera/index.do?mode=del", {jData : JSON.stringify($scope.form)}, function(data){
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
