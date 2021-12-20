<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<script type="text/javascript" src="/lib/js/jquery-1.9.1.js"></script>
<script type="text/javascript">
/*
$(function(){
	$(".menuwrap ul li ul").hide();
	$(".menuwrap .name2 a").on("click", function(){
		$(".menuwrap .name2").closest("div").siblings("ul").hide();
		$(this).closest("div").siblings("ul").show();
	});
	$(".menuwrap .name1 a").on("click", function(){
		$(".menuwrap .name1").closest("div").siblings("ul").hide();
		$(this).closest("div").siblings("ul").show();
	});
	$(".menuwrap a").on("click", function(){
		$(this).closest("li").siblings("li").removeClass("on");
		$(this).closest("li").addClass("on");
	});
});
*/


</script>
<!-- 레프트 메뉴 -->

 <div class="menuwrap catemenu">
<ul>
  <li>
    <div> <span class="name1"><a href="#" onclick = "goBody('/admin/goods/inventory/inventory_cate.do?codeno=0509');">쇼핑몰</a></span> </div>
    <ul>
    <c:forEach items="${menuTreeList }" var="menuTree">
      <li>
      <c:if test="${fn:length(menuTree.codeno) > 4}">
      <c:choose>
     	<c:when test="${fn:length(menuTree.codeno) == 6}">
      	 <div> <span class="name2"><a href="#" onclick = "goBody('/admin/goods/inventory/inventory_cate.do?codeno=${menuTree.codeno}');">${menuTree.codenm}</a></span> </div>
      	</c:when>
      	<c:when test="${fn:length(menuTree.codeno) == 9}">
      	 <div> <span class="name3"><a href="#" onclick = "goBody('/admin/goods/inventory/inventory_cate.do?codeno=${menuTree.codeno}');">${menuTree.codenm}</a></span> </div>
      	</c:when>
      	<c:otherwise>
      	<ul>
          <li class="last">
            <div> <span class="name3"><a href="#" onclick = "goBody('/admin/goods/inventory/inventory_cate.do?codeno=${menuTree.codeno}');">${menuTree.codenm}</a></span> </div>
          </li>
        </ul>
      	</c:otherwise>
      </c:choose>
      </c:if>
      </li>
   </c:forEach>   
  </ul>
</div>
<!--  레프트 끝 -->	