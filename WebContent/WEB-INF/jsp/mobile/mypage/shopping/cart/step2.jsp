<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="kr.co.allthegate.mobile.*"%>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="com.mc.common.util.*" %>
<c:set var="orderno" value="${data.orderno }" scope="request"/>
<c:set var="memberInfo" value="${data.memberInfo }" />
<c:set var="memberBasongji" value="${data.memberBasongji }" />
<c:set var="user_price" value="0"/>
<c:set var="discount_price" value="0"/>
<c:set var="fee_price" value="0"/>
<%
	String store_url = Util.getProperty("store_url");
	String store_js = Util.getProperty("store_js");
	String strAegis = store_url;
	String strCsrf = store_js;
	String http_host = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort(); 
%>
<script type="text/javascript" charset="utf-8" src="<%= strAegis %>/payment/mobilev2/csrf/<%= strCsrf %>"></script> 
<script type="text/javascript">
$(document).ready(function(){
//#allmenu
$("#submenu_open").toggle(function(){
$("#sub_menu").slideToggle(250);
this.src = "/images/mobile/sub/sub_menu_close.gif";
}, function() {
$("#sub_menu").slideToggle(250);
this.src = "/images/mobile/sub/sub_menu_open.gif";
});

});

$(function(){
	$("input[name='basongji_gubun']").on("change", function(){
		var gubun = $(this).val();
		if(gubun == "1"){
			<c:if test="${empty memberBasongji}">
			$("#zip1").val("${memberInfo.zip1}");
			$("#zip2").val("${memberInfo.zip2}");
			$("#addr1").val("${memberInfo.addr1}");
			$("#addr2").val("${memberInfo.addr2}");
			$("#receiver").val("${memberInfo.member_nm}");
			$("#cell1").val("${memberInfo.cell1}");
			$("#cell2").val("${memberInfo.cell2}");
			$("#cell3").val("${memberInfo.cell3}");
			$("#tel1").val("${memberInfo.tel1}");
			$("#tel2").val("${memberInfo.tel2}");
			$("#tel3").val("${memberInfo.tel3}");
			</c:if>
			<c:if test="${!empty memberBasongji}">
			$("#zip1").val("${memberBasongji[0].zip1}");
			$("#zip2").val("${memberBasongji[0].zip2}");
			$("#addr1").val("${memberBasongji[0].addr1}");
			$("#addr2").val("${memberBasongji[0].addr2}");
			$("#receiver").val("${memberBasongji[0].receiver_nm}");
			$("#cell1").val("${memberBasongji[0].cell1}");
			$("#cell2").val("${memberBasongji[0].cell2}");
			$("#cell3").val("${memberBasongji[0].cell3}");
			$("#tel1").val("${memberBasongji[0].tel1}");
			$("#tel2").val("${memberBasongji[0].tel2}");
			$("#tel3").val("${memberBasongji[0].tel3}");
			</c:if>
		}else if(gubun == "2"){
			$("#zip1").val("${memberInfo.zip1}");
			$("#zip2").val("${memberInfo.zip2}");
			$("#addr1").val("${memberInfo.addr1}");
			$("#addr2").val("${memberInfo.addr2}");
			$("#receiver").val("${memberInfo.member_nm}");
			$("#cell1").val("${memberInfo.cell1}");
			$("#cell2").val("${memberInfo.cell2}");
			$("#cell3").val("${memberInfo.cell3}");
			$("#tel1").val("${memberInfo.tel1}");
			$("#tel2").val("${memberInfo.tel2}");
			$("#tel3").val("${memberInfo.tel3}");
		}else if(gubun == "3"){
			$("#zip1").val("");
			$("#zip2").val("");
			$("#addr1").val("");
			$("#addr2").val("");
			$("#receiver").val("");
			$("#cell1").val("");
			$("#cell2").val("");
			$("#cell3").val("");
			$("#tel1").val("");
			$("#tel2").val("");
			$("#tel3").val("");
		}
	}).trigger("change");
	
	$("#zip1").val("${memberInfo.zip1}");
	$("#zip2").val("${memberInfo.zip2}");
	$("#addr1").val("${memberInfo.addr1}");
	$("#addr2").val("${memberInfo.addr2}");
	$("#receiver").val("${memberInfo.member_nm}");
	$("#cell1").val("${memberInfo.cell1}");
	$("#cell2").val("${memberInfo.cell2}");
	$("#cell3").val("${memberInfo.cell3}");
	$("#tel1").val("${memberInfo.tel1}");
	$("#tel2").val("${memberInfo.tel2}");
	$("#tel3").val("${memberInfo.tel3}");
});

//<![CDATA[
function wrapWindowByMask(){
	//화면의 높이와 너비
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();

	$('#mask').css({'width':maskWidth,'height':maskHeight});
	//애니메이션 효과 - 0초동안 까맣게 됐다가 60% 불투명도
	$('#mask').fadeIn(0);
	$('#mask').fadeTo("slow",0.6);
	//윈도우 띄움.
	$('.window').show();
}
$(document).ready(function(){
	//검은 막 띄우기
	$('.openMask').click(function(e){
	e.preventDefault();
	wrapWindowByMask();
	});
	//닫기 버튼을 눌렀을 때
	$('.window .close').click(function (e) {
	//링크 기본동작은 작동하지 않도록 한다.
	e.preventDefault();
	$('#mask, .window').hide();
	});
	//검은 막을 눌렀을 때
	//      $('#mask').click(function () {
	//          $(this).hide();
	//          $('.window').hide();
	//      });
});
//]]>

