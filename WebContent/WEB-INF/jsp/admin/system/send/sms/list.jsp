<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="main" data-ng-init="board.go(1)" data-ng-cloak>
  <div class="titlebar">
    <h2>SMS전송</h2>
    <div> <span>통합관리</span> &gt; <span>시스템관리</span> &gt;<span>SMS/이메일 관리</span> &gt;<span class="bar_tx">SMS전송</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
    <form name="searchFrm" method="post" data-ng-submit="board.go(1)">
      <div class="btn_bottom">
        
      </div>
      <div class="btn_bottom">
        <div class="l_btn">
          <select title="건별보기 선택" data-ng-model="param.rows" data-ng-init="param.rows='10'" data-ng-change="board.go(1)">
            <option value="10">10건씩보기</option>
            <option value="15">15건씩보기</option>
            <option value="20">20건씩보기</option>
          </select> 
        </div>
        <div class="r_btn"  style="margin-top: 5px;">
          <span class="board_listing">총 <span>{{board.totalCount|number}}</span> 건</span>
          <select data-ng-model="param.yy">
          	<option data-ng-repeat="(k,v) in param.Year" value="{{v}}" ng-selected="param.yy == v">{{v}}년</option>
          </select>
          <select data-ng-model="param.mm" data-ng-init="param.mm = param.mm">
          	<option value="01">1월</option>
          	<option value="02">2월</option>
          	<option value="03">3월</option>
          	<option value="04">4월</option>
          	<option value="05">5월</option>
          	<option value="06">6월</option>
          	<option value="07">7월</option>
          	<option value="08">8월</option>
          	<option value="09">9월</option>
          	<option value="10">10월</option>
          	<option value="11">11월</option>
          	<option value="12">12월</option>
          </select>
          <a data-ng-click="search();"><img src="/images/admin/contents/s_btn_search.gif" alt="검색"/></a>
        </div>
      </div>
    </form>
      <table class="style_3">
        <colgroup>
          <col width="8%" />
          <col width="8%" />
          <col width="8%" />
          <col width="8%" />
          <col width="*" />
          <col width="5%" />
          <col width="10%" />
          <col width="10%" />
          <col width="5%" />
        </colgroup>
        <tr>
          <th>번호</th>
          <th>전송일자</th>
          <th>받을전화번호</th>
          <th>보낸전화번호</th>
          <th>내용</th>
          <th>통신사</th>
          <th>전송상태</th>
          <th>전송결과</th>
          <th>전송타입</th>
        </tr>
        <tr data-ng-if="board.list.length==0"><td colspan="9">결과가 없습니다.</td></tr>
        <tr data-ng-repeat="item in board.list">
          <td>{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
          <td>{{item.tran_date}}</td>
          <td>{{item.tran_phone}}</td>
          <td>{{item.tran_callback}}</td>
          <td class="left">{{item.tran_msg}}</td>
          <td>{{item.tran_net}}</td>
          <td>{{item.tran_status}}</td>
          <td>{{item.tran_rslt}}</td>
          <td>{{item.tran_type}}</td>
        </tr>
      </table>
      <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
       <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span>
          <input type="button" value="등록" class="btall" data-my-href="/write"/>
          </span></span> 
        </div>
      </div>
    </div>
  </div>
</div>