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
<title>주문현황</title>
<script type="text/javascript">
function list(value){
	location.replace("?menu=${param.menu }&rows=" + value);
}
</script>
</head>
<body>
	<div class="product_tab">
        <ul>
          <li><a href="seller_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab1_off.gif" alt="상품관리"></a></li>
          <li><a href="product_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab2_on.gif" alt="주문현황"></a></li>
          <li><a href="resources_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab3_off.gif" alt="자원관리"></a></li>
          <li><a href="selfcamera_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab4_off.gif" alt="셀카현황"></a></li>
        </ul>
      </div>

      <div class="sub_wrap">
        <div class="sub_line">
          <h3><img src="/images/mobile/sub/sub_title_b_1.gif" alt="주문상품"></h3>
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
			  <span class="img_b1"><a href="product_view.do?cart_no=${item.cart_no }"><img src="${item.thumb }" alt="${item.productnm }"></a></span>
			  <span class="img_btn a_type"><a href="product_view.do?cart_no=${item.cart_no }"><img src="/images/mobile/sub/btn_view_a1.gif" alt="자세히보기"></a></span>
			  </span>
			  <a href="product_view.do?cart_no=${item.cart_no }">
              <span class="info">
			  <span class="order_num"><strong>주문번호 : ${item.orderno }</strong></span>

              <span class="in_t1">
              <span class="first"><strong>${item.productnm }</strong></span>
              <span><strong>${item.part3_nm }</strong></span>
              <span><strong><c:if test="${!empty item.grade}">${item.grade }등급</c:if></strong></span>
              </span>

              <span><strong>주문자 : ${item.receiver }</strong></span>
			  <span><strong>주문일 : </strong> ${item.orderdate }</span>
			  <span><strong>주문상태 : <b class="c1">${item.status_nm }</b></strong></span>
			  <span><strong>주문수량 : </strong>${item.qty }개</span>
			  <span><strong>결제금액 : <b class="c2">${suf:getThousand(item.amt) }</b> 원</strong></span>
              </span>
			  </a>
            </div>
            </li>
			</c:forEach>
          </ul>
        </div>

        <jsp:include page="/inc/paging2.do">
			<jsp:param  name="cpage" value="${param.cpage }"/>
			<jsp:param  name="rows" value="${param.rows }"/>
			<jsp:param  name="totalpage" value="${data.pagination.totalpage }"/>
		</jsp:include>
      </div>
</body>
</html>