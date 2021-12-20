<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript" src="/lib/js/comment.js"></script>
<div id="sub">
        <div class="strapline">
          <h3><img src="/images/sub_2/h3_img_3.gif" alt="카올바로"></h3>
          <div class="state"> <span>홈</span> &gt; <span>고객센터</span> &gt; <span><strong>카올바로</strong></span> </div>
        </div>
        <div class="contents">
        <h4 class="view_type1 first">PARTS MOA에 문의하신 내용입니다.</h4>
<table class="view_style_1">
<colgroup>
<col width="9%">
<col width="">
<col width="8%">
<col width="13%">
<!--<col width="8%">
<col width="9%">-->
</colgroup>
<thead>
<tr>
  <th scope="row" class="c1">제목</th>
  <td colspan="3" class="title">${view.title}</td>
</tr>
</thead>
<tbody>
<tr>
  <th scope="row">작성자</th>
  <td>${(view.member_id == '' || view.member_id == null) ? view.reg_nm : view.member_id}</td>
  <th scope="row">작성일</th>
  <td>${view.reg_dt}</td>
  <!-- <th scope="row">상태</th>
  <td>${view.status == '0' ? '<img src="/images/article/state_3.gif" alt="접수완료">' : view.status == '1' ? '<img src="/images/article/state_1.gif" alt="답변대기">' : '<img src="/images/article/state_2.gif" alt="답변완료">'}</td> -->
</tr>
<c:if test="${fn:length(files) > 0 }">
<tr>
  <th scope="row">파일</th>
  <td colspan="3">
  <c:forEach items="${files }" var="files" varStatus = "status">
  	<a href="/download.do?uuid=${files.uuid }" target="_blank">${files.attach_nm}</a>&nbsp;
  </c:forEach>
  </td>
</tr>
</c:if>
<tr>
  <td colspan="4" class="view_text">
    ${view.conts}
  </td>
</tr>
</tbody>
</table>

<c:if test="${(sessionScope.member != null && sessionScope.member.member_id == view.member_id) || view.reg_seq == 0}">
<div class="vr_btn">
  <a href="${servletPath }?mode=del&amp;article_seq=${view.article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }"><img src="/images/article/board_btn1_n.gif" alt="문의취소"></a>
  <a href="${servletPath }?mode=modifyForm&amp;article_seq=${view.article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }"><img src="/images/article/board_btn2.gif" alt="내용수정"></a>
</div>
</c:if>






