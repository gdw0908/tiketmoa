<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta content="minimum-scale=1.0, width=device-width, maximum-scale=1, user-scalable=yes" name="viewport" />
</head>
<!-- 파라미터 -->
<c:set var="paramset" value=""/>
<c:forEach var="item" items="${pageContext.request.parameterNames}">
	<c:if test="${!(item eq 'totalpage' || item eq 'cpage' || item eq 'rows' || item eq 'sort' || item eq 'focus' || item eq 'show')}">
	<c:choose>
		<c:when test="${paramset eq '' }">
			<c:set var="paramset" value="${paramset }?${item }=${param[item] }"/>
		</c:when>
		<c:otherwise>
			<c:set var="paramset" value="${paramset }&${item }=${param[item] }"/>
		</c:otherwise>
	</c:choose>
	</c:if>
</c:forEach>
<c:choose>
	<c:when test="${paramset eq '' }">
		<c:set var="paramset" value="?"/>
	</c:when>
	<c:otherwise>
		<c:set var="paramset" value="${paramset }&"/>
	</c:otherwise>
</c:choose>
<!-- //파라미터 -->
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>상품검색</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="/lib/css/sub.css" type="text/css">
<script type="text/javascript" src="/lib/js/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(window).scrollTop($("#content_view").offset().top);
	
	
//#submenu
$("#submenu_open").toggle(function(){
	$("#sub_menu").slideToggle(250);
	this.src = "/images/sub/sub_menu_open.gif";
	}, function() {
	$("#sub_menu").slideToggle(250);
	this.src = "/images/sub/sub_menu_close.gif";
});

<c:if test="${param.menu eq 'menu5' || param.menu eq 'menu6'}">
$("#submenu_open").attr("src","/images/sub/sub_menu_close.gif");
</c:if>
});
 
 
function changeMenu(){
	var upcodenoNumber = '';
	if($("#menu_id").val() == 'menu9'){
		upcodenoNumber = '6';
	}else{
		upcodenoNumber = $("#menu_id").val().replace("menu","");
	}
	$.getJSON("/json/list/old_code.codeList.do", {upcodeno : "05090100"+upcodenoNumber}, function(data){
		$("#part2_1").empty();
		$("#part2_1").append("<option value=''>선 택</option>");
		$.each(data, function(i, o){
			$("#part2_1").append("<option value='"+o.code+"'>"+o.code_nm+"</option>");
		});
	});
}

function replaceApplication(){
	if(confirm("조회 건수가 없습니다.\n부품문의로 이동하시겠습니까?")){
		location.href="/mypage/application/index.do";
	}
}

function changeCarmaker(){
	
	$.getJSON("/json/list/old_code.carmodel.do", {carmakerseq : $("#carmakerseq").val()}, function(data){
		$("#carmodelseq").empty();
		$("#carmodelseq").append("<option value=''>선 택</option>");
		$.each(data, function(i, o){
			$("#carmodelseq").append("<option value='"+o.carmodelseq+"'>"+o.carmodelnm+"</option>");
		});
	});
}

