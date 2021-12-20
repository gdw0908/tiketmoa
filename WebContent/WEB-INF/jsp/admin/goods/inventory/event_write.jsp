<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="main">
  <div class="titlebar">
    <h2>이벤트관리</h2>
    <div> <span>통합관리</span> &gt; <span>상품관리</span> &gt; <span>상품목록</span> &gt;<span class="bar_tx">이벤트 관리</span> </div>
  </div>
  <div class="container"> 
    <!-- <div class="tab_menu">
      <ul class="tab">
        <li><a href="#">이달의 우수상점</a></li>
        <li class="on"><a href="#">상점소개</a></li>
      </ul>
    </div>  -->
    <div class="contents">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate">
      <table class="style_1">
        <colgroup>
        <col width="10%" />
        <col width="*" />
        </colgroup>
        <tr>
          <th>이벤트명</th>
          <td>
            <input type="text" class="input_1" style="width:90%" data-ng-model="form.title" required/>
          </td>
        </tr>
        <tr>
        	<th>타입</th>
        	<td>
        		<select data-ng-model="form.event_type" data-ng-init="form.event_type == 'E'">
        			<option value="E">이벤트</option>
        			<option value="T">튜닝</option>
        			<option value="B">배터리</option>
        			<option value="R">타이어</option>
        			<option value="A">수입차 부품 스페셜</option>
        		</select>
        	</td>
        </tr>
        <tr>
          <th>이벤트기간</th>
          <td>
            <input type="text" class="input_1 date" data-ng-model="form.sdate" datepicker required/> ~ <input type="text" class="input_1 date" data-ng-model="form.edate" datepicker required/>
          </td>
        </tr>
        <tr>
          <th>참여제품</th>
          <td style="padding-right:15px;">
                <div>
                  <span class="bt_alls"><span><input type="button" value="참여제품선택추가" data-ng-click="itemSearch();" class="btalls"/></span></span>
                  <span class="bt_alls"><span><input type="button" value="전체선택" data-ng-click="saleAllSelect()" class="btalls"/></span></span> 
                  <span class="bt_alls"><span><input type="button" value="선택삭제" data-ng-click="saleItemDelete();" class="btalls"/></span></span> 
                  <span class="bt_alls"><span><input type="button" value="선택취소" data-ng-click="saleNotSelect()" class="btalls"/></span></span> 
                  <!-- <span class="bt_alls"><span><input type="button" value="수수료일괄적용" data-ng-click="salePriceAll();" class="btalls"/></span></span> -->
                </div>
                <table class="style_4" id="sale_itemList">
                    <colgroup>
                    <col width="5%" />
                    <col width="10%" />
                    <col width="10%" />
                    <col width="*" />
                    <col width="10%" />
                    <col width="10%" />
                    </colgroup>
                    <tr>
                      <th>선택</th>
                      <th>제품코드</th>
                      <th>업체명</th>
                      <th>제품명</th>
                      <th>재고</th>
                      <th>판매상태</th>
                    </tr>
                    <tr data-ng-repeat="item in form.items">
                      <td><input type="checkbox" value="{{$index}}"/>
                      </td>
                      <td>{{item.item_code}}</td>
                      <td>{{item.com_nm}}</td>
                      <td>{{item.productnm}}</td>
                      <td>{{item.stock_num}}</td>
                      <td>{{item.approval}}</td>
                    </tr>
                </table>
          </td>
        </tr>
        <tr>
          <th>이벤트내용</th>
          <td>
            <textarea style="width:100%;" id="conts" data-ng-model="form.conts" required smarteditor></textarea>
          </td>
        </tr>
      </table>
      
      <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span>
          <input type="button" value="등록" data-ng-click="save()" class="btall"/>
          </span></span> 
          <span class="bt_all"><span>
          <input type="button" value="취소" data-ng-click="list()" class="btall"/>
          </span></span> 
        </div>
      </div>
      <!-- 부품 검색모달팝업 -->
       </form>
    </div>
  </div>
</div>