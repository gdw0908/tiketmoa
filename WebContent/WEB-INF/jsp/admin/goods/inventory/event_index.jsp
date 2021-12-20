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
var app = angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myFilter', 'myPagination', 'myCommon', 'ui.sortable', 'myNmap', 'myEditor', 'ngRange']);
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
	$rootScope.param = {};
	$rootScope.main = {};
});

app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
	$routeProvider
		.when('/list', {controller: 'listCtrl', templateUrl : 'event_list.do'})
		.when('/write', {controller: 'writeCtrl', templateUrl : 'event_write.do'})
		.when('/modify/:seq', {controller: 'modifyCtrl', templateUrl : 'event_modify.do'})
		.otherwise({redirectTo: '/list' });
}]);
app.controller("mainCtrl", function($scope, $location, $window, ajaxService) {
	$scope.list = function(){
		$location.path("/list");
	}
	$scope.main.year = function(){
		return new Date().getFullYear();
	}
});


app.controller("listCtrl", function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService) {
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getJSON('/admin/goods/inventory/event_index.do?mode=list&cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.page_info.totalcount;
			$scope.board.totalPage = data.page_info.totalpage;
		});
	};
	
	$scope.del = function(seq){
		ajaxService.getJSON('/admin/goods/inventory/event_index.do?mode=delete', {"seq" : seq}, function(data){
			$scope.board.go(1);
		});
	}
});

app.controller("writeCtrl", function($scope, $window, $routeParams, $rootScope, ajaxService, dialogService) {
	$scope.form = {
		item_list : []
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
		
		ajaxService.getJSON("/admin/goods/inventory/event_index.do?mode=write", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}
	
	$scope.itemSearch = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "1200",
			height: "700",
			close: function(event, ui) {}
		};
		dialogService.open("itemSearch","/lib/js/partials/event_itemSearch.html", {item : $scope.form.item_list}, options).then(
			function(result) {
				if(result != null && result != ''){
					if($scope.form.item_list.length == 0){
						$scope.form.item_list = result;
					}else{
						var itemArray = $scope.form.item_list;
						$scope.form.item_list = [];
						$(result).each(function(i,v){
							itemArray.push(v);
						});
						$scope.form.item_list = itemArray;
					}
					ajaxService.getJSON('/admin/goods/inventory/event_index.do?mode=itemSelectList', {jData : JSON.stringify({item : $scope.form.item_list})}, function(data){
						$scope.form.items = data.list;
					});
				}
			},
			function(error) {}
		);
	}
	
	$scope.saleAllSelect = function(){
		$($("#sale_itemList input[type=checkbox]")).each(function(){
			$(this).prop("checked",true);
		});
	}
	
	$scope.saleNotSelect = function(){
		$($("#sale_itemList input[type=checkbox]").get().reverse()).each(function(){
			$(this).prop("checked",false);
		});
	}
	
	$scope.saleItemDelete = function(){
		$($("#sale_itemList input[type=checkbox]:checked").get().reverse()).each(function(){
			var item_seq = $scope.form.items[$(this).val()].item_seq;
			$($scope.form.item_list).each(function(i,v){
				if(v == item_seq){
					$scope.form.item_list.splice(i, 1);
				}
			});
			$scope.form.items.splice($(this).val(), 1);
		});
	}
	
});


