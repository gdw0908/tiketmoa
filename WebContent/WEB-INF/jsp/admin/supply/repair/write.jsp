<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="main">
  <div class="titlebar">
    <h2>정비업체신청</h2>
    <div> <span>통합관리</span> &gt; <span>협력업체관리</span> &gt; <span>협력업체신청</span> &gt;<span class="bar_tx">정비업체신청</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate">
      <table class="style_1" style="table-layout:fixed;">
        <colgroup>
        <col width="15%" />
        <col width="*" />
        <col width="15%" />
        <col width="*" />
        </colgroup>
        <tr>
          <th>협력업체명</th>
          <td>
          	<select title="등록된 업체 선택" data-ng-model="form.parent_seq" data-ng-options="item.seq as item.com_nm for item in cooperationList">
          		<option value="">없음</option>
            </select>
          </td>
          <th>정비업체명</th>
          <td>
              <input type="text" class="input_1" data-ng-model="form.com_nm" required/>
          </td>
        </tr>
        <tr>
          <th>대표자명</th>
          <td><input type="text" class="input_1" data-ng-model="form.ceo_nm" required/></td>
          <th>담당자명</th>
          <td><input type="text" class="input_1" data-ng-model="form.staff_nm" required/></td>
        </tr>
        <tr>
          <th>담당자 전화번호</th>
          <td colspan="3">
          	<select title="전화번호 앞자리 선택" data-ng-model="form.staff_tel1" data-ng-options="item.code as item.code for item in main.tel1" data-ng-init="form.staff_tel1=main.tel1[0].code">
            </select>
            <input type="text" class="input_1" style="width:60px" data-ng-model="form.staff_tel2" maxlength="4" required data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="input_1"  style="width:60px" data-ng-model="form.staff_tel3" maxlength="4" required data-ng-pattern="/[0-9]{4}/"/>
          </td>
        </tr>
        <tr>
          <th>지역설정</th>
          <td colspan="3">
            <select title="시도 선택" data-ng-model="form.sido_cd" data-ng-options="item.sido as item.dong_nm for item in sido" data-ng-change="changeSido()">
          	 <option value="">시도 선택</option>
           	</select>
            <select title="시군구 선택" data-ng-model="form.sigungu_cd" data-ng-options="item.sigungu as item.dong_nm for item in sigungu" data-ng-change="changeSigungu()">
          	 <option value="">시군구 선택</option>
           	</select>
            <select title="읍면동 선택" data-ng-model="form.dong_cd" data-ng-options="item.dong as item.dong_nm for item in dong">
          	 <option value="">읍면동 선택</option>
           	</select>
          </td>
        </tr>
        <tr>
          <th>관리번호</th>
          <td colspan="3"><input type="text" class="input_1" style="width:80px" data-ng-model="form.manage_no" required/></td>
        </tr>
        <tr>
          <th>주소</th>
          <td colspan="3">
            <input type="text" class="input_1" style="width:80px" data-ng-model="form.zip1" maxlength="5" required data-ng-pattern="/[0-9]{3}/"/>-<input type="text" class="input_1" style="width:80px" data-ng-model="form.zip2" maxlength="3" data-ng-pattern="/[0-9]{3}/"/>
            <span class="bt_alls"><span><input type="button" value="주소검색" class="btalls" data-ng-click="main.openAddr()"/></span></span> 
            <input type="text" class="input_1" style="width:85%; margin-top:3px;" data-ng-model="form.addr1" required/>
            <input type="text" class="input_1" style="width:85%; margin-top:3px;" data-ng-model="form.addr2"/>
            <div class="mapnaver">
               <nmap data-ng-title="'위치고정'" data-ng-width="800" data-ng-height="250" data-ng-xcoord="form.x_coord" data-ng-ycoord="form.y_coord" data-ng-mode="'admin'"></nmap>
            </div>
          </td>
        </tr>
        <tr>
          <th>상세내용</th>
          <td colspan="3">
            <textarea style="width:100%;" id="conts" data-ng-model="form.conts" smarteditor></textarea>
          </td>
        </tr>
      </table>
      
      <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span>
          <input type="button" value="저장" class="btall" data-ng-click="save()"/>
          </span></span> 
          <span class="bt_all"><span>
          <input type="button" value="취소" class="btall" data-ng-click="list()"/>
          </span></span>
          <span class="bt_all"><span>
          <input type="button" value="목록" class="btall" data-ng-click="list()"/>
          </span></span> 
        </div>
      </div>
      </form>
    </div>
  </div>
</div>