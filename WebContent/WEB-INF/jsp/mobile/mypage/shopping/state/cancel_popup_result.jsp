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
      <h3><img src="/images/mobile/sub_2/sub_2_title_5_2_3.gif" alt="취소신청"></h3>
    </div>
    <div class="address_pop">
      <div class="cancel_img">취소 신청이 완료되었습니다.</div>
      <ul class="last">
        <li>※ 환불관련 정보는 <span>나의쇼핑정보&gt;주문내역</span>에서 확인가능합니다.</li>
        <li>※ 결제수단이 신용카드인 경우 카드승인 취소 여부는 <span>카드사를 통해 3~5일(영업일 기준)후 확인 가능</span>합니다.</li>
      </ul>
      <div class="btn_bottom"><a href="/mobile/mypage/shopping/state/list.do?mode=m_list1"><img src="/images/sub_2/btn_cancel_3.gif" alt="닫기"></a></div>
    </div>
  </div>
</div>
