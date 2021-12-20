<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 <div id="sub">
        <div class="strapline">
          <h3><img src="/images/sub_2/h3_img_3.gif" alt="카올바로"></h3>
          <div class="state"> <span>홈</span> &gt; <span>고객센터</span> &gt; <span><strong>카올바로</strong></span> </div>
        </div>
        <div class="contents">
          <div class="write_top">
  <h4>PARTS MOA에 문의하기</h4>
  <p class="baro">정비품목은 도어, 범퍼, 휀다, 본네트, 테일램프, 라디에이터그릴, 헤드램프, 트렁크판낼, (재제조 부품 : 알터네이터, A/C 콤프레서, 스타트모터) 최상급중고부품을 사용한 견적입니다. (견적은 실제 상태 확인에 따라서 차이가 있을수 있습니다.)</p>
</div>
<form name="wFrm" id="wFrm" action="${servletPath }" method="post" enctype="multipart/form-data" onsubmit="return articleSubmit(this);">
<input type="hidden" name="mode" value="insert"/>
<input type="hidden" name="status" value="0"/>
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
<!-- <tr>
  <th scope="row">공개여부</th>
  <td><input type="radio" name="public_yn" value="Y" checked="checked"/> 공개 <input type="radio" name="public_yn" value="N"/> 비공개</td>
</tr> -->
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
  <th scope="row" class="w_main">문의내용<br /><span>(2000자 입력가능)</span></th>
  <td>
  <textarea cols="" rows="" name="conts" style="width:100%;" id="smarteditor">
1. 브랜드       :<br>
2. 차량명/연식  :<br>
3. 지역         :<br>
4. 수리요구사항을 입력해주세요<br>
&nbsp;&nbsp;&nbsp;&nbsp;(비교전 견적금액, 견적서첨부, 수리할 사진및 내용)<br><br>
  </textarea></td>
</tr>

<tr class="last">
  	<th scope="row">첨부파일</th>
  	<td id="fileList"><div id="file1"><input type="file" id="file" name="attach" style="margin-bottom:5px;"/> <a href="#fileAdd" onclick="fileListAdd()"><img src="/images/article/file_btn_1.png" alt="추가"></a></div></td>
</tr>

</tbody>
</table>

<div class="vr_btn">
  <input type="image" src="/images/article/board_btn6_n.gif" alt="견적등록"/>  
  <a href="${servletPath }?mode=list&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }"><img src="/images/article/board_btn5.gif" alt="입력취소"></a>
</div>
</form>
        </div>
      </div>