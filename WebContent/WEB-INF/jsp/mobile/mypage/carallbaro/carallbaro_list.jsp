<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type = "text/javascript">
function go_url()
{
	if(jQuery("#url").val() == "")
	{
		alert("이동 할 메뉴를 선택해주세요.");
		return;
	}
	else
	{
		location.replace(jQuery("#url").val());
	}
	
}
</script>
<div class="sm_wrap">
  <div class="sm_top"> <span class="select_box s_menu_type">
    <select id="url" name="url" class="select_sm">
      <option value="">메뉴를 선택해 주세요</option>
      <option value="/mobile/mypage/notice/index.do?menu=menu2">공지사항</option>
      <option value="/mobile/mypage/story/index.do?menu=menu2">파츠모아 이야기</option>
      <option value="/mobile/mypage/forces/index.do?menu=menu2">협력사문의</option>
      <option value="/mobile/mypage/carallbaro/index.do?menu=menu2">카올바로</option>
    </select>
    </span> <span class="sm_btn"><a href="javascript:;"><img src="/images/mobile/sub_2/sub_menu_a.gif" alt="메뉴이동" onclick = "go_url();"></a></span> </div>
</div>
		<div class="sub_wrap">
          <div class="sub_line">
            <h3><img src="/images/mobile/sub_2/sub_2_title_4.gif" alt="카올바로"></h3>
            <p><a href="tel:1522-2119"><img src="/images/mobile/sub/cartel.gif" alt="카올바로 고객상담센터 1522-2119"></a></p>
          </div>
		  <div class="sc_top">
            <ul class="sc_tab">
              <li class="first"><a href="quotation_list.do?cpage=1&amp;rows=10&amp;menu=menu2">견적사례</a></li>
              <li><a <c:if test="${params.type_state == null or params.type_state == '1'}"> class="on"</c:if> href="carallbaro_list.do?type_state=1&amp;cpage=1&amp;rows=10&amp;menu=menu2"><span>BEST</span></a></li>
              <li><a <c:if test="${params.type_state == null or params.type_state == '2'}"> class="on"</c:if> href="carallbaro_list.do?type_state=2&amp;cpage=1&amp;rows=10&amp;menu=menu2"><span>수입차</span></a></li>
              <li class="last"><a <c:if test="${params.type_state == null or params.type_state == '3'}"> class="on"</c:if> href="carallbaro_list.do?type_state=3&amp;cpage=1&amp;rows=10&amp;menu=menu2"><span>국산차</span></a></li>	
            </ul>
          </div>
          
          <div class="sub_list">
            <ul>
            <c:if test="${empty list }">
				<li>
					<div>등록 된 게시물이 없습니다.</div>
				</li>
            </c:if>
            <c:forEach items="${list }" var="article" varStatus="status">
				<li> 
					<a href="carallbaro_view.do?type_state=${params.type_state }&amp;seq=${article.seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }&amp;menu=menu2">
	              <span class="img"><img src="${article.file_thumb }_thumb"/></span> 
	              <span class="info info_2"> 
					  <span><strong>브랜드</strong> : ${article.makernm }</span>
					  <span><span class="t_l"><strong>제목</strong> :</span> <span class="t_r">${article.title }</span></span>
					  <span><strong>날&nbsp;&nbsp;짜</strong> : <span class="date">${article.reg_dt }</span></span>
					  <span class="car_a"><strong>사업소 견적비&nbsp;&nbsp; :</strong> <b>${article.tow_time } 원</b></span> 
              		  <span class="car_b"><strong>카올바로 수리비 : </strong><b>${article.carinfo } 원</b></span>
	              </span>
              	</a>
              </li>
            </c:forEach>
            </ul>
          </div>

<div class="vr_btn">
	<a href="quotation_fastForm.do"><img src="/images/article/board_btn12.gif" alt="즉시요청" style="height:25px;"/></a>
	<a href="quotation_insertForm.do"><img src="/images/article/board_btn11.gif" alt="견적요청" style="height:25px;"/></a>
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