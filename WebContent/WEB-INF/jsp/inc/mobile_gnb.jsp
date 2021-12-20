<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<c:set var="menuNumber" value="${param.menu }"/>
<c:set var="menuHide" value="Y"/>
<c:if test="${!(sessionScope.member eq null) && ((sessionScope.member.group_seq eq '3') || (sessionScope.member.group_seq eq '8')) }"><%-- 협력사 or 관리자 or 자원관리 --%>
	<c:set var="menuHide" value="N"/>		
</c:if>
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
    <li><a href="/mobile/goods/list.do?menu=menu1"><img src="/images/mobile/gnb/menu_1_off.gif" alt="바디"></a></li>
    <li><a href="/mobile/goods/list.do?menu=menu2"><img src="/images/mobile/gnb/menu_2_off.gif" alt="의장"></a></li>
    <li><a href="/mobile/goods/list.do?menu=menu3"><img src="/images/mobile/gnb/menu_3_off.gif" alt="엔진"></a></li>
    <li><a href="/mobile/goods/list.do?menu=menu4"><img src="/images/mobile/gnb/menu_4_off.gif" alt="샤시"></a></li>
    <li><a href="/mobile/goods/list.do?menu=menu5"><img src="/images/mobile/gnb/menu_5_off.gif" alt="국산차"></a></li>
    <li><a href="/mobile/goods/list.do?menu=menu6"><img src="/images/mobile/gnb/menu_6_off.gif" alt="수입차"></a></li>
    <!-- <li <c:if test="${menuHide eq 'Y' }"> class="last"</c:if>><a href="/mobile/cooperation/list.do?menu=menu7"><img src="/images/mobile/gnb/menu_7_off.gif" alt="지역별"></a></li> -->
    <li <c:if test="${menuHide eq 'Y' }"> class="last"</c:if>><a href="/mobile/goods/contents_list.do?menu=menu9&amp;part2=050901006003"><img src="/images/mobile/gnb/menu_9_off.gif" alt="재제조"></a></li>
    <%--<li <c:if test="${menuHide eq 'Y' }"> class="last"</c:if>><a href="/mobile/goods/list.do?menu=menu9&amp;part2=050901006003"><img src="/images/mobile/gnb/menu_9_off.gif" alt="재제조"></a></li> --%>
    <c:if test="${menuHide eq 'N' }">
    	<c:if test="${sessionScope.member.group_seq eq '8'}">
    		<li class="last"><a href="/mobile/seller/resources_list.do?menu=menu8"><img src="/images/mobile/gnb/menu_8_off.gif" alt="상품관리"></a></li>
    	</c:if>
    	<c:if test="${sessionScope.member.group_seq ne '8'}">
    		<li class="last"><a href="/mobile/seller/seller_list.do?menu=menu8"><img src="/images/mobile/gnb/menu_8_off.gif" alt="상품관리"></a></li>
    	</c:if>
    </c:if>
  </ul>
</div>