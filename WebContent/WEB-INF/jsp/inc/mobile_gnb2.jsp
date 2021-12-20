<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<c:set var="menuNumber" value="${param.menu }"/>
<script type="text/javascript">
$(function(){
	if('${menuNumber}' != ''){
		$.each($(".gnb > ul > li"),function(){
			if($(this).find("a").attr("href").indexOf('${menuNumber}') > -1){
				$(this).find("a > img").attr("src", $(this).find("img").attr("src").replace("off","on"));
				$(this).attr("class","on");
			}
		});
	}
});
</script>
<div class="gnb">
  <ul>
  	<li><a href="/mobile/mypage/application/index.do?menu=menu1"><img src="/images/mobile/gnb_2/g2_menu_5_off.gif" alt="부품문의"></a></li>
    <li><a href="/mobile/mypage/notice/index.do?menu=menu2"><img src="/images/mobile/gnb_2/g2_menu_1_off.gif" alt="고객게시판"></a></li>
    <li><a href="/mobile/mypage/shopping/cart/list.do?menu=menu3&mode=m_add_cart_list"><img src="/images/mobile/gnb_2/g2_menu_2_off.gif" alt="나의쇼핑"></a></li>
    <li><a href="/mobile/mypage/member/index.do?menu=menu4&mode=<c:choose><c:when test = "${not empty sessionData.busi_no }">mbusi</c:when><c:otherwise>muser</c:otherwise></c:choose>"><img src="/images/mobile/gnb_2/g2_menu_3_off.gif" alt="회원정보"></a></li>
    <!-- li><a href="/mobile/mypage/late/index.do"><img src="/images/mobile/gnb_2/g2_menu_4_off.gif" alt="구매후기"></a></li -->
    <!-- <li><a href="/mobile/mypage/event/event_list.do"><img src="/images/mobile/gnb_2/g2_menu_6_off.gif" alt="이벤트"></a></li> -->
    <li><a href="/mobile/mypage/special_contract/special_contract.do?menu=menu5"><img src="/images/mobile/gnb_2/g2_menu_7_off.gif" alt="부품사용특약"></a></li>
    <li class="last"><a href="/mobile/mypage/annc/annc1.do?menu=menu6"><img src="/images/mobile/gnb_2/g2_menu_8_off.gif" alt="이용약관"></a></li>
  </ul>
</div>