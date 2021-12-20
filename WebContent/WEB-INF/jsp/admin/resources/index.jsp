<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
app.directive('datepicker', function() {
    return {
        restrict: 'A',
        require : 'ngModel',
        link : function (scope, element, attrs, ngModelCtrl) {
            $(function(){
                element.datepicker({
                	changeYear: true,
        			changeMonth: true,
        			showMonthAfterYear: true,
        			monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
        			monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
        			dayNames : ['일', '월', '화', '수', '목', '금', '토'],
        			dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
        			dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
        			dateFormat:'yy-mm-dd',
                    showOn: "button",      
            		buttonImage: "/images/admin/contents/calendar.png",
                    onSelect:function (date) {
                        scope.$apply(function () {
                            ngModelCtrl.$setViewValue(date);
                        });
                    }
                });
            });
        }
    }
});

app.run(function($rootScope){
	$rootScope.param = {
		board_seq : "7",
		group_code : "2",
		order : "Y"
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

app.controller("mainCtrl", function($rootScope, $scope, $location, $window, ajaxService) {
	<c:if test = "${sessionScope.member.group_seq ne '1' && sessionScope.member.group_seq ne '8'}">
	ajaxService.getJSON('/json/request/article.cooperation_parentSeq.do', {'session_member_seq':'${sessionScope.member.member_seq}'}, function(data){
		$rootScope.param.keyword = data.parent_seq;
	});
	</c:if>	
	$scope.list = function(){
		$location.path("/list");
	}
	ajaxService.getJSON('/json/list/article.categoryList.do', $scope.param, function(data){
		$scope.main.group = data;
	});
});

app.controller("listCtrl", function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService,$timeout) {
	$scope.param.cpage = $scope.param.cpage||1;
	$scope.param.cate_seq = {}; 
	$scope.group = {};
	$scope.board = {};
	$scope.board.go = function(n){
		$scope.group.list = $scope.main.group;
		ajaxService.getJSON('/admin/system/board/resources/index.do?mode=resourcesList&cpage='+n, {jData : JSON.stringify($scope.param)}, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pageinfo.totalcount;
			$scope.board.totalPage = data.pageinfo.totalpage;
		});
		ajaxService.getJSON('/json/list/article.resources_cooperation.do', {}, function(data){
			$scope.comList = data;
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
	
	$scope.resource_select = function(info){
		var infoArray = info.split("|+|");
		var returnValue = "";
		$(infoArray).each(function(i,v){
			if(i != 0){
				var array = v.split("|,|");
				returnValue += "<p><span class='res_"+array[1]+"'></span>"+array[0]+" : "+array[3]+"</p>";
			}
		});
		return returnValue;
	};
	
	$scope.resourceWrite = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "680",
				height: "auto",
				close: function(event, ui) {
				}
		};
		dialogService.open("resourceDialog","resourceWrite.html", $scope.param, options).then(
			function(result){
				$scope.main.group = result;
				$scope.group.list = $scope.main.group;
				alert("등록이 완료 되었습니다.");
			},function(error){}
		);
	}
	
	$scope.resourceModify = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "900",
				height: "auto",
				close: function(event, ui) {
				}
		};
		dialogService.open("resourceDialog","resourceModify.html", $scope.main.group, options).then(
			function(result){
				$scope.main.group = result;
				$scope.group.list = $scope.main.group;
			},function(error){}
		);
	}
	
	$scope.resourceView = function(idx){
		var options = {
				autoOpen: false,
				modal: true,
				width: "680",
				height: "auto",
				close: function(event, ui) {
				}
		};
		ajaxService.getJSON("/admin/system/board/resources/index.do?mode=resourcesView", $scope.board.list[idx], function(data){
			dialogService.open("resourceViewDialog","resourceView.html", data, options).then(
				function(result){},function(error){}
			);
		});
	}
	
	$scope.excelDown = function(){
		var param = angular.copy($scope.param);
		var param_cate = JSON.stringify($scope.param.cate_seq);
		$("#excelFrm").empty();
		$.each(param, function(key, val){
			if(key != 'cate_seq'){
				$("#excelFrm").append("<input type='hidden' name='"+key+"' value='"+val+"'/>");
			}
		});
		$("#excelFrm").append("<input type='hidden' name='cate_seq' value='"+param_cate+"'/>");
		$("#excelFrm").submit();
	}
	

});