app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.form = {
		item_list : []
	};
	ajaxService.getJSON("/admin/goods/inventory/event_index.do?mode=view", {seq : $routeParams.seq}, function(data){
		$scope.form = data.view;
		$scope.form.items = data.items;
		if(data.items != null){
			var itemArray = new Array(); 
			$(data.items).each(function(i,v){
				itemArray.push(v.item_seq);
			});
			$scope.form.item_list = itemArray; 
		}
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
		
		ajaxService.getJSON("/admin/goods/inventory/event_index.do?mode=modify", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}
	
	$scope.itemSearch = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "1200",
			height: "700",
			close: function(event, ui) {}
		};
		dialogService.open("itemSearch","/lib/js/partials/event_itemSearch.html", {item : $scope.form.item_list}, options).then(
			function(result) {
				if(result != null && result != ''){
					if($scope.form.item_list.length == 0){
						$scope.form.item_list = result;
					}else{
						var itemArray = $scope.form.item_list;
						$scope.form.item_list = [];
						$(result).each(function(i,v){
							itemArray.push(v);
						});
						$scope.form.item_list = itemArray;
					}
					ajaxService.getJSON('/admin/goods/inventory/event_index.do?mode=itemSelectList', {jData : JSON.stringify({item : $scope.form.item_list})}, function(data){
						$scope.form.items = data.list;
					});
				}
			},
			function(error) {}
		);
	}
	
	$scope.saleAllSelect = function(){
		$($("#sale_itemList input[type=checkbox]")).each(function(){
			$(this).prop("checked",true);
		});
	}
	
	$scope.saleNotSelect = function(){
		$($("#sale_itemList input[type=checkbox]").get().reverse()).each(function(){
			$(this).prop("checked",false);
		});
	}
	
	$scope.saleItemDelete = function(){
		$($("#sale_itemList input[type=checkbox]:checked").get().reverse()).each(function(){
			var item_seq = $scope.form.items[$(this).val()].item_seq;
			$($scope.form.item_list).each(function(i,v){
				if(v == item_seq){
					$scope.form.item_list.splice(i, 1);
				}
			});
			$scope.form.items.splice($(this).val(), 1);
		});
	}
});

app.controller("itemCtrl", function($scope, $window, $routeParams, $compile, $location, ajaxService, dialogService) {
	$scope.result = [];	
	$scope.board = {};
	$scope.params = {
			item_list : {}
	};
	$scope.params.item_list = $scope.model.item;
	
	ajaxService.getAsyncJSON("/json/list/code.codeList.do", {code_group_seq : '37'}, function(data){
		$scope.color = data;
	});

	ajaxService.getAsyncJSON("/json/list/code.codeList.do", {code_group_seq : '38'}, function(data){
		$scope.grade = data;
	});
	$scope.changeNation = function(){
		ajaxService.getAsyncJSON("/json/list/old_code.carmaker.do", $scope.params, function(data){
			$scope.carmaker = data;
			$scope.carmodel = "";
			$scope.cargrade = "";
			$scope.changeCarmaker();
		});
	}
	$scope.changeCarmaker = function(){
		ajaxService.getJSON("/json/list/old_code.carmodel.do", $scope.params, function(data){
			$scope.carmodel = data;
			$scope.cargrade = "";
			$scope.changeCarmodel();
		});
	}
	$scope.changeCarmodel = function(){
		ajaxService.getJSON("/json/list/old_code.cargrade.do", $scope.params, function(data){
			$scope.cargrade = data;
		});
	}
	ajaxService.getAsyncJSON("/json/list/old_code.codeList.do", {upcodeno : '050901'}, function(data){
		$scope.part1 = data;
		$scope.changePart1();
	});
	$scope.changePart1 = function(){
		ajaxService.getJSON("/json/list/old_code.codeList.do", {upcodeno : $scope.params.part1}, function(data){
			$scope.part2 = data;
			$scope.changePart2();
		});
	}
	$scope.changePart2 = function(){
		ajaxService.getJSON("/json/list/old_code.carpart.do", {upcodeno : $scope.params.part2}, function(data){
			$scope.part3 = data;
		});
	}
	
	$scope.board.go = function(n){
		ajaxService.getJSON('/admin/goods/inventory/event_index.do?mode=itemSearch&cpage='+n, {jData : JSON.stringify($scope.params)}, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.page_info.totalcount;
			$scope.board.totalPage = data.page_info.totalpage;
		});
	};
		
	$scope.onChecked = function(seq){
		var a = false;
		if($scope.result != '' && $scope.result != null){
			var resultArray = $scope.result;
			$(resultArray).each(function(i,v){
					if(v == seq){
						a = true;
					}
			});
		}
		return a;
	}
	
	$scope.onSelected = function(idval){
		if($("#c"+idval).prop("checked") == true){
			$scope.result.push(idval);
		}else{
			var resultArray = $scope.result;
			$scope.result = [];
			$(resultArray).each(function(i,v){
				if(v != idval){
					$scope.result.push(v);
				}
			})
		}
	}
	
	$scope.checkReset = function(){
		$scope.result = [];
	}
	
	$scope.itemSelect = function(){
		if($scope.result == null){
			dialogService.close("itemSearch", "");
		}else{
			dialogService.close("itemSearch", $scope.result);
		}
	}
});
</script>
</head>
<body data-ng-controller="mainCtrl">
  <div data-ng-view data-ng-cloak></div>
</body>
</html>
