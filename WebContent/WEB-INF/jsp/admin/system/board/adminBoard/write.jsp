<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="main">
  <div class="titlebar">
    <h2>관리자 게시판</h2>
    <div> <span>통합관리</span> &gt; <span>관리자 게시판</span> &gt; <span class="bar_tx">등록</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate">
      <table class="style_1">
        <colgroup>
          <col width="15%" />
          <col width="*" />
        </colgroup>
        <tr>
          <th>작성자</th>
          <td>${sessionScope.member.member_nm }</td>
        </tr>
        <tr>
          <th>제목</th>
          <td><input type="text" class="input_1" style="width:90%" data-ng-model="form.title" required/></td>
        </tr>
        <!-- <tr>
          <th>연락처</th>
          <td>
            <select title="전화번호 앞자리 선택" data-ng-model="form.tel1" data-ng-options="item.code as item.code for item in main.tel" data-ng-init="form.tel1 = main.tel[0].code">
            </select>
            <input type="text" class="input_1" data-ng-model="form.tel2" style="width:60px" /> - <input type="text" class="input_1" data-ng-model="form.tel3"  style="width:60px" />
          </td>
        </tr>
        <tr>
          <th>부품카테고리</th>
          <td>
            <select data-ng-model="form.upcodeno" data-ng-options="item.codeno as item.codenm for item in main.group" data-ng-init="form.upcodeno = ''" data-ng-change="changeSubcode()" required>
            	<option value="">== 선택 ==</option>
            </select>
            <select data-ng-model="form.codeno" data-ng-options="item.codeno as item.codenm for item in subcode" data-ng-init="form.codeno = ''" required>
                 <option value="">===== 선택 =====</option>
            </select>
          </td>
        </tr>
        <tr>
          <th>공개설정</th>
          <td>
          	<input type="radio" class="input_1" data-ng-model="form.status" value="1" data-ng-init="form.status = 1"/> 전체공개 
          	<input type="radio" class="input_1" data-ng-model="form.status" value="3" /> 협력사공개
          	<input type="radio" class="input_1" data-ng-model="form.status" value="2" /> 비공개
          </td>
        </tr> -->
        <tr>
          <th>내용</th>
          <td>
			<textarea style="width:100%;" id="conts" data-ng-model="form.conts" required smarteditor></textarea>
          </td>
        </tr>
        <tr>
          <th rowspan="2">첨부파일 </th>
          <td><input type="file" name="file" id="file" onchange="angular.element(this).scope().uploadFile()"/></td>
        </tr>
        <tr> 
          <td class="tddiv" id="attach_div">
	          <div data-ng-repeat="item in form.files">
	          	<p style="margin-top: 3px;">{{item.attach_nm}}({{item.size|number}}) <a data-ng-click="removeFile($index)"><img src="/images/admin/contents/s_btn_1.gif" alt="삭제" /></a></p>
	          </div>
	      </td>
        </tr>
      </table>
	  <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span><input type="button" value="등록" class="btall" data-ng-click="save()"/></span></span> 
          <span class="bt_all"><span><input type="button" value="목록" class="btall" data-ng-click="list()"/></span></span>
        </div>
      </div>
	</form>  
    </div>
  </div>
</div>