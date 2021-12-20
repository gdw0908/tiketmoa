<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:choose>
	<c:when test="${params.mode == 'del' }">
		<c:set var='article_mode' value='삭제'/>
		<c:set var='article_mode_image' value='<input type="image" src="/images/article/board_btn1_n.gif" alt="문의취소">'/>
	</c:when>
	<c:otherwise>
		<c:set var='article_mode' value='확인'/>
		<c:set var='article_mode_image' value='<input type="image" src="/images/sub_2/d_btn_4.gif" alt="확인">'/>
	</c:otherwise>
</c:choose>
<div class="sub_wrap">
	<div class="sub_line">
          <h3><img src="/images/mobile/sub_2/sub_2_title_4.gif" alt="중고부품정비견적"></h3>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>

	<div class="write_top">
		<h4>PARTS MOA에 문의하기</h4>
		<p><strong>PARTSMOA</strong>쇼핑몰에 관련한 문의/의견 등을 등록하시면 빠른 시일내에 답변 드리겠습니다.</p>
	</div>
	<form name="wFrm" id="wFrm" action="${servletPath }" method="post" onsubmit="return articleSubmit(this);">
		<input type="hidden" name="mode" value="${params.mode }"/>
		<input type="hidden" name="article_seq" value="${params.article_seq }"/>
		<input type="hidden" name="menu" value="menu2"/>
		<table class="write_style_1">
			<colgroup>
				<col width="25%">
				<col width="">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">비밀번호</th>
					<td><input type="password" id="pass" name="pass" class="input_m2" value=""/></td>
				</tr>
			</tbody>
		</table>
		<div class="vr_btn">
			${article_mode_image }
			<a href="${servletPath }?mode=list&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }"><img src="/images/article/board_btn5.gif" alt="입력취소"></a>
		</div>
	</form>
</div>
