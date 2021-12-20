<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="main">
  <div class="titlebar">
    <h2>메인화면관리</h2>
    <div> <span>통합관리</span> &gt; <span>팝업관리</span> &gt;<span class="bar_tx">레이어팝업관리</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate" enctype="multipart/form-data">
      <table class="style_1">
        <colgroup>
          <col width="15%" />
          <col width="*" />
        </colgroup>
        <tr>
          <th>제목</th>
          <td><input type="text" class="input_1" style="width:90%" data-ng-model="form.title" required/></td>
        </tr>
        <tr>
          <th>링크사용</th>
          <td>
            <label>
              <input type="radio" data-ng-model="form.link_yn" value="Y" data-ng-init="form.link_yn = 'Y'"/><span>사용</span>  
            </label>
            <label>
              <input type="radio" data-ng-model="form.link_yn" value="N" /><span>사용안함</span>  
            </label>
          </td>
        </tr>
        <tr>
          <th>링크URL</th>
          <td><input type="text" class="input_1" data-ng-model="form.link_url" style="width: 80%;" data-ng-required="form.link_yn == 'Y'"/></td>
        </tr>
        <tr>
          <th>링크타겟</th>
          <td>
            <select data-ng-model="form.link_target" data-ng-init="form.link_target = '_self'" title="링크타겟 선택 선택">
                 <option value="_self">현재창</option>
                 <option value="_blank">새창</option>       
            </select>
          </td>
        </tr>
        <tr>
          <th rowspan="2">이미지 </th>
          <td><input type="file" name="file" id="file" onchange="angular.element(this).scope().uploadFile()"/></td>
        </tr>
        <tr> 
          <td class="tddiv" id="attach_div">
	        <div style="margin-top: 3px;"><img data-ng-if="!!form.files[0].uuid" data-ng-src="/upload/temp/{{form.files[0].uuid}}" alt="사진" style="width: 125px; height: 60px;"/></div>
	      </td>
        </tr>
        <tr>
          <th>이미지설명</th>
          <td><input type="text" class="input_1" data-ng-model="form.alt" style="width: 80%;" required/></td>
        </tr>
        <tr>
          <th>기간</th>
          <td><input type="text" class="input_1 date" data-ng-model="form.start_dt" datepicker required/> ~ <input type="text" class="input_1 date" data-ng-model="form.end_dt" datepicker required/></td>
        </tr>
        <tr>
          <th>레이어 위치</th>
          <td>
          TOP : <input type="text" class="input_1" data-ng-model="form.y_coord" style="width: 5%;" required/>
          LEFT : <input type="text" class="input_1" data-ng-model="form.x_coord" style="width: 5%;" required/>
          </td>
        </tr>
        <tr>
          <th>사용여부</th>
          <td>
            <label>
              <input type="radio" data-ng-model="form.use_yn" value="Y" data-ng-init="form.use_yn = 'Y'" /><span>사용</span>  
            </label>
            <label>
              <input type="radio" data-ng-model="form.use_yn" value="N" /><span>사용안함</span>  
            </label>
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