function openAddr(){
	window.open("/addr/road.jsp","addr","width=570,height=420");
}

function setAddr(roadAddrPart1, addrDetail, zipNo, jibunAddr) {
	var zip = zipNo.split("-");
	$("#zip1").val(zip[0]);
	$("#zip2").val(zip[1]);
	$("#addr1").val(jibunAddr);
	$("#addr2").val(addrDetail);
	$("#modal_dialog").dialog({title:'주소검색'}).dialog("close");
}

function doPay(form) {
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 올더게이트 플러그인 설정값을 동적으로 적용하기 JavaScript 코드를 사용하고 있습니다.
	// 상점설정에 맞게 JavaScript 코드를 수정하여 사용하십시오.
	//
	// [1] 일반/무이자 결제여부
	// [2] 일반결제시 할부개월수
	// [3] 무이자결제시 할부개월수 설정
	// [4] 인증여부
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// [1] 일반/무이자 결제여부를 설정합니다.
	//
	// 할부판매의 경우 구매자가 이자수수료를 부담하는 것이 기본입니다. 
	// 그러나, 상점과 올더게이트간의 별도 계약을 통해서 할부이자를 상점측에서 부담할 수 있습니다.
	// 이 경우 구매자는 무이자 할부거래가 가능합니다.
	//
	// 예제)
	// 	(1) 일반결제로 사용할 경우
	// 	form.DeviId.value = "9000400001";
	//
	// 	(2) 무이자결제로 사용할 경우
	// 	form.DeviId.value = "9000400002";
	//
	// 	(3) 만약 결제 금액이 100,000원 미만일 경우 일반할부로, 100,000원 이상일 경우 무이자할부로 사용할 경우
	// 	if(parseInt(form.Amt.value) < 100000)
	//		form.DeviId.value = "9000400001";
	// 	else
	//		form.DeviId.value = "9000400002";
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// [2] 일반 할부기간을 설정합니다.
	// 
	// 일반 할부기간은 2 ~ 12개월까지 가능합니다.
	// 0:일시불, 2:2개월, 3:3개월, ... , 12:12개월
	// 
	// 예제)
	// 	(1) 할부기간을 일시불만 가능하도록 사용할 경우
	// 		form.QuotaInf.value = "0";
	//
	// 	(2) 할부기간을 일시불 ~ 12개월까지 사용할 경우
	//		form.QuotaInf.value = "0:2:3:4:5:6:7:8:9:10:11:12";
	//
	// 	(3) 결제금액이 일정범위안에 있을 경우에만 할부가 가능하게 할 경우
	// 	if((parseInt(form.Amt.value) >= 100000) || (parseInt(form.Amt.value) <= 200000))
	// 		form.QuotaInf.value = "0:2:3:4:5:6:7:8:9:10:11:12";
	// 	else
	// 		form.QuotaInf.value = "0";
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//결제금액이 5만원 미만건을 할부결제로 요청할경우 일시불로 결제
	if(parseInt(form.Amt.value) < 50000)
		form.QuotaInf.value = "0";
	else
		form.QuotaInf.value = "0:2:3:4:5:6:7:8:9:10:11:12";
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// [3] 무이자 할부기간을 설정합니다.
	// (일반결제인 경우에는 본 설정은 적용되지 않습니다.)
	// 
	// 무이자 할부기간은 2 ~ 12개월까지 가능하며, 
	// 올더게이트에서 제한한 할부 개월수까지만 설정해야 합니다.
	// 
	// 100:BC
	// 200:국민
	// 300:외환
	// 400:삼성
	// 500:신한
	// 800:현대
	// 900:롯데
	// 
	// 예제)
	// 	(1) 모든 할부거래를 무이자로 하고 싶을때에는 ALL로 설정
	//	 	form.NointInf.value = "ALL";
	//
	// 	(2) 국민카드 특정개월수만 무이자를 하고 싶을경우 샘플(2:3:4:5:6개월)
	// 		form.NointInf.value = "200-2:3:4:5:6";
	//
	// 	(3) 외환카드 특정개월수만 무이자를 하고 싶을경우 샘플(2:3:4:5:6개월)
	// 		form.NointInf.value = "300-2:3:4:5:6";
	//
	// 	(4) 국민,외환카드 특정개월수만 무이자를 하고 싶을경우 샘플(2:3:4:5:6개월)
	// 		form.NointInf.value = "200-2:3:4:5:6,300-2:3:4:5:6";
	//	
	//	(5) 무이자 할부기간 설정을 하지 않을 경우에는 NONE로 설정
	//		form.NointInf.value = "NONE";
	//
	//	(6) 전카드사 특정개월수만 무이자를 하고 싶은경우(2:3:6개월)
	//		form.NointInf.value = "100-2:3:6,200-2:3:6,300-2:3:6,400-2:3:6,500-2:3:6";
	//
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	 
	//	모든 할부거래를 무이자
	if(form.DeviId.value == "9000400002") {
		form.NointInf.value = "ALL";
	} 
	
	var message_data = new Array();
	var cart_no = new Array();
	
	jQuery("input[name='message']").each(function(index){
		
		message_data[index] = this.value;
	});
	
	jQuery("input[name='cart_no']").each(function(index){
		
		cart_no[index] = this.value;
	});
	
	
	jQuery.ajaxSettings.traditional = true;
	$.post("/mobile/mypage/shopping/cart/index.do?mode=m_make_data", 
			{
				"zip1":jQuery("#zip1").val(),
				"zip2" : jQuery("#zip2").val(),
				"addr1" : jQuery("#addr1").val(), 
				"addr2" : jQuery("#addr2").val(), 
				"receiver" : jQuery("#receiver").val(), 
				"cell1" : jQuery("#cell1").val(), 
				"cell2" : jQuery("#cell2").val(), 
				"cell3" : jQuery("#cell3").val(), 
				"tel1" : jQuery("#tel1").val(), 
				"tel2" : jQuery("#tel2").val(), 
				"tel3" : jQuery("#tel3").val(), 
				"message" : message_data, 
				"cart_no" : cart_no, 
				"m_member_nm" : jQuery("#m_member_nm").val(),
				"m_zip_cd" : jQuery("#m_zip_cd").val(),
				"m_addr1" : jQuery("#m_addr1").val(),
				"m_addr2" : jQuery("#m_addr2").val(),
				"m_cell" : jQuery("#m_cell").val(),
				"m_tel" : jQuery("#m_tel").val(),
				"m_email" : jQuery("#m_email").val()
			}, function(data) {
				
				AllTheGate.pay(document.form);
    });
	
	document.form.RcpNm.value = document.getElementById("receiver").value;
	document.form.RcpPhone.value = document.getElementById("cell1").value + "-" + document.getElementById("cell2").value + "-" + document.getElementById("cell3").value;
	document.form.DlvAddr.value = document.getElementById("addr1").value + " " + document.getElementById("addr2").value;
	document.form.Remark.value = document.getElementById("message").value;
	
	return false;
}
function Check_Common(form){
	if(form.zip1.value == "" || isNaN(form.zip1.value)){
		alert("우편번호를 정확히 입력해주세요");
		form.zip1.focus();
		return false;
	}
	/*if(form.zip2.value == "" || isNaN(form.zip2.value)){
		alert("우편번호를 정확히 입력해주세요");
		form.zip2.focus();
		return false;
	}*/
	if(form.addr1.value == ""){
		alert("배송지 주소를 입력해주세요");
		form.addr1.focus();
		return false;
	}
	if(form.receiver.value == ""){
		alert("수취인 이름을 입력해주세요");
		form.receiver.focus();
		return false;
	}
	if(form.cell1.value == "" || isNaN(form.cell1.value)){
		alert("휴대폰 번호를 정확히 입력해주세요");
		form.cell1.focus();
		return false;
	}
	if(form.cell2.value == "" || isNaN(form.cell2.value)){
		alert("휴대폰 번호를 정확히 입력해주세요");
		form.cell2.focus();
		return false;
	}
	if(form.cell3.value == "" || isNaN(form.cell3.value)){
		alert("휴대폰 번호를 정확히 해주세요");
		form.cell3.focus();
		return false;
	}
	if(form.tel1.value == "" || isNaN(form.tel1.value)){
		alert("연락처를 정확히 입력해주세요");
		form.tel1.focus();
		return false;
	}
	if(form.tel2.value == "" || isNaN(form.tel2.value)){
		alert("연락처를 정확히 입력해주세요");
		form.tel2.focus();
		return false;
	}
	if(form.tel3.value == "" || isNaN(form.tel3.value)){
		alert("연락처를 정확히 입력해주세요");
		form.tel3.focus();
		return false;
	}
	
	if(form.StoreId.value == ""){
		alert("상점아이디를 입력하십시오.");
		return false;
	}
	else if(form.StoreNm.value == ""){
		alert("상점명을 입력하십시오.");
		return false;
	}
	else if(form.OrdNo.value == ""){
		alert("주문번호를 입력하십시오.");
		return false;
	}
	else if(form.ProdNm.value == ""){
		alert("상품명을 입력하십시오.");
		return false;
	}
	else if(form.Amt.value == ""){
		alert("금액을 입력하십시오.");
		return false;
	}
	else if(form.MallUrl.value == ""){
		alert("상점URL을 입력하십시오.");
		return false;
	}
	return true;
}

