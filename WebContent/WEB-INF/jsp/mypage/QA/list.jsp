<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div id="sub">
		
		<div class="strapline">
          <h3><img src="/images/sub_2/h3_img_2.gif" alt="자주묻는질문"> 
          <%-- <c:if test="${params.cate_seq == null or params.cate_seq == '0'}">
          	<span class="arrow">&gt;</span> <span class="text">전체</span>
          </c:if>
          <c:forEach items="${category }" var="category" varStatus = "status">
          	<c:if test="${category.cate_seq == params.cate_seq}">
          	<span class="arrow">&gt;</span> <span class="text">${category.subject }</span>
          	</c:if>
          </c:forEach> --%>
          </h3>
          <div class="state"> <span>홈</span> &gt; <span>고객센터</span> &gt; <span><strong>자주묻는질문</strong></span> </div>
        </div>
        
        <div class="contents">
          <div class="sub_tab">
            <ul class="tab">
              <li<c:if test="${params.cate_seq == null or params.cate_seq == '0'}"> class="on"</c:if>><a href="${servletPath }?mode=list&amp;cpage=1&amp;rows=10&amp;group_code=1"><span>전체</span></a></li>
			<c:forEach items="${category }" var="category" varStatus = "status">
				<li<c:if test="${category.cate_seq == params.cate_seq}"> class="on"</c:if>><a href="${servletPath }?mode=list&amp;cpage=1&amp;rows=10&amp;group_code=${category.group_code}&amp;cate_seq=${category.cate_seq}"><span>${category.subject }</span></a></li>
			</c:forEach>
            </ul>
          </div>
          <div class="list_top">
            <p class="select_box">
            <select class="select_1" onchange="pageRows(this.value);">
	  		<option value="10" <c:if test="${params.rows eq '10' }">selected="selected"</c:if>>10건씩 보기</option>
		    <option value="20" <c:if test="${params.rows eq '20' }">selected="selected"</c:if>>20건씩 보기</option>
		    <option value="50" <c:if test="${params.rows eq '50' }">selected="selected"</c:if>>50건씩 보기</option>
		    </select>
            </p>
            <p class="hit"><b>${page_info.totalcount}</b>개의 글이 등록되어 있습니다.</p>
          </div>
          <div class="faq">
            <div class="faq_head">
              <p class="fh_1">구분</p>
              <p class="fh_2">제목</p>
            </div>
            
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
  <input type="hidden" name="rows" value="${params.rows}"/>
  <input type="hidden" name="cpage" value="${params.cpage }" />
  <input type="hidden" name="group_code" value="${params.group_code }" />
  <input type="hidden" name="cate_seq" value="${params.cate_seq }" />
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
</div>