<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="charge_tel" value="${fn:split(view.charge_tel,'-') }"/>
<c:set var="charge_tel1" value="${charge_tel[0] }"/>
<c:set var="charge_tel2" value="${charge_tel[1] }"/>
<c:set var="charge_tel3" value="${charge_tel[2] }"/>
 <div id="sub">
        <div class="strapline">
          <h3><img src="/images/sub_2/h3_img_7_2.gif" alt="부품문의"></h3>
          <div class="state"> <span>홈</span> &gt; <span>고객센터</span> &gt; <span><strong>부품문의 수입차</strong></span> </div>
        </div>
        <div class="contents">
          <div class="write_top">
  <h4>PARTS MOA에 문의하기</h4>
  <p><strong>PARTSMOA</strong>쇼핑몰에 관련한 문의/의견 등을 등록하시면 빠른 시일내에 답변 드리겠습니다.</p>
</div>
<form name="wFrm" id="wFrm" action="${servletPath }" method="post" enctype="multipart/form-data" onsubmit="return articleSubmit(this);">
<input type="hidden" name="mode" value="modify"/>
<input type="hidden" name="article_seq" value="${view.article_seq }"/>
<table class="write_style_1">
<colgroup>
<col width="20%">
<col width="">
</colgroup>
<tbody>

<tr>
  <th scope="row">문의제목</th>
  <td><input type="text" id="title" name="title" class="input_1" value="${view.title }"></td>
</tr>
<c:if test="${view.reg_seq == 0 }">
<tr>
  <th scope="row">이름</th>
  <td><input type="hidden" id="member_nm" name="member_nm" class="input_1" style="width:100px;" value="${view.reg_nm }">${view.reg_nm }</td>
</tr>
<tr>
  <th scope="row">기존 비밀번호</th>
  <td><input type="password" id="pass" name="pass" class="input_1" style="width:100px;"></td>
</tr>
</c:if>
<tr>
  <th scope="row">전화번호</th>
  <td>
    <select id="charge_tel1" name="charge_tel1" class="select_u1">
    <c:forEach items="${code }" var="code" varStatus="status">
    	<option value="${code.code }" <c:if test="${code.code == charge_tel1 }"> selected="selected"</c:if>>${code.code }</option>
    </c:forEach>
    </select>
    - <input type="text" id="charge_tel2" name="charge_tel2" class="input_3 ws_2" value="${charge_tel2 }"> - <input type="text" id="charge_tel3" name="charge_tel3" class="input_3 ws_2" value="${charge_tel3 }">
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
  <input type="radio" name="status" value="1" <c:if test="${view.status == 1}">checked="checked"</c:if>/> 전체공개 
  <c:if test="${(sessionScope.member.group_seq == 3 or sessionScope.member.group_seq == 1)}">
  <input type="radio" name="status" value="3" <c:if test="${view.status == 3}">checked="checked"</c:if>/> 협력사 공개	
  </c:if>
  <input type="radio" name="status" value="2" <c:if test="${view.status == 2}">checked="checked"</c:if>/> 비공개
  </td>
</tr>
<tr>
  <th scope="row" class="w_main">문의내용<br /><span>(2000자 입력가능)</span></th>
  <td><textarea cols="" rows="" name="conts" style="width:100%;" id="smarteditor">${view.conts }</textarea></td>
</tr>
<c:if test="${fn:length(files) > 0 }">
<tr>
  <th scope="row">기존 첨부파일</th>
  <td id="oldfileList">
  <c:forEach items="${files }" var="files" varStatus = "status">
  	${files.attach_nm} <input type="checkbox" name="delattach" value="${files.uuid }"/>삭제<br/>
  </c:forEach>
  </td>
</tr>
</c:if>
<tr class="last">
  	<th scope="row">첨부파일</th>
  	<td id="fileList"><div id="file1"><input type="file" id="file" name="attach" style="margin-bottom:5px;"/> <a href="#fileAdd" onclick="fileListAdd()"><img src="/images/article/file_btn_1.png" alt="추가"></a></div></td>
</tr>

</tbody>
</table>

<div class="vr_btn">
  <input type="image" src="/images/article/board_btn6.gif" alt="견적등록"/>  
  <a href="${servletPath }?mode=list&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }"><img src="/images/article/board_btn5.gif" alt="입력취소"></a>
</div>
</form>
        </div>
      </div>
<script type="text/javascript">
	category('${view.upcodeno}','${view.codeno}')
</script>