//배송비 선결제 설정
function changeCod(idx, val){

	$.ajax({
		url : "/mypage/shopping/cart/index.do?mode=changeCod", 
		type: "POST", 
		data : {cart_no : idx, cod_yn : val}, 
		dataType : "json", 
		async: false, 
		cache : false, 
		success : function(data){
			if(data.rst == "1"){
				location.reload();
			}else{
				alert("배송비 선결제/착불 변경에 실패하였습니다.");
			}
		},
		error : function(data){
			alert("배송비 선결제/착불 변경에 실패하였습니다.");
		}
	});
}

function changeAreaList(idx, obj){	
	if(obj.id == '' || obj.id == 'undefined')
		return;
	
	areaIdx = idx;
	
	// 통합검색 
	if(obj.id == 'city1'){
		dataFrom 	= 'city';
		dataTo 		= 'county';
		objFrom		= 'city1';
		objTo		= 'county1';
		objClear	= 'town1_oldaddr';		

		//①세종시예외처리 
		document.getElementById("county1").disabled = false;
		
		if(document.getElementById(obj.id).value =='36'){
			document.getElementById("county1").disabled = true;
			dataTo 		= 'town';
			objTo		= 'town1_oldaddr';
		}
	}
	// 통합검색 
	else if(obj.id == 'county1'){
		dataFrom 	= 'county';
		objFrom		= 'county1';
		objClear	= '';
		dataTo 		= 'town';
		objTo		= 'town1_oldaddr';
	}
	else if(obj.id == 'town1_oldaddr'){
		dataFrom 	= 'town';
		objFrom		= 'town1_oldaddr';
		objClear	= '';
		dataTo 		= 'ri';
		objTo		= 'ri1_oldaddr';
		
	}
	// 통합검색 
	else if(obj.id == 'rd_nm_idx1'){
		dataFrom 	= 'county';
		objFrom		= 'county1';
		objClear	= '';
		
	}

	//	update해야 할 select를 초기화
	clearList(objTo);
	
	//	clear해야 할 select가 설정된 경우 초기화
	
	// from object 선택값이 없으면 return
	if(document.getElementById(objFrom).value == ''){
		return;
	}
	
	var url = "/addr/AjaxRequestXML.jsp?getUrl=http://125.60.46.141/getAreaCode.do?" + escape(createParameter());
	 
  	createXMLHttpRequest();
 	xmlHttp.onreadystatechange = handleStateChange;
  	xmlHttp.open("GET", url, true);
  	xmlHttp.send(null);
}


