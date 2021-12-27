<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="main">
  <div class="titlebar">
    <h2>회원관리</h2>
    <div> <span>통합관리</span> &gt; <span>회원관리</span> &gt; <span>회원관리</span> &gt;<span class="bar_tx">회원등록</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate">
      <table class="style_1" style="table-layout:fixed;">
        <colgroup>
        <col width="15%" />
        <col width="*" />
        </colgroup>
        <tr>
          <th>아이디</th>
          <td colspan="3">
            <input type="text" class ="input_1" data-ng-model="form.member_id" data-ng-blur="duplicateCheckMemberId()" data-ng-minlength="4" data-ng-maxlength="16" data-ng-pattern="/^[A-Za-z0-9+]*$/" required/>
            <span class="bt_alls"><span><input type="button" value="중복확인" class="btalls" data-ng-click="duplicateCheckMemberId()"/></span></span> 
            <span style="font-size:11px;" data-ng-if="form.isDuplicateId===undefined">*아이디 중복확인을 해주세요.</span>
            <span style="font-size:11px;" data-ng-if="form.isDuplicateId">*이미 사용중인 아이디 입니다.</span>
            <span style="font-size:11px;" data-ng-if="form.isDuplicateId!==undefined && !form.isDuplicateId">확인되었습니다.</span>
            <div style="margin-top: 3px;">
               <label>
               <input type="checkbox" id="" name="" />
               <span>VIP선택</span>
               </label>
            </div>
           
          </td>
        </tr>
        <tr>
          <th>비밀번호</th>
          <td colspan="3">
          <input type="password" class ="input_1" name="member_pw" data-ng-model="form.member_pw" maxlength="16" data-ng-minlength="4" data-ng-maxlength="16" data-ng-pattern="/([a-zA-Z_]+[0-9]+[^a-zA-Z0-9_]*)|([a-zA-Z_]+[^a-zA-Z0-9_]+[0-9]*)|([0-9]+[a-zA-Z_]+[^a-zA-Z0-9_]*)|([0-9]+[^a-zA-Z0-9_]+[a-zA-Z_]*)|([^a-zA-Z0-9_]+[0-9]+[a-zA-Z_]*)|([^a-zA-Z0-9_]+[a-zA-Z_]+[0-9]*)/" required/>
<!--           <div data-ng-show="frm.member_pw.$error.minlength || frm.member_pw.$error.maxlength || frm.member_pw.$error.pattern">※ 4~16자의 영문대문자, 숫자, 특수문자를 조합하여 사용하실 수 있습니다.</div>  -->
          <span style="font-size:11px;margin:0px 5px 0px 25px;">*비밀번호재입력</span>
          <input type="password" class ="input_1" data-ng-model="form.member_pw_confirm" required/>
