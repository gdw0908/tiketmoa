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
<c:set var="files" value="${data.files }"/>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta property="og:type" content="website" />
<meta property="og:title" content=":: 국내최대 자동차 중고부품 쇼핑몰 PARTSMOA(파츠모아) ! ::" />
<meta property="og:description" content="${view.part3_nm } / ${view.makernm } ${view.carmodelnm } ${view.cargradenm } / ${view.grade}등급" />
<meta property="og:image" content="http://www.partsmoa.co.kr/images/favicon/favicon.jpg" />
<title>상품검색</title>
<link rel="stylesheet" href="/lib/css/sub.css" type="text/css">
<script type="text/javascript" src="/lib/js/jcarousellite_1.0.1.js"></script>
<script type="text/javascript" src="/lib/js/jquery.xml2json.js"></script>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=<spring:eval expression="@config['navar.map.key']" />"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(window).scrollTop($("#content_view").offset().top);
	nmap({ngTitle:"${view.com_nm}" ,ngXcoord:"${view.x_coord}", ngYcoord:"${view.y_coord}", ngWidth: 416, ngHeight:342});
	other_listPage(1);
});

function setCookie(cname,cvalue,exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays*24*60*60*1000));
	var expires = "expires=" + d.toGMTString();
	document.cookie = cname+"="+cvalue+"; "+expires+"; path=/";
}
setCookie("part_view_${view.item_seq}",'${view.item_seq}',1);

//다른상품
function other_listPage(page){
	$(".d_con2").load("/popup/goods/other_list.do?seq=${param.seq}&cpage="+page);
}

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


function changeCarmaker(){
	
	$.getJSON("/json/list/old_code.carmodel.do", {carmakerseq : $("#carmakerseq").val()}, function(data){
		$("#carmodelseq").empty();
		$.each(data, function(i, o){
			$("#carmodelseq").append("<option value='"+o.carmodelseq+"'>"+o.carmodelnm+"</option>");
		});
	});
}

function changeCarmodel(){
	$.getJSON("/json/list/old_code.cargrade.do", {carmakerseq: $("#carmakerseq").val(),  carmodelseq: $("#carmodelseq").val()}, function(data){
		$("#cargradeseq").empty();
		$.each(data, function(i, o){
			$("#cargradeseq").append("<option value='"+o.cargradeseq+"'>"+o.cargradenm+"</option>");
		});
	});
}