/*
 *	행정구역 조회 쿼리에 사용할 파라메터값 설정
 */
function createParameter() {
	var valFrom		= document.getElementById(objFrom).value;
	var valTo		= document.getElementById(objTo).value;

	//	시군구>도로명, 시군구>지번주소인 경우
	//	시도코드도 가져가야함

	if(dataFrom == 'county' && (areaIdx == 1 || areaIdx == 3)){
		var cityName = 'city'+areaIdx;
		var cityVal = document.getElementById(cityName).value;
	
		valFrom = cityVal+valFrom;
	
	}else if(dataFrom == 'town' && (areaIdx == 1 || areaIdx == 3)){
		var cityName	= 'city'+areaIdx;
		var countyName	= 'county'+areaIdx;

		if(document.getElementById(cityName).value=='36'){
			valFrom = '36110'+valFrom;
		}else
			valFrom = document.getElementById(cityName).value+document.getElementById(countyName).value+valFrom;
	}

	var queryString = "from="+encodeURI(dataFrom)+"&to="+encodeURI(dataTo)+"&valFrom="+encodeURI(valFrom)+"&valTo="+encodeURI(valTo);

  	return queryString;
}

/*
 *	지정된 행정구역코드 리스트를 초기화
 */
function clearList(obj) {
	if(obj == 'town1_oldaddr'){
		var toObject = document.getElementById(obj);
		  
		toObject.options.length = 0;
		toObject.options[0] = new Option('::선택::', '');
		
		document.getElementById("ri1_oldaddr").options.length = 0;
		document.getElementById("ri1_oldaddr").options[0] = new Option('::선택::', '');
	}
	else if(obj != '' && obj != 'town1_oldaddr'){
	
		var toObject = document.getElementById(obj);
		  
		toObject.options.length = 0;
		toObject.options[0] = new Option('::선택::', '');
	}
}
	
