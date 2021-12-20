<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="main" data-ng-init="board.go(1)" data-ng-cloak>
  <div class="titlebar">
    <h2>이메일관리</h2>
    <div> <span>통합관리</span> &gt; <span>SMS/이메일관리</span> &gt;<span>이메일관리</span> &gt;<span class="bar_tx">이메일타겟</span> </div>
  </div>
  <div class="container">
    <div class="tab_menu">
      <ul class="tab">
        <li><a href="/admin/system/send/email/send/index.do">이메일전송</a></li>
        <li class="on"><a href="#/list">이메일타켓</a></li>
        <li><a href="/admin/system/send/email/template/index.do">이메일템플릿</a></li>
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
     </form>
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
      <table class="style_3">
        <colgroup>
          <col width="5%" />
          <col width="*" />
          <col width="12%" />
          <col width="10%" />
          <col width="10%" />
          <col width="6%" />
          <col width="6%" />
        </colgroup>
        <tr>
          <th>번호</th>
          <th>제목</th>
          <th>타겟방침</th>
          <th>대상인원</th>
          <th>등록일</th>
          <th>수정</th>
          <th>삭제</th>
        </tr>
        <tr data-ng-if="board.list.length==0"><td colspan="7">결과가 없습니다.</td></tr>
        <tr data-ng-repeat="item in board.list">
          <td>{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
          <td class="left">{{item.title}}</td>
          <td>{{item.target_cd == '1' ? '파일업로드' : item.target_cd == '2' ? '직접입력' : item.target_cd == '4' ? '대상선택' : '테스트'}}</td>
          <td>{{item.tg_cnt|num}}</td>
          <td>{{item.reg_dt}}</td>
          <td>
             <span class="bt_alls"><span><input type="button" value="수정" data-my-href="/modify/{{item.tg_seq}}" class="btalls"/></span></span>          
          </td>
          <td>
             <span class="bt_alls"><span><input type="button" value="삭제" data-ng-click="del(item.tg_seq)" class="btalls"/></span></span>
          </td>
        </tr>
      </table>
      <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
       <div class="btn_bottom">
        <div class="r_btn"> 
          <span class="bt_all"><span><input type="button" value="등록" data-ng-click="target_write()" class="btall"/></span></span>
        </div>
      </div>
      
    </div>
  </div>
</div>