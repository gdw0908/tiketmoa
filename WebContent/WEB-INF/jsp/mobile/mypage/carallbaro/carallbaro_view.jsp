<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript" src="/lib/js/comment_carall.js"></script>
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
		<div class="sub_wrap">
          <div class="sub_line">
            <h3><img src="/images/mobile/sub_2/sub_2_title_4.gif" alt="카올바로"></h3>
            <p><a href="tel:1522-2119"><img src="/images/mobile/sub/cartel.gif" alt="카올바로 고객상담센터 1522-2119"></a></p>
          </div>
<table class="view_style_1" style="margin-top:5%;">
<colgroup>
<col width="25%">
<col width="*">
<col width="25%">
<col width="25%">
</colgroup>
<thead>
<tr>
  <th scope="row" class="c1">제목</th>
  <td colspan="3" class="title">${view.title}</td>
</tr>
</thead>
<tbody>
<tr>
  <th scope="row">사업소 수리비</th>
  <td>${view.tow_time } 원</td>
  <th scope="row">카올바로 수리비</th>
  <td>${view.carinfo } 원</td>
</tr>
<tr>
  <th scope="row">브랜드</th>
  <td>${view.makernm }</td>
  <th scope="row">작성일</th>
  <td>${view.reg_dt}</td>
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
    ${view.content}
  </td>
</tr>
</tbody>
</table>

<div class="view_top">
  <p class="btn_box">
  <a href="carallbaro_list.do?type_state=${params.type_state }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }&amp;menu=menu2"><img src="/images/article/board_btn3.gif" alt="목록으로"></a>
  </p>
</div>

<div class="comment_box">
  <ul id="comment_list">
  <c:forEach items="${comment }" var="comment" varStatus = "status">
    <li<c:if test="${comment.lvl > 0 }"> class="comm_2"</c:if> id="comment${comment.comment_seq}">
	    <div class="comment_top">
	    	<c:choose>
	    		<c:when test="${comment.password == null }">
	    		<p class="ct_l"><strong<c:if test="${comment.lvl > 0 }"> class="comm_arrow"</c:if>>${comment.reg_id }</strong> <span>${comment.reg_dt }</span></p>
	    		</c:when>
	    		<c:otherwise>
	    		<p class="ct_l"><strong<c:if test="${comment.lvl > 0 }"> class="comm_arrow"</c:if>>${comment.reg_nm }</strong> <span>${comment.reg_dt }</span></p>
	    		</c:otherwise>
	    	</c:choose>
	      <p class="ct_r">
	      <c:if test="${sessionScope.member.member_id == comment.reg_id or comment.password != null}">
	      <%-- <a href="#comment${comment.comment_seq}" onclick="commentDel('${comment.comment_seq}')"><img src="/images/article/comm_btn_1.png" alt="삭제"></a>
	      <a href="#comment${comment.comment_seq}" onclick="commentUpdate('${comment.comment_seq}','mobile/')"><img src="/images/article/comm_btn_2.png" alt="수정"></a> --%>
	      </c:if>
	      <a href="#comment${comment.comment_seq}" onclick="commentReplyOnOff('${comment.comment_seq}','open')"><img src="/images/article/comm_btn_4.png" alt="답글"></a>
	      <!-- <a href="#"><img src="/images/article/comm_btn_3.png" alt="취소"></a> -->
	      </p>
	    </div>
	    <form name="commentUpdate${comment.comment_seq }" action="/m/mypage/comment/index.do" method="post" onsubmit="return commentReply(this);">
	      <input type="hidden" name="comment_seq" value="${comment.comment_seq }"/>
	      <input type="hidden" name="mode" value="commentReplyUpdate"/>
	      <div class="comm_text" id="comm_text${comment.comment_seq}">
		      <p id="conts${comment.comment_seq}"><c:if test="${comment.lvl > 0 }"><strong>@${comment.reply_id }</strong></c:if> ${comment.conts }</p>
	      </div>
	    </form>
	    <div class="area_box" id="commentReply${comment.comment_seq}" style="display:none;"><!-- 댓글 로그인 사용자만 -->
	      <form name="comment${comment.comment_seq }" action="/m/mypage/comment/index.do" method="post" onsubmit="return commentReply(this);">
	      <c:if test="${sessionScope.member == null }">
	       이름 : <input type="text" name="member_nm" value="" style="width:100px;"/><input type="hidden" name="password" value="." style="width:100px;"/>
	      </c:if>
	      <input type="hidden" name="reply_id" value="${comment.reg_id }"/>
	      <input type="hidden" name="comment_seq" value="${comment.comment_seq }"/>
	      <input type="hidden" name="mode" value="commentReply"/>
	      <c:choose>
	    		<c:when test="${comment.password == null }">
	    		<p><strong class="comm_arrow">${sessionScope.member.member_id } @${comment.reg_id } 님께 댓글쓰기</strong> <a class="mod" href="#comment${comment.comment_seq}" onclick="commentReplyOnOff('${comment.comment_seq}','close')"><img src="/images/article/comm_btn_3.png" alt="취소"></a></p>
	    		</c:when>
	    		<c:otherwise>
	    		<p><strong class="comm_arrow">${sessionScope.member.member_id } @${comment.reg_nm } 님께 댓글쓰기</strong> <a class="mod" href="#comment${comment.comment_seq}" onclick="commentReplyOnOff('${comment.comment_seq}','close')"><img src="/images/article/comm_btn_3.png" alt="취소"></a></p>
	    		</c:otherwise>
	    	</c:choose>
	      <div>
	        <span class="textarea"><textarea class="textarea_1" name="conts"></textarea></span>
	        <a href="javascript:void(0);" class="comm_btn" onclick="commentReply(document.comment${comment.comment_seq });"><img src="/images/mobile/article/comm_btn_en.gif" alt="입력하기"></a>
	      </div>
	      </form>
    	</div>
    </li>
  </c:forEach>
  <li>
    <div class="area_box area_box_2">
    <p class="comm_txt">댓글은 <b>1000</b> 자 내외로 작성해주시기 바랍니다.</p>
      <form name="comment" action="/m/mypage/comment/index.do" method="post" onsubmit="return commentReply(this);">
      이름 : <input type="text" name="member_nm" value="" style="width:100px;"/><input type="hidden" name="password" value="." style="width:100px;"/>
      <input type="hidden" name="mode" value="commentInsert"/>
      <input type="hidden" name="article_seq" value="${view.seq }"/>
      <div>
        <span class="textarea"><textarea class="textarea_1" name="conts"></textarea></span>
        <a href="javascript:void(0);" class="comm_btn" onclick="commentReply(document.comment);"><img src="/images/mobile/article/comm_btn_en.gif" alt="입력하기"></a>
      </div>
      </form>
    </div>
    </li>  
  </ul>
</div>

<p class="pa_guide">PARTSMOA 쇼핑몰에 관련한 상세한 상담이 필요하신 사항은 고객센터 문의전화 (1544-6444)로 연락주시면 친절히 상담해 드리겠습니다.</p>

<form name="commentDelete" action="/mobile/mypage/comment/index.do" method="post" onsubmit="return commentDel(this);">
<input type="hidden" name="mode" value="commentDel"/>
<input type="hidden" name="comment_seq" value=""/>
</form>
        </div>