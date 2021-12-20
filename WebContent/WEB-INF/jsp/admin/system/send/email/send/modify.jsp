<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="main">
  <div class="titlebar">
    <h2>이메일관리</h2>
    <div> <span>통합관리</span> &gt; <span>SMS/이메일관리</span> &gt; <span>이메일관리</span> &gt;<span class="bar_tx">이메일전송</span> </div>
  </div>
  <div class="container">
    <div class="tab_menu">
      <ul class="tab">
        <li class="on"><a href="#/list">이메일전송</a></li>
        <li><a href="/admin/system/send/email/target/index.do">이메일타켓</a></li>
        <li><a href="/admin/system/send/email/template/index.do">이메일템플릿</a></li>
      </ul>
    </div> 
    <div class="contents">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate">
      <table class="style_1">
        <colgroup>
          <col width="15%" />
          <col width="*" />
        </colgroup>
        <tr>
          <th>제목</th>
          <td><input type="text" class="input_1" data-ng-model="form.title" style="width: 80%;" required/></td>
        </tr>
        <tr>
          <th>비고</th>
          <td><input type="text" class="input_1" data-ng-model="form.etc" style="width: 80%;"/></td>
        </tr>
        <tr>
          <th>발송자명</th>
          <td><input type="text" class="input_1" data-ng-model="form.from_nm" style="width: 80%;" required/></td>
        </tr>
        <tr>
          <th>발송자이메일</th>
          <td>
            <input type="text" class="input_1"  data-ng-model="form.from_email" style="width: 80%;" required/>
         </td>
        </tr>
        <tr>
          <th>타겟</th>
          <td>
			<span class="bt_alls"><span><input type="button" value="타겟선택" data-ng-click="targetSearch();" class="btalls"/></span></span> <span data-ng-if="form.tg_title != null && form.tg_title != ''"><b>{{form.tg_title}}</b></span>
         </td>
        </tr>
        <tr>
          <th>템플릿</th>
          <td>
            <span class="bt_alls"><span><input type="button" value="템플릿선택" data-ng-click="templateSearch();" class="btalls"/></span></span> <span data-ng-if="form.tp_title != null && form.tp_title != ''"><b>{{form.tp_title}}</b></span>
         </td>
        </tr>
      </table>
      
       <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span><input type="button" value="등록" data-ng-click="save();" class="btall"/></span></span>
          <span class="bt_all"><span><input type="button" value="목록" data-ng-click="list();" class="btall"/></span></span> 
        </div>
      </div>
     </form>
    </div>
  </div>
</div>