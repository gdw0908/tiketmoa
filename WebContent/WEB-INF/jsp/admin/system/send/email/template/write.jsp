<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="main">
  <div class="titlebar">
    <h2>이메일관리</h2>
    <div> <span>통합관리</span> &gt; <span>SMS/이메일관리</span> &gt; <span>이메일관리</span> &gt;<span class="bar_tx">이메일템플릿</span> </div>
  </div>
  <div class="container">
    <div class="tab_menu">
      <ul class="tab">
        <li><a href="/admin/system/send/email/send/index.do">이메일전송</a></li>
        <li><a href="/admin/system/send/email/target/index.do">이메일타켓</a></li>
        <li class="on"><a href="#/list">이메일템플릿</a></li>
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
          <td><input type="text" class="input_1" data-ng-model="form.title" required style="width: 80%;"/></td>
        </tr>
        <tr>
          <th>내용</th>
          <td><textarea style="width:100%;" id="conts" data-ng-model="form.conts" required smarteditor></textarea></td>
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