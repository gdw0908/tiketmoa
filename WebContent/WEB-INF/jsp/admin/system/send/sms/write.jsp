<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="main">
  <div class="titlebar">
    <h2>SMS전송</h2>
    <div> <span>통합관리</span> &gt; <span>시스템관리</span> &gt;<span>SMS/이메일 관리</span> &gt;<span class="bar_tx">SMS전송</span> </div>
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
          <th>보내는 분 연락처</th>
          <td>
            <input type="text" class="input_1" data-ng-model="form.tran_callback" style="width:150px" required/>
          </td>
        </tr>
        <tr>
          <th>받는 분 연락처</th>
          <td>
            <input type="text" class="input_1" data-ng-model="form.tran_phone" style="width:150px" required/>
          </td>
        </tr>
        <tr>
          <th>제목</th>
          <td><input type="text" class="input_1" style="width:90%" data-ng-model="form.subject" required/></td>
        </tr>
        <tr>
          <th>내용</th>
          <td>
			<textarea style="width:160px;" id="tran_msg" data-ng-model="form.tran_msg" required></textarea>
          </td>
        </tr>
      </table>
	  <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span><input type="button" value="등록" class="btall" data-ng-click="save()"/></span></span> 
        </div>
      </div>
	</form>  
    </div>
  </div>
</div>