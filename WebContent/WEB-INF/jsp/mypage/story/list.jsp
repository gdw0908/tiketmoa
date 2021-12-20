<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">
$(function(){
	$(function(){
		$("img").on("error", function(){
			$(this).off("error").attr("src", "/images/common/no_image.gif");
		});
	});
	$.each($("img"), function(){
		if($(this).attr("src") == ""){
			$(this).attr("src", "/images/common/no_image.gif");
		}
	});
});
</script>
<div id="sub">
        <div class="strapline">
          <h3><img src="/images/sub_2/h3_img_2_1.gif" alt="파츠모아 이야기"></h3>
          <div class="state">
            <span>홈</span> &gt; <span>고객센터</span> &gt; <span><strong>파츠모아 이야기</strong></span>
          </div>
        </div>

		<div class="contents">
		<div class="list_top">
  <p class="hit"><b>${page_info.totalcount}</b>개의 글이 등록되어 있습니다.</p>
</div>
<div class="photo_view">
<c:if test="${empty list }">
<tr><td colspan="4">등록 된 게시물이 없습니다.</td></tr>
</c:if>
<c:set var="tr_start" value="0"/>
<c:forEach items="${list }" var="article" varStatus="status">
	<ul>
		<li class="photo_i">
			<a href="${servletPath }?mode=view&amp;article_seq=${article.article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">
				<img src="${article.file_thumb }" alt="<c:out value="${article.title }" escapeXml="true"/>"/>
			</a>
		</li>
		<li class="photo_t">
			<a href="${servletPath }?mode=view&amp;article_seq=${article.article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">
				${article.title }
			</a>	
		</li>
		<li class="photo_d"><span>[ ${article.reg_dt } ]</span></li>
	</ul>
</c:forEach>
</div>

<jsp:include page="/inc/paging.do" />

<div class="bottom_search">
  <form action="${servletPath }" name="articleSearchForm" id="articleSearchForm" method="post" onsubmit="return goPage(1);">
  <input type="hidden" name="rows" value="${params.rows}"/>
  <input type="hidden" name="cpage" value="${params.cpage }" />
  <input type="hidden" name="mode" value="list" />
  <input type="hidden" name="article_seq" />  
  <select name="condition" class="select_1">
  	<option value="TITLE" <c:if test="${params.condition eq 'TITLE' }">selected="selected"</c:if>>제목</option>
  	<option value="REG_NM" <c:if test="${params.condition eq 'REG_NM' }">selected="selected"</c:if>>작성자</option>
  	<option value="CONTS" <c:if test="${params.condition eq 'CONTS' }">selected="selected"</c:if>>내용</option>
  </select>
  <span class="bottom_search_add"><input type="text" class="input_2" name="keyword" value="${params.keyword}" title="검색바" />
  <span class="bottom_search_bt"><input type="image" class="search_vd"  src="/images/article/btn_bottom_search.gif" name="image" alt="검색버튼"></span>
  </span>
  </form>
</div>
		</div>

      </div>