<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>상품관리</title>
<script type="text/javascript">
function list(value){
	location.replace("?menu=${param.menu }&rows=" + value);
}
$( document ).ready(function() {
	$("img").each(function(){
		if($(this).attr("src") == "/upload/board///_thumb"){
			$(this).attr("src", "/images/common/no_image.gif");
		}
	})	
	$("img").on("error", function(){
		$(this).off("error").attr("src", "/images/common/no_image.gif");
	});
});
</script>
</head>
<body>
	<div class="product_tab">
        <ul>
          <li><a href="seller_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab1_on.gif" alt="상품관리"></a></li>
          <li><a href="product_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab2_off.gif" alt="주문현황"></a></li>
          <li><a href="resources_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab3_off.gif" alt="자원관리"></a></li>
          <li><a href="selfcamera_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab4_off.gif" alt="셀카현황"></a></li>
        </ul>
      </div>

      <div class="sub_wrap">
        <div class="sub_line">
          <h3><img src="/images/mobile/sub/sub_title_b_2.gif" alt="상품목록"></h3>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>
        <div class="sc_top">
          <ul class="sc_tab">
            <li class="first"><a class="on" href="#">전체</a></li>
          </ul>
          <div class="sc_type">
            <select id="rows" name="rows" class="select_1" onchange = "list(this.value);">
            <option value = "10" <c:if test = "${param.rows eq '10'}">selected</c:if>>10개</option>
            <option value = "30" <c:if test = "${param.rows eq '30'}">selected</c:if>>30개</option>
            <option value = "50" <c:if test = "${param.rows eq '50'}">selected</c:if>>50개</option>
            </select>
          </div>
        </div>

        <div class="sub_list">
          <ul>
          	<c:forEach var="item" items="${data.list }" varStatus="status">
            <li>
            <div>
			  <span class="img_box">
			  <span class="img_b1"><a href="/mobile/goods/view.do?menu=menu${fn:substring(item.part1, 8, 9) }&amp;seq=${item.item_seq }"><img src="${item.thumb }" alt="${item.part3_nm }"></a></span>
			  <span class="img_btn a_type"><a href="/mobile/seller/seller_modify.do?menu=menu8&amp;seq=${item.item_seq }"><img src="/images/mobile/sub/btn_mod_a1.gif" alt="상품수정"></a></span>
			  </span>
			  <a href="/mobile/goods/view.do?menu=menu${fn:substring(item.part1, 8, 9) }&amp;seq=${item.item_seq }">
              <span class="info">
              <span class="in_t1">
              <span class="first"><strong>${item.carmodelnm} <c:if test="${!empty item.caryyyy }">( ${item.caryyyy } )</c:if></strong></span>
              <span><strong>${item.part3_nm }</strong></span>
              <span><strong>${item.grade }등급</strong></span>
              </span>
              <span><strong>${item.com_nm }</strong> / ${item.sigungu_nm }</span>
              <span><strong>상품등록 : </strong>${item.reg_date }</span>
			  <span><strong>최종수정 : </strong>${item.mod_date }</span>
			  <span><strong>재고수량 : ${suf:getThousand(item.stock_num) }개</strong></span>
			  <span><strong>혜택 : <c:if test="${!empty view.discount_rate }"><b class="c2">${item.discount_rate }% </b></c:if></strong></span>
			  <span><strong>판매가격 : <b class="c2">${suf:getThousand(item.user_price) }</b> 원</strong></span>
              </span>
			  </a>
            </div>
            </li>
			</c:forEach>
          </ul>
        </div>
        
        <div class="vr_btn">
			<a href="seller_insert.do?menu=menu8"><img src="/images/mobile/sub/btn_register.gif" alt="등록"></a>
		</div>

        <jsp:include page="/inc/paging2.do">
			<jsp:param  name="cpage" value="${param.cpage }"/>
			<jsp:param  name="rows" value="${param.rows }"/>
			<jsp:param  name="totalpage" value="${data.pagination.totalpage }"/>
		</jsp:include>
      </div>
</body>
</html>