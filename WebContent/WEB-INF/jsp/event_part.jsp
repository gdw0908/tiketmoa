<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:parseNumber var="totalpage" value="${event.pagination.totalpage }" integerOnly="true" type="number"/>
<c:set var="rows" value="${empty param.rows ? '12' : param.rows }"/>
<c:set var="blocksize" value="${empty param.blocksize ? '10' : param.blocksize }"/>
<c:set var="cpage" value="${empty param.cpage ? '1' : param.cpage }"/>
<fmt:parseNumber var="start" value="${cpage - ((cpage - 1) % blocksize) }" integerOnly="true" type="number"/>
<fmt:parseNumber var="end" value="${start + (blocksize-1) > totalpage ? totalpage : start + (blocksize-1) }" integerOnly="true" type="number"/>
<fmt:parseNumber var="nextblock" value="${(start+blocksize) > totalpage ? totalpage : (start+blocksize) }" integerOnly="true" type="number"/>
<fmt:parseNumber var="prevblock" value="${(end-blocksize) < 1 ? 1 : (start-blocksize)}" integerOnly="true" type="number"/>
<script type="text/javascript">
$(".event_box img").on("error", function(){
	$(this).off("error").attr("src", "/images/common/no_image.gif");
});
</script>
<div class="ev_line">
    <!-- <h4 class="ev_type"><img src="/images/sub_2/event_t1.gif" alt="이벤트 상품"></h4> -->
    <div class="ev_search">
    <input type="text" class="input_2" id="search_event_text" name="search_event_text" value="${param.search_event_text }" title="검색바">    
    <a href="javascript:search_event();"><img class="search_vd" src="/images/article/btn_bottom_search.gif" alt="검색버튼"></a>
    </div>
    </div>
    <div class="event_box">
      <div class="md_list event_list">
        <ul>
        <c:forEach var="item" items="${event.item }">
          <li>
            <div class="md_top">
              <p class="mt_img"><a href="/goods/view.do?menu=menu${fn:substring(item.part1, 8, 9) }&seq=${item.item_seq }"><img src="${item.thumb }_thumb" alt=""></a></p>
              <p class="mt_btn">
              <a href="/goods/view.do?menu=menu${fn:substring(item.part1, 8, 9) }&seq=${item.item_seq }" target="_blank"><img src="images/container/md_img_btn1.gif" alt="새창"></a><a href="/mypage/shopping/cart/index.do?mode=add_cart&seq=${item.item_seq }&qty=1"><img src="images/container/md_img_btn2.gif" alt="장바구니"></a><a href="/mypage/shopping/cart/index.do?mode=direct_order&seq=${item.item_seq }&qty=1"><img src="images/container/md_img_btn3.gif" alt="바로구매"></a></p>
            </div>
            <div class="md_bottom">
              <p class="mb_1"><strong>차량명</strong> : ${item.carmodelnm } ${item.cargradenm }</p>
              <p class="mb_1"><strong>부품명</strong> : ${item.part3_nm }</p>
              <p class="mb_2"><span class="mb_2_1"><b class="c1">${item.grade }</b>등급</span> <c:if test="${item.discount_rate > 0}"><span class="mb_2_2">${item.discount_rate }%↓</span></c:if> <!-- <span class="mb_2_3">${suf:getThousand(item.user_price) } 원</span> --></p>
              <p class="mb_3"><strong>판매가격  : </strong> <span class="c1">
              			<c:choose>
				        	<c:when test="${item.inquiry_yn eq 'Y' }">
				        	협의
				        	</c:when>
				        	<c:otherwise>
						        <c:if test="${item.discount_rate > 0}">
					              <!-- <p class="price_un">${suf:getThousand(item.user_price) }</p>
					              <p class="price"> -->${suf:getThousand(item.sale_price) } 원<!-- <p> -->
				            	</c:if>
								<c:if test="${item.discount_rate == 0 || empty item.discount_rate}">
									<c:if test="${item.user_price == 0 || empty item.user_price}">
									협의
									</c:if>
									<c:if test="${item.user_price > 0 }">
									${suf:getThousand(item.user_price) } 원
									</c:if>
				            	</c:if>
				        	</c:otherwise>
				        </c:choose>
              	</span>
              </p>
            </div>
          </li>
        </c:forEach>
        </ul>        
		
		<div class="paging">
			<span id="pagingWrap"> 
			<a href="javascript:page_event('1','${param.search_event_text }');">처음</a>
			
			<c:if test="${cpage > 1 }">
				<a href="javascript:page_event('${prevblock }','${param.search_event_text }');">이전</a>
			</c:if>
			
			<c:forEach var="i" begin="${start }" end="${end}">
			<c:choose>
				<c:when test="${cpage eq i }">
					<b><a href="javascript:void(0);">${i }</a></b>
				</c:when>
				<c:otherwise>
					<a href="javascript:page_event('${i}','${param.search_event_text }');">${i}</a>
				</c:otherwise>
			</c:choose>
			</c:forEach>
			
			<c:if test="${cpage < totalpage }">
				<a href="javascript:page_event('${nextblock }','${param.search_event_text }');">다음</a>
			</c:if>
			
			<a href="javascript:page_event('${totalpage }','${param.search_event_text }');">끝</a>
			</span>
		</div>
      </div>
	</div>