<div class="comment_box">
  <ul id="comment_list">
  <c:forEach items="${comment }" var="comment" varStatus = "status">
    <li<c:if test="${comment.lvl > 0 }"> class="comm_2"</c:if> id="comment${comment.comment_seq}">
	    <div class="comment_top">
	      <p class="ct_l"><strong<c:if test="${comment.lvl > 0 }"> class="comm_arrow"</c:if>>${comment.reg_id }</strong> <span>${comment.reg_dt }</span></p>
	      <c:if test="${sessionScope.member != null }">
	      <p class="ct_r">
	      <c:if test="${sessionScope.member.member_id == comment.reg_id}">
	      <a href="#comment${comment.comment_seq}" onclick="commentDel('${comment.comment_seq}')"><img src="/images/article/comm_btn_1.png" alt="삭제"></a>
	      <a href="#comment${comment.comment_seq}" onclick="commentUpdate('${comment.comment_seq}','${params.img }')"><img src="/images/article/comm_btn_2.png" alt="수정"></a>
	      </c:if>
	      <a href="#comment${comment.comment_seq}" onclick="commentReplyOnOff('${comment.comment_seq}','open')"><img src="/images/article/comm_btn_4.png" alt="답글"></a>
	      <!-- <a href="#"><img src="/images/article/comm_btn_3.png" alt="취소"></a> -->
	      </p>
	      </c:if>
	    </div>
	    <form name="commentUpdate${comment.comment_seq }" action="${servletPath }" method="post" onsubmit="return commentReply(this);">
	      <input type="hidden" name="comment_seq" value="${comment.comment_seq }"/>
	      <input type="hidden" name="mode" value="commentReplyUpdate"/>
	      <div class="comm_text" id="comm_text${comment.comment_seq}">
		      <p id="conts${comment.comment_seq}"><c:if test="${comment.lvl > 0 }"><strong>@${comment.reply_id }</strong></c:if> ${comment.conts }</p>
	      </div>
	    </form>
	    
	    
	    
	    
	    <c:if test="${sessionScope.member != null }">
	    <div class="area_box" id="commentReply${comment.comment_seq}" style="display:none;"><!-- 댓글 로그인 사용자만 -->
	      <form name="comment${comment.comment_seq }" action="${servletPath }" method="post" onsubmit="return commentReply(this);">
	      <input type="hidden" name="reply_id" value="${comment.reg_id }"/>
	      <input type="hidden" name="comment_seq" value="${comment.comment_seq }"/>
	      <input type="hidden" name="mode" value="commentReply"/>
	      <p><strong class="comm_arrow">${sessionScope.member.member_id } @${comment.reg_id } 님께 댓글쓰기</strong> <a class="mod" href="#comment${comment.comment_seq}" onclick="commentReplyOnOff('${comment.comment_seq}','close')"><img src="/images/article/comm_btn_3.png" alt="취소"></a></p>
	      <div>
	        <span class="textarea"><textarea class="textarea_1" name="conts"></textarea></span>
	        <a href="#" class="comm_btn" onclick="commentReply(document.comment${comment.comment_seq });"><img src="/images/article/comm_btn_en.gif" alt="입력하기"></a>
	      </div>
	      </form>
    	</div>
    	</c:if>
    </li>
  </c:forEach>  
    <!-- 댓글 원글 달기 -->
    <li>
    <div class="area_box area_box_2">
    <p class="comm_txt">댓글은 <b>1000</b> 자 내외로 작성해주시기 바랍니다.</p>
      <form name="comment" action="${servletPath }" method="post" onsubmit="return commentReply(this);">
      <input type="hidden" name="mode" value="commentInsert"/>
      <input type="hidden" name="article_seq" value="${view.article_seq }"/>
      <div>
        <span class="textarea"><textarea class="textarea_1" name="conts"></textarea></span>
        <a href="#" class="comm_btn" onclick="commentReply(document.comment);"><img src="/images/article/comm_btn_en.gif" alt="입력하기"></a>
      </div>
      </form>
    </div>
    </li>
  </ul>
</div>

<p class="pa_guide">PARTSMOA 쇼핑몰에 관련한 상세한 상담이 필요하신 사항은 고객센터 문의전화 (1544-6444)로 연락주시면 친절히 상담해 드리겠습니다.</p>

<form name="commentDelete" action="${servletPath }" method="post" onsubmit="return commentDel(this);">
<input type="hidden" name="mode" value="commentDel"/>
<input type="hidden" name="comment_seq" value=""/>
</form>

<div class="view_top">
  <p class="btn_box">
	<a href="${servletPath }?mode=list&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }"><img src="/images/article/board_btn3.gif" alt="목록으로"></a>  
  </p>
</div>

<table class="view_prevnext">
<colgroup>
<col width="8%">
<col width="">
</colgroup>
<tbody>
<tr>
  <th scope="row">다음글</th>
  <td>
  <c:choose>
  <c:when test="${view.next_article_seq eq null}">다음 글이 없습니다.</c:when>
  <c:otherwise><a href="${servletPath }?mode=view&amp;article_seq=${view.next_article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">${view.next_article_title }</a></c:otherwise>
  </c:choose>
  </td>
</tr>
<tr>
  <th scope="row">이전글</th>
  <td>
  <c:choose>
  <c:when test="${view.pre_article_seq eq null}">이전 글이 없습니다.</c:when>
  <c:otherwise><a href="${servletPath }?mode=view&amp;article_seq=${view.pre_article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }">${view.pre_article_title }</a></c:otherwise>
  </c:choose>
  </td>
</tr>
</tbody>
</table>
        </div>
      </div>