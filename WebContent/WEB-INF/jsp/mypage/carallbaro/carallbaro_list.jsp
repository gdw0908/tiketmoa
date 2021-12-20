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
              <li><a href="quotation_list.do?cpage=1&amp;rows=10"><span>견적사례</span></a></li>
              <li<c:if test="${params.type_state == null or params.type_state == '1'}"> class="on"</c:if>><a href="carallbaro_list.do?type_state=1&amp;cpage=1&amp;rows=10"><span>BEST</span></a></li>
              <li<c:if test="${params.type_state == null or params.type_state == '2'}"> class="on"</c:if>><a href="carallbaro_list.do?type_state=2&amp;cpage=1&amp;rows=10"><span>수입차</span></a></li>
              <li<c:if test="${params.type_state == null or params.type_state == '3'}"> class="on"</c:if>><a href="carallbaro_list.do?type_state=3&amp;cpage=1&amp;rows=10"><span>국산차</span></a></li>			
            </ul>
          </div>
<div class="carall_img_list carall_img_list_2">
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
				<a href="carallbaro_view.do?type_state=${params.type_state }&amp;seq=${article.seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">
					<span class="img">
					<span class="lt"></span>
              		<span class="rb"></span>
					<img src="${article.file_thumb }_thumb"/><!-- ${page_info.totalcount - article.rn + 1} -->
					</span>
					<span class="text">
						<span><strong>브랜드</strong> : ${article.makernm }</span>
						<span class="title"><span class="t_l"><strong>제&nbsp;&nbsp;목</strong> :</span> <span class="t_r">${article.title }</span></span>
						<span><strong>날&nbsp;&nbsp;짜</strong> : <span class="date">${article.reg_dt }</span></span>
						<span class="car_a"><strong>사업소 견적비&nbsp;&nbsp; :</strong> <b>${article.tow_time } 원</b></span> 
              			<span class="car_b"><strong>카올바로 수리비 : </strong><b>${article.carinfo } 원</b></span> 
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
	<a href="quotation_fastForm.do"><img src="/images/article/board_btn12.gif" alt="즉시요청" style="height:30px;"/></a>
	<a href="quotation_insertForm.do"><img src="/images/article/board_btn11.gif" alt="견적요청" style="height:30px;"/></a>
</div>

<jsp:include page="/inc/paging2.do">
	<jsp:param name="cpage" value="${params.cpage }"/>
	<jsp:param name="rows" value="${params.rows }"/>
	<jsp:param name="totalpage" value="${page_info.totalpage }"/>
</jsp:include>

<div class="bottom_search">
  <form action="carallbaro_list.do" name="articleSearchForm" id="articleSearchForm" method="post" onsubmit="return goPage(1);">
  <input type="hidden" name="rows" value="${params.rows}"/>
  <input type="hidden" name="cpage" value="${params.cpage }" />
  <input type="hidden" name="type_state" value="${params.type_state }" />
  <select name="condition" class="select_1">
  	<option value="MAKERNM" <c:if test="${params.condition eq 'MAKERNM' }">selected="selected"</c:if>>브랜드</option>
  	<option value="TITLE" <c:if test="${params.condition eq 'TITLE' }">selected="selected"</c:if>>제목</option>
  </select>
  <span class="bottom_search_add"><input type="text" class="input_2" name="keyword" value="${params.keyword}" title="검색바" />
  <span class="bottom_search_bt"><input type="image" class="search_vd"  src="/images/article/btn_bottom_search.gif" name="image" alt="검색버튼"></span>
  </span>
  </form>
</div>
		</div>

      </div>