function normalSearch(currentPage){
	var form = document.check;
	if(form.bun1.value == ""){
		alert("번지를 입력하세요.");
		return;
	}
	
	var keyword = "";
	var cityText='',countyText='',townText='',riText='',orgCode='219',orgNm='국민생활체육회';
	var special_pattern = /['~!@#$%^&*|\\\'\'';:\.?]/gi;
	cityText= form.city1.options[form.city1.selectedIndex].text;
	countyText = form.county1.options[form.county1.selectedIndex].text;
	townText = form.town1_oldaddr.options[form.town1_oldaddr.selectedIndex].text;
	riText = form.ri1_oldaddr.options[form.ri1_oldaddr.selectedIndex].text;
	
	if(form.san.checked){
		form.san1.value = '1';
	}else{
		form.san1.value ='0';
	}

	if(form.city1.value == "") cityText = "";
	if(form.county1.value == "") countyText = "";
	if(form.town1_oldaddr.value == "") townText = "";
	if(form.ri1_oldaddr.value == "") riText = "";
	
	form.engineCtpNm.value =cityText;
	form.engineSigNm.value =countyText;
	form.engineEmdNm.value =townText;
	form.engineLiNm.value = riText;
	form.engineBdMaSn.value= form.bun1.value;
	form.engineBdSbSn.value = form.bun2.value;
	form.engineMtYn.value= form.san1.value;
	form.currentPage.value =currentPage;

	if(cityText == ''){
		alert('시군구를 선택해 주세요');
		return;
	}

	var url;
	
	url = "/addr/AjaxRequestXML.jsp?getUrl="+escape("http://125.60.46.141/link/search.do?extend=false&mode=jibun_search&searchType=location_jibun&topTab=1&engineCtpNm="+encodeURI(cityText)+"&engineSigNm="+encodeURI(countyText)+"&engineEmdNm="+encodeURI(townText)+"&engineLiNm="+encodeURI(riText)+"&engineBdMaSn="+encodeURI(form.bun1.value)+"&engineBdSbSn="+encodeURI(form.bun2.value)+"&engineMtYn="+encodeURI(form.san1.value)+"&currentPage="+currentPage+"&orgCode="+orgCode+"&orgNm="+encodeURI(orgNm));
	
	createXMLHttpRequest();
	
 	xmlHttp.onreadystatechange = handleStateChangeSearch;
  	xmlHttp.open("GET", url, true);
  	xmlHttp.send(null);
}
function open_zipcode(){
	$("#modal_dialog").load("/addr/addr_mobile.jsp", "");
	$("#modal_dialog").dialog({title:'주소검색'}).dialog("open");
}
</script>
<link rel="stylesheet" href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" type="text/css">
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="/addr/common_c.js"></script>
<div>
  	<div id="modal_dialog"></div>
  </div>  