function changeSido(){
	$.getJSON("/json/list/code.sigungu.do", {sido: $("#sido").val()}, function(data){
		$("#sigungu").empty();
		$("#sigungu").append("<option value=''>시/군/구</option>");
		$.each(data, function(i, o){
			$("#sigungu").append("<option value='"+o.sigungu+"'>"+o.dong_nm+"</option>");
		});
	});
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

function cart(seq){
	<c:choose>
		<c:when test="${empty view.stock_num || view.stock_num <= 0}">
			alert("재고수량이 없습니다.");
		</c:when>
		<c:otherwise>
			location.href="/mypage/shopping/cart/index.do?mode=add_cart&seq="+seq+"&qty="+$("#qty").val();
		</c:otherwise>
	</c:choose>
}

function snsLink(gubun){
	var url = location.href;
	$.ajax({
		type : "POST",
		url : "/shorturl.do",
		data : {
			fullurl : "http://openapi.naver.com/shorturl.xml?url="+encodeURIComponent(url)
		},
		dataType : "text",
		success : function(transUrl){
			var title = encodeURIComponent("${view.part3_nm } / ${view.makernm } ${view.carmodelnm } ${view.cargradenm } / ${view.grade}등급| Partsmoa 국내최대 자동차 중고부품 쇼핑몰");
			if(gubun == "twt"){
				window.open("http://twitter.com/home?status=" + title + ":" + transUrl);
			}else if(gubun == "face"){
				window.open("http://www.facebook.com/sharer/sharer.php?u=" + transUrl);
			}
		}
	});	
}

function goSubmit(){
	$("#frm").submit();
}
</script>
<script type="text/javascript">
function view(opt) {
	  if(opt) {
	     spec1.style.display = "block";
	  }
	  else {
	     spec1.style.display = "none";
	  }
	}
</script>
</head>

<body>
<div class="gnb_wrap"> 
  <!-- gnb메뉴 -->
  <page:applyDecorator name="gnb" />
  <!-- //gnb메뉴 --> 
</div>
<div class="sub_line_bg">
  <div class="sub_line">
    <div class="sl_wrap">
      <div class="sl_l" id="content_view">
        <c:choose>
        	<c:when test="${param.menu != '' && param.menu != null}"><%-- menu not null --%>
        		<c:choose>
        			<c:when test="${param.menu == 'menu1'}">
        				<h3><img src="/images/sub/body_title.gif" alt="바디 부품정보"></h3>
        			</c:when>
        			<c:when test="${param.menu == 'menu2'}">
        				<h3><img src="/images/sub/title_2.gif" alt="의장 부품정보"></h3>
        			</c:when>
        			<c:when test="${param.menu == 'menu3'}">
        				<h3><img src="/images/sub/title_3.gif" alt="엔진 부품정보"></h3>
        			</c:when>
        			<c:when test="${param.menu == 'menu4'}">
        				<h3><img src="/images/sub/title_4.gif" alt="샤시 부품정보"></h3>
        			</c:when>
        			<c:when test="${param.menu == 'menu5'}">
        				<h3><img src="/images/sub/title_5.gif" alt="국산차 부품정보"></h3>
        			</c:when>
        			<c:when test="${param.menu == 'menu6'}">
        				<h3><img src="/images/sub/title_6.gif" alt="수입차 부품정보"></h3>
        			</c:when>
        		</c:choose>
        	</c:when>
        	<c:otherwise>
        		<c:set var="menu" value="${fn:substring(view.part1, 8, 9) }"/>
        		<c:choose>
        			<c:when test="${menu == '1'}">
        				<h3><img src="/images/sub/body_title.gif" alt="바디 부품정보"></h3>
        			</c:when>
        			<c:otherwise>
        				<h3><img src="/images/sub/title_${menu}.gif" alt="부품정보"></h3>
        			</c:otherwise>
        		</c:choose>
        	</c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
  <!-- all_menu on -->
  <div class="sm_wrap" style="display:none;" id="sub_menu">
    <div class="sub_menu">
      <div class="product_list">
        <form action="/goods/list.do?menu=${param.menu }" method="post" id="frm" name="frm">
          <p class="pl_title">※ 검색조건과 함께 찾으시는 부품을 선택해 주세요</p>
          <table>
            <colgroup>
            <col width="15.5%">
            <col width="18%">
            <col width="">
            <col width="14.5%">
            <c:if test="${param.menu eq 'menu1' || param.menu eq 'menu2' || param.menu eq 'menu3' || param.menu eq 'menu4'}">
              <col width="18%">
            </c:if>
            <col width="12%">
            </colgroup>
            <thead>
              <tr>
                <th scope="col">제조사</th>
                <th scope="col">차량명</th>
                <th scope="col">모델명</th>
                <th scope="col">연식</th>
                <c:if test="${param.menu eq 'menu1' || param.menu eq 'menu2' || param.menu eq 'menu3' || param.menu eq 'menu4'}">
                  <th scope="col">부품</th>
                </c:if>
                <th scope="col">등급</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><select id="carmakerseq" name="carmakerseq" class="select_1" size="8" onchange="changeCarmaker()">
                    <c:forEach var="item" items="${data.carmaker }">
                      <option value="${item.carmakerseq }" <c:if test="${item.carmakerseq eq param.carmakerseq }">selected="selected"</c:if>>${item.makernm }</option>
                    </c:forEach>
                  </select></td>
                <td><select id="carmodelseq" name="carmodelseq" class="select_1" size="8" onchange="changeCarmodel()">
                    <c:forEach var="item" items="${data.carmodel }">
                      <option value="${item.carmodelseq }" <c:if test="${item.carmodelseq eq param.carmodelseq }">selected="selected"</c:if>>${item.carmodelnm }</option>
                    </c:forEach>
                  </select></td>
                <td><select id="cargradeseq" name="cargradeseq" class="select_1" size="8">
                    <c:forEach var="item" items="${data.cargrade }">
                      <option value="${item.cargradeseq }" <c:if test="${item.cargradeseq eq param.cargradeseq }">selected="selected"</c:if>>${item.cargradenm }</option>
                    </c:forEach>
                  </select></td>
                <td><select id="caryyyy" name="caryyyy" class="select_1" size="8">
                    <c:forEach var="item" begin="1995" end="${dtf:getTime('yyyy') }">
                      <option value="${item }" <c:if test="${item eq param.caryyyy }">selected="selected"</c:if>>${item }년</option>
                    </c:forEach>
                  </select></td>
                <c:if test="${param.menu eq 'menu1' || param.menu eq 'menu2' || param.menu eq 'menu3' || param.menu eq 'menu4'}">
                  <td><select id="part2" name="part2" class="select_1" size="8" multiple="multiple">
                      <c:forEach var="item" items="${data.part2 }">
                        <option value="${item.code }" <c:if test="${item.code eq param.part2 }">selected="selected"</c:if>>${item.code_nm }</option>
                      </c:forEach>
                    </select></td>
                </c:if>
                <td><select id="grade" name="grade" class="select_1" size="8">
                    <option value="">전체</option>
                    <c:forEach var="item" items="${data.grade }">
                      <option value="${item.code }" <c:if test="${item.code eq param.grade }">selected="selected"</c:if>>${item.code_nm }</option>
                    </c:forEach>
                  </select></td>
              </tr>
            </tbody>
          </table>
          <div class="pl_bottom">
            <p class="plb_l"> <span class="cb_1">지역별</span> <span>
              <select id="sido" name="sido" class="select_1" onchange="changeSido()">
                <option>시/도</option>
                <c:forEach var="item" items="${data.sido }">
                  <option value="${item.sido }" <c:if test="${item.sido eq param.sido }">selected="selected"</c:if>>${item.dong_nm }</option>
                </c:forEach>
              </select>
              </span> <span>
              <select id="sigungu" name="sigungu" class="select_1" onchange="changeSigungu()">
                <option>시/군/구</option>
                <c:forEach var="item" items="${data.sigungu }">
                  <option value="${item.sigungu }" <c:if test="${item.sigungu eq param.sigungu }">selected="selected"</c:if>>${item.dong_nm }</option>
                </c:forEach>
              </select>
              </span> <span>
              <select id="dong" name="dong" class="select_1">
                <option>읍/면/동</option>
                <c:forEach var="item" items="${data.dong }">
                  <option value="${item.dong }" <c:if test="${item.dong eq param.dong }">selected="selected"</c:if>>${item.dong_nm }</option>
                </c:forEach>
              </select>
              </span> </p>
            <p class="plb_r"> <span class="cb_1">조건 내 검색</span> <span class="input_box">
              <input type="text" name="keyword" class="input_1">
              </span> <span><a href="#"><img src="/images/container/pl_btn_1.gif" alt="초기화"></a></span> <span><a href="javascript:goSubmit()"><img src="/images/container/pl_btn_2.gif" alt="검색"></a></span> </p>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- all_menu on End -->

<div class="sub_wrap" >
  <div class="sub_contents" style="position: relative;">
    <div class="details_1" >
      <div id="galleryWrap">
        <div class="galleryView"> 
          <!-- div class="galleryViewLeft"></div>
              <div class="galleryViewright"></div-->
          <c:forEach var="item" items="${files }">
            <div class="item">
              <div style='position:absolute;'><img src='/upload/board/${item.yyyy }/${item.mm }/${item.uuid }'></div>
            </div>
          </c:forEach>
        </div>
        <div class="thumbnails">
          <div class="thumb_left"></div>
          <p class="thumb_left_2"></p>
          <div class="thumbnails_body">
            <ul>
              <c:forEach var="item" items="${files }" varStatus="status">
                <li>
                  <div class="thumbitem" rel="${status.index }"  num="${status.index }" pg="${status.index }"> <img src="/upload/board/${item.yyyy }/${item.mm }/${item.uuid }" align="absmiddle" rel="${status.index }"  class='thumbimg'> </div>
                </li>
              </c:forEach>
            </ul>
          </div>
          <div class="thumb_right"></div>
          <p class="thumb_right_2"></p>
        </div>
      </div>
      <script type="text/javascript" src="../lib/js/gallery.js"></script> 
      <script type="text/javascript">
          jQuery(function($){
          var options = {};
          options['animSpeed'] = 0; //애니시간
          options['pauseTime'] = 5000; //대기시간
          options['dataViewType'] = "none";  //내용보기효과 'none','Randam','top','bottom','topleft','topright','bottomleft','bottomright'   none일경우 사용안함
          options['ImgViewType'] = "fade";  //이미지효과 'Randam','sliceDownRight','sliceDownLeft','sliceUpRight','sliceUpLeft','sliceUpDown','boxblockRight','fade','sliceLeft','sliceLeftUp','sliceRight','sliceRightUp','sliceLeftRight',               'boxRandom','boxblock','boxblockDown','boxblockUp','boxblockLeft'
          options['tailCut'] =4; //썸네일출력수
          $('#galleryWrap').galleryeffect(options);

          });

          </script>
      <div class="details_info" >
        <p class="details_title"><strong>${view.part3_nm } </strong>/ ${view.makernm } ${view.carmodelnm } ${view.cargradenm }</p>
        <table class="details_style_1">
          <colgroup>
          <col width="30%">
          <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th>판매가격</th>
              <td class="big_f">
              	<c:choose>
                  <c:when test="${view.inquiry_yn eq 'Y' }"><span class="f_style_c2">협의</span></c:when>
                  <c:otherwise>
                    <c:if test="${view.discount_rate > 0}"> <span class="f_style_2">${suf:getThousand(view.sale_price) } <b>원</b></span> <span class="price_un">종전가 : ${suf:getThousand(view.user_price) }</span> </c:if>
                    <c:if test="${view.discount_rate == 0 || empty view.discount_rate}"> <span class="f_style_2">${suf:getThousand(view.user_price) } <b>원</b></span> </c:if>
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
            <tr>
              <th>배송비</th>
              <td class="big_f"><c:choose>
                  <c:when test="${view.fee_yn eq 'C' }"> 착불 </c:when>
                  <c:when test="${view.fee_yn eq 'Y' }"> ${view.fee_amount } 원 </c:when>
                  <c:otherwise>무료</c:otherwise>
                </c:choose></td>
            </tr>
            <c:choose>
			    <c:when test="${view.gubun eq '1' }">
		            <tr>
		              <th>제품분류</th>
		              <td>${view.part1_nm } &gt; ${view.part2_nm }</td>
		            </tr>
            	</c:when>
			    <c:when test="${view.gubun eq '2' }">
		            <tr>
		              <th>제품분류</th>
		              <td>수입차(부품용)</td>
		            </tr>
            	</c:when>
			    <c:when test="${view.gubun eq '3' }">
		            <tr>
		              <th>제품분류</th>
		              <td>수출용/부품용(완차)</td>
		            </tr>
            	</c:when>
            </c:choose>
            <tr>
              <th> <p>차량명</p>
                <p>부품명</p>
              </th>
              <td><p>${view.makernm } ${view.carmodelnm } ${view.cargradenm }</p>
                <p>${view.part3_nm }</p></td>
            </tr>
            <tr>
              <th>상품코드</th>
              <td>${view.item_code }</td>
            </tr>
            <tr>
              <th> <p>연식</p>
                <p>등급</p>
              </th>
              <td><p>${view.caryyyy } 년</p>
                <p class="c1">${view.grade } 등급 <span style=""><a href="#" onmouseover="view(true)" onmouseout="view(false)" style="text-decoration:none"> <img src="/images/container/qustion_03.gif" alt="부품등급에 대한 설명 보기" /></a> </span> </p>
                <div id="spec1" style="position:absolute;display:none; top:410px; left:700px;"> <img src="/images/container/qustion_07.gif" alt="부품등급에대한 설명 보기" /> </div></td>
            </tr>
            <tr>
              <th>색상</th>
              <td>${view.color_nm }</td>
            </tr>
            <tr>
              <th>혜택</th>
              <td><c:if test="${!(empty view.discount_rate || view.discount_rate == 0) }"><span class="f_style_1">${view.discount_rate }%↓</span></c:if></td>
            </tr>
            <tr>
              <th>판매자정보</th>
              <td><p><strong>${view.com_nm }</strong></p>
                <p>${view.addr1 } ${view.addr2 }</p>
                <p><span class="phone"><strong>${view.staff_tel }</strong></span> <span><a href="#"></a></span></p></td>
            </tr>
            <tr>
              <th>수량</th>
              <td><c:choose>
                  <c:when test="${view.inquiry_yn eq 'Y' }"><span class="c2">주문불가</span></c:when>
                  <c:otherwise>
                    <c:choose>
                      <c:when test="${empty view.stock_num || view.stock_num <= 0}"> 재고수량이 없습니다. </c:when>
                      <c:otherwise>
                        <select class="select_1 ws_1" id="qty">
                          <c:forEach var="i" begin="1" end="${view.stock_num }">
                            <option value="${i }">${i }개</option>
                          </c:forEach>
                        </select>
                      </c:otherwise>
                    </c:choose>
                  </c:otherwise>
                </c:choose></td>
            </tr>
          </tbody>
        </table>
        <c:choose>
          <c:when test="${view.inquiry_yn eq 'Y' }">
            <p class="d_info_guide">고객센터 <b class="c1">1544-6444</b> 로 연락주시기 바랍니다.</p>
          </c:when>
          <c:otherwise>
            <div class="d_info_btn"> <a href="/mypage/shopping/cart/index.do?mode=direct_order&seq=${param.seq }&qty=1"><img src="../images/sub/details_btn1.gif" alt="구매하기"></a> <a href="javascript:cart('${param.seq }')"><img src="../images/sub/details_btn2.gif" alt="장바구니"></a> <a class="sns_type" href="javascript:snsLink('twt');"><img src="/images/sub/sns_twitter.png" alt="twitter"></a> <a class="sns_type" href="javascript:snsLink('face');"><img src="/images/sub/sns_facebook.png" alt="facebook"></a> 
              <!-- <a class="sns_type" href="javascript:snsLink('kakao');"><img src="/images/sub/sns_kakaolink.png" alt="kakaolink"></a>  --> 
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
    <div class="details_2">
      <div class="h4_line">
        <h4><img src="../images/sub/details_h4_img1.gif" alt=""></h4>
        <!-- <span>(최종정보수정일 : 2014-04-08 오후 6:54:40)</span> --> 
      </div>
      <div class="details_self"> 
      ${view.conts } 
	      <div class="default" >
				<div class="default_box">
					<p class="s1">제품구매시 주의 사항입니다.</p>
					<p class="s2">문의사항은 1544-6444 문의 바랍니다.</p>
					</div>
					<ul>
					<li>배송비<br/>
					모든 배송비는 착불을 기본으로 합니다.<br/>
					- 배송비는 기본 5,000원으로 무게/부피에 따라서 배송비가 증가 됩니다.<br/>
					(범퍼 : 25,000~28,000원 &nbsp; 도어 : 27,000~30,000원 &nbsp; 본닛 : 28,000~35,000원)</li>
					<li>사진은 여건상 실상태 보다 다소 흐리게 나온점 양해바랍니다</li>
					<li><strong>호환여부 반드시 1544-6444번호로 문의바랍니다</strong></li>
					<li>대체로 검사시점의 킬로수인 경우가 많습니다<br>계기판 구매자는 미기재건은 정보가 없는 계기판이므로 <strong>킬로수 관계 없으신분 구매바랍니다</strong></li>
					<li>
					<strong>구매자 부주의로 인한 주문건 교환,반품 배송비용은 고객님 부담입니다</strong><br>
					구매 부품에 대한 명확한 확신이 없을시 반드시 문의바랍니다 <strong>7일이후 반품불가</strong><br>
					<strong>(상품 수령후 7일 이내에 반품건이 공급처에 도착해야됩니다)</strong><br>
					</li>
					<li><strong>가격이 현저히 높을시 1544-6444번호로 문의바랍니다</strong></li>
					<li><strong>모든제품은 착불 발송됩니다</strong> (도서산간, 지역별, 부피에 따라서 금액이 틀립니다.)</li>
					<li>범퍼 본넷 펜다등 <strong>부피나 중량이 큰 제품은 화물택배 발송시 파손이 빈번하여 꼭 수령후 확인 부탁드립니다.</strong></li>
					<li><strong>오디오는 테스트 완료후 출고하는 상품</strong>입니다. 오작동시 다른 원인을 파악하시기 바라고 반품을 원하시면<br><strong>배송비는 구매자님이 부담</strong>해주셔야 합니다.</li>
					<li>바디 부품(예 : 사이드 미러, 헤드 램프)의 경우  <strong>'좌'는 운전석, '우'는 조수석입니다.</strong> 운전자가 운전석에 앞을 보고 앉았을 때 기준입니다. 부품 주문 (구매) 시 착오 없으시기 바랍니다.</li>
					</ul>
				</div>
	      </div>
      </div>
      
      <div class="d_tab_box"> 
      
      <!-- tab -->
      <div id="tabNav_d1" class="details_tab">
        <h4 id="tabNavTitle0101" class="on"><a href="#" onclick="shwoTabNav('01', 3, 1); return false;" onfocus="this.onclick();">공급사정보</a></h4>
        <div id="tabNav0101" style="display:block;">
          <div class="d_con1">
            <div id="nmap" class="map"></div>
            <!--                 <div class="map"><img src="../images/sub/naver_map.gif" alt=""></div> -->
            
            <div class="supply">
              <p class="details_title"><strong>${view.com_nm }</strong></p>
              <table class="details_style_2">
              <colgroup>
              <col width="35%">
              <col width="">
              </colgroup>
                <tbody>
                  <tr>
                    <th> 
                      <p>대표자</p>
                      <p>전화번호</p>
                      <p>팩스번호</p>
                    </th>
                    <td>
                      <p>${view.ceo_nm }&nbsp;</p>
                      <p>${view.tel }&nbsp;</p>
                      <p>${view.fax }&nbsp;</p>
                    </td>
                  </tr>
                  <tr>
                    <th class="f_normal"><strong>사업장소재지</strong></th>
                    <td>
                      <p>${view.addr1 }</p>
                      <p>${view.addr2 }</p></td>
                  </tr>
                  <tr>
                    <th class="f_normal">
                      <p><strong>담당자</strong></p>
                      <p><strong>전화번호</strong></p>
                      <c:if test="${!empty view.staff_tel2 }">
                      <p><strong>담당자2</strong></p>
                      <p><strong>전화번호2</strong></p>
                      </c:if>
                    </th>
                    <td>
                      <p>${view.staff_nm }</p>
                      <p>${view.staff_tel }</p>
                      <c:if test="${!empty view.staff_tel2 }">
                      <p>${view.staff_nm2 }</p>
                      <p>${view.staff_tel2 }</p>
                      </c:if>
                    </td>
                  </tr>
                  <tr>
                    <th class="f_normal"><strong>업체분류</strong></th>
                    <td>${view.comptyp2 } &gt; ${view.comptyp1 }</td>
                  </tr>
                  <!-- tr class="last">
                    <th class="f_normal"> 
                      <p><strong>사업자등록번호</strong></p>
                      <p><strong>통신판매업신고번호</strong></p>
                      <p><strong>PARTSMOA 가입일</strong></p>
                    </th>
                    <td><p>${view.busi_no }&nbsp;</p>
                      <p>${view.telesales_no }&nbsp;</p>
                      <p>${view.reg_date }</p></td>
                  </tr-->
                </tbody>
              </table>
            </div>
            <p class="d_last">※ 제품과 관련된 자세한 문의사항은 판매 담당자의 연락처로 문의 바랍니다.</p>
          </div>
        </div>
        <h4 id="tabNavTitle0102"><a href="#" onclick="shwoTabNav('01', 3, 2); return false;" onfocus="this.onclick();">판매자 상품보기</a></h4>
        <div id="tabNav0102">
          <div class="d_con2"> </div>
        </div>
        <h4 id="tabNavTitle0103"><a href="#" onclick="shwoTabNav('01', 3, 3); return false;" onfocus="this.onclick();">반품/교환/환불정보</a></h4>
        <div id="tabNav0103">
          <div class="d_con3">
            <div class="section">
              <h5 class="first">배송안내</h5>
              <div class="sec_box">
                <dl>
                  <dt>1.배송</dt>
                  <dd>택배 집하시간은 4시까지이며, 익일배송을 원칙으로 처리하여 드립니다.</dd>
                  <dd>단, 부피가 큰 부품이나 고객이 원할 경우 1톤, 다마스 차량으로 운송하며, 지방의 경우 화물택배로 배송하여드립니다.</dd>
                  <dd>기타 궁금하신 사항은 1544-6444 고객센터로 문의주시면 언제든지 상세히 답변 드리도록 하겠습니다.</dd>
                  <dd class="c1 b1">주문 예) 화물, 일반, 퀵서비스 선택 가능</dd>
                  <dt>2.배송비</dt>
                  <dd>모든 배송비는 착불을 기본으로 합니다. </dd>
                  <dd>- 택배 가능 부품(한사람이 들 수 있는 무게/부피가 작은 부품)은 기본이 5,000원이며, 무게/부피에 따라 배송비가 증가 됩니다. </dd>
                  <dd>- 택배 불가능한 부품은 경동택배를 통해 발송되며, 배송비는 기본 5,000원으로 무게/부피에 따라 배송비가 증가 됩니다</dd>
                  <dd class="c1">( 범퍼 : 25,000~28,000원  도어 : 27,000~30,000원    본닛 : 28,000~35,000원  )</dd>
                </dl>
              </div>
              <h5>결제안내</h5>
              <div class="sec_box">
                <dl class="sec_2">
                  <dt>1.현금결제</dt>
                  <dd>올더게이트를 이용하여 무통장입금 및 실시간 계좌이체 모두 가능합니다.</dd>
                  <dd>주문 후 3일 이내 입금이 안 될 경우, 자동으로 주문취소되며, 다시 주문해주셔야 합니다.</dd>
                  <dd>무통장입금을 하신 경우에는 주문자와 입금자가 동일해야 합니다.</dd>
                  <dd class="c1">- 부득이하게 다른 경우,</dd>
                  <dd class="c1">T: 1544-6444 고객센터로 연락하여 주시기 바랍니다.</dd>
                  <dd class="c1">- 계좌번호 안내</dd>
                  <dd class="c1 b1">T: 1544-6444 고객센터로 연락하여 주시기 바랍니다.</dd>
                  <dt>2.카드결제</dt>
                  <dd>파츠모아의 신용카드 결제는 올더게이트 전자결제를 이용하여 고객의 카드 정보를 안전하게 보호하며,<br>
                    신용카드를 이용한 결제는 즉시 주문처리가 가능하므로 빠르게 배송처리할 수 있습니다.</dd>
                </dl>
              </div>
              <h5>교환 및 반품안내</h5>
              <dl class="sec_3">
                <dt>1.교환안내</dt>
                <dd>상품을 배송 받은 날부터 7일 이내 교환은 언제든지 가능합니다. </dd>
                <dd class="c1">(주문하신 상품에 따라 배송기간이 조금 상이 할 수도 있음 / 동일 배송지의 1회만 가능)</dd>
                <dd>단, 고객님의 과실 혹은 단순 변심으로 인해 교환이 불가능할 수 있습니다.</dd>
                <dd class="b1">기타 궁금하신 사항은 1544-6444 고객센터로 문의 주시면 언제든지 상세히 답변 드리도록 하겠습니다.</dd>
                <dt>2.반품안내</dt>
                <dd>상품 특성상 포장을 개봉하시거나 상품을 사용하신 후에는 반품이 불가하오니 이점 유의하시기 바랍니다.</dd>
                <dd>단, 제품하자 시에는 1544-6444 고객센터로 문의 주시면 처리절차에 대해 친절하게 안내해 드리겠습니다.</dd>
                <dd class="c1" style="margin:12px 0 0 26px;">※ 파츠모아에 입고되서 판매하기까지의 절차와 주문, 결제, 배송 등에 대한 설명<br>
                  기존 판매 절차와 동일 하며, 파츠모아를 통하지 않고 거래 되는 부분에 대해서는 관련 책임을 지지 않습니다.</dd>
              </dl>
            </div>
          </div>
        </div>
      </div>
      <script type="text/javascript">
          function shwoTabNav(eName, totalNum, showNum) {
          	for(i=1; i<=totalNum; i++){
          		var zero = (i >= 10) ? "" : "0";
          		var e = document.getElementById("tabNav" + eName + zero + i);
          		var eTitle = document.getElementById("tabNavTitle" + eName + zero + i);
          		e.style.display = "none";
          		eTitle.className = "";
          	}

          	var zero = (showNum >= 10) ? "" : "0";
          	var e = document.getElementById("tabNav" + eName + zero + showNum);
          	var eTitle = document.getElementById("tabNavTitle" + eName + zero + showNum);
          	e.style.display = "block";
          	eTitle.className = "on";
          }
          </script> 
      <!-- //tab --> 
      
    </div>
      
    </div>
    
  </div>
</body>
</html>
