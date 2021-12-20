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

});
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

function goSubmit(){
	$("#frm").submit();
}

function list(value){
	location.replace("?menu=${param.menu }&keyword=${param.keyword}&rows=" + value);
}

</script>
</head>
<body>
	<form action="list.do?menu=${param.menu }" method="post" id="frm" name="frm">
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
                  <a href="javascript:document.frm.reset();"><img src="/images/mobile/common/btn_reset.gif" alt="초기화"></a>
                  <a href="javascript:goSubmit();"><img src="/images/mobile/common/btn_search.gif" alt="검색"></a>
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
          <h3><img src="/images/mobile/sub/sub_title_7.gif" alt="지역별 부품정보"></h3>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>

        <div class="sc_top">
          <div class="sc_type">
            <select id="rows" name="rows" class="select_1" onchange = "list(this.value);">
            <option value = "10" <c:if test = "${param.rows eq '10'}">selected</c:if>>10개</option>
            <option value = "30" <c:if test = "${param.rows eq '30'}">selected</c:if>>30개</option>
            <option value = "50" <c:if test = "${param.rows eq '50'}">selected</c:if>>50개</option>
            </select>
          </div>
        </div>

		<table class="sub_list_style_1">
          <colgroup>
          <col width="18%">
          <col width="">
          <col width="20%">
          <col width="25%">
          </colgroup>

          <thead>
          <tr>
            <th>지역</th>
            <th>업체명</th>
            <th>담당자명</th>
            <th>상세보기</th>
          </tr>
          </thead>
          <tbody>
          <c:if test="${empty data.list } "><tr><td colspan="4">검색 결과가 존재하지 않습니다.</td></tr></c:if>
          <c:forEach var="item" items="${data.list }">
          <tr>
            <td>${item.dong_nm }</td>
			<td>${item.com_nm }</td>
			<td>${item.staff_nm }</td>
			<td class="img">
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
	</div>
</body>
</html>
