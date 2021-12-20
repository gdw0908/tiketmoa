<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="main">
  <div class="titlebar">
    <h2>셀카관리</h2>
    <div> <span>통합관리</span> &gt; <span>자원/셀카 관리</span> &gt;<span class="bar_tx">셀카관리</span> </div>
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
          <th>업체명</th>
          <td>
          	<select title="업체명" data-ng-model="form.com_seq" data-ng-options="item.seq as item.com_nm for item in cooperation_list" required>
			</select>
		  </td>
        </tr>
        <tr>
        	<th>상태</th>
        	<td>
        	<c:if test="${sessionScope.member.group_seq ne '3' }">
        		<select title="상태" data-ng-model="form.state">
        			<option value="0">등록</option>
        			<option value="1">검토중</option>
        			<option value="2">반려</option>
        			<option value="3">구매완료</option>
        			<option value="4">삭제</option>
        		</select>
        	</c:if>
        	<c:if test="${sessionScope.member.group_seq eq '3' }">
        		{{form.state == '0' ? '등록' : form.state == '1' ? '검토중' : form.state == '2' ? '반려' : form.state == '3' ? '구매완료' : '삭제' }}
        	</c:if>
        	</td>
        </tr>
        <tr>
          <th>내용</th>
          <td>
			<textarea style="width:100%;" id="conts" data-ng-model="form.content" required smarteditor></textarea>
          </td>
        </tr>
        <tr>
          <th rowspan="3">첨부파일 </th>
          <td><input type="file" name="file" id="file" onchange="angular.element(this).scope().uploadFile()"/></td>
        </tr>
        <tr> 
          <td>
          	<span data-ng-repeat="item in form.files">
				<a data-ng-href="/upload/board/{{item.yyyy}}/{{item.mm}}/{{item.uuid}}" target="_blank"><img src="/upload/board/{{item.yyyy}}/{{item.mm}}/{{item.uuid}}" style="width:100px;height:100px;"/></a>&nbsp;&nbsp;
			</span>
	      </td>
        </tr>
        <tr> 
          <td class="tddiv" id="attach_div">
	          <div data-ng-repeat="item in form.files">
	          	<p style="margin-top: 3px;"><a data-ng-href="/download.do?uuid={{item.uuid}}">{{item.attach_nm}}</a> <a data-ng-click="removeFile($index)"><img src="/images/admin/contents/s_btn_1.gif" alt="삭제" /></a></p>
	          </div>
	      </td>
        </tr>
      </table>
	  <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span><input type="button" value="수정" class="btall" data-ng-click="save()"/></span></span>
          <span class="bt_all"><span><input type="button" value="삭제" class="btall" data-ng-click="del()"/></span></span> 
          <span class="bt_all"><span><input type="button" value="목록" class="btall" data-ng-click="list()"/></span></span>
        </div>
      </div>
	</form>  
    </div>
  </div>
</div>