function changeCarmodel(){
	$.getJSON("/json/list/old_code.cargrade.do", {carmakerseq: $("#carmakerseq").val(),  carmodelseq: $("#carmodelseq").val()}, function(data){
		$("#cargradeseq").empty();
		$("#cargradeseq").append("<option value=''>선 택</option>");
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

function goSubmit(){
	$("#frm").submit();
}

function list(value)
{
	location.replace("${paramset}rows=" + value+"&show=${param.show}&sort=${param.sort}&focus=${param.focus}");
}

function go_url(url)
{	
	location.replace(url);

}

function frmreset(){
	<c:if test="${param.menu eq '' || param.menu eq null}">
	document.frm.menu.value = "";
	</c:if>
	document.frm.carmakerseq.value = "";
	document.frm.carmodelseq.value = "";
	document.frm.cargradeseq.value = "";
	document.frm.caryyyy.value = "";
	<c:if test="${param.menu eq 'menu1' || param.menu eq 'menu2' || param.menu eq 'menu3' || param.menu eq 'menu4' || param.menu eq '' || param.menu eq null}">
	document.frm.part2_1.value = "";
	</c:if>
	document.frm.grade.value = "";
	document.frm.sido.value = "";
	document.frm.sigungu.value = "";
	document.frm.dong.value = "";
	document.frm.keyword.value = "";
	document.frm.search_all_text.value = "";
}

function inquery_y(){
	alert("협의가 필요한 물품입니다.\n고객센터로 문의 바랍니다.");
}

function addCart(item_seq){
	$("#cartFrm>[name='mode']").val("add_cart");
	$("#cartFrm>[name='seq']").val(item_seq);
	$("#cartFrm").submit();
	return false;
}

function directOrder(item_seq){
	$("#cartFrm>[name='mode']").val("direct_order");
	$("#cartFrm>[name='seq']").val(item_seq);
	$("#cartFrm").submit();
	return false;
}
<c:if test="${empty data.list}">
	replaceApplication();
</c:if>
</script>
</head>

<body>
   <div class="container" style="background: #E8EBE8;">
    <div class="gnb_wrap">
        <!-- gnb메뉴 -->
<%-- 		<page:applyDecorator name="gnb" /> --%>
        <!-- //gnb메뉴 -->
    </div>

    <div class="sub_line_bg">
      <div class="sub_line">
        <div class="sl_wrap">
          <div class="sl_l" id="content_view">
          	<c:choose>
          		<c:when test="${param.menu eq 'menu1' }"><h3>마이크</h3></c:when>
          		<c:when test="${param.menu eq 'menu2' }"><h3>앰프</h3></c:when>
          		<c:when test="${param.menu eq 'menu3' }"><h3>오디오믹서</h3></c:when>
          		<c:when test="${param.menu eq 'menu4' }"><h3>스피커</h3></c:when>
          		<c:when test="${param.menu eq 'menu5' }"><h3>전관방송</h3></c:when>
          		<c:when test="${param.menu eq 'menu6' }"><h3>소스/프로세서</h3></c:when>
          		<c:when test="${param.menu eq 'menu7' }"><h3>랙/하드케이스</h3></c:when>
          		<c:when test="${param.menu eq 'menu8' }"><h3>스탠드/보면대</h3></c:when>
          		<c:when test="${param.menu eq 'menu9' }"><h3>케이블/커넥터</h3></c:when>
          		<c:when test="${param.menu eq 'menu10' }"><h3>영상기기</h3></c:when>
          		<c:when test="${param.menu eq 'menu11' }"><h3>패키지</h3></c:when>
          		<c:when test="${param.menu eq 'menu9' }"><c:if test="${param.part2 == '050901006003'}"><h3><img src="/images/sub/title_7_1.gif" alt="알터네이터"></h3></c:if><c:if test="${param.part2 == '050901006001'}"><h3><img src="/images/sub/title_7_2.gif" alt="A/C콤프레서"></h3></c:if><c:if test="${param.part2 == '050901006002'}"><h3><img src="/images/sub/title_7_3.gif" alt="스타트모터"></h3></c:if></c:when>
          	</c:choose>
<!--             <p> -->
<!--             <span><strong>홈</strong></span> &gt; -->
<!--             <span> -->
<%--            		<c:choose> --%>
<%--           			<c:when test="${param.menu eq 'menu1' }">마이크</c:when> --%>
<%--           			<c:when test="${param.menu eq 'menu2' }">앰프</c:when> --%>
<%--           			<c:when test="${param.menu eq 'menu3' }">오디오믹서</c:when> --%>
<%--           			<c:when test="${param.menu eq 'menu4' }">스피커</c:when> --%>
<%--           			<c:when test="${param.menu eq 'menu5' }">전관방송</c:when> --%>
<%--           			<c:when test="${param.menu eq 'menu6' }">소스/프로세서</c:when> --%>
<%--           			<c:when test="${param.menu eq 'menu7' }">랙/하드케이스</c:when> --%>
<%--           			<c:when test="${param.menu eq 'menu8' }">스탠드/보면대</c:when> --%>
<%--           			<c:when test="${param.menu eq 'menu9' }">케이블/커넥터</c:when> --%>
<%--           			<c:when test="${param.menu eq 'menu10' }">영상기기</c:when> --%>
<%--           			<c:when test="${param.menu eq 'menu11' }">패키지</c:when> --%>
<%--           			<c:when test="${param.menu eq 'menu9' }"><c:if test="${param.part2 == '050901006003' }">재제조 &gt; 알터네이터</c:if><c:if test="${param.part2 == '050901006001' }">재제조 &gt; A/C 콤프레서</c:if><c:if test="${param.part2 == '050901006002' }">재제조 &gt; 스타트모터</c:if></c:when> --%>
<%--           			<c:otherwise> --%>
<!--           				전체검색 -->
<%--           			</c:otherwise> --%>
<%--           		</c:choose> --%>
<!--             </span> &gt; -->
            <c:choose>
            	<c:when test = "${not empty param.menu}">
            	
            	</c:when>
            	<c:otherwise>
            	
            	</c:otherwise>
            </c:choose>
            <c:if test = "${not empty param.menu}">
            <span>${param.cname }</span>
            </c:if>
             <!-- &gt; <span><strong>총 부품 : <b>${suf:getThousand(data.pagination.totalcount) }</b> 개</strong></span>  -->
<!--             </p> -->
          </div>
          <c:choose>
    		<c:when test="${empty data.list && param.menu eq 'menu9'}">
    		</c:when>
    		<c:otherwise>
<!--           <div class="sl_r"> -->
<!--             <span class="sr_3"><img id="submenu_open" src="/images/sub/sub_menu_close.gif" alt="상세조건 검색버튼" style="cursor:pointer;"></span> -->
<!--           </div> -->
          	</c:otherwise>
          </c:choose>
        </div>
      </div>
	<c:choose>
    	<c:when test="${empty data.list && param.menu eq 'menu9'}">
    	</c:when>
    	<c:otherwise>
      <!-- all_menu on -->
      <div class="sm_wrap" style="display:block;" id="sub_menu">
        <div class="sub_menu">

<!--           <div class="product_list"> -->
<%--           <c:set var="actionURL" value="/goods/list.do?menu=${param.menu }"/> --%>
<%--           <c:if test="${param.menu eq '' || param.menu eq null}"> --%>
<%--           	<c:set var="actionURL" value="/goods/list.do"/> --%>
<%--           </c:if> --%>
<%--           <form action="${actionURL }" method="post" id="frm" name="frm"> --%>
<%--             <input type="hidden" name="search_all_text" value="${param.search_all_text }"> --%>
<!--             <p class="pl_title">※ 검색조건과 함께 찾으시는 부품을 선택해 주세요</p> -->
<!--             <table> -->
<%--             <colgroup> --%>
            
<%--             <col width="15.5%"> --%>
<%--             <col width="18%"> --%>
<%--             <col width=""> --%>
<%--             <col width="10%"> --%>
<%--             <c:if test="${param.menu eq '' || param.menu eq null}"> --%>
<%--             <col width="7%"> --%>
<%--             </c:if> --%>
<%-- 			<c:if test="${param.menu eq 'menu1' || param.menu eq 'menu2' || param.menu eq 'menu3' || param.menu eq 'menu4' || param.menu eq 'menu9' || param.menu eq '' || param.menu eq null}"> --%>
<%--             <col width="18%"> --%>
<%--             </c:if> --%>
<%--             <col width="12%"> --%>
<%--             </colgroup> --%>
<!--             <thead> -->
<!--             <tr> -->
<!--               <th scope="col">제조사</th> -->
<!--               <th scope="col">차량명</th> -->
<!--               <th scope="col">모델명</th> -->
<!--               <th scope="col">연식</th> -->
<%--               <c:if test="${param.menu eq '' || param.menu eq null}"> --%>
<!-- 	          <th scope="col">구분</th> -->
<%-- 	          </c:if> --%>
<%-- 			  <c:if test="${param.menu eq 'menu1' || param.menu eq 'menu2' || param.menu eq 'menu3' || param.menu eq 'menu4' || param.menu eq 'menu9' || param.menu eq '' || param.menu eq null}"> --%>
<!--               <th scope="col">부품</th> -->
<%--               </c:if> --%>
<!--               <th scope="col">등급</th> -->
<!--             </tr> -->
<!--             </thead> -->
<!--             <tbody> -->
<!--             <tr> -->
            
            
	        
<!--               <td> -->
<!--               	<select id="carmakerseq" name="carmakerseq" class="select_sm1" size="8" onchange="changeCarmaker()"> -->
<!--               	<option value="">선 택</option> -->
<%--                 	<c:forEach var="item" items="${data.carmaker }"> --%>
<%--                 	<option value="${item.carmakerseq }" <c:if test="${item.carmakerseq eq param.carmakerseq }">selected="selected"</c:if>>${item.makernm }</option> --%>
<%--                 	</c:forEach> --%>
<!-- 				</select> -->
<!--               </td> -->

<!--               <td> -->
<!--               	<select id="carmodelseq" name="carmodelseq" class="select_sm1" size="8" onchange="changeCarmodel()"> -->
<!--               	<option value="">선 택</option> -->
<%--                 	<c:forEach var="item" items="${data.carmodel }"> --%>
<%--                 	<option value="${item.carmodelseq }" <c:if test="${item.carmodelseq eq param.carmodelseq }">selected="selected"</c:if>>${item.carmodelnm }</option> --%>
<%--                 	</c:forEach> --%>
<!--               	</select> -->
<!--               </td> -->

<!--               <td> -->
<!--               	<select id="cargradeseq" name="cargradeseq" class="select_sm1" size="8"> -->
<!--               	<option value="">선 택</option> -->
<%--                 	<c:forEach var="item" items="${data.cargrade }"> --%>
<%--                 	<option value="${item.cargradeseq }" <c:if test="${item.cargradeseq eq param.cargradeseq }">selected="selected"</c:if>>${item.cargradenm }</option> --%>
<%--                 	</c:forEach> --%>
<!--               	</select> -->
<!--               </td> -->

<!--               <td> -->
<!--               	<select id="caryyyy" name="caryyyy" class="select_sm1" size="8"> -->
<!--               	<option value="">선 택</option> -->
<%--               	<c:forEach var="item" begin="1995" end="${dtf:getTime('yyyy') }"> --%>
<%--               		<option value="${item }" <c:if test="${item eq param.caryyyy }">selected="selected"</c:if>>${item }년</option> --%>
<%--                	</c:forEach> --%>
<!--               	</select> -->
<!--               </td> -->
			  
<%-- 			  <c:if test="${param.menu eq '' || param.menu eq null}"> --%>
<!--               <td> -->
<!--               	<select id="menu_id" name="menu" class="select_sm1" size="8" onchange="changeMenu();"> -->
<!-- 					<option value="menu1">바디</option> -->
<!-- 					<option value="menu2">의장</option> -->
<!-- 					<option value="menu3">엔진</option> -->
<!-- 					<option value="menu4">샤시</option> -->
<!-- 					<option value="menu9">재제조</option> -->
<!--                 </select> -->
<!--               </td> -->
<%-- 	          </c:if> --%>
	          
<%-- 			  <c:if test="${param.menu eq 'menu1' || param.menu eq 'menu2' || param.menu eq 'menu3' || param.menu eq 'menu4' || param.menu eq 'menu9' || param.menu eq '' || param.menu eq null}"> --%>
<!--               <td> -->
<!--               	<select id="part2_1" name="part2_1" class="select_sm1" size="8" multiple="multiple"> -->
<!--               	<option value="">선 택</option> -->
<%--               	<c:forEach var="item" items="${data.part2 }"> --%>
<%--               		<option value="${item.code }" <c:if test="${item.code eq param.part2_1 }">selected="selected"</c:if>>${item.code_nm }</option> --%>
<%--               	</c:forEach> --%>
<!--               	</select> -->
<!--               </td> -->
<%--               </c:if> --%>

<!--               <td> -->
<!--               	<select id="grade" name="grade" class="select_sm1" size="8"> -->
<!--               	<option value="">선 택</option> -->
<%--               	<c:forEach var="item" items="${data.grade }"> --%>
<%--               		<option value="${item.code }" <c:if test="${item.code eq param.grade }">selected="selected"</c:if>>${item.code_nm }</option> --%>
<%--               	</c:forEach> --%>
<!--               	</select> -->
<!--               </td> -->

<!--             </tr> -->
<!--             </tbody> -->
<!--             </table> -->

<!--             <div class="pl_bottom"> -->

<!--               <p class="plb_l"> -->
<!--               <span class="cb_1">지역별</span> -->

<!--               <span> -->
<!--               <select id="sido" name="sido" class="select_1" onchange="changeSido()"> -->
<!--               	<option value="">시/도</option> -->
<%--               	<c:forEach var="item" items="${data.sido }"> --%>
<%--               		<option value="${item.sido }" <c:if test="${item.sido eq param.sido }">selected="selected"</c:if>>${item.dong_nm }</option> --%>
<%--               	</c:forEach> --%>
<!--               </select> -->
<!--               </span> -->

<!--               <span> -->
<!--               <select id="sigungu" name="sigungu" class="select_1" onchange="changeSigungu()"> -->
<!--               	<option value="">시/군/구</option> -->
<%--               	<c:forEach var="item" items="${data.sigungu }"> --%>
<%--               		<option value="${item.sigungu }" <c:if test="${item.sigungu eq param.sigungu }">selected="selected"</c:if>>${item.dong_nm }</option> --%>
<%--               	</c:forEach> --%>
<!--               </select> -->
<!--               </span> -->

<!--               <span> -->
<!--               <select id="dong" name="dong" class="select_1"> -->
<!--               <option value="">읍/면/동</option> -->
<%--               	<c:forEach var="item" items="${data.dong }"> --%>
<%--               		<option value="${item.dong }" <c:if test="${item.dong eq param.dong }">selected="selected"</c:if>>${item.dong_nm }</option> --%>
<%--               	</c:forEach> --%>
<!--               </select> -->
<!--               </span> -->

<!--               </p> -->

<!--               <p class="plb_r"> -->
<!--               <span class="cb_1">조건 내 검색</span> -->

<%--               <span class="input_box"><input type="text" name="keyword" class="input_1" value="${param.keyword }"></span>               --%>
<!--               <span><a href="javascript:goSubmit();"><img src="/images/container/pl_btn_2.gif" alt="검색"></a></span> -->
<!--               <span><a href="javascript:frmreset();"><img src="/images/container/pl_btn_1.gif" alt="초기화"></a></span> -->
              

<!--               </p> -->

<!--             </div> -->
<!-- 			</form> -->
<!--           </div> -->

        </div>
      </div>
    </div>
    <!-- all_menu on End -->
    	</c:otherwise>
    </c:choose>
    <c:choose>
    <c:when test="${empty data.list && param.menu eq 'menu9'}">
    <div class="sub_wrap">
      <div class="sub_contents">
        <div class="sub_contents_img">
    	<c:if test="${param.part2 == '050901006003'}">
    	<p><img src="/images/sub/contents_img_01.gif" alt="알터네이터 문의"></p>
    	</c:if>
    	<c:if test="${param.part2 == '050901006001'}">
    	<p><img src="/images/sub/contents_img_02.gif" alt="A/C콤프레서 문의"></p>
    	</c:if>
    	<c:if test="${param.part2 == '050901006002'}">
    	<p><img src="/images/sub/contents_img_03.gif" alt="스타트모터 문의"></p>
    	</c:if>
    	</div>
      </div>
    </div>
    </c:when>
    <c:otherwise>    
    <div class="sub_wrap">
    	<!--  가격대 조건 검색  -->
<!--     	<article class="condition_wrap"> -->
<!--     		<div class="condition_content"> -->
<!--     			<p>가격대</p> -->
<!--     			<ul> -->
<!--     				<li data-filter="all">전체</li> -->
<!--     				<li data-filter="1">~1만원</li> -->
<!--     				<li data-filter="2">1~5만원</li> -->
<!--     				<li data-filter="3">5~15만원</li> -->
<!--     				<li data-filter="4">15~30만원</li> -->
<!--     				<li data-filter="5">30만원~</li> -->
<!--     			</ul> -->
<!--     			<div class="input_wrap"> -->
<!--     				<input type="text"   /> 원 ~  -->
<!--     				<input type="text"   /> 원    			 -->
<!--     			</div> -->
<!--     			<a href="#" class="serch_btn">검색</a> -->
<!--     		</div> -->
<!--     	</article> -->
    	
        <div class="sub_contents">
      
			<div class="sc_top">
		          <ul class="sc_tab">
		            <li><a <c:if test = "${empty param.focus}">class="on"</c:if> href="javascript:go_url('${paramset }show=${param.show }&rows=${param.rows }');">최근등록순</a></li>
		            <li><a <c:if test = "${param.focus eq '1'}">class="on"</c:if> href="javascript:go_url('${paramset }sort=row&focus=1&show=${param.show }&rows=${param.rows }');">낮은가격</a></li>
		            <li class="last"><a <c:if test = "${param.focus eq '2'}">class="on"</c:if> href="javascript:go_url('${paramset }sort=high&focus=2&show=${param.show }&rows=${param.rows }');">높은가격</a></li>
		          </ul>
		
		          <div class="sc_type">
		            <span><a href="javascript:go_url('${paramset }show=1&rows=10&sort=${param.sort}&focus=${param.focus}');"><img src="/images/sub/sc_type_btn1_<c:choose><c:when test = "${param.show eq '1' || empty param.show }">on</c:when><c:otherwise>off</c:otherwise></c:choose>.gif" alt=""></a></span>
		            <span><a href="javascript:go_url('${paramset }show=2&rows=12&sort=${param.sort}&focus=${param.focus}');"><img src="/images/sub/sc_type_btn2_<c:choose><c:when test = "${param.show eq '2' }">on</c:when><c:otherwise>off</c:otherwise></c:choose>.gif" alt=""></a></span>
		            <span>
		            <c:choose>
		            	<c:when test="${param.show == '2' }">
		            	<select id="rows" name="rows" class="select_1" onchange = "list(this.value);">
			            <option value = "12" <c:if test = "${param.rows eq '12'}">selected</c:if>>12개</option>
			            <option value = "24" <c:if test = "${param.rows eq '24'}">selected</c:if>>24개</option>
			            <option value = "48" <c:if test = "${param.rows eq '48'}">selected</c:if>>48개</option>
			            </select>
		            	</c:when>
		            	<c:otherwise>
		            	<select id="rows" name="rows" class="select_1" onchange = "list(this.value);">
			            <option value = "10" <c:if test = "${param.rows eq '10'}">selected</c:if>>10개</option>
			            <option value = "30" <c:if test = "${param.rows eq '30'}">selected</c:if>>30개</option>
			            <option value = "50" <c:if test = "${param.rows eq '50'}">selected</c:if>>50개</option>
			            </select>
		            	</c:otherwise>
		            </c:choose>
		            </span>
		          </div>
		        </div>
        
		<c:choose>
			<c:when test = "${empty param.show || param.show eq '1' }">
				<!-- 방명록 스타일 시작 -->
		        <div class="sub_list">
		        
		          	<div class="list_item_wrap">
		          		<ul class="item_wrap">
		        			<c:if test="${empty data.list }"><li>조회 건수가 없습니다.</li></c:if>
		         				 <c:forEach var="item" items="${data.list }">
		          			<li class="item_list">
		          				<div class="item">
		          					<a href="view.do?menu=${param.menu }&seq=${item.item_seq }" class="img_wrap"><img src="${item.thumb }" alt="${item.part3_nm }"></a>
		          					<div class="m_btn">
		                				<a href="view.do?menu=${param.menu }&seq=${item.item_seq }" target="_blank">새창</a>
		                				<a href="#" onclick="return addCart('${item.item_seq }')">장바구니</a>
		                				<c:choose>
		                					<c:when test="${item.inquiry_yn eq 'Y' }"><a href="javascript:inquery_y();">바로구매</a>
		                					</c:when>
		                					<c:otherwise>
		                						<a href="#" onclick="return directOrder('${item.item_seq }')">바로구매</a>
		                					</c:otherwise>
		                				</c:choose>
		                			</div>
		          				</div>
		          				<div class="list_info">
		          					<span class="tit">${item.part3_nm }</span>
		          					<ul>
		          						<li>${item.part1_nm } / ${item.part2_nm }</li>
		          						<li>
		          							<c:choose>
				        						<c:when test="${item.inquiry_yn eq 'Y' }">
				        							<span class="price">협의</span>
				        						</c:when>
				        						<c:otherwise>
						        					<c:if test="${item.discount_rate > 0}">
					              						<span class="price_un">${suf:getThousand(item.user_price) }</span>
					              						<span class="price">${suf:getThousand(item.sale_price) } 원</span>
				            						</c:if>
													<c:if test="${item.discount_rate == 0 || empty item.discount_rate}">
					              						<span class="price">${suf:getThousand(item.user_price) } 원</span>
				            						</c:if>
				        						</c:otherwise>
				       						 </c:choose>
		          						</li>
		          					</ul>
		          				</div>
		          			</li>
		         		    </c:forEach>
		          		</ul>
		          	</div>
		

<%-- 		          <colgroup> --%>
<%-- 		          <col width=""> --%>
<%-- 		          <col width="15%"> --%>
<%-- 		          <col width="30%"> --%>
<%-- 		          <col width="20%"> --%>
<%-- 		          </colgroup> --%>
		
<!-- 		          <thead> -->
<!-- 		          <tr> -->
<!-- 		            <th>제품사진</th> -->
<!-- 		            <th>제품정보</th> -->
<!--  		            <th>협력사가</th> -->
<!-- 		            <th>상품코드</th> --> 
<!-- 		            <th>판매가격</th> -->
<!-- 		            <th>혜택</th>  -->
<!-- 		            <th>판매자</th> -->
<!-- 		          </tr> -->
<!-- 		          </thead> -->
	
		          
					<jsp:include page="/inc/paging2.do">
						<jsp:param  name="cpage" value="${param.cpage }"/>
						<jsp:param  name="rows" value="${param.rows }"/>
						<jsp:param  name="totalpage" value="${data.pagination.totalpage }"/>
					</jsp:include>
		
		        </div>
        	<!-- 방명록 스타일 끝 -->
			</c:when>
			<c:otherwise>
			
				<!-- 바둑판 형 스타일 시작 -->
				
		        <div class="sub_list">

		          <ul class="sl_type_2">
					<c:forEach var="item" items="${data.list }">
			            <li>
			            <div>
			              <a href="view.do?menu=${param.menu }&seq=${item.item_seq }">
			              <span class="img"><img src="${item.thumb }" alt="${item.part3_nm }"></span>
			              <span class="f_type1">${item.carmodelnm } (${item.caryyyy }년식) / ${item.part3_nm } / ${item.grade }등급 <c:if test = "${not empty item.discount_rate && item.discount_rate > 0 }"><span class="f_style_1">${item.discount_rate }%↓</span></c:if></span>
			              </a>
			            </div>
			            <div class="text">
<%-- 			              <p class="f_type2">${item.com_nm } / <b class="phone">${item.sigungu_nm }</b></p> --%>
<%-- 						  <p class="f_type2">상품코드 / <b class="phone">${item.item_code }</b></p> --%>
			             <!--  <p class="f_type3"><strong>협력사가</strong> : <b class="c2">10,000,000 원<span class="price_un">90,000</span></b></p>  --> 
			              <p class="f_type3"><strong>판매가격</strong> : 
			              <b class="c2">
			              	<c:choose>
					        	<c:when test="${item.inquiry_yn eq 'Y' }">
					        	협의
					        	</c:when>
					        	<c:otherwise>
							        <c:if test="${item.discount_rate > 0}">
						              ${suf:getThousand(item.sale_price) } 원
						              <span class="price_un">${suf:getThousand(item.user_price) }</span>
					            	</c:if>
									<c:if test="${item.discount_rate == 0 || empty item.discount_rate}">
						              ${suf:getThousand(item.user_price) } 원
					            	</c:if>
					        	</c:otherwise>
					        </c:choose>
			              </b>
			              </p>
			            </div>
			            </li>
					</c:forEach>
		          </ul>
		         	<jsp:include page="/inc/paging2.do">
						<jsp:param name="cpage" value="${param.cpage }"/>
						<jsp:param name="rows" value="${param.rows }"/>
						<jsp:param name="totalpage" value="${data.pagination.totalpage }"/>
					</jsp:include>
		        </div>
		        <!-- 바둑판 형 스타일 끝 -->
			</c:otherwise>
		</c:choose>
      </div>
    </div>
    </c:otherwise>
    </c:choose>
    <form id="cartFrm" name="cartFrm" method="post" action="/mypage/shopping/cart/index.do">
    	<input type="hidden" name="mode" value=""/>
    	<input type="hidden" name="seq" value=""/>
    	<input type="hidden" name="qty" value="1"/>
    </form>
    </div>
</body>
</html>
