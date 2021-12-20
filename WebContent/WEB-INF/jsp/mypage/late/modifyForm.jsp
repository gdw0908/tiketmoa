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
          <h3><img src="/images/sub_2/h3_img_6.gif" alt="구매후기"></h3>
          <div class="state"> <span>홈</span> &gt; <span>고객센터</span> &gt; <span><strong>구매후기</strong></span> </div>
        </div>
        <div class="contents">
          <div class="write_top">
<!-- 
  <h4>PARTS MOA에 문의하기</h4>
  <p><strong>PARTSMOA</strong>쇼핑몰에 관련한 문의/의견 등을 등록하시면 빠른 시일내에 답변 드리겠습니다.</p>
  
-->
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
  <th scope="row">후기제목</th>
  <td><input type="text" id="title" name="title" class="input_1" value="${view.title }"></td>
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
  <th scope="row" class="w_main">후기내용<br /><span>(2000자 입력가능)</span></th>
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
setTimeout(function(){category('${view.upcodeno}','${view.codeno}')},200);
</script>