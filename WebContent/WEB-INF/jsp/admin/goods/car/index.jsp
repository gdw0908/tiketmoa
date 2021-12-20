<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${!(sessionScope.member.group_seq eq '1' || sessionScope.member.group_seq eq '3')}">
<c:redirect url="/noPermission.do"/>
</c:if>
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
<script type="text/javascript" src="/lib/js/jquery-migrate-1.2.1.min.js"></script>
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
var app = angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myNmap', 'myFilter', 'myEditor', 'ngRange']);
app.run(function($rootScope){
	$rootScope.param = {
		gubun : "${param.gubun}",
		group_seq : "${sessionScope.member.group_seq}",
		com_seq : "${sessionScope.member.com_seq}",
		com_nm : "${sessionScope.member.com_nm}"
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
		$location.path("/list");
	}
	$scope.main.year = function(){
		return new Date().getFullYear();
	}
});
app.controller("listCtrl", function($scope, $window, $routeParams, $compile, ajaxService, dialogService, $filter) {
	$scope.param.cpage = $scope.param.cpage||1;
	<c:if test = "${sessionScope.member.group_seq ne '1'}">
	$scope.param.session_member_id = '${sessionScope.member.member_id}'
	</c:if>
	
	ajaxService.getAsyncJSON("/json/list/code.codeList.do", {code_group_seq : '37'}, function(data){
		$scope.color = data;
	});

	ajaxService.getAsyncJSON("/json/list/code.codeList.do", {code_group_seq : '38'}, function(data){
		$scope.grade = data;
	});
	$scope.changeNation = function(){
		ajaxService.getAsyncJSON("/json/list/old_code.carmaker.do", $scope.param, function(data){
			$scope.carmaker = data;
			$scope.carmodel = "";
			$scope.cargrade = "";
			$scope.changeCarmaker();
		});
	}
	$scope.changeCarmaker = function(){
		ajaxService.getJSON("/json/list/old_code.carmodel.do", $scope.param, function(data){
			$scope.carmodel = data;
			$scope.cargrade = "";
			$scope.changeCarmodel();
		});
	}
	$scope.changeCarmodel = function(){
		ajaxService.getJSON("/json/list/old_code.cargrade.do", $scope.param, function(data){
			$scope.cargrade = data;
		});
	}
	ajaxService.getAsyncJSON("/json/list/old_code.codeList.do", {upcodeno : '050901'}, function(data){
		$scope.part1 = data;
		$scope.changePart1();
	});
	$scope.changePart1 = function(){
		ajaxService.getJSON("/json/list/old_code.codeList.do", {upcodeno : $scope.param.part1}, function(data){
			$scope.part2 = data;
			$scope.changePart2();
		});
	}
	$scope.changePart2 = function(){
		ajaxService.getJSON("/json/list/old_code.carpart.do", {upcodeno : $scope.param.part2}, function(data){
			$scope.part3 = data;
		});
	}
	var angularDateFilter = $filter('date');
	$scope.search_yesterday = function(){
		var sdt = new Date().setDate(new Date().getDate() -1);
		$scope.param.sdate = angularDateFilter(sdt, 'yyyy-MM-dd');
		$scope.param.edate = angularDateFilter(sdt, 'yyyy-MM-dd');
	}
	
	$scope.search_today = function(){
		$scope.param.sdate = angularDateFilter(new Date(), 'yyyy-MM-dd');
		$scope.param.edate = angularDateFilter(new Date(), 'yyyy-MM-dd');
	}
	
	$scope.search_week = function(){
		var sdt = new Date().setDate(new Date().getDate() -7);
		var edt = new Date();
		$scope.param.sdate = angularDateFilter(sdt, 'yyyy-MM-dd');
		$scope.param.edate = angularDateFilter(edt, 'yyyy-MM-dd');
	}
	
	$scope.search_month = function(){
		var sdt = new Date().setDate(new Date().getDate() -30);
		var edt = new Date();
		$scope.param.sdate = angularDateFilter(sdt, 'yyyy-MM-dd');
		$scope.param.edate = angularDateFilter(edt, 'yyyy-MM-dd');
	}
	
	$scope.search_cmonth = function(){
		var today = new Date();
		var sdt = new Date().setDate(1);
		var edt = new Date(today.getFullYear(), today.getMonth()+1, 1).setDate(0);
		$scope.param.sdate = angularDateFilter(sdt, 'yyyy-MM-dd');
		$scope.param.edate = angularDateFilter(edt, 'yyyy-MM-dd');
	}
	
	$scope.search_bmonth = function(){
		var today = new Date();
		var sdt = new Date(today.getFullYear(), today.getMonth()-1, 1).setDate(1);
		var edt = new Date().setDate(0);
		$scope.param.sdate = angularDateFilter(sdt, 'yyyy-MM-dd');
		$scope.param.edate = angularDateFilter(edt, 'yyyy-MM-dd');
	}
	
	$scope.search_all = function(){
		$scope.param.sdate = "";
		$scope.param.edate = "";
	}
	
	$scope.chk_all_btn = function(){
		for (var i = 0; i < $scope.board.list.length; i++) {
			var item = $scope.board.list[i];
			if($scope.board.chk_all){
				item.check = "Y";
			}else{
				item.check = "N";
			}
		}
	}
	
	$scope.openPartSearch = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "900",
				height: "700",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("PartSearchDialog","/lib/js/partials/partsearch.html", {gubun : $scope.param.gubun}, options)
		.then(
			function(result) {
				$scope.param.carmakerseq = result.carmakerseq;
				$scope.changeCarmaker();
				$scope.param.carmodelseq = result.carmodelseq;
				$scope.param.cargradeseq = result.cargradeseq;
				$scope.param.part1 = result.part1;
				$scope.changePart1();
				$scope.param.part2 = result.part2;
				$scope.param.part3 = result.part3;
				$scope.param.part3_nm = result.part3_nm;
				$scope.param.grade = result.grade;
				$scope.param.caryyyy = result.caryyyy;
				$scope.param.color = result.color;
			},
			function(error) {
			}
		);
	}
	
	$scope.openCooperationSearch = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "800",
				height: "600",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("CooperationSearchDialog","/lib/js/partials/cooperationSearch.html", {}, options)
		.then(
			function(result) {
				$scope.param.com_nm = result.com_nm;
				$scope.param.com_seq = result.seq;
			},
			function(error) {
			}
		);
	}
	
	$scope.board = {};
	$scope.board.go = function(n){
		$scope.param.cpage=n;
		ajaxService.getJSON('/admin/goods/car/index.do?mode=list&cpage='+n, $scope.param, function(data){
			$scope.board.list = data.list;
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.pagination.totalcount;
			$scope.board.totalPage = data.pagination.totalpage;
		});
	};
	$scope.del = function(){
		if(!confirm("정말 삭제 하시겠습니까?")){
			return false;
		}
		
		var param = (function(list){
			var rst = [];
			for ( var i in list) {
				var item = list[i];
				if(angular.equals("Y", item.check)){
					rst.push({item_seq : item.item_seq});
				}
			}
			return rst;
		})($scope.board.list);
		
		ajaxService.getJSON("/admin/goods/car/index.do?mode=del", {jData : JSON.stringify({del : param})}, function(data){
			if(data.rst == '1'){
				$scope.board.go(1);
			}else{
				alert(data.msg);
			}
		});
	}
	
});
app.controller("writeCtrl", function($scope, $window, $routeParams, ajaxService, dialogService, $timeout) {
	$scope.form = {
		gubun : $scope.param.gubun,
		com_nm : $scope.param.com_nm,
		com_seq : $scope.param.com_seq,
		files : [
			{order_seq : 1},
			{order_seq : 2},
			{order_seq : 3},
			{order_seq : 4},
			{order_seq : 5},
			{order_seq : 6},
			{order_seq : 7},
			{order_seq : 8},
			{order_seq : 9},
			{order_seq : 10},
			{order_seq : 11},
			{order_seq : 12},
			{order_seq : 13},
			{order_seq : 14},
			{order_seq : 15},
			{order_seq : 16},
			{order_seq : 17},
			{order_seq : 18},
			{order_seq : 19},
			{order_seq : 20}
		]
	};
	
	ajaxService.getJSON("/json/list/part.cooperationList.do", {}, function(data){
		$scope.cooperationList = data;
	});
	
	ajaxService.getJSON("/json/list/code.codeList.do", {code_group_seq : '37'}, function(data){
		$scope.color = data;
	});

	ajaxService.getJSON("/json/list/code.codeList.do", {code_group_seq : '38'}, function(data){
		$scope.grade = data;
	});
	ajaxService.getJSON("/json/list/old_code.carmaker.do", {}, function(data){
		$scope.carmaker = data;
		$scope.carmodel = "";
		$scope.cargrade = "";
		$scope.changeCarmaker();
	});
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
	ajaxService.getJSON("/json/list/old_code.codeList.do", {upcodeno : '050901'}, function(data){
		$scope.part1 = data;
		$scope.changePart1();
	});
	$scope.changePart1 = function(){
		ajaxService.getJSON("/json/list/old_code.codeList.do", {upcodeno : $scope.form.part1}, function(data){
			$scope.part2 = data;
			$scope.changePart2();
		});
	}
	$scope.changePart2 = function(){
		ajaxService.getJSON("/json/list/old_code.carpart.do", {upcodeno : $scope.form.part2}, function(data){
			$scope.part3 = data;
		});
	}
	
	$scope.openPartSearch = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "900",
				height: "700",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("PartSearchDialog","/lib/js/partials/partsearch.html", {gubun : $scope.param.gubun}, options)
		.then(
			function(result) {
				$scope.form.carmakerseq = result.carmakerseq;
				$scope.changeCarmaker();
				$scope.form.carmodelseq = result.carmodelseq;
				$scope.form.cargradeseq = result.cargradeseq;
				$scope.form.part1 = result.part1;
				$scope.changePart1();
				$scope.form.part2 = result.part2;
				$scope.form.part3 = result.part3;
				$scope.form.part3_nm = result.part3_nm;
				$scope.form.grade = result.grade;
				$scope.form.caryyyy = result.caryyyy;
				$scope.form.color = result.color;
			},
			function(error) {
			}
		);
	}
	
	$scope.uploadFile = function(idx){
		var filename = $("#file"+idx).val();
		if(filename == ''){	//한번 올려지고 비워지기때문에 onchange가 한번더 일어나기 때문에 필요
			return;
		}
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
			alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
			if($.browser.msie){ // IE 일 경우
 			   $("#file"+idx).replaceWith( $("#file"+idx).clone(true) );
 			}else{
	    			$("#file"+idx).val('');
 			}
			return false;
		}
    	$("#wFrm").ajaxSubmit({
    		url : '/ajaxUploadCar.do',
    		iframe: true,
    		dataType : "json",
    		uploadProgress : function(event, position, total, percentComplete){
    		},
    		success : function(data){
    			$scope.addFile(data, idx);
    			if($.browser.msie){ // IE 일 경우
    			   $("#file"+idx).replaceWith( $("#file"+idx).clone(true) );
    			}else{
	    			$("#file"+idx).val('');
    			}
    		},
    		error: function(e){
    			alert(e.responseText);
    		}
    	});
	}
	
	$scope.addFile = function(data, idx){
		data.order_seq = idx;
		$scope.$apply(function(){
			$scope.form.files.splice(idx-1, 1, data);
		});
	}
	
	$scope.removeFile = function(idx){
		$scope.form.files.splice(idx, 1);
	}
	
	$scope.salePrice = function(){
		$scope.form.sale_price = (function(discount_rate2){
			if(discount_rate2 > 0){
				return $scope.form.user_price - Math.floor($scope.form.user_price * discount_rate2 / 100);
			}else{
				return "";
			}
		})($scope.form.discount_rate2|0);
	}
	
	$scope.supplierPrice = function(){
		
		$scope.form.supplier_price = (function(){
			if($scope.form.supplier_pricing_yn == "Y"){
				var commission = (function(list){
					for (var i in list) {
						var item = list[i];
						if(item.seq == $scope.form.com_seq){
							return item.commission;
						}
					}
				})($scope.cooperationList);
				
				return $scope.form.user_price - Math.floor($scope.form.user_price * commission / 100);
			}else{
				return "";
			}
		})();
	}
	
	$scope.$watch("form.caryyyy", function(newVal, oldVal){
		if(angular.equals(newVal, oldVal)){
			return;
		}
		$scope.productnm_sum();
	});
	
	$scope.$watch("form.carmodelseq", function(newVal, oldVal){
		if(angular.equals(newVal, oldVal)){
			return;
		}
		$scope.productnm_sum();
	});
	
	$scope.$watch("form.part3", function(newVal, oldVal){
		if(angular.equals(newVal, oldVal)){
			return;
		}
		$scope.productnm_sum();
	});
	
	$scope.productnm_sum = function(){
		var f = $scope.form;
		var rst = "";
		for (var i in $scope.carmodel) {
			var item = $scope.carmodel[i];
			if(angular.equals(item.carmodelseq, f.carmodelseq)){
				rst = item.carmodelnm;
				break;
			}
		}
		for (var i in $scope.part3) {
			var item = $scope.part3[i];
			if(angular.equals(item.code, f.part3)){
				rst += " "+item.code_nm;
				break;
			}
		}
		if(!!f.caryyyy){
			rst += " ("+f.caryyyy+")";
		}
		$scope.form.productnm = rst.replace("undefined", "");
	}
	
	$scope.save = function(){
		
		if($scope.form.files.length == 0){
			alert("상품사진을 하나이상 올리셔야 합니다.");
			return false;
		}
			
		if($scope.frm.$invalid){
			if($scope.frm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		$scope.form.discount_rate = $scope.form.discount_rate2; 
		ajaxService.getJSON("/admin/goods/car/index.do?mode=write", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}
	
	var copyForm;
	$timeout(function(){
		copyForm = {
			form : angular.copy($scope.form),
			carmaker : angular.copy($scope.carmaker),
			carmodel : angular.copy($scope.carmodel),
			cargrade : angular.copy($scope.cargrade),
			part1 : angular.copy($scope.part1),
			part2 : angular.copy($scope.part2),
			part3 : angular.copy($scope.part3)
		};
	}, 500);
	
	$scope.resetForm = function(){
		$scope.carmaker = angular.copy(copyForm.carmaker);
		$scope.carmodel = angular.copy(copyForm.carmodel);
		$scope.cargrade = angular.copy(copyForm.cargrade);
		$scope.part1 = angular.copy(copyForm.part1);
		$scope.part2 = angular.copy(copyForm.part2);
		$scope.part3 = angular.copy(copyForm.part3);
		$scope.form = angular.copy(copyForm.form);
	}
});
app.controller("modifyCtrl", function($scope, $window, $routeParams, ajaxService, dialogService, $filter, $timeout) {
	$scope.form = {
			files : []
		};
		var angularDateFilter = $filter('myDate');
		ajaxService.getJSON("/admin/goods/car/index.do?mode=view", {seq : $routeParams.seq}, function(data){
			$scope.form = data.view;
			$scope.form.sale_sdate = angularDateFilter(data.view.sale_sdate, 'yyyy-MM-dd');
			$scope.form.sale_edate = angularDateFilter(data.view.sale_edate, 'yyyy-MM-dd');
			$scope.form.files = [
						{order_seq : 1},
						{order_seq : 2},
						{order_seq : 3},
						{order_seq : 4},
						{order_seq : 5},
						{order_seq : 6},
						{order_seq : 7},
						{order_seq : 8},
						{order_seq : 9},
						{order_seq : 10},
						{order_seq : 11},
						{order_seq : 12},
						{order_seq : 13},
						{order_seq : 14},
						{order_seq : 15},
						{order_seq : 16},
						{order_seq : 17},
						{order_seq : 18},
						{order_seq : 19},
						{order_seq : 20}
					];
			for (var i=0; i < (data.files).length; i++) {
					var item = data.files[i];
					item.load="Y";
					$scope.form.files[(item.order_seq-1)] = item;
				}
			$scope.form.removeFiles = [];
			if(!$scope.form.productnm){
				$timeout(function(){
					$scope.productnm_sum();
				}, 1000);
			}
		});
	
	ajaxService.getJSON("/json/list/part.cooperationList.do", {}, function(data){
		$scope.cooperationList = data;
	});
	
	ajaxService.getJSON("/json/list/code.codeList.do", {code_group_seq : '37'}, function(data){
		$scope.color = data;
	});

	ajaxService.getJSON("/json/list/code.codeList.do", {code_group_seq : '38'}, function(data){
		$scope.grade = data;
	});
	ajaxService.getJSON("/json/list/old_code.carmaker.do", {}, function(data){
		$scope.carmaker = data;
		$scope.carmodel = "";
		$scope.cargrade = "";
		$scope.changeCarmaker();
	});
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
	ajaxService.getJSON("/json/list/old_code.codeList.do", {upcodeno : '050901'}, function(data){
		$scope.part1 = data;
		$scope.changePart1();
	});
	$scope.changePart1 = function(){
		ajaxService.getJSON("/json/list/old_code.codeList.do", {upcodeno : $scope.form.part1}, function(data){
			$scope.part2 = data;
			$scope.changePart2();
		});
	}
	$scope.changePart2 = function(){
		ajaxService.getJSON("/json/list/old_code.carpart.do", {upcodeno : $scope.form.part2}, function(data){
			$scope.part3 = data;
		});
	}
	
	$scope.openPartSearch = function(){
		var options = {
				autoOpen: false,
				modal: true,
				width: "900",
				height: "700",
				close: function(event, ui) {
				}
			};
		
		dialogService.open("PartSearchDialog","/lib/js/partials/partsearch.html", {gubun : $scope.param.gubun}, options)
		.then(
			function(result) {
				$scope.form.carmakerseq = result.carmakerseq;
				$scope.changeCarmaker();
				$scope.form.carmodelseq = result.carmodelseq;
				$scope.form.cargradeseq = result.cargradeseq;
				$scope.form.part1 = result.part1;
				$scope.changePart1();
				$scope.form.part2 = result.part2;
				$scope.form.part3 = result.part3;
				$scope.form.part3_nm = result.part3_nm;
				$scope.form.grade = result.grade;
				$scope.form.caryyyy = result.caryyyy;
				$scope.form.color = result.color;
			},
			function(error) {
			}
		);
	}
	
	$scope.uploadFile = function(idx){
		var filename = $("#file"+idx).val();
		if(filename == ''){	//한번 올려지고 비워지기때문에 onchange가 한번더 일어나기 때문에 필요
			return;
		}
		filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
		if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
			alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
			if($.browser.msie){ // IE 일 경우
 			   $("#file"+idx).replaceWith( $("#file"+idx).clone(true) );
 			}else{
	    			$("#file"+idx).val('');
 			}
			return false;
		}
    	$("#wFrm").ajaxSubmit({
    		url : '/ajaxUploadCar.do',
    		iframe: true,
    		dataType : "json",
    		uploadProgress : function(event, position, total, percentComplete){
    		},
    		success : function(data){
    			$scope.addFile(data, idx);
    			if($.browser.msie){ // IE 일 경우
    			   $("#file"+idx).replaceWith( $("#file"+idx).clone(true) );
    			}else{
	    			$("#file"+idx).val('');
    			}
    		},
    		error: function(e){
    			alert(e.responseText);
    		}
    	});
	}
	
	$scope.addFile = function(data, idx){
		data.order_seq = idx;
		$scope.$apply(function(){
			$scope.form.files.splice(idx-1, 1, data);
		});
	}
	
	$scope.removeFile = function(idx){
		$scope.form.removeFiles.push($scope.form.files[idx]);
		$scope.form.files.splice(idx, 1);
	}
	
	$scope.salePrice = function(){
		$scope.form.sale_price = (function(discount_rate2){
			if(discount_rate2 > 0){
				return $scope.form.user_price - Math.floor($scope.form.user_price * discount_rate2 / 100);
			}else{
				return "";
			}
		})($scope.form.discount_rate2|0);
	}
	
	$scope.supplierPrice = function(){
		
		$scope.form.supplier_price = (function(){
			if($scope.form.supplier_pricing_yn == "Y"){
				var commission = (function(list){
					for (var i in list) {
						var item = list[i];
						if(item.seq == $scope.form.com_seq){
							return item.commission;
						}
					}
				})($scope.cooperationList);
				
				return $scope.form.user_price - Math.floor($scope.form.user_price * commission / 100);
			}else{
				return "";
			}
		})();
	}
	
	$scope.$watch("form.caryyyy", function(newVal, oldVal){
		if(angular.equals(newVal, oldVal)){
			return;
		}
		$scope.productnm_sum();
	});
	
	$scope.$watch("form.carmodelseq", function(newVal, oldVal){
		if(angular.equals(newVal, oldVal)){
			return;
		}
		$scope.productnm_sum();
	});
	
	$scope.$watch("form.part3", function(newVal, oldVal){
		if(angular.equals(newVal, oldVal)){
			return;
		}
		$scope.productnm_sum();
	});
	
	$scope.productnm_sum = function(){
		var f = $scope.form;
		var rst = "";
		for (var i in $scope.carmodel) {
			var item = $scope.carmodel[i];
			if(angular.equals(item.carmodelseq, f.carmodelseq)){
				rst = item.carmodelnm;
				break;
			}
		}
		for (var i in $scope.part3) {
			var item = $scope.part3[i];
			if(angular.equals(item.code, f.part3)){
				rst += " "+item.code_nm;
				break;
			}
		}
		if(!!f.caryyyy){
			rst += " ("+f.caryyyy+")";
		}
		$scope.form.productnm = rst.replace("undefined", "");
	}
	
	$scope.save = function(){
		
		if($scope.form.files.length == 0){
			alert("상품사진을 하나이상 올리셔야 합니다.");
			return false;
		}
			
		if($scope.frm.$invalid){
			if($scope.frm.$error.required){
				alert("필수값을 입력하여 주십시오.");
			}else{
				alert("값이 유효하지 않습니다.");
			}
			$("#wFrm .ng-invalid")[0].focus();
			return false;
		}
		$scope.form.discount_rate = $scope.form.discount_rate2;
		ajaxService.getJSON("/admin/goods/car/index.do?mode=modify", {jData : JSON.stringify($scope.form)}, function(data){
			$scope.list();
		});
	}
	
	var copyForm;
	$timeout(function(){
		copyForm = {
			form : angular.copy($scope.form),
			carmaker : angular.copy($scope.carmaker),
			carmodel : angular.copy($scope.carmodel),
			cargrade : angular.copy($scope.cargrade),
			part1 : angular.copy($scope.part1),
			part2 : angular.copy($scope.part2),
			part3 : angular.copy($scope.part3)
		};
	}, 500);
	
	$scope.resetForm = function(){
		$scope.carmaker = angular.copy(copyForm.carmaker);
		$scope.carmodel = angular.copy(copyForm.carmodel);
		$scope.cargrade = angular.copy(copyForm.cargrade);
		$scope.part1 = angular.copy(copyForm.part1);
		$scope.part2 = angular.copy(copyForm.part2);
		$scope.part3 = angular.copy(copyForm.part3);
		$scope.form = angular.copy(copyForm.form);
	}
});
app.controller("cooperationSearchCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.param = {
		condition : "com_nm"
	};
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getJSON('/json/list/cooperation.list.do?cpage='+n, $scope.param, function(data){
			$scope.board.list = data;
		});
		ajaxService.getJSON('/json/request/cooperation.pagination.do', $scope.param, function(data){
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.totalcount;
			$scope.board.totalPage = data.totalpage;
		});
	};
	
	$scope.send = function(item) {
		dialogService.close("CooperationSearchDialog", item);
	};

	$scope.cancel = function() {
		dialogService.cancel("CooperationSearchDialog");
	};
});
app.controller("partSearchCtrl", function($scope, $window, $routeParams, ajaxService, dialogService) {
	$scope.search = {
		gubun : $scope.model.gubun
		,session_member_id : ''
	};
	
	ajaxService.getAsyncJSON("/json/list/code.codeList.do", {code_group_seq : '37'}, function(data){
		$scope.color = data;
	});

	ajaxService.getAsyncJSON("/json/list/code.codeList.do", {code_group_seq : '38'}, function(data){
		$scope.grade = data;
	});
	$scope.changeNation = function(){
		ajaxService.getAsyncJSON("/json/list/old_code.carmaker.do", $scope.search, function(data){
			$scope.carmaker = data;
			$scope.carmodel = "";
			$scope.cargrade = "";
		});
	}
	$scope.changeCarmaker = function(carmakerseq){
		ajaxService.getJSON("/json/list/old_code.carmodel.do", $scope.search, function(data){
			$scope.carmodel = data;
			$scope.cargrade = "";
		});
	}
	$scope.changeCarmodel = function(carmakerseq, carmodelseq){
		ajaxService.getJSON("/json/list/old_code.cargrade.do", $scope.search, function(data){
			$scope.cargrade = data;
		});
	}
	ajaxService.getAsyncJSON("/json/list/old_code.codeList.do", {upcodeno : '050901'}, function(data){
		$scope.part1 = data;
	});
	$scope.changePart1 = function(){
		ajaxService.getJSON("/json/list/old_code.codeList.do", {upcodeno : $scope.search.part1}, function(data){
			$scope.part2 = data;
		});
	}
	$scope.changePart2 = function(){
		ajaxService.getJSON("/json/list/old_code.carpart.do", {upcodeno : $scope.search.part2}, function(data){
			$scope.part3 = data;
		});
	}
	
	$scope.board = {};
	$scope.board.go = function(n){
		ajaxService.getJSON('/json/list/part.list.do?cpage='+n, $scope.search, function(data){
			$scope.board.list = data;
		});
		ajaxService.getJSON('/json/request/part.pagination.do', $scope.search, function(data){
			$scope.board.currentPage = n;
			$scope.board.totalCount = data.totalcount;
			$scope.board.totalPage = data.totalpage;
		});
	};
	$scope.board.go(1);
	
	$scope.send = function(item){
		dialogService.close("PartSearchDialog", item);
	}
});
</script>
</head>
<body data-ng-controller="mainCtrl" data-ng-cloak>
  <div data-ng-view data-ng-cloak></div>
</body>
</html>