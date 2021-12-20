<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="main">
  <div class="titlebar">
    <h2>자원관리</h2>
    <div> <span>통합관리</span> &gt; <span>자원관리</span> &gt;<span class="bar_tx">등록</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
   	<form id="wFrm" name="frm" method="post" novalidate="novalidate">
      <table class="style_1">
        <colgroup>
          <col width="15%" />
          <col width="*" />
        </colgroup>
        <c:if test = "${sessionScope.member.group_seq eq '8'}">
        <tr>
        	<th>업체선택</th>
        	<td>
        		<select title="업체선택" data-ng-model="form.title" data-ng-options="item.seq as item.com_nm for item in cooperation_list" data-ng-init="form.title = cooperation_list[0].seq">
        		</select>
        	</td>
        </tr>
        </c:if>
        <tr>
          <th>반출희망날짜</th>
          <td><input type="text" class="input_1 date" data-ng-model="form.sdate" datepicker required readonly="readonly" /></td>
        </tr>
        <tr>
          <th>자원물질</th>
          <td>
          	<p data-ng-repeat="item in form.resources">
            	<select title="자원물질 선택" data-ng-model="form.resources[$index].cate_seq" data-ng-options="item.cate_seq as item.subject for item in group.list" data-ng-init="form.resources[$index].cate_seq = group.list[0].cate_seq">
            	</select>
           		<input type="text" class="input_1 date" data-ng-model="form.resources[$index].item_weight" required/>
           		<span class="bt_alls">
           			<span data-ng-if="$index == 0"><input type="button" value="추가" data-ng-click="addResources()" class="btalls"></span>
           			<span data-ng-if="$index != 0"><input type="button" value="삭제" data-ng-click="deleteResources($index)" class="btalls"></span>           		
           		</span>
            </p>
          </td>
        </tr>
        <tr>
          <th>비고</th>
          <td style="padding:11px 23px 9px 10px;"><textarea id="conts" data-ng-model="form.conts" class="textarea_1"></textarea></td>
        </tr>
        <tr>
          <th>상태</th>
          <td>
          <select title="상태 선택" data-ng-model="form.status" data-ng-init="form.status = '0'">
          	<option value="0">반출요청</option>
          	<option value="1">반출진행</option>
          	<option value="2">반출완료</option>
          </select>
          <span data-ng-if="form.status == '2'">
          	<input type="text" class="input_1 date" data-ng-model="form.edate" datepicker data-ng-required="form.status == '2'" readonly="readonly" />
          </span>
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