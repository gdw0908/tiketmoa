<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>상품검색</title>
<link rel="stylesheet" href="/lib/css/sub.css" type="text/css">
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

});
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


function search_cooperation(f){
	f.submit();
}
function search_cooperation_reset(f){
	f.sido.value = "";
	f.sigungu.value = "";
	f.dong.value = "";
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
            <h3><img src="/images/sub/title_7.gif" alt="협력사정보"></h3>
            <!--<p>
            <span><strong>홈</strong></span> &gt; <span>바디</span> &gt; <span>라지에이터 그릴</span> &gt; <span><strong>총 부품 : <b>1,866</b> 개</strong></span>
            </p> -->
          </div>
          <div class="sl_r">
            <!--
            <span><a href="#"><img src="/images/sub/sub_line_btn_2.gif" alt="PARTS MOA 추천상품"></a></span>
            <span class="sr_3"><img id="submenu_open" src="/images/sub/sub_menu_open.gif" alt="상세조건 검색버튼" style="cursor:pointer;"></span>  -->
          </div>
        </div>
      </div>

      <!-- all_menu on -->
      <div class="sm_wrap sm7">
        <div class="sub_menu">

          <div class="product_list">
            <div class="pl_bottom">
			<form name="search" action="list.do?menu=${param.menu }" method="post">
              <p class="plb_l">
              <span class="cb_1">지역별</span>

              <span>
              <select id="sido" name="sido" class="select_1" onchange="changeSido();">
              <option value="">시/도</option>
              <c:forEach items="${data.sido }" var="item" varStatus="status">
              	<option value="${item.sido }" <c:if test="${item.sido eq param.sido}">selected="selected"</c:if>>${item.dong_nm }</option>
              </c:forEach>
              </select>
              </span>

              <span>
              <select id="sigungu" name="sigungu" class="select_1" onchange="changeSigungu()">
              <option value="">시/군/구</option>
              <c:forEach var="item" items="${data.sigungu }">
              		<option value="${item.sigungu }" <c:if test="${item.sigungu eq param.sigungu }">selected="selected"</c:if>>${item.dong_nm }</option>
              </c:forEach>
              </select>
              </span>

              <span>
              <select id="dong" name="dong" class="select_1">
              <option value="">읍/면/동</option>
                <c:forEach var="item" items="${data.dong }">
              		<option value="${item.dong }" <c:if test="${item.dong eq param.dong }">selected="selected"</c:if>>${item.dong_nm }</option>
              	</c:forEach>
              </select>
              </span>

              </p>

              <p class="plb_r">
              <span class="cb_1">조건 내 검색</span>

              <span class="input_box"><input type="text" id="keyword" name="keyword" class="input_1" value="${param.keyword }"/></span>

              <span><a href="javascript:search_cooperation_reset(document.search)"><img src="/images/container/pl_btn_1.gif" alt="초기화"></a></span>
              <span><a href="javascript:search_cooperation(document.search)"><img src="/images/container/pl_btn_2.gif" alt="검색"></a></span>

              </p>
			</form>
            </div>

          </div>

        </div>
      </div>
    </div>
    <!-- all_menu on End -->

    <div class="sub_wrap">
      <div class="sub_contents">
        <div class="sub_list">

          <table class="sub_list_style_1">
          <colgroup>
          <col width="18%">
          <col width="">
          <col width="15%">
          <col width="15%">
          <col width="6%">
          <col width="16%">
          </colgroup>

          <thead>
          <tr>
            <th>지역</th>
            <th>업체명</th>
            <th>업태/종목</th>
            <th>대표자명</th>
            <th>담당자명</th>
            <th>상세보기</th>
          </tr>
          </thead>

          <tbody>
          <c:if test="${empty data.list } "><tr><td colspan="6">검색 결과가 존재하지 않습니다.</td></tr></c:if>
          <c:forEach var="item" items="${data.list }">
          <tr>
            <td>${item.dong_nm }</td>
			<td>${item.com_nm }</td>
			<td>${item.comptyp1 }/${item.comptyp2 }</td>
			<td>${item.ceo_nm }</td>
			<td>${item.staff_nm }</td>
			<td>
			  <a href="view.do?menu=${param.menu }&amp;seq=${item.seq }&amp;cpage=${param.cpage }&amp;keyword=${param.keyword }&amp;sido=${param.sido }&amp;sigungu=${param.sigungu }&amp;dong=${param.dong }"><img src="/images/sub/see_g7_03.gif" alt="상세보기" /></a>
			</td>
          </tr>
          </c:forEach>
          </tbody>

          </table>
			<jsp:include page="/inc/paging2.do">
				<jsp:param  name="cpage" value="${param.cpage }"/>
				<jsp:param  name="rows" value="${param.rows }"/>
				<jsp:param  name="totalpage" value="${data.pagination.totalpage }"/>
			</jsp:include>
        <!--
          <div class="con_more">
            <span class="page">1page/106</span>
            <div class="more"><a href="#"><strong class="arrow">더보기</strong><span class="arrow"></span></a></div>
          </div>
 		-->
        </div>

      </div>
    </div>
    
</body>
</html>
