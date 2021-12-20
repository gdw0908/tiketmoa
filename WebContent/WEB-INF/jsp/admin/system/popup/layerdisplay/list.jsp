<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="main" data-ng-init="board.go(1)" data-ng-cloak>
   <div class="titlebar">
    <h2>메인화면관리</h2>
    <div> <span>통합관리</span> &gt; <span>팝업관리</span> &gt;<span class="bar_tx">레이어팝업관리</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
    <form name="searchFrm" method="post" data-ng-submit="board.go(1)">
      <div class="btn_bottom">
        <div class="r_btn">
          <select title="공지사항 검색조건 선택" data-ng-model="param.condition" data-ng-init="param.condition='title'">
            <option value="title">제목</option>
          </select> 
          <input type="text" class="input_1" data-ng-model="param.keyword"/>
          <span><a data-ng-click="board.go(1)"><img src="/images/admin/contents/s_btn_search.gif" alt="검색" /></a></span>
        </div>
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
        </div>
      </div>
    </form>
      <table class="style_3" id="boardList">
         <colgroup>
          <col width="5%" />
          <col width="5%" />
          <col width="*" />
          <col width="10%" />
          <col width="10%" />
          <col width="6%" />
          <col width="6%" />
        </colgroup>
        <tr>
          <th>선택</th>
          <th>번호</th>
          <th>제목</th>
          <th>시작일</th>
          <th>종료일</th>
          <th>사용여부</th>
          <th>삭제</th>
        </tr>
        <tr data-ng-if="board.list.length==0"><td colspan="7">결과가 없습니다.</td></tr>
        <tr data-ng-repeat="item in board.list">
          <td><input type="checkbox" value="{{item.popupzone_seq}}"/></td>
          <td>{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
          <td class="left"><a data-my-href="/modify/{{item.popupzone_seq}}"><img data-ng-src="{{item.file_path}}" alt="{{item.alt}}" style="width:125px;height:60px;"/>{{item.title}}</a></td>
          <td>{{item.start_dt|myDate:'yyyy/MM/dd'}}</td>
          <td>{{item.end_dt|myDate:'yyyy/MM/dd'}}</td>
          <td>{{item.use_yn == 'Y' ? '사용' : '미사용'}}</td>
          <td><span class="bt_alls"><span><input type="button" value="삭제" data-ng-click="Del(item.popupzone_seq)" class="btalls"/></span></span></td>
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