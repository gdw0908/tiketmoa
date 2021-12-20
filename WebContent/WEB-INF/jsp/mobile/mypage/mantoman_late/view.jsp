<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">
$(document).ready(function(){
	var view_text = $(".view_text");
	$.each($(view_text).find("img"),function(){
		$(this).attr("width","");
		$(this).attr("height","");
		$(this).css("width","90%");
		$(this).css("height","");
	});
});
</script>
      <div class="sub_wrap">
	  <div class="sub_line">
          <h3><img src="/images/mobile/sub_2/sub_2_title_4_b1.gif" alt="정비사례"></h3>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
      </div>
<table class="view_style_1" style="margin-top:5%;">
<colgroup>
<col width="20%">
<col width="">
</colgroup>
<thead>
<tr>
  <th scope="row" class="c1">제목</th>
  <td class="title">${view.title}</td>
</tr>
</thead>
<tbody>
<tr>
  <td class="date" colspan="2">작성일 : ${view.reg_dt}</td>
</tr>
<c:if test="${fn:length(files) > 0 }">
<tr>
  <td scope="row" colspan="2">
  첨부파일 : <c:forEach items="${files }" var="files" varStatus = "status">
  	<a href="/download.do?uuid=${files.uuid }" target="_blank">${files.attach_nm}</a>&nbsp;
  </c:forEach>
  </td>
</tr>
</c:if>
<tr>
  <td colspan="2" class="view_text">
    <p>
    ${view.conts}
    </p>
  </td>
</tr>
</tbody>
</table>

<p class="pa_guide">PARTSMOA 쇼핑몰에 관련한 상세한 상담이 필요하신 사항은 고객센터 문의전화 (1544-6444)로 연락주시면 친절히 상담해 드리겠습니다.</p>

<div class="view_top">
  <p class="btn_box">
  <a href="${servletPath }?mode=list&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }&amp;menu=menu2"><img src="/images/article/board_btn3.gif" alt="목록으로"></a>
  </p>
</div>

<table class="view_prevnext">
<colgroup>
<col width="20%">
<col width="">
</colgroup>
<tbody>
<tr>
  <th scope="row">다음글</th>
  <td>
  <c:choose>
  <c:when test="${view.next_article_seq eq null}">다음 글이 없습니다.</c:when>
  <c:otherwise><a href="${servletPath }?mode=view&amp;article_seq=${view.next_article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }&amp;menu=menu2">${view.next_article_title }</a></c:otherwise>
  </c:choose>
  </td>
</tr>
<tr>
  <th scope="row">이전글</th>
  <td>
  <c:choose>
  <c:when test="${view.pre_article_seq eq null}">이전 글이 없습니다.</c:when>
  <c:otherwise><a href="${servletPath }?mode=view&amp;article_seq=${view.pre_article_seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }&amp;menu=menu2">${view.pre_article_title }</a></c:otherwise>
  </c:choose>
  </td>
</tr>
</tbody>
</table>

      </div>