<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
      <div class="sub_wrap">
        <div class="sub_line">
          <h3><img src="/images/mobile/sub_2/sub_2_title_7.gif" alt="구매후기"></h3>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>
        
       	
        <div class="list_top">
		  <p class="hit"><b>${page_info.totalcount}</b>개의 글이 등록되어 있습니다.</p>
		</div>
		
		<table class="list_style_1">
		<colgroup>
			<col width="15%" />
			<col width="" />
			<col width="20%" />
		</colgroup>
		<thead>
		<tr>
			<th scope="col">구분</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${empty list }">
			<tr><td colspan="3">등록 된 게시물이 없습니다.</td></tr>
		</c:if>
		<c:forEach items="${list }" var="article" varStatus = "status">
			<tr>
				<td>${article.groupcodenm }</td>
				<td class="title">
					<a href="${servletPath }?mode=view&amp;article_seq=${article.article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">
					${article.title }${article.public_yn == 'Y' ? '' :' (비공개)'}<c:if test="${article.comm_cnt > 0}"> (${article.comm_cnt })</c:if>
					</a>
				</td>
				<td>${(article.member_id == '' || article.member_id == null) ? article.reg_nm : article.member_id}</td>	
			</tr>
		</c:forEach>
		</tbody>
		</table>
		
		<div class="vr_btn"><a href="${servletPath }?mode=insertForm"><img src="/images/article/board_btn6.gif" alt="문의등록"></a></div>
		
		<jsp:include page="/inc/paging.do" />
		
		<div class="bottom_search">
		  <form action="${servletPath }" name="articleSearchForm" id="articleSearchForm" method="post" onsubmit="return goPage(1);">
  		  <input type="hidden" name="cpage" value="${params.cpage }" />
		  <input type="hidden" name="mode" value="list" />
		  <input type="hidden" name="article_seq" />
		  <select name="condition" class="select_1">
		  <option value="TITLE" <c:if test="${params.condition eq 'TITLE' }">selected="selected"</c:if>>제목</option>
		  <option value="REG_NM" <c:if test="${params.condition eq 'REG_NM' }">selected="selected"</c:if>>작성자</option>
		  <option value="CONTS" <c:if test="${params.condition eq 'CONTS' }">selected="selected"</c:if>>내용</option>
		  </select>
		  <span class="bottom_search_add"><input type="text" class="input_2" name="keyword" value="${params.keyword}" title="검색바" /></span>
		  <span class="bottom_search_bt"><input type="image" class="search_vd"  src="/images/article/btn_bottom_search.gif" name="image" alt="검색버튼"></span>
		  </form>
		</div>
      </div>