<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="sub_wrap">
	<div class="sub_line">
          <h3><img src="/images/mobile/sub_2/sub_2_title_8.gif" alt="부품문의"></h3>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>

	<div class="write_top">
		<h4>PARTS MOA에 문의하기</h4>
		<p><strong>PARTSMOA</strong>쇼핑몰에 관련한 문의/의견 등을 등록하시면 빠른 시일내에 답변 드리겠습니다.</p>
	</div>
	
	<form name="wFrm" id="wFrm" action="${servletPath }" method="post" enctype="multipart/form-data" onsubmit="return articleSubmit(this);">
	<input type="hidden" name="mode" value="insert"/>
	<table class="write_style_1">
		<colgroup>
			<col width="20%">
			<col width="">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">문의제목</th>
				<td><input type="text" id="title" name="title" class="input_1"></td>
			</tr>
			<c:if test="${sessionScope.member == null }">
			<tr>
			  	<th scope="row">이름</th>
			  	<td><input type="text" id="member_nm" name="member_nm" class="input_1" style="width:100px;"></td>
			</tr>
			<tr>
			  	<th scope="row">비밀번호</th>
			  	<td><input type="password" id="pass" name="pass" class="input_1" style="width:100px;"></td>
			</tr>
			</c:if>
			<tr>
			  	<th scope="row">전화번호</th>
			  	<td>
			    	<p>
			    	<select id="charge_tel1" name="charge_tel1" class="select_u1">
			    	<c:forEach items="${code }" var="code" varStatus="status">
				    	<option value="${code.code }">${code.code }</option>
				    </c:forEach>
			    	</select>
			    	- <input type="text" id="charge_tel2" name="charge_tel2" class="input_3 ws_2"> - <input type="text" id="charge_tel3" name="charge_tel3" class="input_3 ws_2">
			    	</p>
					<p class="ph_text">※ 입력하신 개인정보는 별도 요청이 없을 경우 6개월 보관 후 삭제되며, 문의 사항 확인이나 답변의 전달을 위해 고객님께 연락을 취하는 용도 이외에는 사용되지 않습니다. 또한 항목에 체크하실 경우 이에 동의하는 것으로 간주하며, 동의하지 않을 경우, 게시가 이루어지지 않습니다. <label><input type="checkbox" id="agree" name="agree" class="check"> 동의합니다</label></p>
			  	</td>
			</tr>
			<tr>
			  <th scope="row">부품카테고리</th>
			  <td>
			    <p>
			    <select id="upcodeno" name="upcodeno" class="select_1 ws_1" onchange="select_codeno(this.value)">
			    </select>
			    <select id="codeno" name="codeno" class="select_1 ws_2">
			    </select>
			    </p>
			  </td>
			</tr>
			<tr>
			  	<th scope="row">공개설정</th>
			  	<td>
			  	 <input type="radio" name="status" value="1" <c:if test="${view.status == 1 || view.status == null}">checked="checked"</c:if>/> 전체공개 
			  	 <c:if test="${(sessionScope.member.group_seq == 3 or sessionScope.member.group_seq == 1)}">
			  	 <input type="radio" name="status" value="3" <c:if test="${view.status == 3}">checked="checked"</c:if>/> 협력사 공개	
			  	 </c:if>
			  	 <input type="radio" name="status" value="2" <c:if test="${view.status == 2}">checked="checked"</c:if>/> 비공개
			  	</td>
			</tr>
			<tr>
			  	<th scope="row" class="w_main">문의내용<br /><span>(2000자 입력가능)</span></th>
			  	<td><textarea cols="" rows="" name="conts" id="smarteditor_mobile" style="width:100%;height:150px;min-width:100%; display:none;"></textarea></td>
			</tr>
			<tr class="last">
			  	<th scope="row">첨부파일</th>
			  	<td id="fileList"><div id="file1"><input type="file" id="file" name="attach" style="margin-bottom:5px;"/> <a href="#fileAdd" onclick="fileListAdd()"><img src="/images/article/file_btn_1.png" alt="추가"></a></div></td>
			</tr>
		</tbody>
	</table>
	
	<div class="vr_btn">
 		<input type="image" src="/images/article/board_btn6.gif" alt="견적등록"/>  
 		<a href="${servletPath }?mode=list&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }&amp;menu=menu1"><img src="/images/article/board_btn5.gif" alt="입력취소"></a>
	</div>
	</form>
	
</div>