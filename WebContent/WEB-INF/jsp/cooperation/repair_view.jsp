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
<link rel="stylesheet" href="/lib/css/sub.css" type="text/css">
<script type="text/javascript" src="/lib/js/jcarousellite_1.0.1.js"></script>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=<spring:eval expression="@config['navar.map.key']" />"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(window).scrollTop($("#content_view").offset().top);
	//#submenu
	$("#submenu_open").toggle(function(){
		$("#sub_menu").slideToggle(250);
		this.src = "/images/sub/sub_menu_close.gif";
	}, function() {
		$("#sub_menu").slideToggle(250);
		this.src = "/images/sub/sub_menu_open.gif";
	});
	$("#other_list").load("/popup/cooperation/other_list.do?com_seq=${view.seq}&cpage=1");
	nmap({ngTitle:"${view.com_nm}" ,ngXcoord:"${view.x_coord}", ngYcoord:"${view.y_coord}", ngWidth: 416, ngHeight:342});
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

function other_listPage(page){
	$("#other_list").load("/popup/cooperation/other_list.do?com_seq=${view.seq}&cpage="+page);
}
</script>
</head>
<body>

	<div class="gnb_wrap">
        <!-- gnb메뉴 -->
		<page:applyDecorator name="gnb" />
        <!-- //gnb메뉴 -->
    </div>

    <div class="sub_line_bg bg7">
      <div class="sub_line sub_lineg7">
        <div class="sl_wrap">
          <div class="sl_l" id="content_view">
            <h3><img src="/images/sub/title_7_a.gif" alt="지역별 정비업체정보"></h3>
          </div>
          <div class="sl_r">
          </div>
        </div>
      </div>
    </div>
    <!-- all_menu on End -->
    
    <div class="sub_wrap">
      <div class="sub_contents">
        <div class="sub_list">
          <h3 class="g7h3"><p class="details_titleg7"><strong>${view.com_nm }</strong></p></h3>
          <div class="d_con1 d_con1g7" style="overflow:hidden;">

            <div id="nmap" class="map"></div>

            <div class="supply">
              <table class="details_style_2" style="border:none;">
              <colgroup>
              <col width="130px;" />
              <col width="*" />
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
                <p><strong>담당자번호</strong></p>
                </th>
                <td>
                  <p><strong>${view.staff_tel }</strong></p>
                </td>
              </tr>
<!-- 
              <tr>
                <th class="f_normal">업태 &gt; 종목</th>
                <td> &gt; </td>
              </tr>
 -->
              <tr class="last">
                <th class="f_normal">
                <p>PARTSMOA 등록일</p>
                </th>
                <td>
                  <p>${view.reg_dt }</p>
                </td>
              </tr>
              </tbody>
              </table>
            </div>
          </div>

          <h3 class="g7h3"><p class="details_titleg7"><strong><span style="color:#ce3434;" >업체</span>설명</strong></p></h3>
          <div class="g7_memowarp">
            <div class="g7_memo">
              ${view.conts }
            </div>
          </div>

          <div class="view_top">
            <p class="btn_box btn_boxg7">
            <a href="repair_list.do?menu=${param.menu }&amp;cpage=${param.cpage }&amp;keyword=${param.keyword }&amp;sido=${param.sido }&amp;sigungu=${param.sigungu }&amp;dong=${param.dong }"><img src="/images/article/board_btn3.gif" alt="목록으로"></a>
            </p>
          </div>
          <!-- //d_tab_roll -->

        </div>

      </div>

    </div>
</body>
</html>
