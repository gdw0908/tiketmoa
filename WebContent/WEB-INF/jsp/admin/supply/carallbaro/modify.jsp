<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="main">
  <div class="titlebar">
    <h2>카올바로지점신청</h2>
    <div> <span>통합관리</span> &gt; <span>협력업체관리</span> &gt; <span>업체신청</span> &gt;<span class="bar_tx">카올바로지점신청</span> </div>
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
        <tr data-ng-show="param.session_group_seq == '1'">
          <th>거래처종류</th>
          <td>
          	<select title="거래처종류 선택" data-ng-model="form.customer_category" data-ng-options="item.code as item.code_nm for item in main.customer_category" data-ng-init="form.customer_category=main.customer_category[0].code">
            </select>
          </td>
          <th>공급사 판매할인율</th>
          <td>
            <input <c:if test = "${sessionScope.member.group_seq ne '1'}">readonly</c:if> type="text" class="input_1" style="width:80px" data-ng-model="form.commission" data-ng-pattern="/^[0-9\.]+$/"/>%
          </td>
        </tr>
        <tr data-ng-show="param.session_group_seq == '1'">
          <th>사용자 수수료</th>
          <td>
            <input <c:if test = "${sessionScope.member.group_seq ne '1'}">readonly</c:if> type="text" class="input_1" style="width:80px" data-ng-model="form.user_commission" data-ng-pattern="/^[0-9\.]+$/"/>%
          </td>
          <th>공급사 수수료</th>
          <td>
            <input <c:if test = "${sessionScope.member.group_seq ne '1'}">readonly</c:if> type="text" class="input_1" style="width:80px" data-ng-model="form.com_commission" data-ng-pattern="/^[0-9\.]+$/"/>%
          </td>
        </tr>
        <tr>
          <th>업체명</th>
          <td>
              <input type="text" class="input_1" data-ng-model="form.com_nm" required/>
          </td>
          <th>사업자번호</th>
          <td>
            <input type="text" class="input_1" style="width:60px" data-ng-model="form.busi_no1" maxlength="3" required data-ng-pattern="/^[0-9]{3}$/"/> - <input type="text" class="input_1" style="width:60px" data-ng-model="form.busi_no2" maxlength="2" required data-ng-pattern="/^[0-9]{2}$/"/> - <input type="text" class="input_1" style="width:60px" data-ng-model="form.busi_no3" maxlength="5" required data-ng-pattern="/^[0-9]{5}$/"/>
          </td>
        </tr>
        <tr>
          <th>업태</th>
          <td>
             <input type="text" class="input_1" data-ng-model="form.comptyp2" required/>
          </td>
          <th>종목</th>
          <td>
            <input type="text" class="input_1" data-ng-model="form.comptyp1" required/>
          </td>
        </tr>
        <tr>
          <th>대표자명</th>
          <td><input type="text" class="input_1" data-ng-model="form.ceo_nm" required/></td>
          <th>전화번호</th>
          <td>
          	<select title="전화번호 앞자리 선택" data-ng-model="form.tel1" data-ng-options="item.code as item.code for item in main.tel1" data-ng-init="form.tel1=main.tel1[0].code">
            </select>
            <input type="text" class="input_1" style="width:60px" data-ng-model="form.tel2" maxlength="4" required data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="input_1"  style="width:60px" data-ng-model="form.tel3" maxlength="4" required data-ng-pattern="/[0-9]{4}/"/>
          </td>
        </tr>
        <tr>
          <th>담당자명</th>
          <td><input type="text" class="input_1" data-ng-model="form.staff_nm" required/></td>
          <th>담당자 전화번호</th>
          <td>
          	<select title="전화번호 앞자리 선택" data-ng-model="form.staff_tel1" data-ng-options="item.code as item.code for item in main.cell1" data-ng-init="form.staff_tel1=main.cell1[0].code">
            </select>
            <input type="text" class="input_1" style="width:60px" data-ng-model="form.staff_tel2" maxlength="4" required data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="input_1"  style="width:60px" data-ng-model="form.staff_tel3" maxlength="4" required data-ng-pattern="/[0-9]{4}/"/>
          </td>
        </tr>
        <tr>
          <th>담당자명2</th>
          <td><input type="text" class="input_1" data-ng-model="form.staff_nm2"/></td>
          <th>담당자2 전화번호</th>
          <td>
          	<select title="전화번호 앞자리 선택" data-ng-model="form.staff_tel2_1" data-ng-options="item.code as item.code for item in main.cell1" data-ng-init="form.staff_tel2_1=main.cell1[0].code">
            </select>
            <input type="text" class="input_1" style="width:60px" data-ng-model="form.staff_tel2_2" maxlength="4" data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="input_1"  style="width:60px" data-ng-model="form.staff_tel2_3" maxlength="4" data-ng-pattern="/[0-9]{4}/"/>
          </td>
        </tr>
        <tr>
          <th>SMS수신번호</th>
          <td colspan="3">
          	<select title="전화번호 앞자리 선택" data-ng-model="form.sms_tel1" data-ng-options="item.code as item.code for item in main.cell1" data-ng-init="form.sms_tel1=main.cell1[0].code">
            </select>
            <input type="text" class="input_1" style="width:60px" data-ng-model="form.sms_tel2" maxlength="4" data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="input_1"  style="width:60px" data-ng-model="form.sms_tel3" maxlength="4" data-ng-pattern="/[0-9]{4}/"/>
          </td>
        </tr>
        <tr>
          <th>담당자 이메일</th>
          <td>
           <input type="text" class="input_1" data-ng-model="form.staff_email1"/>@<input type="text" class="input_1" style="width:80px" data-ng-model="form.staff_email2"/>
           <select title="이메일선택" data-ng-model="form.staff_email2" data-ng-options="item.code_nm as item.code_nm for item in main.email2">
          	 <option value="">직접입력</option>
           </select>
          </td>
          <th>FAX 번호</th>
          <td>
          	<select title="fax 앞자리 선택" data-ng-model="form.fax1" data-ng-options="item.code as item.code for item in main.tel1" data-ng-init="form.fax1=main.tel1[0].code">
            </select>
            <input type="text" class="input_1" style="width:60px" data-ng-model="form.fax2" maxlength="4" required data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="input_1"  style="width:60px" data-ng-model="form.fax3" maxlength="4" required data-ng-pattern="/[0-9]{4}/"/>
          </td>
        </tr>
        <tr>
          <th>예금주</th>
          <td><input type="text" class="input_1" data-ng-model="form.holder"/></td>
          <th>거래은행</th>
          <td>
          	<select title="거래은행 선택" data-ng-model="form.bank" data-ng-options="item.code as item.code_nm for item in main.bank" data-ng-init="form.bank=main.bank[0].code">
          		<option value="">선택</option>
            </select>
          </td>
        </tr>
        <tr>
          <th>계좌번호</th>
          <td colspan="3"><input type="text" class="input_1" data-ng-model="form.acc_no" data-ng-pattern="/^[0-9]*$/"/> <span>(숫자만입력)</span></td>
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
          <td><input type="text" class="input_1" style="width:80px" data-ng-model="form.manage_no"/></td>
          <th>상태</th>
          <td>
            <select title="상점상태 변경 선택" data-ng-model="form.status" data-ng-init="form.status='1'">
              <option value="1">정상</option>
              <option value="2">중지</option>
              <option value="3">퇴점</option>
            </select>
          </td>
        </tr>
        <tr>
          <th>통신판매업신고번호</th>
          <td colspan="3"><input type="text" class="input_1" style="width:80px" data-ng-model="form.telesales_no" /></td>
        </tr>
        <c:if test = "${sessionScope.member.group_seq == 1}">
        <tr>
          <th>관리자로그인허용</th>
          <td>
          	<select title="관리자로그인허용" data-ng-model="form.login_yn">
              <option value="Y">허용</option>
              <option value="N">비허용</option>
            </select>
          </td>
          <th>카올바로 회원여부</th>
          <td>
          	<select title="카올바로회원" data-ng-model="form.carall">
              <option value="Y">카올바로 회원</option>
              <option value="N">카올바로 비회원</option>
            </select>
          </td>
        </tr>
        </c:if>
        <tr>
          <th>주소</th>
          <td colspan="3">
            <input type="text" class="input_1" style="width:80px" data-ng-model="form.zip1" maxlength="5" required data-ng-pattern="/[0-9]{5}/"/>-<input type="text" class="input_1" style="width:80px" data-ng-model="form.zip2" maxlength="3" data-ng-pattern="/[0-9]{3}/"/>
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
      
      <!-- 아이디 추가 --> 
      <div class="btn_bottom" data-ng-show="param.session_group_seq == '1'">
        <div class="r_btn">
          <span class="bt_alls"><span><input type="button" value="아이디추가" class="btalls" data-ng-click="memberAdd()"/></span></span> 
          <span class="bt_alls"><span><input type="button" value="선택삭제" class="btalls" data-ng-click="memberRemove()"/></span></span> 
          <span class="bt_alls"><span><input type="button" value="선택취소" class="btalls" data-ng-click="memberCancel()"/></span></span> 
        </div>
      </div>  
      <table id="member_t" class="style_1" style="margin-top:15px;" data-ng-show="param.session_group_seq == '1'">
         <colgroup>
        <col width="10%" />
        <col width="*" />
        </colgroup>
        <tr data-ng-repeat="item in form.memberList" data-ng-hide="item.seq=='-1'">
          <th class="center"><input type="checkbox" value="{{$index}}"/></th>
          <td style="padding-right:15px;">
            <table class="style_4" style="margin-top:0px;">
              <tr>
                <th>아이디</th>
                <td colspan="3" class="left" data-ng-if="item.seq=='0'">
                  <input type="text" class="input_1" data-ng-model="item.member_id" data-ng-minlength="4" data-ng-maxlength="16" data-ng-pattern="/^[A-Za-z0-9+]*$/" required/>
                  <span class="bt_alls">
                  	<span><input type="button" value="중복확인" class="btalls" data-ng-click="duplicateCheckMemberId($index)"/></span>
                  	<span data-ng-show="item.isDuplicateId===false">사용 가능한 아이디 입니다.</span>
                  	<span data-ng-show="item.isDuplicateId===true">사용 불가능한 아이디 입니다.</span>
                  </span>
                </td>
                <td colspan="3" class="left" data-ng-if="item.seq!='0'">
                  <input type="text" class="input_1" data-ng-model="item.member_id" readonly="readonly"/>
                </td>
              </tr>
              <tr>
                <th>비밀번호</th>
                <td class="left" data-ng-if="item.seq=='0'"><input type="password" class="input_1" data-ng-model="item.member_pw" data-ng-minlength="4" data-ng-maxlength="16" data-ng-pattern="/([a-zA-Z_]+[0-9]+[^a-zA-Z0-9_]*)|([a-zA-Z_]+[^a-zA-Z0-9_]+[0-9]*)|([0-9]+[a-zA-Z_]+[^a-zA-Z0-9_]*)|([0-9]+[^a-zA-Z0-9_]+[a-zA-Z_]*)|([^a-zA-Z0-9_]+[0-9]+[a-zA-Z_]*)|([^a-zA-Z0-9_]+[a-zA-Z_]+[0-9]*)/" required="required"/></td>
                <td class="left" data-ng-if="item.seq!='0'"><input type="password" class="input_1" data-ng-model="item.member_pw" data-ng-minlength="4" data-ng-maxlength="16" data-ng-pattern="/([a-zA-Z_]+[0-9]+[^a-zA-Z0-9_]*)|([a-zA-Z_]+[^a-zA-Z0-9_]+[0-9]*)|([0-9]+[a-zA-Z_]+[^a-zA-Z0-9_]*)|([0-9]+[^a-zA-Z0-9_]+[a-zA-Z_]*)|([^a-zA-Z0-9_]+[0-9]+[a-zA-Z_]*)|([^a-zA-Z0-9_]+[a-zA-Z_]+[0-9]*)/"/></td>
                <th>비밀번호확인</th>
                <td class="left"><input type="password" class="input_1" data-ng-model="item.member_pw_confirm"/></td>
              </tr>
            </table>
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