<div class="wrap">
      <div class="sub_wrap">
        <div class="sub_2_line line_2">
          <h3><img src="/images/mobile/sub_2/sub_2_title_5_1_2.gif" alt="주문/결제"></h3>
        </div>

        <h5 class="pay_type">1. 주문제품</h5>

        <div class="sub_list">

          <ul>
			<c:forEach var="item" items="${data.list }" varStatus="status">
				<c:set var="user_price_l" value="0"/>
				<c:set var="discount_price_l" value="0"/>
				<c:set var="fee_price_l" value="0"/>
				
	          	<c:choose>
		       		<c:when test="${(sessionScope.member.group_seq eq '3' or sessionScope.member.group_seq eq '9') && item.supplier_pricing_yn eq 'Y'}">
	       			<c:set var="user_price" value="${user_price + (item.user_price * item.qty) }"/>
					<c:set var="user_price_l" value="${item.user_price * item.qty }"/>
					<c:set var="discount_price" value="${discount_price + ((item.user_price * item.qty) - (item.supplier_price * item.qty)) }"/>
					<c:set var="discount_price_l" value="${(item.user_price * item.qty) - (item.supplier_price * item.qty) }"/>
		       		</c:when>
		       		<c:otherwise>
		       			<c:if test="${item.discount_rate > 0}">
			        		<c:set var="user_price" value="${user_price + (item.user_price * item.qty) }"/>
		          			<c:set var="discount_price" value="${discount_price + ((item.user_price * item.qty) - (item.sale_price * item.qty)) }"/>
							<c:set var="user_price_l" value="${item.user_price * item.qty }"/>
							<c:set var="discount_price_l" value="${(item.user_price * item.qty) - (item.sale_price * item.qty) }"/>
		            	</c:if>
						<c:if test="${item.discount_rate == 0 || empty item.discount_rate}">
			        		<c:set var="user_price" value="${user_price + (item.user_price * item.qty) }"/>
							<c:set var="user_price_l" value="${item.user_price * item.qty }"/>
		            	</c:if>
		       		</c:otherwise>
	       		</c:choose>
	       		<c:if test="${item.cod_yn eq 'Y' }">
	            	<c:set var="fee_price" value="${fee_price + item.fee_amt }"/>
	            	<c:set var="fee_price_l" value="${item.fee_amt }"/>
	            </c:if>
	            <li>
	
	            <div>
	              <span class="img"><img src="${item.thumb }" alt=""></span>
	
	              <span class="info">
	
	              <span class="in_t1">
	              <span class="first"><strong>${item.cargradenm } (${item.caryyyy })</strong></span>
	              <span><strong>${item.productnm}</strong></span>
	              <span><strong>${item.grade }등급</strong></span>
	              </span>
	
	              <span><strong>${item.com_nm}</strong> / ${item.sigungu_nm }</span>
	              <span>상품등록 : ${dtf:simpleDateFormat(item.reg_dt, 'yyyy-MM-dd HH:mm:ss' , 'yyyy-MM-dd') }</span>
	
	              <span class="t_money">
	              <!-- <span class="c1">협력가 : ${suf:getThousand(item.sale_price * item.qty) } 원</span>  -->
	              <span class="c2">일반가 : ${suf:getThousand(item.user_price * item.qty) } 원</span>
	              <span id = "fee_price">배송비 : <c:choose>
	              	<c:when test="${item.fee_yn eq 'C' }">
	              	착불
	              	</c:when>
	              	<c:when test="${item.fee_yn eq 'Y' }">
	              	<select name="cod_yn" onchange="changeCod('${item.cart_no }', this.value)">
	              		<option value="Y" <c:if test="${item.cod_yn eq 'Y'}">selected="selected"</c:if>>선결제</option>
	              		<option value="N" <c:if test="${item.cod_yn eq 'N'}">selected="selected"</c:if>>착불</option>
	              	</select>
	              	</c:when>
	              	<c:otherwise>무료</c:otherwise>
				</c:choose></span>
	              
	              </span>
	
	              </span>
	
	              <p class="btn_2">
	
	              <span class="b2_l">
	
	              <span class="text">제품수량 :</span>
	              <span>${item.qty }개</span>
	
	              </span>
	
	              </p>
	
	            </div>
	
	            </li>
          	</c:forEach>
          </ul>

        </div>

        <ul class="sub_list_1">
          <li><strong>PARTSMOA</strong>는 통신판매중개자이며 통신판매의 당사자가 아닙니다. 따라서 상품ㆍ거래정보 및 거래에 대하여 책임을 지지 않습니다.</li>
        </ul>

        <h5 class="pay_type">2. 주문회원 정보</h5>

        <div class="sub_table_1">
          <table>
          <colgroup>
          <col width="25%">
          <col width="">
          </colgroup>
          <tbody>
          <tr>
            <th scope="row">주문자</th>
            <td>${memberInfo.member_nm }</td>
          </tr>
          <tr>
            <th scope="row">주소</th>
            <td>
              <div class="input_box_1">우편번호 : ${memberInfo.zip_cd }</div>
              <div class="input_box_1">${memberInfo.addr1 }</div>
              <div>${memberInfo.addr2 }</div>
            </td>
          </tr>
          <tr>
            <th scope="row">이메일</th>
            <td>${memberInfo.email }</td>
          </tr>
          <tr>
            <th scope="row">주문자<br>휴대폰</th>
            <td>${memberInfo.cell }</td>
          </tr>
          <tr>
            <th scope="row">주문자<br>연락처</th>
            <td>${memberInfo.tel }</td>
          </tr>
          </tbody>
          </table>
        </div>

        <h5 class="pay_type">3. 배송지정보<span>( <i>필수입력사항입니다.)</i></span></h5>

        <div class="sub_table_1">
          <table>
          <colgroup>
          <col width="25%">
          <col width="">
          </colgroup>
          <tbody>
          <tr>
            <th scope="row" rowspan="2"><span>배송지<br>주소</span></th>
            <td>
              <span>
              <label><input type="radio" id="basongji_gubun" name="basongji_gubun" value = "2" checked class="radio"> 회원정보주소<br><br></label>
              <label><input type="radio" id="basongji_gubun" name="basongji_gubun" value = "1" class="radio"> 기본배송지</label>
              <label><input type="radio" id="basongji_gubun" name="basongji_gubun" value = "3" class="radio"> 새로운배송지</label>
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <div class="input_box_1">
                <input type="text" id="zip1" name="zip1" class="input_2 ws_1" maxlength="3"> - <input type="text" id="zip2" name="zip2" class="input_2 ws_1" maxlength="3">
                <a href="javascript:open_zipcode();"><img src="/images/sub_2/pay_s_btn2.gif" alt="주소찾기"></a><br><br><label><input type="checkbox" id="default_yn" name="default_yn" value = "Y" class="check"> 주소록에 기본배송지로 저장</label>
              </div>
              <div class="input_box_1">
                <input type="text" id="addr1" name="addr1" class="input_2 ws_2">
              </div>
              <div class="last">
                <input type="text" id="addr2" name="addr2" class="input_2 ws_2">
              </div>
            </td>
          </tr>
          <tr>
            <th scope="row"><span>수취인<br>이름</span></th>
            <td><input type="text" id="receiver" name="receiver" class="input_2 ws_3"></td>
          </tr>
          <tr>
            <th scope="row"><span>수취인<br>휴대폰</span></th>
            <td>
              <input type="text" id="cell1" name="cell1" class="input_2 ws_1" maxlength="3">
              -
              <input type="text" id="cell2" name="cell2" class="input_2 ws_1" maxlength="4">
              -
              <input type="text" id="cell3" name="cell3" class="input_2 ws_1" maxlength="4">
            </td>
          </tr>
          <tr>
            <th scope="row"><span>수취인<br>연락처</span></th>
            <td>
              <input type="text" id="tel1" name="tel1" class="input_2 ws_1" maxlength="3">
              -
              <input type="text" id="tel2" name="tel2" class="input_2 ws_1" maxlength="4">
              -
              <input type="text" id="tel3" name="tel3" class="input_2 ws_1" maxlength="4">
            </td>
          </tr>
          <tr>
            <th scope="row">
            <p><span>배송시<br>요청사항</span></p>
            <p class="btn_s5"><a href="#">공통사항<br>요청</a></p>
            </th>
            <td>
              <div class="color_2"><strong>주의!</strong> : 판매자와 사전에 협의되지 않은 선택정보 변경 기재는 반영되지 않을 수 있습니다.</div>
              <c:forEach var="item" items="${data.list }" varStatus="status">
              
              <div class="middle">
                <p class="color_1">상품명 : ${item.part3_nm } / ${item.carmodelnm } ${item.cargradenm } (${item.caryyyy }) </p>
                <p><input type="text" id="message" name="message" class="input_2 ws_4"> <span class="t_type1">( 0/100 bytes )</span></p>
                  <input type="hidden" name="cart_no" value="${item.cart_no }"/>
              </div>
               </c:forEach>
            </td>
          </tr>
          </tbody>
          </table>
        </div>

        <h5 class="pay_type">4. 결제금액</h5>

        <div class="pricecheck">

          <div class="top">

            <p>
            <span class="pt_l">정상가격</span>
            <span class="pt_r"><b>${suf:getThousand(user_price) }</b> 원</span>
            </p>

            <p class="t_mar">
            <span class="pt_l">할인금액</span>
            <span class="pt_r minus"><b>${suf:getThousand(discount_price) }</b> 원</span>
            </p>
            
             <p class="t_mar">
            <span class="pt_l">선결제배송비</span>
            <span class="pt_r"><b>${suf:getThousand(fee_price) }</b> 원</span>
            </p>

          </div>

          <div class="bottom">
            <p>
            <span class="pt_l">총 구매금액</span>
            <c:set var="actual_price" value="${user_price - discount_price + fee_price}" scope="request"/>
            <span class="pt_r"><b class="c1"><b>${suf:getThousand(actual_price) }</b></b> 원</span>
            </p>

          </div>

        </div>