<!--           <div data-ng-show="form.member_pw != form.member_pw_confirm">※ 비밀번호를 확인해주세요.</div> -->
          </td>
        </tr>
        <tr>
          <th>회원선택</th>
          <td colspan="3">
            <label><input type="radio" data-ng-model="form.member_type" value="1" data-ng-init="form.member_type='1'"/><span>일반회원</span></label>
            <!-- <label data-ng-if="form.group_seq != '9'"><input type="radio" data-ng-model="form.member_type" value="2"/><span>기업회원</span></label>
            <label data-ng-if="form.group_seq != '9'"><input type="radio" data-ng-model="form.member_type" value="8"/><span>자원관리회원</span></label> -->
          </td>
        </tr>
        <tr data-ng-if="form.member_type=='1' || form.member_type=='8'">
          <th>이름</th>
          <td colspan="3"><input type="text" class ="input_1" data-ng-model="form.member_nm" required/></td>
        </tr>
        <tr data-ng-if="form.member_type=='2'">
          <th>사업자등록번호</th>
          <td>
            <input type="text" class="input_1" data-ng-model="form.busi_no1" style="width:60px" required="required" maxlength="3" data-ng-pattern="/^[0-9]+$/"/> - <input type="text" class="input_1" data-ng-model="form.busi_no2" style="width:60px" required="required" maxlength="2" data-ng-pattern="/^[0-9]+$/"/> - <input type="text" class="input_1" data-ng-model="form.busi_no3" style="width:60px" required="required" maxlength="5" data-ng-pattern="/^[0-9]+$/"/>
          </td>
          <th>업체명</th>
          <td>
            <input type="text" class="input_1" data-ng-model="form.busi_nm" required="required"/>
          </td>
        </tr>
        <tr data-ng-if="form.member_type=='2'">
          <th>업태</th>
          <td>
            <input type="text" class="input_1" data-ng-model="form.comptyp1" required="required"/>
          </td>
          <th>종목</th>
          <td>
            <input type="text" class="input_1" data-ng-model="form.comptyp2" required="required"/>
          </td>
        </tr>
        <tr data-ng-if="form.member_type=='2'">
          <th>대표자명</th>
          <td>
            <input type="text" class="input_1" data-ng-model="form.ceo_nm"/>
          </td>
          <th>담당자명</th>
          <td>
            <input type="text" class="input_1" data-ng-model="form.staff_nm" required="required"/>
          </td>
        </tr>
        
        
        <tr>
          <th>전화번호</th>
          <td colspan="3">
          	<select title="전화번호 앞자리 선택" data-ng-model="form.tel1" data-ng-options="item.code as item.code for item in main.tel1" data-ng-init="form.tel1=main.tel1[0].code">
            </select>
            <input type="text" class="input_1" style="width:60px" data-ng-model="form.tel2" maxlength="4" required data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="input_1"  style="width:60px" data-ng-model="form.tel3" maxlength="4" required data-ng-pattern="/[0-9]{4}/"/>
          </td>
        </tr>
        <tr>
          <th>휴대폰번호</th>
          <td colspan="3">
          	<select title="휴대폰 앞자리 선택" data-ng-model="form.cell1" data-ng-options="item.code as item.code for item in main.cell1" data-ng-init="form.cell1=main.cell1[0].code">
            </select>
            <input type="text" class="input_1" style="width:60px" data-ng-model="form.cell2" maxlength="4" data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="input_1"  style="width:60px" data-ng-model="form.cell3" maxlength="4" data-ng-pattern="/[0-9]{4}/"/>
            <select title="수신여부 선택" data-ng-model="form.sms_yn" data-ng-init="form.sms_yn='Y'">
                 <option value="Y">수신</option>
                 <option value="N">수신안함</option>
            </select>
          </td>
        </tr>
        <tr>
          <th>이메일</th>
          <td colspan="3">
            <input type="text" class="input_1" data-ng-model="form.email1"/>@<input type="text" class="input_1" style="width:80px" data-ng-model="form.email2"/>
          	<select title="이메일선택" data-ng-model="form.email2" data-ng-options="item.code_nm as item.code_nm for item in main.email2">
          		<option value="">직접입력</option>
            </select>
            <select title="수신여부 선택" data-ng-model="form.email_yn" data-ng-init="form.email_yn='Y'">
                 <option value="Y">수신</option>
                 <option value="N">수신안함</option>
            </select>
          </td>
        </tr>
        <tr>
          <th>주소</th>
          <td colspan="3">
            <input type="text" class="input_1" style="width:80px" data-ng-model="form.zip1" required data-ng-pattern="/[0-9]{3}/"/>-<input type="text" class="input_1" style="width:80px" data-ng-model="form.zip2" data-ng-pattern="/[0-9]{3}/" required/>
            <span class="bt_alls"><span><input type="button" value="주소검색" class="btalls" data-ng-click="main.openAddr()"/></span></span> 
            <input type="text" class="input_1" style="width:85%; margin-top:3px;" data-ng-model="form.addr1" required/>
            <input type="text" class="input_1" style="width:85%; margin-top:3px;" data-ng-model="form.addr2"/>
          </td>
        </tr>
        <tr data-ng-if="form.member_type!='8'">
          <th>배송지 주소</th>
          <td colspan="3" style="padding-right:15px;">
            <table class="style_4" id="basongji_t">
              <tr>
                <th>선택</th>
                <th>주소</th>
                <th>배송지명</th>
                <th>수취인명</th>
                <th>수정</th>
              </tr>
              <tr data-ng-if="form.basongji.length==0"><td colspan="6">등록된 배송지 주소가 없습니다.</td></tr>
        	  <tr data-ng-repeat="item in form.basongji">
                <td><input type="checkbox" value="{{$index}}"/></td>
                <td>{{item.addr1}} {{item.addr2}}</td>
                <td data-ng-if="item.default_yn=='Y'">기본배송지</td>
                <td data-ng-if="item.default_yn!='Y'">{{item.receiver_nm}}</td>
                <td>{{item.receiver_title}}</td>
                <td><span class="bt_alls"><span><input type="button" value="수정" class="btalls"/></span></span></td>
              </tr>
            </table>
            <div style="margin-top:5px; text-align:right;">
              <span class="bt_alls"><span><input type="button" value="전체선택" class="btalls" data-ng-click="basongjiCheckAll()"/></span></span>
              <span class="bt_alls"><span><input type="button" value="선택삭제" class="btalls" data-ng-click="basongjiRemove()"/></span></span>
              <span class="bt_alls"><span><input type="button" value="선택취소" class="btalls" data-ng-click="basongjiCheckCancel()"/></span></span>
              <span class="bt_alls"><span><input type="button" value="선택 기본배송지등록" class="btalls" data-ng-click="basongjiDefault()"/></span></span>
              <span class="bt_alls"><span><input type="button" value="배송지추가" class="btalls" data-ng-click="basongjiOpen()"/></span></span>
            </div>
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