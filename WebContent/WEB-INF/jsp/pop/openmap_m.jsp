<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld"%>
<style>
	.mobile_carall_pop img{width:100%;}
</style>
	<div class="details_info">
		<p class="details_title">
			${data.com_nm }
		</p>
		<p class="details_title">
			<div id="nmap" class="map"></div>
		</p>
		<table class="details_style_1" style="margin-top:10px;">
			<colgroup>
				<col width="35%">
				<col width="">
			</colgroup>
			<tbody>
				<tr>
					<th style="width:110px;">업체명</th>
					<td style="text-align:left;">${data.com_nm }</td>
				</tr>
				<tr>
					<th style="width:110px;">대표</th>
					<td style="text-align:left;">${data.ceo_nm }</td>
				</tr>
				<tr>
					<th style="width:110px;">전화번호<br/>팩스</th>
					<td style="text-align:left;">${data.tel }<br/>${data.fax }</td>
				</tr>
				<tr>
					<th style="width:110px;">담당자<br/>전화번호</th>
					<td style="text-align:left;">${data.staff_nm }<br/>${data.staff_tel1 }-${data.staff_tel2 }-${data.staff_tel3 }</td>
				</tr>
				<tr>
					<th style="width:110px;">주소</th>
					<td style="text-align:left;">${data.zip_cd }<br/>${data.addr1 }<br/>${data.addr2 }</td>
				</tr>
				<tr>
					<th style="text-align:center" colspan="2">업체설명</th>
				</tr>
				<tr>
					<td style="text-align:left;"colspan="2" class="mobile_carall_pop">${data.conts }</td>
				</tr>				
	  		</tbody>
		</table>
	</div>
<script type="text/javascript">
function nmap(scope){
	if((scope.ngXcoord == "" || scope.ngXcoord == 0) || (scope.ngYcoord == "" || scope.ngYcoord == 0) ) {
		return false;
	}
	
	var oPoint = new nhn.api.map.LatLng(scope.ngYcoord, scope.ngXcoord);
	var oMap = new nhn.api.map.Map("nmap"  ,{
		point : oPoint,// 지도 중심점의 좌표
		zoom : 12,// 지도의 축척 레벨
//			boundary : pointArr, // 지도 생성 시 주어진 array 에 있는 점이 모두 보일 수 있도록 지도를 초기화한다.
//			boundaryOffset : Number // boundary로 지도를 초기화 할 때 지도 전체에서 제외되는 영역의 크기.
		enableWheelZoom : true, // 마우스 휠 동작으로 지도를 확대/축소할지 여부
		enableDragPan : true,// 마우스로 끌어서 지도를 이동할지 여부
		enableDblClickZoom : true,// 더블클릭으로 지도를 확대할지 여부
		mapMode : 0,	// 지도 모드(0 : 일반 지도, 1 : 겹침 지도, 2 : 위성 지도)
		activateTrafficMap : false,	// 실시간 교통 활성화 여부
		activateBicycleMap : false, // 자전거 지도 활성화 여부
		minMaxLevel : [ 5, 14 ],	// 지도의 최소/최대 축척 레벨
		size : new nhn.api.map.Size(scope.ngWidth, scope.ngHeight),	// 지도의 크기
		detectCoveredMarker : true // 겹쳐 있는 마커를 클릭했을 때 겹친 마커 목록 표시 여부
	});
	
	var oSlider = new nhn.api.map.ZoomControl();
	oMap.addControl(oSlider);
	oSlider.setPosition({
		top : 10,
		left : 10
	});
	
	var oMapType = new nhn.api.map.MapTypeBtn();
	oMap.addControl(oMapType);
	oMapType.setPosition({
		top : 10,
		right : 35
	});
	
	var IconOption = {
			url:"http://static.naver.com/maps2/icons/pin_spot2.png", 
			size:{width:28, height:37},
			spriteSize:{width:27, height:36},
			imgOrder:0, 
			offset : {width: 14, height: 37}
	};
	var Icon = new nhn.api.map.Icon(IconOption.url, IconOption.size, IconOption.spriteSize, 0, IconOption.offset);
	
	var oMarker = null;
	function marker(point, title){
		var rstMarker = null;
		rstMarker = new nhn.api.map.Marker(Icon , {	
			title : title,
			point : point,
			zIndex : 1,
			enableDragPan : true,
			smallSrc :  Icon});
		oMarker = rstMarker;
		return rstMarker;
	}
	
	oMap.addOverlay(marker(oPoint, scope.ngTitle));
	oMap.setCenter(oPoint);
	
	var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.
	oMap.attach('mouseenter', function(oCustomEvent) {                        
	    var oTarget = oCustomEvent.target;                        
	    // 마커위에 마우스 올라간거면                        
	    if (oTarget instanceof nhn.api.map.Marker || oTarget instanceof nhn.api.map.DraggableMarker) {                                                             
	        oLabel.setVisible(true, oTarget); // - 특정 마커를 지정하여 해당 마커의 title을 보여준다.                        
	    }                
	});                
	oMap.attach('mouseleave', function(oCustomEvent) {                        
	    var oTarget = oCustomEvent.target;                        
	    // 마커위에서 마우스 나간거면                        
	    if (oTarget instanceof nhn.api.map.Marker || oTarget instanceof nhn.api.map.DraggableMarker) {                                
	        oLabel.setVisible(false);                        
	    }                
	});
	// 정보상자(안보이는 상태로 맵에 추가해 놓기) 
	var oInfoWnd = new nhn.api.map.InfoWindow();                
	oInfoWnd.setVisible(false);                
	oMap.addOverlay(oInfoWnd);                
	oInfoWnd.setPosition({                        
	    top : 20,                        
	    left :20                
	});
	
	// 마커라벨(안보이는 상태로 맵에 추가해 놓기) 
	var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.                
	oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.                
	oInfoWnd.attach('changeVisible', function(oCustomEvent) {                        
	    if (oCustomEvent.visible) {                                
	        oLabel.setVisible(false);                        
	    }                
	});
}
$(document).ready(function(){
	var ngWidth = ($(window).width() * 0.85);
	var ngHeight = ($(window).height() * 0.4);
	if(ngHeight == 0 ){
		ngHeight = 200;
	}
	nmap({ngTitle:"${data.com_nm}" ,ngXcoord:"${data.x_coord}", ngYcoord:"${data.y_coord}", ngWidth:ngWidth, ngHeight:ngHeight});	
})
</script>