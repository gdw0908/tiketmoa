<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="main" data-ng-init="board.go(1)" data-ng-cloak>
  <div class="titlebar">
    <h2>사례보기</h2>
    <div> <span>통합관리</span> &gt; <span>시스템 관리</span> &gt; <span>카올바로</span> &gt;<span class="bar_tx">사례보기</span> </div>
  </div>
  <div class="container"> 
  <div class="tab_menu">
      <ul class="tab">
      	<li data-ng-class="{on:param.type_state=='1'}"><a data-ng-click="param.type_state = '1';board.go(1);">BEST</a></li>
      	<li data-ng-class="{on:param.type_state=='2'}"><a data-ng-click="param.type_state = '2';board.go(1);">수입차</a></li>
      	<li data-ng-class="{on:param.type_state=='3'}"><a data-ng-click="param.type_state = '3';board.go(1);">국산차</a></li>
      </ul>
    </div>
    <div class="contents">
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
          <col width="5%" />
          <col width="10%" />
          <col width="*" />
          <col width="10%" />
          <col width="10%" />
          <col width="8%" />
          <col width="8%" />
        </colgroup>
        <tr>
          <th>선택</th>
          <th>번호</th>
          <th>제조사</th>
          <th>제목</th>
          <th>사업소 수리비</th>
          <th>카올바로 수리비</th>
          <th>작성일</th>
          <th>작성자</th>
        </tr>
        <tr data-ng-if="board.list.length==0"><td colspan="8">결과가 없습니다.</td></tr>
        <tr data-ng-repeat="item in board.list">
          <td><input type="checkbox" value="{{item.seq}}"/></td>
          <td>{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
          <td>{{item.makernm}}</td>
          <td class="left"><a data-my-href="/modify/{{item.seq}}">{{item.title}}</a></td>
          <td>{{item.tow_time}} 원</td>
          <td>{{item.carinfo}} 원</td>
          <td>{{item.reg_dt|myDate:'yyyy/MM/dd'}}</td>
          <td>{{item.reg_nm}}</td>
        </tr>
      </table>
      <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
       <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span>
          <input type="button" value="등록" class="btall" data-my-href="/write"/>
          </span></span>
          <span class="bt_all"><span><input type="button" value="선택삭제" class="btall" data-ng-click="listDel()"/></span></span>
        </div>
      </div>
    </div>
  </div>
</div>