<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="main">
  <div class="titlebar">
    <h2>이메일관리</h2>
    <div> <span>통합관리</span> &gt; <span>SMS/이메일관리</span> &gt;<span>이메일관리</span> &gt;<span class="bar_tx">이메일타겟</span> </div>
  </div>
  <div class="container">
    <div class="tab_menu">
      <ul class="tab">
        <li><a href="/admin/system/send/email/send/index.do">이메일전송</a></li>
        <li class="on"><a href="#/list">이메일타켓</a></li>
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
          <th>타겟방식</th>
          <td class="chbox">
            <label><input type="radio" data-ng-model="form.target_cd" value="1" data-ng-init="form.target_cd = '1'"/><span>파일업로드</span></label>
            <label><input type="radio" data-ng-model="form.target_cd" value="2" /><span>직접입력</span></label>
            <!-- <label><input type="radio" data-ng-model="form.target_cd" value="3" /><span>DB추출</span></label> -->
            <label><input type="radio" data-ng-model="form.target_cd" value="4" /><span>대상선택</span></label>
          </td>
        </tr>
       </table>
       
       <!-- 파일업로드 -->
       <div style="margin-top: 15px;">
         <table class="style_1">
           <colgroup>
	          <col width="15%" />
	          <col width="*" />
	        </colgroup>
           <tr>
             <th>샘플다운로드</th>
             <td>
               <span class="bt_alls"><span><a href="/mail_download.do?file_nm=mail_sample.xls"><input type="button" value="샘플다운로드" class="btalls"/></a></span></span> 
             </td>
           </tr>
           <tr>
             <th>업로드파일</th>
             <td>
             	<input type="file" name="file" id="file" onchange="angular.element(this).scope().uploadFile()"/>
             	<span data-ng-if="form.old_tg_xls_file_nm != null" class="bt_alls"><span><a href="/mail_download.do?file_nm={{form.old_tg_xls_file_nm}}"><input type="button" value="이전파일받기" class="btalls"/></a></span></span> 
			 </td>
           </tr>
         </table>
         <p class="targetp">*파일업로드는 엑셀파일(xls)만 업로드 가능하며 샘플파일을 이용하여 대상을 작성하신후 업로드 하십시오.</p>
       </div>
       <!-- 파일업로드 end-->
       
       <!-- 직접입력창 -->
       <div style="margin-top: 15px;">
         <table class="style_1">
           <colgroup>
	          <col width="15%" />
	          <col width="*" />
	        </colgroup>
           <tr>
             <th>직접입력창</th>
             <td>
               <textarea data-ng-model="form.tg_input_str" style="width: 95%; height: 70px;" data-ng-required="form.target_cd == '2'"></textarea>
             </td>
           </tr>
         </table>
         <p class="targetp">*대상자 입력은 예제와 같이 입력하시고, 각 라인은 엔터키로 구분됩니다.<br/>&nbsp;예)webmarster@insun.com;인선모터스</p>
       </div>
       <!-- 직접입력창 end-->
       
       <!-- DB추출 -->
       <!-- <div style="margin-top: 15px;">
         <table class="style_1">
           <colgroup>
	          <col width="15%" />
	          <col width="*" />
	        </colgroup>
           <tr>
             <th>쿼리</th>
             <td>
               <textarea data-ng-model="form.tg_query_str" style="width: 95%; height: 70px;" data-ng-required="form.target_cd == '3'"></textarea>
             </td>
           </tr>
         </table>
         <p class="targetp">*데이터베이스 쿼리를 사용하여 대상자를 직접 지정합니다. 데이터베이스를 다룰수 있는 전문가만 다루시기 바랍니다.</p>
       </div> -->
       <!-- DB추출 end-->
       
       <!-- 대상선택 -->
       <div style="margin-top: 15px;">
         <table class="style_1">
           <colgroup>
	          <col width="15%" />
	          <col width="*" />
	        </colgroup>
           <tr>
             <th>대상그룹선택</th>
             <td class="chbox">
               <label><input type="checkbox" value="0" data-ng-model="form.tg_chk_cd.0"/><span>전체회원</span></label>
               <label><input type="checkbox" value="2" data-ng-model="form.tg_chk_cd.2"/><span>일반회원</span></label>
               <label><input type="checkbox" value="4" data-ng-model="form.tg_chk_cd.4"/><span>사업자회원</span></label>
               <label><input type="checkbox" value="3" data-ng-model="form.tg_chk_cd.3"/><span>협력사회원</span></label>
             </td>
           </tr>
         </table>
         <p class="targetp">*등록된 회원그룹선택.</p>
       </div>
       <!-- 대상선택 end-->
       
       
       <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span><input type="button" value="등록" data-ng-click="save()" class="btall"/></span></span>
          <span class="bt_all"><span><input type="button" value="목록" data-ng-click="list()" class="btall"/></span></span> 
        </div>
      </div>
      </form>
    </div>
  </div>
</div>