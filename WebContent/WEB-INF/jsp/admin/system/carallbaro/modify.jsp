<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="main">
  <div class="titlebar">
    <h2>견적/즉시 신청</h2>
    <div> <span>통합관리</span> &gt; <span>시스템 관리</span> &gt; <span>카올바로</span> &gt;<span class="bar_tx">견적/즉시 신청</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate">
      <table class="style_1">
        <colgroup>
          <col width="16%" />
          <col width="16%" />
          <col width="16%" />
          <col width="16%" />
          <col width="16%" />
          <col width="*" />
        </colgroup>
        <tr>
        	<th>타입</th>
        	<td colspan="5">{{form.set_type == '0' ? '견적내기' : form.set_type == '1' ? '즉시신청' : '사례보기'}}</td>
        </tr>
        <!-- <tr>
			<th>제목</th>
			<td colspan="5">
				{{form.title}}
			</td>
        </tr> -->
        <tr>
        	<th>회원구분</th>
        	<td>
        		{{member_yn == 'Y' ? '회원' : '비회원'}}
        	</td>
        	<th>이름</th>
        	<td>
        		{{form.reg_nm}}
        	</td>
        	<th>전화번호</th>
        	<td>
        		{{form.tel}}
        	</td>
        </tr>
        <tr data-ng-if="form.set_type == '0'">
        	<th>견인요청</th>
        	<td>
        		<strong style="border:1px solid gray;width:18px;">{{form.insurance_yn == 'Y' ? '&nbsp;√&nbsp;' : '&nbsp;&nbsp;&nbsp;'}}</strong>
        	</td>
        	<th>렌터카</th>
        	<td>
        		<strong style="border:1px solid gray;width:18px;">{{form.rent_yn == 'Y' ? '&nbsp;√&nbsp;' : '&nbsp;&nbsp;&nbsp;'}}</strong>
        	</td>
        	<th>픽업요청</th>
        	<td> 
        		<strong style="border:1px solid gray;width:18px;">{{form.pickup_yn == 'Y' ? '&nbsp;√&nbsp;' : '&nbsp;&nbsp;&nbsp;'}}</strong>
        	</td>
        </tr>
        <tr data-ng-if="form.set_type == '1'">
        	<th>직접방문</th>
        	<td>
        		<strong style="border:1px solid gray;width:18px;">{{form.tow_type == '1' ? '&nbsp;√&nbsp;' : '&nbsp;&nbsp;&nbsp;'}}</strong>
        	</td>
        	<th>탁송요청</th>
        	<td>
        		<strong style="border:1px solid gray;width:18px;">{{form.tow_type == '2' ? '&nbsp;√&nbsp;' : '&nbsp;&nbsp;&nbsp;'}}</strong>
        	</td>
        	<th>대차</th>
        	<td> 
        		<strong style="border:1px solid gray;width:18px;">{{form.tow_type == '3' ? '&nbsp;√&nbsp;' : '&nbsp;&nbsp;&nbsp;'}}</strong>
        	</td>
        </tr>
        
        <tr>
        	<th>브랜드</th>
        	<td>{{form.makernm}}</td>
        	<th>차량명 / 연식</th>
        	<td>{{form.carinfo}}</td>
        	<th>지역</th>
        	<td colspan="3">
        		{{form.sido_nm}} {{form.sigungu_nm}}
        	</td>
        </tr>
        
        <tr data-ng-if="form.set_type == '1'">
        	<th>견인희망일</th>
        	<td>{{form.tow_date|myDate:'yyyy/MM/dd'}}</td>
        	<th>견인희망시간</th>
        	<td colspan="3">{{form.tow_time}}</td>
        </tr>
        <tr data-ng-if="form.set_type == '3'">
        	<th>예약일</th>
        	<td colspan="2">
        		<input type="text" class="input_1 date" data-ng-model="form.reserv_dt" datepicker required/>
        	</td>
        	<th>상태</th>
        	<td colspan="2">
        		<select data-ng-model="form.state">
        			<option value="0">예약요청</option>
        			<option value="1">예약완료</option>
        			<option value="2">완료</option>
        		</select>
        	</td>
        </tr>
        <tr>
          <th>내용</th>
          <td colspan="5" ng-bind-html="bindHTML(form.content)"></td>
        </tr>
        <tr>
          <th rowspan="2">첨부파일 </th>
          <td colspan="5">
          	<span data-ng-repeat="item in form.files">
				<a data-ng-href="/upload/board/{{item.yyyy}}/{{item.mm}}/{{item.uuid}}" target="_blank"><img src="/upload/board/{{item.yyyy}}/{{item.mm}}/{{item.uuid}}" style="width:100px;height:100px;"/></a>&nbsp;&nbsp;
			</span>
	      </td>
        </tr>
        <tr>
          <td colspan="5" class="tddiv" id="attach_div">
	          <div data-ng-repeat="item in form.files">
	          	<p style="margin-top: 3px;"><a data-ng-href="/download.do?uuid={{item.uuid}}">{{item.attach_nm}}</a></p>
	          </div>
	      </td>
        </tr>
      </table>
	  <div class="btn_bottom">
        <div class="r_btn">
          <!-- <span class="bt_all"><span><input type="button" value="수정" class="btall" data-ng-click="save()"/></span></span> -->
          <span class="bt_all"><span><input type="button" value="삭제" class="btall" data-ng-click="del()"/></span></span> 
          <span class="bt_all"><span><input type="button" value="목록" class="btall" data-ng-click="list()"/></span></span>
        </div>
      </div>
	</form>
	
	      <!-- 답글 리스트  -->
      <div class="commentbox">
        <div class="commentlist">
          
          
		  <ul>
		  	<li data-ng-if="comment.length == 0"></li>
            <li data-ng-repeat="item in comment" data-ng-class="{next : item.lvl != '0'}">
              <div>{{item.reg_nm}} <span class="comment_date">{{item.reg_dt}}</span>
                  <span><a href="" data-ng-click="commentReplyOpen(item.comment_seq)"><img src="/images/admin/contents/comm_btn_1.gif" alt="답글"/></a></span>
                  <span><a href="" data-ng-click="commentReplyClose(item.comment_seq)"><img src="/images/admin/contents/comm_btn_2.gif" alt="취소" /></a></span>
                  <span><a href="" data-ng-click="commentDel(item.comment_seq)"><img src="/images/admin/contents/comm_btn_3.gif" alt="삭제" /></a></span>
                  <span><a href="" data-ng-click="commentUpdateWindow(item.comment_seq)"><img src="/images/admin/contents/comm_btn_4.gif" alt="수정" /></a></span>
              </div>
              <div class="textcomment">
              <span data-ng-class="{textname : item.lvl != '0'}">{{item.reply_id != null ? '@'+item.reply_id : ''}}</span>
              <pre>{{item.conts}}</pre>
              </div>
              <ul class="comment_reply" id="c{{item.comment_seq}}" style="display:none">
              	<li class="next">
	                <div class="comment">
			           <p class="comment_text">
			             <textarea rows="" cols="" data-ng-model="cp.conts" id="cp{{item.comment_seq}}"></textarea>
			           </p>
			           <p class="comment_bt"><img src="/images/admin/contents/btn_comment.gif" alt="답글등록" style="cursor:pointer;" data-ng-click="commentReply(item.comment_seq);"/></p>
			        </div>
	            </li>
              </ul>
            </li>
          </ul>
          
          
        </div>
        
        
        <form id="cFrm" name="cfrm" method="post" novalidate="novalidate">
        <div class="comment ctfirst">
           <p class="comment_text">
             <textarea rows="" cols="" data-ng-model="cfrm.conts" required ></textarea>
           </p>
           <p class="comment_bt"><img src="/images/admin/contents/btn_comment.gif" alt="답글등록" style="cursor:pointer;" data-ng-click="commentSubmit();"/></p>
        </div>
        </form>
        
        
      </div> 
      <!-- 답글 리스트  end-->
	
	
	  
    </div>
  </div>
</div>