app.controller("writeCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	$scope.form = {
		board_seq : $rootScope.param.board_seq,
		resources : [{seq:0,item_code:$scope.main.group[0].orderby}],
		files : []
	};
	<c:if test = "${sessionScope.member.group_seq eq '8'}">
	$scope.cooperation_list = {}
	
	ajaxService.getAsyncJSON("/json/list/seller.all_cooperation.do", {}, function(data){
		$scope.cooperation_list = data;
		$scope.form.title = data[0].seq;
	});
	</c:if>
	$scope.group = {};
	$scope.group.list = $scope.main.group;
	
	$scope.addResources = function(){
		$scope.form.resources.push({seq:'0'});
	}
	
	$scope.deleteResources = function(i){
		$scope.form.resources.splice(i, 1);
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
		if($scope.form.status != "2"){
			$scope.form.edate = "";
		}
		ajaxService.getJSON("/admin/system/board/resources/index.do?mode=resourcesWrite", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();	
		});
	}
});

app.controller("modifyCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	$scope.form = {
		board_seq : $rootScope.param.board_seq,
		resources : []
	};
	
	ajaxService.getJSON("/admin/system/board/resources/index.do?mode=resourcesView", {article_seq : $routeParams.seq, board_seq : $scope.param.board_seq}, function(data){
		$scope.form = data.view[0];
		$scope.form.resources = data.resources;
		$scope.form.files = data.files;
		$scope.form.removeFiles = [];
	});
	
	$scope.group = {};
	$scope.group.list = $scope.main.group;
	
	$scope.addResources = function(){
		$scope.form.resources.push({seq:'0'});
	}
	
	$scope.deleteResources = function(i){
		if($scope.form.resources[i].del_yn != null){
			$scope.form.resources[i].del_yn = 'Y';
		}else{
			$scope.form.resources.splice(i, 1);	
		}		
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
		if($scope.form.status != "2"){
			$scope.form.edate = "";
		}
		ajaxService.getJSON("/admin/system/board/resources/index.do?mode=resourcesModify", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();	
		});
	}
	
	$scope.del = function(){
		if(confirm("삭제하시겠습니까?")){
			ajaxService.getJSON("/admin/system/board/resources/index.do?mode=del", {jData : JSON.stringify($scope.form)}, function(data){
				$scope.list();
			});
		}
	}
});


app.controller('resourceViewCtrl', function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService) {
	$scope.view = $scope.model.view[0];
	$scope.files = $scope.model.files;
	$scope.resource_view_select = function(info){
		var infoArray = info.split("|+|");
		var returnValue = "";
		$(infoArray).each(function(i,v){
			if(i != 0){
				var array = v.split("|,|");
				returnValue += "<tr><td>"+array[0]+"</td><td>"+array[3]+"</td><tr>";
			}
		});
		return returnValue;
	};
	$scope.dialogClose = function(){
		dialogService.cancel("resourceDialog");
		$location.path("/list");
	}
});

app.controller('resourceWriteCtrl', function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService) {
	$scope.resourceSave = function() {
		if($scope.resourceFrm.$invalid){
			if($scope.resourceFrm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#cFrm .ng-invalid")[0].focus();
			return false;
		}
		$scope.resourceFrm.group_code = $scope.model.group_code;
		$scope.resourceFrm.use_yn = "Y";
		
		ajaxService.getJSON("/admin/system/board/resource/index.do?mode=categoryWrite", {jData : JSON.stringify($scope.resourceFrm)}, function(data){
			ajaxService.getJSON('/json/list/article.categoryList.do', $scope.param, function(data2){
				dialogService.close("resourceDialog",data2); 
			});			
		});
	};

	$scope.dialogClose = function(){
		dialogService.cancel("resourceDialog");
		$location.path("/list");
	}
});

