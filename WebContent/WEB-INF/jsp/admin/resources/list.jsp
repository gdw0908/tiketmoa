<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="main" data-ng-init="board.go(1)" data-ng-cloak>
  <div class="titlebar">
    <h2>자원관리</h2>
    <div> <span>통합관리</span> &gt; <span>자원관리</span> &gt;<span class="bar_tx">자원관리리스트</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
    <table class="style_1">
        <colgroup>
        <col width="15%" />
        <col width="" />
        <col width="15%" />
        <col width="" />
        </colgroup>
        <tbody>
        <c:if test = "${sessionScope.member.group_seq eq '1' || sessionScope.member.group_seq eq '8'}">
          <tr>
            <th>시/도</th>
            <td>
            <select title="시도 선택" data-ng-model="param.sido_cd" data-ng-options="item.sido as item.dong_nm for item in sido" data-ng-change="changeSido()">
          	 <option value="">시도 선택</option>
           	</select>
           	</td>
            <th>시/군/구</th>
            <td>
            <select title="시군구 선택" data-ng-model="param.sigungu_cd" data-ng-options="item.sigungu as item.dong_nm for item in sigungu">
          	 <option value="">시군구 선택</option>
           	</select>
            </td>
          </tr>
          </c:if>
          <tr>
            <th>자원선택</th>
            <td colspan="3" class="label_type">
            <label data-ng-repeat="item in group.list"><input type="checkbox" data-ng-true-value="{{item.cate_seq}}" data-ng-false-value="" data-ng-model="param.cate_seq[$index]"/>{{item.subject}}</label>
            </td>
          </tr>
          <tr>
            <th>조건선택</th>
            <td colspan="3">
              <select data-ng-model="param.status">
              	<option value="">전체</option>
              	<option value="0">반출요청</option>
              	<option value="1">반출진행</option>
              	<option value="2">반출완료</option>
              </select>
              <span data-ng-if="param.status == '2'">
               <input type="text" class="input_1 date" data-ng-model="param.sdate" datepicker />
              ~
              <input type="text" class="input_1 date" data-ng-model="param.edate" datepicker />
              </span>
              </td>
          </tr>
          <c:if test = "${sessionScope.member.group_seq eq '1'}">
          <tr>
          <th>업체선택</th>
          <td colspan="3">
          	<select data-ng-model="param.keyword" data-ng-options="item.seq as item.com_nm for item in comList" >
                <option value="">전체</option>
          	</select>
          </td>
          </tr>
          </c:if>
        </tbody>
      </table>
      <div class="btn_bottom">
        <div class="r_btn"> <span class="bt_all"><span>
          <input type="button" value="검색" data-ng-click="board.go(1)" class="btall"/>
          </span></span> </div>
      </div>
    </form>
	<div class="resources_top">
      <ul>
      <li data-ng-repeat="item in group.list"><span class="res_{{item.orderby}}"></span>{{item.subject}}</li>
      </ul>
    </div> 
      <table class="style_3">
        <colgroup>
	      <col width="6%" />
	      <col width="" />
	      <col width="11%" />
	      <col width="15%" />
	      <col width="10%" />
	      <col width="10%" />
	      <col width="10%" />
	      <col width="8%" />
	      <col width="8%" />
	      <c:if test = "${sessionScope.member.group_seq eq '1' || sessionScope.member.group_seq ne '8'}">
	      <col width="8%" />
	      </c:if>
	      </colgroup>
	      
	      <thead>
	      <tr>
	      <th>번호</th>
	      <th>주소</th>
	      <th>업체명</th>
	      <th>폐자원현황</th>
	      <th>연락처</th>
	      <th>반출희망일자</th>
	      <th>반출완료일자</th> 
	      <th>상세보기</th>
	      <th>상태</th>
	      <th>수정</th>
	      </tr>
	      </thead>
        <tr data-ng-if="board.list.length==0"><td colspan="10">결과가 없습니다.</td></tr>
        <tr data-ng-repeat="item in board.list">
          <td>{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
          <td>{{item.dong_nm}}</td>
          <td>{{item.com_nm}}</td>
          <td bind-html-unsafe="resource_select(item.item_info)" style="text-align: left; padding-left: 5px;"></td>
          <td>{{item.staff_tel}}</td>
          <td>{{item.sdate|myDate:'yyyy-MM-dd'}}</td>
          <td>{{item.edate|myDate:'yyyy-MM-dd'}}</td>
          <td><span class="bt_alls"><span>
          <input type="button" value="상세보기" data-ng-click="resourceView($index)" class="btalls"/>
          </span></span></td>
          <td>{{item.status == '0' ? '반출요청' : item.status == '1' ? '반출진행' : '반출완료'}}</td>
          <td>
 	         <span class="bt_alls"><span>
          		<input type="button" value="수정" data-my-href="/modify/{{item.article_seq}}" class="btalls"/>
          	 </span></span>
          </td> 
        </tr>
      </table>
      <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
       <div class="btn_bottom">
        <div class="r_btn">
          <c:if test = "${sessionScope.member.group_seq ne '1'}">
          <span class="bt_all"><span><input type="button" value="등록" class="btall" data-my-href="/write"/></span></span>
          </c:if>
          <c:if test = "${sessionScope.member.group_seq eq '1'}">
          <span class="bt_all"><span><input type="button" value="자원등록"  class="btall" data-ng-click="resourceWrite()"/></span></span>
          <span class="bt_all"><span><input type="button" value="자원수정"  class="btall" data-ng-click="resourceModify()"/></span></span>
          <span class="bt_all"><span><input type="button" value="엑셀 다운로드" class="btall" data-ng-click="excelDown()"/></span></span>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</div>