<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<c:set var="cpage" value="${empty param.cpage?'1':param.cpage }"/>
<c:set var="prev" value="${cpage-1<=0?data.pagination.totalpage:cpage-1 }"/>
<c:set var="next" value="${cpage+1>data.pagination.totalpage?1:cpage+1 }"/>
	<p class="total totalg7">총 부품 : <b>${suf:getThousand(data.pagination.totalcount) }</b> 개 제품이 판매중입니다.</p>
	<div>
	  <ul class="d_tab_list d_tab_listg7">
		<c:forEach var="item" items="${data.list }" varStatus="status">
           <li<c:if test="${(status.count%5) == 0 }"> class="right"</c:if>>
           <a href="/goods/view.do?seq=${item.item_seq }">
           <span class="img"><img src="${item.thumb }" alt="${item.part3_nm }"></span>
           <span class="text"><strong>차량명</strong> : ${item.carmodelnm } ${item.cargradenm } <c:if test="${item.caryyyy != null && item.caryyyy != ''}">(${item.caryyyy })</c:if></span>
           <span class="text"><strong>부품명</strong> : ${item.part3_nm } </span>
           </a>
           </li>
		</c:forEach>
	  </ul>
	</div>
	
    <p class="d_tab_roll_btn d_tab_roll_btng7" >
    <span class="roll_prev"><a href="javascript:other_listPage('${prev }')"><img src="/images/sub/d_roll_prev.gif" alt="이전"></a></span>
    <span><b>${cpage }</b> / ${data.pagination.totalpage }</span>
    <span class="roll_next"><a href="javascript:other_listPage('${next }')"><img src="/images/sub/d_roll_next.gif" alt="다음"></a></span>
    </p>