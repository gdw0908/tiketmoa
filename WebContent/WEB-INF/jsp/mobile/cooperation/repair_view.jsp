<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<c:set var="view" value="${data.view }"/>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>상품검색</title>
<script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=<spring:eval expression="@config['navar.map.key']" />"></script>
<script type="text/javascript">
$(document).ready(function(){

	//#submenu
	$("#submenu_open").toggle(function(){
		$("#sub_menu").slideToggle(250);
		this.src = "/images/sub/sub_menu_close.gif";
	}, function() {
		$("#sub_menu").slideToggle(250);
		this.src = "/images/sub/sub_menu_open.gif";
	});
	var ngWidth = ($(window).width() * 0.92);
	var ngHeight = ($(window).height() * 0.5);
	nmap({ngTitle:"${view.com_nm}" ,ngXcoord:"${view.x_coord}", ngYcoord:"${view.y_coord}", ngWidth: ngWidth, ngHeight:ngHeight});
});

//네이버지도
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


function changeSido(){
	if($("#sido").val() == ""){
		$("#sigungu").empty();
		$("#sigungu").append("<option value=''>시/군/구</option>");
		$("#dong").empty();
		$("#dong").append("<option value=''>읍/면/동</option>");
	}else{
		$.getJSON("/json/list/code.sigungu.do", {sido: $("#sido").val()}, function(data){
			$("#sigungu").empty();
			$("#sigungu").append("<option value=''>시/군/구</option>");
			$("#dong").empty();
			$("#dong").append("<option value=''>읍/면/동</option>");
			$.each(data, function(i, o){
				$("#sigungu").append("<option value='"+o.sigungu+"'>"+o.dong_nm+"</option>");
			});
		});
	}
}

function changeSigungu(){
	$.getJSON("/json/list/code.dong.do", {sido: $("#sido").val(), sigungu: $("#sigungu").val()}, function(data){
		$("#dong").empty();
		$("#dong").append("<option value=''>읍/면/동</option>");
		$.each(data, function(i, o){
			$("#dong").append("<option value='"+o.dong+"'>"+o.dong_nm+"</option>");
		});
	});
}
</script>
</head>
<body>
	<form name="search" action="repair_list.do?menu=${param.menu }" method="post">
	<div class="sm_wrap">
        <div class="sm_top" style="padding-top:0px;">
          <div class="sm_con" id="sub_menu">
            <div class="con_2">
              <table class="sm_style_1">
              <colgroup>
              <col width="20%">
              <col width="">
              </colgroup>
              <tbody>
              <tr>
                <th scope="row">지역별</th>
                <td class="s_type_2">
                  <span>
                  <select id="sido" name="sido" class="select_sm" onchange="changeSido()">
	              	<option value="">시/도</option>
	              	<c:forEach var="item" items="${data.sido }">
	              		<option value="${item.sido }" <c:if test="${item.sido eq param.sido }">selected="selected"</c:if>>${item.dong_nm }</option>
	              	</c:forEach>
	              </select>
                  </span>

                  <span>
                  <select id="sigungu" name="sigungu" class="select_sm" onchange="changeSigungu()">
	              	<option value="">시/군/구</option>
	              	<c:forEach var="item" items="${data.sigungu }">
	              		<option value="${item.sigungu }" <c:if test="${item.sigungu eq param.sigungu }">selected="selected"</c:if>>${item.dong_nm }</option>
	              	</c:forEach>
	              </select>
                  </span>
                  <span class="last">
                  <select id="dong" name="dong" class="select_sm">
	              <option value="">읍/면/동</option>
	              	<c:forEach var="item" items="${data.dong }">
	              		<option value="${item.dong }" <c:if test="${item.dong eq param.dong }">selected="selected"</c:if>>${item.dong_nm }</option>
	              	</c:forEach>
	              </select>
                  </span>
                </td>
              </tr>

              <tr>
                <th scope="row">조건 내 검색</th>
                <td class="i_type_2">
                  <p>
                  <span class="input_t"><input type="text" name="keyword" class="input_1" value="${param.keyword }"></span>
                  <span class="btn">
                  <a href="javascript:document.search.reset();"><img src="/images/mobile/common/btn_reset.gif" alt="초기화"></a>
                  <a href="javascript:document.search.submit();"><img src="/images/mobile/common/btn_search.gif" alt="검색"></a>
                  </span>
                  </p>
                </td>
              </tr>
              </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </form>

      <div class="sub_wrap">
        <div class="sub_line">
          <h3><img src="/images/mobile/sub/sub_title_8.gif" alt="지역별 부품정보"></h3>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>

        <h3 class="g7h3"><p class="details_titleg7"><strong>${view.com_nm }</strong></p></h3>
		 <div class="map" id="nmap" style="margin-top:3px;"></div>
        <div class="d_con1 d_con1g7" style="overflow:hidden; padding-top:5px;">


          <div class="supply">
            <table class="details_style_2" style="border:none;">
            <colgroup>
            <col width="130px;">
            <col width="*">
            </colgroup>
            <tbody>

            <tr>
              <th>
              <p>대표자</p>
              <p>담당자</p>
              </th>
              <td>
                <p>${view.ceo_nm }</p>
                <p>${view.staff_nm }</p>
              </td>
            </tr>

            <tr>
              <th class="f_normal">사업장소재지</th>
              <td>
                <p>${view.addr1 } ${view.addr2 }</p>
                <!-- <p><img src="/images/sub/g7_15.gif" alt="도로명주소" /></p> -->
              </td>
            </tr>

            <tr>
              <th class="f_normal">
              <p>담당자번호</p>
              </th>
              <td>
                <p><strong>${view.staff_tel }</strong></p>
              </td>
            </tr>
<!-- 
            <tr class="last">
              <th class="f_normal">업태 &gt; 종목</th>
              <td>업태 &gt; 종목</td>
            </tr>
-->            
            <tr class="last">
              <th class="f_normal"><p>PARTSMOA 등록일</p></th>
              <td>
              	<p>${view.reg_dt }</p>
              </td>
           </tr>

            </tbody>
            </table>
          </div>
        </div>
		<h3 class="g7h3"><p class="details_titleg7"><strong><span style="color:#ce3434;">업체</span>설명</strong></p></h3>
		<div class="g7_memowarp">
          <div class="g7_memo">
            ${view.conts }
          </div>
        </div>
      </div>
<!--       <div class="view_top">
        <p class="btn_box btn_boxg7">
        <a href="repair_list.do?menu=${param.menu }&amp;cpage=${param.cpage }&amp;keyword=${param.keyword }&amp;sido=${param.sido }&amp;sigungu=${param.sigungu }&amp;dong=${param.dong }"><img src="/images/article/board_btn3.gif" alt="목록으로"></a>
        </p>
      </div> -->       
</body>
</html>
