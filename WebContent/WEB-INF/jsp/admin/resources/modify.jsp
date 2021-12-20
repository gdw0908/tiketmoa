<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="main">
  <div class="titlebar">
    <h2>자원관리</h2>
    <div> <span>통합관리</span> &gt; <span>자원관리</span> &gt;<span class="bar_tx">수정</span> </div>
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
          <th>반출희망날짜</th>
          <td><input type="text" class="input_1 date" data-ng-model="form.sdate" datepicker required readonly="readonly" /></td>
        </tr>
        <tr>
          <th>자원물질</th>
          <td>
          	<p data-ng-repeat="item in form.resources" ng-if="item.del_yn == 'N' || item.del_yn == null">
            	<select title="자원물질 선택" data-ng-model="item.cate_seq" data-ng-options="items.cate_seq as items.subject for items in group.list" data-ng-init="item.cate_seq == null ? group.list[0].cate_seq : item.cate_seq">
            	</select>
           		<input type="text" class="input_1 date" data-ng-model="item.item_weight" required/>
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
          <select title="상태 선택" data-ng-model="form.status">
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