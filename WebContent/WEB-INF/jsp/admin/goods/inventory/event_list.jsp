<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="main" data-ng-init="board.go(1)" data-ng-cloak>
  <div class="titlebar">
    <h2>이벤트관리</h2>
    <div> <span>통합관리</span> &gt; <span>상품관리</span> &gt; <span>상품목록</span> &gt;<span class="bar_tx">이벤트 관리</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
      <table class="style_1">
        <colgroup>
        <col width="10%" />
        <col width="*" />
        </colgroup>
        <tr>
          <th>이벤트 검색</th>
          <td><span>
              <label><span style="font-weight:bold; padding-right:5px;">이벤트명</span>
                <input type="text" class="input_1" data-ng-model="param.keyword" />
              </label>
              <span><a data-ng-click="board.go(1)"><img src="/images/admin/contents/s_btn_search.gif" alt="검색" /></a></span> </span>
          </td>
        </tr>
      </table>
      <div class="top_line" style="margin-top:20px;">
        <div class="search_box">
          <select title="보기 선택" data-ng-model="param.status" data-ng-init="param.status=''" data-ng-change="board.go(1)">
            <option value="">전체</option>
            <option value="ing">진행</option>
            <option value="end">중지</option>
          </select>
        </div>
        <div class="select_box"> <span><b>{{board.totalCount|number}}</b> 건[{{board.currentPage}}/{{board.totalPage}}페이지]</span> </div>
      </div>
      <table class="style_3" style="table-layout: fixed;">
        <colgroup>
        <col width="7%" />
        <col width="*" />
        <col width="7%" />
        <col width="7%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="13%" />
        <col width="7%" />
        <col width="7%" />
        </colgroup>
        <tr>
          <th>번호</th>
          <th>이벤트명</th>
          <th>이벤트타입</th>
          <th>상태</th>          
          <th>시작일시</th>
          <th>종료일시</th>
          <th>참여제품수량</th>
          <th>링크주소</th>
          <th>수정</th>
          <th>삭제</th>
        </tr>
        <tr data-ng-if="board.list.length==0"><td colspan="9">결과가 없습니다.</td></tr>
        <tr data-ng-repeat="item in board.list">
          <td>{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
          <td class="left">{{item.title}}</td>
          <td>{{item.event_type == 'E' ? '이벤트' : item.event_type == 'T' ? '튜닝' : item.event_type == 'B' ? '배터리' : item.event_type == 'A' ? '수입차 부품 스페셜' : '타이어'}}</td>
          <td>{{item.event_type == 'E' ? item.status : ''}}</td>          
          <td>{{item.sdate}}</td>
          <td>{{item.edate}}</td>
          <td>{{item.icnt == null ? 0 : item.icnt}}</td>
          <td><a href="/event.do?seq={{item.seq}}" target="_blank">/event.do?seq={{item.seq}}</a></td>
          <td>
             <span class="bt_alls"><span><input type="button" value="수정" data-my-href="/modify/{{item.seq}}" class="btalls"/></span></span>          
          </td>
          <td>
             <span class="bt_alls"><span><input type="button" value="삭제" data-ng-click="del(item.seq)" class="btalls"/></span></span>
          </td>
        </tr>
       </table>
      <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
      <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span>
          <input type="button" value="등록" data-my-href="/write" class="btall"/>
          </span></span> 
        </div>
      </div>
    </div>
  </div>
</div>