app.controller('resourceModifyCtrl', function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService) {
	$scope.group = {};
	$scope.group.list = $scope.model;
	$scope.resourceUpdate = function(seq) {
		$scope.resourceFrmUpdate = {};
		$scope.resourceFrmUpdate = $scope.group.list[seq];
		if($scope.resourceFrmUpdate.$invalid){
			if($scope.resourceFrmUpdate.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#resourceFrm .ng-invalid")[0].focus();
			return false;
		}
		ajaxService.getJSON("/admin/system/board/resource/index.do?mode=categoryModify", {jData : JSON.stringify($scope.resourceFrmUpdate)}, function(data){
			ajaxService.getJSON('/json/list/article.categoryList.do', $scope.param, function(data2){
				$scope.main.group = data2;
				$scope.group.list = data2;
				alert("수정이 완료되었습니다.");
			});
		});
	};
	
	$scope.resourceDelete = function(seq) {
		$scope.resourceFrmUpdate = {};
		$scope.resourceFrmUpdate = $scope.group.list[seq];
		$scope.resourceFrmUpdate.del_yn = 'Y';
		ajaxService.getJSON("/admin/system/board/resource/index.do?mode=categoryModify", {jData : JSON.stringify($scope.resourceFrmUpdate)}, function(data){
			ajaxService.getJSON('/json/list/article.categoryList.do', $scope.param, function(data2){
				alert("삭제가 완료되었습니다.");
				$scope.main.group = data2;
				$scope.group.list.splice(seq, 1);
				$location.path("/list");
			});
		});
	};

	$scope.dialogClose = function(){
		ajaxService.getJSON('/json/list/article.categoryList.do', $scope.param, function(data2){
			dialogService.close("resourceDialog",data2); 
		});
	}
});
</script>
</head>
<body data-ng-controller="mainCtrl">
  <div data-ng-view data-ng-cloak></div>
  <form id="excelFrm" action="/admin/system/board/resource/index.do?mode=excelDown" method="post">
  </form>
