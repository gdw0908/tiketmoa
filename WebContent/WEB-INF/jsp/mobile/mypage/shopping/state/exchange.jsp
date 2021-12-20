<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<script type="text/javascript">
$(document).ready(function(){
//submenu
$("#submenu_a_open").toggle(function(){
$("#sub_menu_a").slideToggle(250);
this.src = "/images/mobile/sub/sub_menu_a_close.gif";
}, function() {
$("#sub_menu_a").slideToggle(250);
this.src = "/images/mobile/sub/sub_menu_a_open.gif";
});

});
</script>
<div class="wrap">

      <div class="sub_wrap">

        <div class="sub_2_line line_2">
          <h3><img src="/images/mobile/sub_2/sub_2_title_5_2_3_3.gif" alt="교환신청"></h3>
        </div>

        <div class="address_pop">

          <ul>
            <li>※ 상품이 배송전일 경우 취소신청을 할 수 있습니다.</li>
            <li>※ 이미 상품을 받으신 경우,반품신청을 해주시기 바랍니다.</li>
            <li>※ 반품,교환 신청은 배송완료일부터 7일 이내까지 가능합니다.</li>
          </ul>

          <div class="sub_list sub_list_a1">
            <p class="s_top_line">
            <span class="st_l">${dtf:simpleDateFormat(item.orderdate, 'yyyy-MM-dd HH:mm:ss' , 'yyyy-MM-dd') }</span>
            <!-- <span class="st_r"><a href="#"><img src="/images/mobile/sub_2/s_top_btn1.gif" alt="주문/배송조회"></a></span>  -->
            </p>

            <ul>

              <li>

              <div>

                <span class="img_box">
                <span class="img_b1"><a href="#"><img src="${item.thumb }" alt=""></a></span>
                </span>

                <span class="info">

                <span class="order_num"><strong>주문번호 : ${item.orderno }</strong></span>

                <span class="in_t1">
                <span class="first"><strong>${item.cargradenm } (${item.caryyyy })</strong></span>
                <span><strong>${item.productnm}</strong></span>
                <span><strong>${item.grade }등급</strong></span>
                </span>

                <span><strong>${item.com_nm}</strong> / ${item.sigungu_nm }</span>
                <span><strong>주문상태 : <b class="c1">${item.status_nm }</b></strong></span>
                <span><strong>합계 : <b class="c2">${suf:getThousand(item.amt) }</b> 원</strong></span>

                </span>
                

              </div>

              </li>

            </ul>

          </div>

		  <div class="btn_bottom"><a href="/mobile/mypage/shopping/state/index.do?mode=m_refunds_form&cart_no=${item.cart_no }"><img src="/images/sub_2/btn_cancel_c1.gif" alt="교환신청"></a></div>

        </div>

      </div>
      </div>