<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="main" data-ng-init="board.go(param.cpage)">
  <div class="titlebar">
    <h2>정비업체현황</h2>
    <div> <span>통합관리</span> &gt; <span>협력업체관리</span> &gt; <span>업체현황</span> &gt;<span class="bar_tx">정비업체현황</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
      <div class="btn_bottom">
      <form name="searchFrm" method="post" data-ng-submit="board.go(1)">
        <div class="r_btn">
          <select title="협력업체 검색조건 선택" data-ng-model="param.condition" data-ng-init="param.condition='com_nm'">
            <option value="ceo_nm">대표자</option>
            <option value="com_nm">업체명</option>
          </select> 
          <input type="text" class="input_1" data-ng-model="param.keyword"/>
          <span><a data-ng-click="board.go(1)"><img src="/images/admin/contents/s_btn_search.gif" alt="검색" /></a></span>
        </div>
      </form>
      </div>
      <table class="style_3">
        <colgroup>
          <col width="5%" />
          <col width="15%" />
          <col width="*%" />
          <col width="10%" />
          <col width="6%" />
          <col width="10%" />
          <col width="10%" />
          <col width="8%" />
          <col width="8%" />
        </colgroup>
        <tr>
          <th>번호</th>
          <th>관리번호</th>
          <th>주소</th>
          <th>정비업체명</th>
          <th>연관업체</th>
          <th>대표자</th>
          <th>등록날짜</th>
          <th>수정</th>
          <th>삭제</th>
        </tr>
        <tr data-ng-if="board.list.length==0"><td colspan="9">결과가 없습니다.</td></tr>
        <tr data-ng-repeat="item in board.list">
          <td>{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
          <td>
            {{item.manage_no}}
          </td>
          <td>{{item.addr1}} {{item.addr2}}</td>
          <td>
            {{item.com_nm}}
          </td>
          <td>
            {{item.repair_nm}}
          </td>
          <td>{{item.com_nm}}</td>
          <td>{{item.reg_dt|myDate:'yyyy/MM/dd'}}</td>
          <td>
            <span class="bt_alls"><span><input type="button" value="수정" class="btalls" data-my-href="/modify/{{item.seq}}"/></span></span> 
          </td>
          <td>
            <span class="bt_alls"><span><input type="button" value="삭제" class="btalls" data-ng-click="del(item)"/></span></span> 
          </td>
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