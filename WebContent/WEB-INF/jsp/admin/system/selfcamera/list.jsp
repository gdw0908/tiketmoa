<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="main" data-ng-init="board.go(1)" data-ng-cloak>
  <div class="titlebar">
    <h2>셀카관리</h2>
    <div> <span>통합관리</span> &gt; <span>자원/셀카 관리</span> &gt;<span class="bar_tx">셀카관리</span> </div>
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
          <tr>
            <th>조건선택</th>
            <td colspan="3">
              <select data-ng-model="param.state">
              	<option value="">전체</option>
              	<option value="0">등록</option>
              	<option value="1">검토중</option>
              	<option value="2">반려</option>
              	<option value="3">구매완료</option>
              	<option value="4">삭제</option>
              </select>
              </td>
          </tr>
          <tr>
          <th>업체선택</th>
          <td colspan="3">
          	<select data-ng-model="param.com_seq" data-ng-options="item.seq as item.com_nm for item in comList" >
                <option value="">전체</option>
          	</select>
          </td>
          </tr>
          </c:if>
        </tbody>
      </table>
    
    
    <form name="searchFrm" method="post" data-ng-submit="board.go(1)">
      <div class="btn_bottom">
        <div class="r_btn">
          <select title="공지사항 검색조건 선택" data-ng-model="param.condition" data-ng-init="param.condition='title'">
            <option value="title">제목</option>
            <option value="reg_nm">작성자</option>
          </select> 
          <input type="text" class="input_1" data-ng-model="param.keyword"/>
          <span><a data-ng-click="board.go(1)"><img src="/images/admin/contents/s_btn_search.gif" alt="검색" /></a></span>
        </div>
      </div>
      <div class="btn_bottom">
        <div class="l_btn">
          <select title="건별보기 선택" data-ng-model="param.rows" data-ng-change="board.go(1)" data-ng-init="param.rows = '10'">
            <option value="10">10건씩보기</option>
            <option value="15">15건씩보기</option>
            <option value="20">20건씩보기</option>
          </select> 
        </div>
        <div class="r_btn"  style="margin-top: 5px;">
          <span class="board_listing">총 <span>{{board.totalCount|number}}</span> 건</span>
        </div>
      </div>
    </form>
      <table class="style_3" id="boardList">
        <colgroup>
          <col width="5%" />
          <col width="15%" />
          <col width="*" />
          <col width="15%" />
          <col width="10%" />
          <col width="10%" />
          <col width="10%" />
        </colgroup>
        <tr>
          <th>번호</th>
          <th>업체명</th>
          <th>주소</th>
          <th>전화번호</th>
          <th>작성일</th>
          <th>상태</th>
          <th>수정</th>
        </tr>
        <tr data-ng-if="board.list.length==0"><td colspan="10">결과가 없습니다.</td></tr>
        <tr data-ng-repeat="item in board.list">
          <td>{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
          <td>{{item.com_nm}}</td>
          <td>{{item.dong_nm}}</td>
          <td>{{item.staff_tel}}</td>
          <td>{{item.reg_dt|myDate:'yyyy/MM/dd'}}</td>
          <td>
          	{{item.state == '0' ? '등록' : item.state == '1' ? '검토중' : item.state == '2' ? '반려' : item.state == '3' ? '구매완료' : '삭제' }}          
          </td>
          <td>
          	<span class="bt_alls"><span><a data-my-href="/modify/{{item.seq}}"><input type="button" value="수정" class="btalls"></a></span></span>
          </td>
        </tr>
      </table>
      <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
       <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span>
          <input type="button" value="등록" class="btall" data-my-href="/write/{{param.group_seq}}"/>
          </span></span>
          <span class="bt_all"><span><input type="button" value="선택삭제" class="btall" data-ng-click="listDel()"/></span></span>
        </div>
      </div>
    </div>
  </div>
</div>