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
      <option value="/mobile/mypage/notice/index.do">공지사항</option>
      <option value="/mobile/mypage/QA/index.do">자주묻는질문</option>
      <option value="/mobile/mypage/mantoman/index.do">1:1문의</option>
      <option value="/mobile/mypage/forces/index.do">협력사문의</option>
    </select>
    </span> <span class="sm_btn"><a href="javascript:;"><img src="/images/mobile/sub_2/sub_menu_a.gif" alt="상세조건 검색버튼" onclick = "go_url();"></a></span> </div>
</div>
      <div class="sub_wrap">
        <div class="sub_line">
          <h3><img src="/images/mobile/sub_2/sub_2_title_2.gif" alt="자주묻는 질문"></h3>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>
        
        <div class="sub_tab">
          <ul class="tab">
            <li class="first"><a <c:if test="${params.cate_seq == null or params.cate_seq == '0'}"> class="first on"</c:if> href="${servletPath }?mode=list&amp;cpage=1&amp;rows=10&amp;group_code=1"><span>전체</span></a></li>
			<c:forEach items="${category }" var="category" varStatus = "status">
				<li><a <c:if test="${category.cate_seq == params.cate_seq}"> class="on"</c:if> href="${servletPath }?mode=list&amp;cpage=1&amp;rows=10&amp;group_code=${category.group_code}&amp;cate_seq=${category.cate_seq}"><span>${category.subject }</span></a></li>
			</c:forEach>
          </ul>
        </div>
        
        <div class="faq">

		<c:if test="${empty list }">
			<div class="question">
				<div class="text" style="width:90%;text-align:center;">등록 된 글이 없습니다.</div>
			</div>
		</c:if>
		<c:forEach items="${list }" var="article" varStatus = "status">
			<div class="question" onMouseOver="this.style.backgroundColor='#FAF2E8'" onMouseOut="this.style.backgroundColor=''" style="cursor: pointer;">
				<div class="img"><img src="/images/sub_2/question.gif" alt="Q"></div>
				<div class="text">${article.title }</div>
			</div>
			<div class="answer" style="display: none;">
				<div class="img"><img src="/images/sub_2/answer.gif" alt="A"></div>
				<div class="text">
					${article.conts }
					<c:if test="${fn:length(article.attach_info) > 0}"><br/><br/> 첨부파일 : </c:if>
					<c:set var="attach_info" value="${fn:split(article.attach_info, '|') }"/>
					<c:forEach items="${attach_info }" var="attach">
						<c:set var="temp" value="${fn:split(attach, ',') }"/>
						<c:if test="${fn:length(temp) == 2}">
							<a href="/download.do?uuid=${temp[1] }" target="_blank">${temp[0] }</a>&nbsp;
						</c:if>
					</c:forEach>
	    			<br/><br/>
		  		</div>
			</div>
		</c:forEach>
		
		</div>
		  
		<script type="text/javascript">
		$(function(){
			$('.question').click(function(){
				$(this).next().slideDown().siblings('.answer:visible').slideUp();
			});
			$('#condition').val('');
			$('#keyword').val('');
		});
		</script>
		
		<jsp:include page="/inc/paging.do" />
		
		<div class="bottom_search">
		  <form action="${servletPath }" name="articleSearchForm" id="articleSearchForm" method="post" onsubmit="return goPage(1);">
		  <select name="condition" class="select_1">
			  <option value="TITLE">제목</option>
			  <option value="REG_NM" >작성자</option>
			  <option value="CONTS" >내용</option>
		  </select>
		  <span class="bottom_search_add"><input type="text" class="input_2" name="keyword" value="${params.keyword}" title="검색바" /></span>
		  <span class="bottom_search_bt"><input type="image" class="search_vd"  src="/images/article/btn_bottom_search.gif" name="image" alt="검색버튼"></span>
		  </form>
		</div>
      </div>
