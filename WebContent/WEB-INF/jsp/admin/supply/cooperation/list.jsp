<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="main" data-ng-init="board.go(param.cpage)">
  <div class="titlebar">
    <h2>협력업체신청</h2>
    <div> <span>통합관리</span> &gt; <span>협력업체관리</span> &gt; <span>협력업체신청</span> &gt;<span class="bar_tx">협력업체신청</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
      <c:if test="${sessionScope.member.group_seq eq '1' }">
      <table class="style_1">
        <colgroup>
          <col width="15%" />
          <col width="*" />
        </colgroup>
        <tr>
          <th>공통 사용자 수수료 적용</th>
          <td>
            <input type="text" class="input_1" style="width:80px" data-ng-model="param.user_commission" data-ng-pattern="/^[0-9\.]+$/"/>%
            <span class="bt_alls"><span><input type="button" value="적용" class="btalls" data-ng-click="updateUserCommission()"/></span></span>
          </td>
        </tr>
        <tr>
          <th>공통 판매자 수수료 적용</th>
          <td>
            <input type="text" class="input_1" style="width:80px" data-ng-model="param.com_commission" data-ng-pattern="/^[0-9\.]+$/"/>%
            <span class="bt_alls"><span><input type="button" value="적용" class="btalls" data-ng-click="updateComCommission()"/></span></span>
          </td>
        </tr>
      </table>
      </c:if>
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
          <col width="13%" />
          <col width="*" />
          <col width="6%" />
          <col width="10%" />
          <col width="10%" />
          <col width="8%" />
          <col width="8%" />
        </colgroup>
        <tr>
          <th>번호</th>
          <th>관리번호</th>
          <th>업체명</th>
          <th>ID</th>
          <th>대표자</th>
          <th>등록날짜</th>
          <th>상태</th>
          <th>수정</th>
          <th>삭제</th>
        </tr>
        <tr data-ng-if="board.list.length==0"><td colspan="9">결과가 없습니다.</td></tr>
        <tr data-ng-repeat="item in board.list">
          <td>{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
          <td>
            {{item.manage_no}}
           
          </td>
          <td>{{item.com_nm}}</td>
          <td>
            <ul>
              <li data-ng-repeat="mitem in item.member_id.split(',')">{{mitem}} <span class="bt_alls"><span><input type="button" value="로그인" class="btalls" data-ng-click="login(mitem)"/></span></span> </li>
            </ul>
          </td>
          <td>{{item.ceo_nm}}</td>
          <td>{{item.reg_dt|myDate:'yyyy/MM/dd'}}</td>
          <td>
            <select data-ng-model="item.status" data-ng-change="changeStatus(item)">
              <option value="1">정상</option>
              <option value="2">중지</option>
              <option value="3">퇴점</option>
            </select>
          </td>

          <td>
            <span class="bt_alls"><span><input type="button" value="수정" class="btalls" data-my-href="/modify/{{item.seq}}"/></span></span> 
          </td>
          <td>
          	<c:if test = "${sessionScope.member.group_seq eq '1'}">
            <span class="bt_alls"><span><input type="button" value="삭제" class="btalls" data-ng-click="del(item)"/></span></span>
            </c:if> 
          </td>
        </tr>
      </table>
      <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
      <c:if test = "${sessionScope.member.group_seq eq '1'}">
      <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span>
          <input type="button" value="등록" class="btall" data-my-href="/write"/>
          </span></span> 
        </div>
      </div>
      </c:if>
    </div>
  </div>
</div>