<!-- 
        <div class="sub_table_1" style="margin-top:25px;">
          <table>
          <colgroup>
          <col width="35%">
          <col width="">
          </colgroup>
          <tbody>
          <tr>
            <th scope="row">현금영수증 신청</th>
            <td>
              <span><label><input type="radio" id="" name="" class="radio"> 발급</label></span>
              <span><label><input type="radio" id="" name="" class="radio"> 미발급</label></span>
            </td>
          </tr>
          <tr>
            <th scope="row">용도</th>
            <td>
              <span><label><input type="radio" id="" name="" class="radio"> 개인소득공제용</label></span>
              <span><label><input type="radio" id="" name="" class="radio"> 사업자증빙용</label></span>
            </td>
          </tr>
          <tr>
            <th scope="row">휴대폰번호</th>
            <td>
              <input type="text" id="" name="" class="input_2 ws_1">
              -
              <input type="text" id="" name="" class="input_2 ws_1">
              -
              <input type="text" id="" name="" class="input_2 ws_1">
            </td>
          </tr>
          </tbody>
          </table>
        </div>
 -->
        <div class="btn_bottom btn_big_1">
          <a href="javascript:;" onclick="return doPay(document.form)"><img src="/images/sub_2/btn_pay_2.gif" alt="결제하기"></a>
          <a href="/mobile/mypage/shopping/cart/index.do?mode=m_add_cart_list"><img src="/images/sub_2/btn_pay_3.gif" alt="장바구니로 가기"></a>
        </div>

      </div>
  
  
  <%
	/* 해쉬 암호화 적용( StoreId + OrdNo + Amt)
	 * StoreId          : 상점아이디		form.StoreId.value
	 * OrdNo          : 주문번호			form.OrdNo.value
	 * Amt      		 : 금액					form.Amt.value
	 * MD5 해쉬데이터 암호화 검증을 위해
	 */
	 
	 /*
	 String StoreId = request.getParameter("StoreId");
	 String OrdNo = request.getParameter("OrdNo");
	 String Amt = request.getParameter("Amt");
	*/
	String StoreId = Util.getProperty("store_id");
	String OrdNo = String.valueOf(request.getAttribute("orderno"));
	String Amt = String.valueOf(request.getAttribute("actual_price"));
	
	StringBuffer sb = new StringBuffer();
	sb.append(StoreId);
	sb.append(OrdNo);
	sb.append(Amt);
	
	byte[] bNoti = sb.toString().getBytes();
	MessageDigest md = MessageDigest.getInstance("MD5");
	byte[] digest = md.digest(bNoti);
	
	StringBuffer strBuf = new StringBuffer();
	for (int i=0 ; i < digest.length ; i++) {
	 	int c = digest[i] & 0xff;
		if (c <= 15){
			strBuf.append("0");
	 	}
	 	strBuf.append(Integer.toHexString(c));
	}
	
	String AGS_HASHDATA = strBuf.toString();
 
