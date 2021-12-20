<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div id="sub">
        <div class="strapline">
			<h3><img src="/images/sub_2/h3_img_3.gif" alt="카올바로"></h3>
			<div class="state"> <span>홈</span> &gt; <span>고객센터</span> &gt; <span><strong>카올바로</strong></span></div>
		</div>
		<div class="contents">
		<div class="sub_tab">
            <ul class="tab">
              <li class="on"><a href="quotation_list.do?cpage=1&amp;rows=10"><span>견적사례</span></a></li>
              <li><a href="carallbaro_list.do?type_state=1&amp;cpage=1&amp;rows=10"><span>BEST</span></a></li>
              <li><a href="carallbaro_list.do?type_state=2&amp;cpage=1&amp;rows=10"><span>수입차</span></a></li>
              <li><a href="carallbaro_list.do?type_state=3&amp;cpage=1&amp;rows=10"><span>국산차</span></a></li>			
            </ul>
          </div>
<div class="carall_img_list">
	<ul>
	<c:if test="${empty list }">
		<li>
			<div>등록 된 게시물이 없습니다.</div>
		</li>
	</c:if>
	<c:forEach items="${list }" var="article" varStatus="status">
	<c:if test="${status.count%2 == 1 }">
		<li>
	</c:if>
			<div>
				<a href="quotation_view.do?seq=${article.seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }&amp;myarticle=${params.myarticle}">
					<span class="img">
						<span class="lt"></span>
						<span class="rb"></span>
						<c:choose>
							<c:when test="${article.file_thumb == null || article.file_thumb == ''}">
								<img src="/images/sub/noimg2.png"/><!-- ${page_info.totalcount - article.rn + 1} -->
							</c:when>
							<c:otherwise>
								<img src="${article.file_thumb }_thumb"/><!-- ${page_info.totalcount - article.rn + 1} -->
							</c:otherwise>
						</c:choose>
					</span>
					<span class="text">
						<span><strong>${article.reg_nm }</strong> 님의 ${article.set_type == '0' ? '견적요청' : '즉시신청' }</span>
						<span><strong>브랜드</strong> : ${article.makernm }</span>
						<span><strong>날&nbsp;&nbsp;짜</strong> : <span class="date">${article.reg_dt }</span></span>
						<c:if test="${article.comment_cnt > 0 }"><span class="comment">견적댓글( ${article.comment_cnt } )</span></c:if> 
					</span>
				</a>
			</div>
	<c:if test="${status.count%2 == 0  || status.last == true}">
		</li>
	</c:if>
	</c:forEach>
	</ul>
</div>

<div class="vr_btn">
	<c:if test="${sessionScope.member != null }">
	<a href="quotation_list.do?myarticle=Y"><img src="/images/article/myarticle_btn.gif" alt="내요청보기" style="height:30px;"/></a>
	</c:if>
	<a href="quotation_fastForm.do"><img src="/images/article/board_btn12.gif" alt="즉시요청" style="height:30px;"></a>
	<a href="quotation_insertForm.do"><img src="/images/article/board_btn11.gif" alt="견적요청" style="height:30px;"></a>
</div>

<jsp:include page="/inc/paging2.do">
	<jsp:param name="cpage" value="${params.cpage }"/>
	<jsp:param name="rows" value="${params.rows }"/>
	<jsp:param name="totalpage" value="${page_info.totalpage }"/>
</jsp:include>

<div class="bottom_search">
  <form action="quotation_list.do" name="articleSearchForm" id="articleSearchForm" method="post" onsubmit="return goPage(1);">
  <input type="hidden" name="rows" value="${params.rows}"/>
  <input type="hidden" name="cpage" value="${params.cpage }" />
  <input type="hidden" name="type_state" value="${params.type_state }" />
  <select name="condition" class="select_1">
  	<option value="MAKERNM" <c:if test="${params.condition eq 'MAKERNM' }">selected="selected"</c:if>>브랜드</option>
  	<option value="REG_NM" <c:if test="${params.condition eq 'REG_NM' }">selected="selected"</c:if>>이름</option>
  </select>
  <span class="bottom_search_add"><input type="text" class="input_2" name="keyword" value="${params.keyword}" title="검색바" />
  <span class="bottom_search_bt"><input type="image" class="search_vd"  src="/images/article/btn_bottom_search.gif" name="image" alt="검색버튼"></span>
  </span>
  </form>
</div>
		</div>

      </div>