</body>
<script type="text/ng-template" id="resourceModify.html">
<div ng-controller="resourceModifyCtrl" title="자원등록">
	<form name="resourceFrm" method="post" novalidate="novalidate">
   	<div id="dialog2" title="자원물질등록" >
        <table class="style_1">
          <colgroup>
          <col width="20%" />
          <col width="" />
		  <col width="75px" />
		  <col width="75px" />
          </colgroup>
		  <thead>
			<tr>
              <th style="text-align:center;">자원물질명</th>
			  <th style="text-align:center;">자원아이콘</th>
			  <th style="text-align:center;">수정</th>
              <th style="text-align:center;">삭제</th>
            </tr>
          </thead>
          <tbody>
            <tr data-ng-repeat="resourceFrm in group.list">
              <td><input type="text" data-ng-model="resourceFrm.subject" class="input_1" ></td>
              <td class="label_type">
              <label><input type="radio" value="1" data-ng-model="resourceFrm.orderby"> <span class="res_1"></span></label>
              <label><input type="radio" value="2" data-ng-model="resourceFrm.orderby"> <span class="res_2"></span></label>
              <label><input type="radio" value="3" data-ng-model="resourceFrm.orderby"> <span class="res_3"></span></label>
              <label><input type="radio" value="4" data-ng-model="resourceFrm.orderby"> <span class="res_4"></span></label>
              <label><input type="radio" value="5" data-ng-model="resourceFrm.orderby"> <span class="res_5"></span></label>
              <label><input type="radio" value="6" data-ng-model="resourceFrm.orderby"> <span class="res_6"></span></label>
              <label><input type="radio" value="7" data-ng-model="resourceFrm.orderby"> <span class="res_7"></span></label>
              <label><input type="radio" value="8" data-ng-model="resourceFrm.orderby"> <span class="res_8"></span></label>
              <label><input type="radio" value="9" data-ng-model="resourceFrm.orderby"> <span class="res_9"></span></label>
              <label><input type="radio" value="10" data-ng-model="resourceFrm.orderby"> <span class="res_10"></span></label>
              <label><input type="radio" value="11" data-ng-model="resourceFrm.orderby"> <span class="res_11"></span></label>
              <label><input type="radio" value="12" data-ng-model="resourceFrm.orderby"> <span class="res_12"></span></label>
              <label><input type="radio" value="13" data-ng-model="resourceFrm.orderby"> <span class="res_13"></span></label>
              <label><input type="radio" value="14" data-ng-model="resourceFrm.orderby"> <span class="res_14"></span></label>
              <label><input type="radio" value="15" data-ng-model="resourceFrm.orderby"> <span class="res_15"></span></label>
              <label><input type="radio" value="16" data-ng-model="resourceFrm.orderby"> <span class="res_16"></span></label>
              <label><input type="radio" value="17" data-ng-model="resourceFrm.orderby"> <span class="res_17"></span></label>
              <label><input type="radio" value="18" data-ng-model="resourceFrm.orderby"> <span class="res_18"></span></label>
              <label><input type="radio" value="19" data-ng-model="resourceFrm.orderby"> <span class="res_19"></span></label>
              <label><input type="radio" value="20" data-ng-model="resourceFrm.orderby"> <span class="res_20"></span></label>
              </td>
				<td>
					<span class="bt_all"><span><input type="button" value="수정" class="btall" data-ng-click="resourceUpdate($index)"></span></span>
				</td>
				<td>
					<span class="bt_all"><span><input type="button" value="삭제" class="btall" data-ng-click="resourceDelete($index)"></span></span>
				</td>
            </tr>
          </tbody>
        </table>        
        <div class="btn_bottom">
        	<div class="r_btn"> 
        		<span class="bt_all"><span><input type="button" value="닫기" class="btall" data-ng-click="dialogClose()"></span></span>
        	</div>
      	</div>
	</div>
	</form>
</div>
</script>