%>
  
  <input type="hidden" id = "m_member_nm" name="m_member_nm" value="${memberInfo.member_nm }"/>
  <input type="hidden" id = "m_zip_cd" name="m_zip_cd" value="${memberInfo.zip_cd }"/>
  <input type="hidden" id = "m_addr1" name="m_addr1" value="${memberInfo.addr1 }"/>
  <input type="hidden" id = "m_addr2" name="m_addr2" value="${memberInfo.addr2 }"/>
  <input type="hidden" id = "m_cell" name="m_cell" value="${memberInfo.cell }"/>
  <input type="hidden" id = "m_tel" name="m_tel" value="${memberInfo.tel }"/>
  <input type="hidden" id = "m_email" name="m_email" value="${memberInfo.email }"/>
  
  <form name="form" method="post" action="<%= strAegis %>/payment/mobilev2/intro.jsp">
  <input type="hidden" name="OrdNo" value="<%=OrdNo %>"/> 										<!-- 주문번호 -->		<!-- 필수 값 -->
  <c:choose>
  	<c:when test = "${fn:length(data.list) == 0}">
  	<input type="hidden" name="ProdNm" value="(주)파츠모아;${data.list[0].part3_nm}"/> 		<!-- 상품제공기간 -->
  	</c:when>
  	<c:otherwise>
  	<input type="hidden" name="ProdNm" value="(주)파츠모아;${data.list[0].part3_nm} 외 ${fn:length(data.list) }개"/> 		<!-- 상품제공기간 -->
  	</c:otherwise>
  </c:choose>
  <input type="hidden" name="Amt" value="<%=Amt %>"/> 											<!-- 가격 -->		<!-- 필수 값 -->
  <input type="hidden" name="OrdNm" value="${memberInfo.member_nm }"/> 							<!-- 구매자이름 -->	<!-- 필수 값 -->
  <input type="hidden" name="StoreNm" value="(주)파츠모아"/> 										<!-- 상점이름 -->		<!-- 필수 값 -->
  <input type="hidden" name="OrdPhone" value="${memberInfo.cell }"/> 							<!-- 휴대폰번호 -->	<!-- 필수 값 -->
  <input type="hidden" name="UserEmail" value="${memberInfo.email }"/> 							<!-- 이메일 -->		<!-- 필수 값 -->
  <input type="hidden" name="Job" value=""/> 													<!-- 결제방법 -->		<!-- 필수 값 -->
  <input type="hidden" name="StoreId" value="<%=StoreId %>"/> 									<!-- 상점아이디 --> 	<!-- 필수 값 -->
  <input type="hidden" name="MallUrl" value="http://www.partsmoa.co.kr"/> 						<!-- 상점URL -->		<!-- 필수 값 -->
  <input type="hidden" name="UserId" value="${memberInfo.member_id }"/> 						<!-- 회원아이디 -->	<!-- 필수 값 -->
  <input type="hidden" name="OrdAddr" value="${memberInfo.addr1 } ${memberInfo.addr2 }"/> 		<!-- 주문자주소 -->	<!-- 필수 값 -->
  
  <input type="hidden" name="RtnUrl" value="<%=http_host%>/AGSMobile/AGSMobile_approve.jsp"/> 		<!-- 성공 URL -->
  <input type="hidden" name="CancelUrl" value="<%=http_host%>/AGSMobile/AGSMobile_cancel.jsp"/> 	<!-- 취소 URL -->
  <c:choose>
  	<c:when test = "${fn:length(data.list) == 0}">
  	<input type="hidden" name="SubjectData" value="(주)파츠모아;${data.list[0].part3_nm};<%=Amt %>;"/> 		<!-- 상품제공기간 -->
  	</c:when>
  	<c:otherwise>
  	<input type="hidden" name="SubjectData" value="(주)파츠모아;${data.list[0].part3_nm} 외 ${fn:length(data.list) }개;<%=Amt %>;"/> 		<!-- 상품제공기간 -->
  	</c:otherwise>
  </c:choose>

  <input type="hidden" name="MallPage" value="/nositemesh/mypage/shopping/cart/index.do?mode=virAcctResult"/>						<!-- 통보페이지 -->
  <input type="hidden" name="VIRTUAL_DEPODT" value=""/>					<!-- 입금예정일 (YYYYMMDD) -->
  <input type="hidden" name="RcpNm" value=""/>							<!-- 수신자명 -->
  <input type="hidden" name="RcpPhone" value=""/>						<!-- 수신자연락처 -->
  <input type="hidden" name="DlvAddr" value=""/>						<!-- 배송지주소 -->
  <input type="hidden" name="Remark" value=""/>							<!-- 기타요구사항 -->
  <input type="hidden" name="DutyFree" value="0"/>						<!-- 면세금액 -->
  <input type="hidden" name=DeviId value="9000400001">			
  <input type="hidden" name=QuotaInf value="0">			
  <input type="hidden" name=NointInf value="NONE">
  
  <input type="hidden" name="CardSelect" value=""/>						<!-- 카드사선택 -->
  <input type="hidden" name="Column1" value=""/>						<!-- 추가사용필드1 -->
  <input type="hidden" name="Column2" value=""/>						<!-- 추가사용필드2 -->
  <input type="hidden" name="Column3" value=""/>						<!-- 추가사용필드3 -->
  <input type="hidden" name="HP_ID" value=""/>							<!-- CP아이디 -->
  <input type="hidden" name="HP_PWD" value=""/>							<!-- CP비밀번호 -->
  <input type="hidden" name="HP_SUBID" value=""/>						<!-- SUB-CP아이디 -->
  <input type="hidden" name="ProdCode" value=""/>						<!-- 상품코드 -->
  <input type="hidden" name="HP_UNITType" value=""/>					<!-- 상품종류 디지털:1 실물:2-->
 </form>
</body>
</html>
