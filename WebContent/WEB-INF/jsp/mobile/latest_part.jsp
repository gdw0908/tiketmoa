<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<ul class="lately_list">
<c:forEach var="mdpart" items="${data.list }" varStatus="status">
	<li>
	<div>
	  <a href="/mobile/goods/view.do?menu=menu${fn:substring(mdpart.part1, 8, 9) }&seq=${mdpart.item_seq }"> 
	<span class="img">
		<img src="${mdpart.thumb }" alt="">
	</span>
	<span class="text">${mdpart.carmodelnm }</span>
	<span class="text">${mdpart.productnm }</span>
	</a>
	
	<c:if test="${(!empty newParts.sale_price && newParts.sale_price != '' && newParts.sale_price != '0')}">
	<p class="mb_3"><strong>판매가격  : </strong><span class="c1">${suf:getThousand(mdpart.sale_price) } 원</span></p>
	</c:if>
	<c:if test="${(empty newParts.sale_price || newParts.sale_price == '' || newParts.sale_price == '0')}">
	<p class="mb_3"><strong>판매가격  : </strong><span class="c1">${suf:getThousand(mdpart.user_price) } 원</span></p>
	</c:if>	          
	<!--<c:if test="${empty mdpart.supplier_price }">
	   <p class="mb_3"><strong>협력사가  : </strong> <span class="c2">${suf:getThousand(mdpart.supplier_price) } 원</span></p>
	   </c:if>-->
	</div>
	</li>
</c:forEach>
</ul>
<c:if test="${param.tab eq '1' }">
<script>
//$("#mdcount").text("${suf:getThousand(data.pagination[0].totalcount)}");
$("#mdpage").html("<b>${param.cpage}</b>/${data.pagination[0].totalpage}");
</script>
</c:if>
<c:if test="${param.tab eq '2' }">
<script>
//$("#newcount").text("${suf:getThousand(data.total[0].totalcount)}");
$("#newpage").html("<b>${param.cpage}</b>/${data.pagination[0].totalpage}");
</script>
</c:if>