<script type="text/ng-template" id="resourceWrite.html">
<div ng-controller="resourceWriteCtrl" title="자원등록">
	<form name="resourceFrm" method="post" novalidate="novalidate">
   	<div id="dialog2" title="자원물질등록" >
        <table class="style_1">
          <colgroup>
          <col width="20%" />
          <col width="" />
          </colgroup>
          <tbody>
            <tr>
              <th>자원물질명</th>
              <td><input type="text" data-ng-model="resourceFrm.subject" class="input_1" ></td>
            </tr>
            <tr>
              <th>자원아이콘 선택</th>
              <td class="label_type">
              <label><input type="radio" value="1" data-ng-model="resourceFrm.orderby" data-ng-init="resourceFrm.orderby = '1'"> <span class="res_1"></span></label>
              <label><input type="radio" value="2" data-ng-model="resourceFrm.orderby"> <span class="res_2"></span></label>
              <label><input type="radio" value="3" data-ng-model="resourceFrm.orderby"> <span class="res_3"></span></label>
              <label><input type="radio" value="4" data-ng-model="resourceFrm.orderby"> <span class="res_4"></span></label>
              <label><input type="radio" value="5" data-ng-model="resourceFrm.orderby"> <span class="res_5"></span></label>
              <label><input type="radio" value="6" data-ng-model="resourceFrm.orderby"> <span class="res_6"></span></label>
              <label><input type="radio" value="7" data-ng-model="resourceFrm.orderby"> <span class="res_7"></span></label>
              <label><input type="radio" value="8" data-ng-model="resourceFrm.orderby"> <span class="res_8"></span></label>
              <label><input type="radio" value="9" data-ng-model="resourceFrm.orderby"> <span class="res_9"></span></label>
              <label><input type="radio" value="10" data-ng-model="resourceFrm.orderby"> <span class="res_10"></span></label>
              <label><input type="radio" value="11" data-ng-model="resourceFrm.orderby"> <span class="res_11"></span></label>
              <label><input type="radio" value="12" data-ng-model="resourceFrm.orderby"> <span class="res_12"></span></label>
              <label><input type="radio" value="13" data-ng-model="resourceFrm.orderby"> <span class="res_13"></span></label>
              <label><input type="radio" value="14" data-ng-model="resourceFrm.orderby"> <span class="res_14"></span></label>
              <label><input type="radio" value="15" data-ng-model="resourceFrm.orderby"> <span class="res_15"></span></label>
              <label><input type="radio" value="16" data-ng-model="resourceFrm.orderby"> <span class="res_16"></span></label>
              <label><input type="radio" value="17" data-ng-model="resourceFrm.orderby"> <span class="res_17"></span></label>
              <label><input type="radio" value="18" data-ng-model="resourceFrm.orderby"> <span class="res_18"></span></label>
              <label><input type="radio" value="19" data-ng-model="resourceFrm.orderby"> <span class="res_19"></span></label>
              <label><input type="radio" value="20" data-ng-model="resourceFrm.orderby"> <span class="res_20"></span></label>
              </td>
            </tr>
          </tbody>
        </table>        
        <div class="btn_bottom">
        	<div class="r_btn"> 
        		<span class="bt_all"><span><input type="button" value="추가" class="btall" data-ng-click="resourceSave()"></span></span>
        		<span class="bt_all"><span><input type="button" value="닫기" class="btall" data-ng-click="dialogClose()"></span></span>
        	</div>
      	</div>
	</div>
	</form>
</div>
</script>

<script type="text/ng-template" id="resourceView.html">
	<div ng-controller="resourceViewCtrl" title="상세보기" >
      <h4 style="padding:0 0 8px 0;">{{view.com_nm}} 자원 반출신청현황</h4>
        <table class="style_1">
          <colgroup>
          <col width="20%" />
          <col width="" />
          </colgroup>
          <tbody>
            <tr>
              <th>주소</th>
              <td>{{view.zip_cd}} {{view.addr1}} {{view.addr2}}</td>
            </tr>
            <tr>
              <th>담당자/연락처</th>
              <td>{{view.staff_nm}} / {{view.staff_tel}}</td>
            </tr>
            <tr>
              <th>반출희망일자</th>
              <td>{{view.sdate|myDate:'yyyy-MM-dd'}}</td>
            </tr>
            <tr>
              <th>진행상황</th>
              <td>{{view.status == '0' ? '반출대기' : view.status == '1' ? '반출진행' : '반출완료'}} ({{view.edate|myDate:'yyyy-MM-dd'}})</td>
            </tr>
			<tr>
          		<th>첨부파일</th>
				<td class="tddiv" id="attach_div">
	          		<div data-ng-repeat="item in files">
	          			<p style="margin-top: 3px;"><a data-ng-href="/download.do?uuid={{item.uuid}}">{{item.attach_nm}}</a></p>
	          		</div>
	      		</td>
        	</tr>
          </tbody>
        </table>
        <table class="style_3" style="margin-top:12px;">
          <colgroup>
          <col width="20%" />
          <col width="" />
          </colgroup>
          <thead>
            <tr>
              <th>자원명</th>
              <th>용량</th>
            </tr>
          </thead>
          <tbody bind-html-unsafe="resource_view_select(view.item_info)">
          </tbody>
        </table>
        <table class="style_3">
          <thead>
            <tr>
              <th>비고</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><pre>{{view.conts}}</pre></td>
            </tr>
          </tbody>
        </table>
      </div>
</script>

</html>
