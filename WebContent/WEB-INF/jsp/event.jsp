<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="event" value="${event.view }"/>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>파츠모아</title>
<script type="text/javascript">
$( document ).ready(function(){
	<c:if test="${event.icnt > '0'}">
	$("#event_items").load("/event_part.do", {seq:"${param.seq}",cpage:'1',rows:'12'});
	</c:if>
});

function search_event(){
	var keyword = $("#search_event_text").val();
	$("#event_items").load("/event_part.do", {seq:"${param.seq}",cpage:'1',rows:'12',search_event_text:keyword});
}
function page_event(c,k){
	$("#event_items").load("/event_part.do", {seq:"${param.seq}",cpage:c,rows:'12',search_event_text:k});
}
</script>
</head>
<body>
	<div id="sub2">
	<c:choose>
	  <c:when test="${event.event_type == 'R' }">
	  <div class="strapline">
	    <h3><img src="/images/sub/h_pop_title_1.gif" alt="중고타이어"></h3>
	    <div class="state"> <span>홈</span> &gt; <span><strong>중고타이어</strong></span> </div>
	  </div>
	  </c:when>
	  <c:when test="${event.event_type == 'B' }">
	  <div class="strapline">
	    <h3><img src="/images/sub/h_pop_title_2.gif" alt="중고배터리"></h3>
	    <div class="state"> <span>홈</span> &gt; <span><strong>중고타이어</strong></span> </div>
	  </div>
	  </c:when>
	  <c:when test="${event.event_type == 'T' }">
	  <div class="strapline">
	    <h3><img src="/images/sub/h_pop_title_3.gif" alt="튜닝부품"></h3>
	    <div class="state"> <span>홈</span> &gt; <span><strong>튜닝부품</strong></span> </div>
	  </div>
	  </c:when>
	  <c:when test="${event.event_type == 'A' }">
	  <div class="strapline">
	    <h3><img src="/images/sub/h_pop_title_4.gif" alt="수입차 부품 스페셜"></h3>
	    <div class="state"> <span>홈</span> &gt; <span><strong>수입차 부품 스페셜</strong></span> </div>
	  </div>
	  </c:when>
	  <c:otherwise>
	  <div class="strapline">
	    <h3><img src="/images/sub_2/h3_img_8.gif" alt="이벤트"></h3>
	    <div class="state"> <span>홈</span> &gt; <span><strong>이벤트</strong></span> </div>
	  </div>
	  </c:otherwise>
	</c:choose>
	  <div class="contents">
	    <table class="view_style_1 view_s1">
	      <colgroup>
	      <col width="9%">
	      <col width="*">
	      </colgroup>
	      <thead>
	        <tr>
	          <td colspan="2" class="title" style="text-align:center;font-size:20px;">${event.title }</td>
	        </tr>
	      </thead>
	      <tbody>
	      	<c:if test="${event.event_type == 'E' }">
	        <tr>
	          <th scope="row">기간</th>
	          <td>${event.sdate } ~ ${event.edate } <img src="/images/article/ev_state_${event.status_code }.gif" alt="${event.status }" ></td>
	        </tr>
	        </c:if>
	        <tr>
	          <td colspan="2" class="view_text"> ${event.conts } </td>
	        </tr>
	      </tbody>
	    </table>
	    <div id="event_items">    
	    </div>
	  </div>
	</div>
</body>
</html>