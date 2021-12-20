<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="main" data-ng-init="board.go(param.cpage)" >
  <div class="titlebar">
    <h2>부품목록</h2>
    <div> <span>통합관리</span> &gt; <span>상품관리</span> &gt; <span>상품등록</span> &gt;<span class="bar_tx">부품목록</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
      	<form name="searchFrm" method="post" data-ng-submit="board.go(1)">
		<table class="style_1" style="table-layout: fixed;">
          <colgroup>
          <col width="10%" />
          <col width="*" />
          <col width="10%" />
          <col width="*" />
          </colgroup>
        <tr>
          <th>상세검색</th>
          <td colspan="3"><div> <span>
              <label><span style="font-weight:bold; padding-right:5px;">부품명</span>
                <input type="text" class="input_1" data-ng-model="param.part3_nm" readonly="readonly"/>
              </label>
              <span><a data-ng-click="openPartSearch()"><img src="/images/admin/contents/s_btn_search.gif" alt="검색" /></a></span> </span> 
              <!-- 부품명 초기화  -->
              <span><a data-ng-click="resetPartSearch()"><img src="/images/admin/contents/invent_03.gif" alt="초기화" /></a></span>
              <c:if test="${sessionScope.member.group_seq eq '1' || sessionScope.member.member_id eq 'insun'}">
              <span style="margin-left:50px;">
              <label><span style="font-weight:bold; padding-right:5px;">매장명</span>
                <input type="text" class="input_1" data-ng-model="param.com_nm" readonly="readonly"/>
              </label>
              <span><a data-ng-click="openCooperationSearch()"><img src="/images/admin/contents/s_btn_search.gif" alt="검색" /></a></span> </span>
              <!-- 추가 매장명 초기화 -->
	          <span><a data-ng-click="param.com_seq='';param.com_nm=''"><img src="/images/admin/contents/invent_03.gif" alt="초기화" /></a></span>
              
              <span style="margin-left:50px;">
              <label><span style="font-weight:bold; padding-right:5px;">비검색 매장명</span>
                <input type="text" class="input_1" data-ng-model="param.not_com_nm" readonly="readonly"/>
              </label>
              <span><a data-ng-click="openCooperationNotSearch()"><img src="/images/admin/contents/s_btn_search.gif" alt="검색" /></a></span> </span>
              <!-- 추가 매장명 초기화 -->
	          <span><a data-ng-click="param.not_com_seq='';param.not_com_nm=''"><img src="/images/admin/contents/invent_03.gif" alt="초기화" /></a></span>
              </c:if>
              </div>
            <div class="seldiv" style="margin-top:20px;">
                <select title="국산/수입선택" data-ng-model="param.nation" data-ng-change="changeNation()" data-ng-init="changeNation()">
	          		<option value="">국산/수입</option>
	          		<option value="Y">국산</option>
	          		<option value="N">수입</option>
	            </select>
                <select title="제조사선택" data-ng-model="param.carmakerseq" data-ng-options="item.carmakerseq as item.makernm for item in carmaker" data-ng-change="changeCarmaker()">
	          		<option value="">제조사</option>
	            </select>
	          	<select title="차량명선택" data-ng-model="param.carmodelseq" data-ng-options="item.carmodelseq as item.carmodelnm for item in carmodel" data-ng-change="changeCarmodel()">
	          		<option value="">차량명</option>
	            </select>
	          	<select title="모델명선택" data-ng-model="param.cargradeseq" data-ng-options="item.cargradeseq as item.cargradenm for item in cargrade">
	          		<option value="">모델명</option>
	            </select>
	          	<select title="연식선택" data-ng-model="param.caryyyy" data-ng-options="item as item for item in [1995, main.year()]|range:4">
	          		<option value="">연식</option>
	            </select>
	          	<select title="색상선택" data-ng-model="param.color" data-ng-options="item.code as item.code_nm for item in color">
	          		<option value="">색상</option>
	            </select>
	            <select title="등급선택" data-ng-model="param.grade" data-ng-options="item.code as item.code_nm for item in grade">
	          		<option value="">등급</option>
	            </select>
	          	<select title="부품분류선택" data-ng-model="param.part1" data-ng-options="item.code as item.code_nm for item in part1" data-ng-change="changePart1()">
	          		<option value="">부품분류</option>
	            </select>
	          	<select title="부품종류선택" data-ng-model="param.part2" data-ng-options="item.code as item.code_nm for item in part2" data-ng-change="changePart2()">
	          		<option value="">부품종류</option>
	            </select>
	          	<select title="부품선택" data-ng-model="param.part3" data-ng-options="item.code as item.code_nm for item in part3">
	          		<option value="">부품</option>
	            </select>
            </div></td>
        </tr>
        <tr>
          <th>기간조회</th>
          <td colspan="3">
            <div>
                <span class="bt_alls"><span><input type="button" value="어제" class="btalls" data-ng-click="search_yesterday()"/></span></span>
                <span class="bt_alls"><span><input type="button" value="오늘" class="btalls" data-ng-click="search_today()"/></span></span>
                <span class="bt_alls"><span><input type="button" value="일주" class="btalls" data-ng-click="search_week()"/></span></span>
                <span class="bt_alls"><span><input type="button" value="한달" class="btalls" data-ng-click="search_month()"/></span></span>
                <span class="bt_alls"><span><input type="button" value="당월" class="btalls" data-ng-click="search_cmonth()"/></span></span>
                <span class="bt_alls"><span><input type="button" value="전월" class="btalls" data-ng-click="search_bmonth()"/></span></span>
                <span class="bt_alls"><span><input type="button" value="전체" class="btalls" data-ng-click="search_all()"/></span></span>
            </div> 
            <div style="margin-top:10px;">
              <input type="text" class="input_1" data-ng-model="param.sdate" datepicker/> ~ <input type="text" class="input_1" data-ng-model="param.edate" datepicker/>
            </div>
          </td>
        </tr>
        <tr>
          <th>승인여부</th>
          <td>
          	<select title="승인여부 선택" data-ng-model="param.approval_yn">
          		<option value="">선택</option>
          		<option value="Y">승인</option>
          		<option value="N">미승인</option>
            </select>
          </td>
          <th>재고여부</th>
          <td>
          	<select title="재고여부 선택" data-ng-model="param.stock_yn">
          		<option value="">선택</option>
          		<option value="Y">있음</option>
          		<option value="N">없음</option>
            </select>
          </td>
        </tr>
        <tr>
          <th>사진여부</th>
          <td>
          	<select title="사진여부 선택" data-ng-model="param.picture_yn">
          		<option value="">선택</option>
          		<option value="Y">있음</option>
          		<option value="N">없음</option>
            </select>
          </td>
          <th>가격등록유무</th>
          <td>
          	<select title="가격등록유무 선택" data-ng-model="param.acount_yn">
          		<option value="">선택</option>
          		<option value="Y">등록</option>
          		<option value="N">없음</option>
            </select>
          </td>
        </tr>
        <c:if test="${sessionScope.member.group_seq eq '1' || sessionScope.member.member_id eq 'insun'}">
        <tr>
          <th>상품ERP코드</th>
          <td>
            <input type="text" class="input_1" data-ng-model="param.erp_code"/>
          </td>
          <th>상품일련번호</th>
          <td>
            <input type="text" class="input_1" data-ng-model="param.item_code"/>
          </td>
        </tr>
        
        <tr>
          <th>공급사 공통할인율</th>
          <td colspan="3">
            <select title="공급사 공통할인율선택" data-ng-model="param.common_rate" data-ng-options="item+'' as item+' %' for item in [0, 100]|range" data-ng-init="param.common_rate='0'">
            </select>
            <span class="bt_alls"><span><input type="button" value="적용" class="btalls" data-ng-click="updateCommonRate()"/></span></span>
          </td>
        </tr>
        </c:if>
      </table>
      </form>
      
      <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all">
          	<span><input type="button" value="검색" class="btall" data-ng-click="board.go(1)"/></span>
          </span> 
        </div>
      </div>
      
      <div class="top_line" style="margin-top:20px;">
        <div class="select_box"> <span><b>{{board.totalCount|number}}</b> 건[{{board.currentPage}}/{{board.totalPage}}페이지]</span> </div>
      </div>
      
      <table class="style_3">
        <colgroup>
          <col width="4%" />
          <col width="4%" />
          <col width="8%" />
          <col width="8%" />
          <col width="8%" />
          <col width="*" />
          <col width="8%" />
          <col width="10%" />
          <col width="5%" />
          <col width="5%" />
          <col width="8%" />
          <col width="5%" />
          <col width="5%" />
          <col width="10%" />
        </colgroup>
        <tr>
          <th>
            <input type="checkbox" data-ng-model="board.chk_all" data-ng-change="chk_all_btn()"/>
          </th>
          <th>번호</th>
          <th>상품ERP코드</th>
          <th>상품일련번호</th>
          <th>상품사진</th>
          <th>상품명</th>
          <th>상품가격</th>
          <th>상품위치</th>
          <th>상품부위</th>
          <th>제조사</th>
          <th>등록일</th>
          <th>승인여부</th>
          <th>재고</th>
          <th>공급업체</th>
        </tr>
        <tr data-ng-if="board.list.length==0"><td colspan="14">결과가 없습니다.</td></tr>
        <tr data-ng-repeat="item in board.list" data-my-href="/modify/{{item.item_seq}}">
          <td onclick="event.cancelBubble = true">
            <input type="checkbox" data-ng-model="item.check" data-ng-true-value="Y" data-ng-false-value="N" data-ng-init="item.check='N'"/>
          </td>
          <td>{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
          <td>{{item.erp_code}}</td>
          <td onclick="event.cancelBubble = true">{{item.item_code}}</td>
          <td onclick="event.cancelBubble = true">
          	<a data-ng-click="imgPopupList(item)">
            <img data-ng-src="{{item.thumb}}" data-err-src="/images/common/no_image.gif" alt="{{item.attach_nm}}" style="width:100px;"/>
            </a>
          </td>
          <td>{{item.productnm}}</td>
          <td>{{item.user_price|number}} 원</td>
          <td>{{item.part_location}}<div data-ng-if="!!item.code_nm">색상 : {{item.code_nm}}</div></td>
          <td>{{item.part1_nm}}</td>
          <td>{{item.makernm}}</td>
          <td>{{item.reg_dt|myDate:'yyyy-MM-dd'}}</td>
          <td>{{item.approval_nm}}</td>
          <td>{{item.stock_num>0?item.stock_num+' 개':'재고없음'}}</td>
          <td>{{item.com_nm}}</td>
        </tr>
      </table>
      <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
      <div class="btn_bottom">
        <div class="r_btn">
<!--           <span class="bt_all"> -->
<!--           	<span><input type="button" value="엑셀일괄등록" class="btall" data-ng-click="excelUploadForm()"/></span> -->
<!--           </span>  -->
          <span class="bt_all">
          	<span><input type="button" value="등록" class="btall" data-my-href="/write"/></span>
          </span> 
          <span class="bt_all">
          	<span><input type="button" value="삭제" class="btall" data-ng-click="del()"/></span>
          </span> 
        </div>
      </div>
    </div>
  </div>
</div>