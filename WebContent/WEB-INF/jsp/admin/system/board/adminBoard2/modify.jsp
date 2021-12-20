<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="main">
  <div class="titlebar">
    <h2>관리자 게시판</h2>
    <div> <span>통합관리</span> &gt; <span>회원사 공지 게시판</span> &gt; <span class="bar_tx">수정</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate">
      <table class="style_1">
        <colgroup>
          <col width="15%" />
          <col width="*" />
        </colgroup>
        <tr>
          <th>작성자</th>
          <td>{{form.reg_nm }}</td>
        </tr>
        <tr>
          <th>제목</th>
          <c:if test="${sessionScope.member.group_seq eq '1' }"><td><input type="text" class="input_1" style="width:90%" data-ng-model="form.title" required/></td></c:if>
          <c:if test="${sessionScope.member.group_seq ne '1' }"><td ng-bind-html="bindHTML(form.title)"></td></c:if>
        </tr>
        <!-- <tr>
          <th>부품카테고리</th>
          <td>
            <select data-ng-model="form.upcodeno" data-ng-options="item.codeno as item.codenm for item in main.group" data-ng-change="changeSubcode()" required>
            	<option value="">== 선택 ==</option>
            </select>
            <select data-ng-model="form.codeno" data-ng-options="item.codeno as item.codenm for item in subcode" required>
                 <option value="">===== 선택 =====</option>
            </select>
          </td>
        </tr>
        <tr>
          <th>공개설정</th>
          <td>
          	<input type="radio" class="input_1" data-ng-model="form.status" value="1" /> 전체공개 
          	<input type="radio" class="input_1" data-ng-model="form.status" value="3" /> 협력사공개
          	<input type="radio" class="input_1" data-ng-model="form.status" value="2" /> 비공개
          </td>
        </tr>
        <tr>
          <th>연락처</th>
          <td>
          	{{form.charge_tel}}
          </td>
        </tr> -->
        <tr>
          <th>내용</th>
          <c:if test="${sessionScope.member.group_seq eq '1' }"><td><textarea style="width:100%;" id="conts" data-ng-model="form.conts" required smarteditor></textarea></td></c:if>
          <c:if test="${sessionScope.member.group_seq ne '1' }"><td ng-bind-html="bindHTML(form.conts)"></td></c:if>
        </tr>
        <tr>
        <c:if test="${sessionScope.member.group_seq eq '1' }">
          <th rowspan="2">첨부파일 </th>
          <td><input type="file" name="file" id="file" onchange="angular.element(this).scope().uploadFile()"/></td>
        </tr>
        <tr> 
          <td class="tddiv" id="attach_div">
	          <div data-ng-repeat="item in form.files">
	          	<p style="margin-top: 3px;"><a data-ng-href="/download.do?uuid={{item.uuid}}">{{item.attach_nm}}</a> <a data-ng-click="removeFile($index)"><img src="/images/admin/contents/s_btn_1.gif" alt="삭제" /></a></p>
	          </div>
	      </td>
	    </c:if>
	    <c:if test="${sessionScope.member.group_seq ne '1' }">
          <th>첨부파일 </th>
          <td class="tddiv" id="attach_div">
	          <div data-ng-repeat="item in form.files">
	          	<p style="margin-top: 3px;"><a data-ng-href="/download.do?uuid={{item.uuid}}">{{item.attach_nm}}</a></p>
	          </div>
	      </td>
        </c:if>
        </tr>
      </table>
	  <div class="btn_bottom">
        <div class="r_btn">
        	<c:if test="${sessionScope.member.group_seq eq '1' }">
          <span class="bt_all"><span><input type="button" value="등록" class="btall" data-ng-click="save()"/></span></span>
          <span class="bt_all"><span><input type="button" value="삭제" class="btall" data-ng-click="del()"/></span></span>
          	</c:if> 
          <span class="bt_all"><span><input type="button" value="목록" class="btall" data-ng-click="list()"/></span></span>
          <!-- <span class="bt_all"><span><input type="button" value="답변완료 문자발송" class="btall" data-ng-click="mms(form)"/></span></span> -->
        </div>
      </div>
	</form>  



      <!-- 답글 리스트  -->
      <div class="commentbox">
        <div class="commentlist">
          
          
		  <ul>
		  	<li data-ng-if="comment.length == 0"></li>
            <li data-ng-repeat="item in comment" data-ng-class="{next : item.lvl != '0'}">
              <div>{{item.reg_id}} <span class="comment_date">{{item.reg_dt}}</span>
                  <span><a href="" data-ng-click="commentReplyOpen(item.comment_seq)"><img src="/images/admin/contents/comm_btn_1.gif" alt="답글"/></a></span>
                  <span><a href="" data-ng-click="commentReplyClose(item.comment_seq)"><img src="/images/admin/contents/comm_btn_2.gif" alt="취소" /></a></span>
                  <span data-ng-if="item.reg_id == '${sessionScope.member.member_id }' || '1' == '${sessionScope.member.group_seq }'"><a href="" data-ng-click="commentDel(item.comment_seq)"><img src="/images/admin/contents/comm_btn_3.gif" alt="삭제" /></a></span>
                  <span data-ng-if="item.reg_id == '${sessionScope.member.member_id }' || '1' == '${sessionScope.member.group_seq }'"><a href="" data-ng-click="commentUpdateWindow(item.comment_seq)"><img src="/images/admin/contents/comm_btn_4.gif" alt="수정" /></a></span>
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
