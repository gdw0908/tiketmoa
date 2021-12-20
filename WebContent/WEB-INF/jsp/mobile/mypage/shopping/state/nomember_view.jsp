<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="com.mc.common.util.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>

<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/lib/js/jquery.lck.util.js"></script>
<script type="text/javascript">
$(document).ready(function(){
//#allmenu
$("#submenu_open").toggle(function(){
$("#sub_menu").slideToggle(250);
this.src = "/images/mobile/sub/sub_menu_close.gif";
}, function() {
$("#sub_menu").slideToggle(250);
this.src = "/images/mobile/sub/sub_menu_open.gif";
});

});

function refunds_popup(cart_no){
	
	location.replace("/mobile/mypage/shopping/state/index.do?mode=m_refunds&cart_no=" + cart_no);
	return;
}

function cancel_popup(cart_no){

	jQuery("#cart_no").val(cart_no);
	jQuery("#recFrm").submit();
	return;
}

function return_popup(cart_no){
	location.replace("/mobile/mypage/shopping/state/index.do?mode=m_return&cart_no=" + cart_no);
	return;

}

function exchange_popup(cart_no){
	location.replace("/mobile/mypage/shopping/state/index.do?mode=m_exchange&cart_no=" + cart_no);
	return;
}

function track(cart_no){
	window.open("/popup/mypage/shopping/state/index.do?mode=track&cart_no="+cart_no,"delivery","width=1000,height=750, scrollbars=yes, resizable=yes"); 
}
</script>
<div class="wrap">
      <div class="sub_wrap">

        <div class="sub_2_line line_2">
          <h3><img src="/images/mobile/sub_2/no_mem_title.gif" alt="비회원 주문/배송조회"></h3>
        </div>

        <div class="no_mem_visual">
          <strong class="c1">비회원으로 주문하신 내용은 다음과 같습니다.</strong>  주문/배송조회 이외의 서비스는 회원가입 후 이용이 가능합니다.<br>
          <strong class="c1">반품/환불 및 교환은 판매자와 협의 후 진행 하시기 바랍니다.</strong> <strong>(기타 문의사항은 파츠모아쇼핑몰 고객센터로 전화주시기 바랍니다)</strong>
        </div>

        <h5 class="pay_type">상품정보</h5>

        <div class="sub_list">

          <ul>
			<c:forEach var="item" items="${data.list }" varStatus="status">
	          <c:set var="user_price" value="${user_price + (item.user_price * item.qty) }"/>
	          <c:set var="discount_price" value="${discount_price + ((item.user_price * item.qty) - (item.sale_price * item.qty)) }"/>
	            <li>
	
	            <div>
	
	              <span class="img_box">
	              <span class="img_b1"><a href="#"><img src="${item.thumb }" alt=""></a></span>
	              
	              </span>
	
	              <a href="#">
	
	              <span class="info">
	
	              <span class="order_num" orderno="${item.orderno }"><strong>주문번호 : ${data.resultInfo.orderno }</strong></span>
	
	              <span class="in_t1">
	              <span class="first"><strong>${item.cargradenm } (${item.caryyyy })</strong></span>
	              <c:if test="${item.discount_rate > 0}">
                  <span class="f_style_1">${item.discount_rate }%↓</span>
                  </c:if>
	              <span><strong>컴비네이션램프 후미등</strong></span>
	              <span><strong>A등급</strong></span>
	              </span>
	
	              <span><strong>${item.com_nm }</strong> / ${item.sigungu_nm }</span>
	              <span><strong>주문일 :</strong> ${dtf:simpleDateFormat(data.resultInfo.orderdate, 'yyyy-MM-dd HH:mm:ss' , 'yyyy-MM-dd') }</span>
	              <span><strong>주문상태 : </strong><b class="c1">${item.status_nm }</b></span>
	              <span><strong>주문수량 : ${item.qty } 개</strong></span>
	              <span><strong>합계 : <b class="c2">${suf:getThousand(item.amt) }</b> 원</strong></span>
	               <c:if test="${item.status eq '1' }"> 
	               	<a href="javascript:;" onClick="cancel_popup('${item.cart_no}');"><img src="/images/mobile/sub_2/btn_type_d2.gif" alt="취소신청"></a> 
	               </c:if>
	                <c:if test="${item.status eq '8' || item.status eq '18'}">
	                  <a href="#"><img src="/images/mobile/sub_2/btn_type_d12.gif" alt="수취확인"></a>
	                </c:if>
	                <c:if test="${item.status eq '8' || item.status eq '18' }">
	                  <a href="#" onClick="return_popup('${item.cart_no}');"><img src="/images/mobile/sub_2/btn_type_d9.gif" alt="반품신청"></a>
	                </c:if>
	                <c:if test="${item.status eq '8' }">
	                  <a href="#" onClick="exchange_popup('${item.cart_no}');"><img src="/images/mobile/sub_2/btn_type_d10.gif" alt="교환신청"></a>
	                </c:if>
	                <c:if test="${item.status eq '12' }">
	                  <a href="#" onClick="refunds_popup('${item.cart_no}');"><img src="/images/mobile/sub_2/btn_type_d11.gif" alt="환불신청"></a>
	                </c:if>
	              </span>
	
	              </a>
	
	            </div>
	
	            </li>
			</c:forEach>
            
          </ul>

        </div>

		<h5 class="pay_type">결제내역</h5>

        <div class="cart_style_2">

          <table>
          <colgroup>
          <col width="25%">
          <col width="">
          </colgroup>
          <tbody>
          <tr>
            <th scope="row" rowspan="3"><c:choose>
              		<c:when test="${data.resultInfo.paytyp eq 'card' }">
              			신용카드결제
              		</c:when>
              		<c:when test="${data.resultInfo.paytyp eq 'iche' }">
              			계좌이체
              		</c:when>
              		<c:when test="${data.resultInfo.paytyp eq 'hp' }">
              			핸드폰결제
              		</c:when>
              		<c:when test="${data.resultInfo.paytyp eq 'ars' }">
              			ARS결제
              		</c:when>
              		<c:when test="${data.resultInfo.paytyp eq 'virtual' }">
              			가상계좌결제
              		</c:when>
              	</c:choose></th>
            <td>결제금액 : <b class="b_num">${suf:getThousand(data.resultInfo.payamt) }</b>원</td>
          </tr>
         
          </tbody>
          </table>

        </div>

		<h5 class="pay_type">결제금액</h5>

        <div class="pricecheck" style="margin-top:0;">

          <div class="top">

            <p>
            <span class="pt_l">정상가격</span>
            <span class="pt_r">${suf:getThousand(user_price) }</span>
            </p>

            <p class="t_mar">
            <span class="pt_l">할인금액</span>
            <c:set var="actual_price" value="${user_price-discount_price }" scope="request"/>
            <span class="pt_r minus">${suf:getThousand(user_price-discount_price) } 원</span>
            </p>

          </div>

          <div class="bottom">

            <p>
            <span class="pt_l">정상가격</span>
            <span class="pt_r"><b class="c1">20,000</b> 원</span>
            </p>

          </div>

        </div>

        <h5 class="pay_type">주문회원 정보</h5>

        <div class="sub_table_1">
          <table>
          <colgroup>
          <col width="25%">
          <col width="">
          </colgroup>
          <tbody>
          <tr>
            <th scope="row">주문자</th>
            <td>${data.resultInfo.order_nm }</td>
          </tr>
          <tr>
            <th scope="row">이메일</th>
            <td>${data.resultInfo.email }</td>
          </tr>
          <tr>
            <th scope="row">주문자<br>휴대폰</th>
            <td>${data.resultInfo.rehp }</td>
          </tr>
          </tbody>
          </table>
        </div>

        <h5 class="pay_type">배송정보 내역</h5>

        <div class="sub_table_1">
          <table>
          <colgroup>
          <col width="25%">
          <col width="">
          </colgroup>
          <tbody>
          <tr>
            <th scope="row">수취인</th>
            <td>${data.resultInfo.receiver }</td>
          </tr>
          <tr>
            <th scope="row">배송지<br>주소</th>
            <td>
              <p>(${data.resultInfo.re_zipcd }) ${data.resultInfo.re_addr1 }</p>
              <p>${data.resultInfo.re_addr2 }</p>
            </td>
          </tr>
          <tr>
            <th scope="row">수취인<br>휴대폰</th>
            <td>${data.resultInfo.re_cell }</td>
          </tr>
          <tr>
            <th scope="row">수취인<br>연락처</th>
            <td>${data.resultInfo.re_tel }</td>
          </tr>
          </tbody>
          </table>
        </div>

        <h5 class="pay_type">배송시 요청사항</h5>

        <div class="sub_table_1">
          <table>
          <colgroup>
          <col width="25%">
          <col width="">
          </colgroup>
          <tbody>
          <tr>
            <th scope="row">배송시<br>요청사항</th>
            <td class="request_type">
				<c:forEach var="item" items="${data.list }" varStatus="status">
                <div class="request_top">
                  <p class="request_c1"><strong>상품명</strong> : ${item.part3_nm } / ${item.carmodelnm } ${item.cargradenm } (${item.caryyyy })</p>
                  <p><strong>요청사항</strong> :  ${item.message }</p>
                </div>
				</c:forEach>
            </td>
          </tr>
          </tbody>
          </table>
        </div>
        <script type="text/javascript">
          $(document).ready(function(){
        	  $('td .request_top:last').css('background', 'none');
          });
          </script>

        <ul class="pay_c_list">
          <li class="c1"><strong>PARTSMOA</strong>는 통신판매중개자이며 통신판매의 당사자가 아닙니다. 따라서 <strong>PARTSMOA</strong>는 상품ㆍ거래정보 및 거래에 대하여 책임을 지지 않습니다.</li>
          <li>구매주문내역, 배송상태 확인, 구매영수증 출력, 구매취소/반품/교환은 사이트상단의 주문/배송조회에서 확인할 수 있습니다.</li>
          <li class="c1">
          고객님의 주문이 체결된 후 상품품절 및 단종 등에 의해 배송이 불가능할 경우, 전자상거래등에서의 소비자 보호에 관한 법률 제15조 2항에 의거하여
          3영업일(공휴일제외) 이내에 자동으로 취소될 수 있으며, 이 경우 취소 안내 메일이 고객님께 발송되오니 양지 바랍니다.
          </li>
          <li>극히 일부 상품의 경우, 상품페이지의 팔자주문수량이 해당 상품의 실제 재고수량과 다를 수 있는 점 양해바랍니다. </li>
          <li>일부상품에 대해 수량부족, 카드결제승인오류 등의 사례가 간혹 있을 수 있으니 나의쇼핑정보에서 다시 한번 확인해주세요. </li>
          <li>무통장 입금으로 구매하셨을 경우, 입금 하신 후 판매자에게 입금확인이 되었는지를 다시 한번 확인해주세요. </li>
        </ul>

      </div>
  </div>
  <form id="recFrm" name = "recFrm" method = "post" action = "/mobile/mypage/shopping/state/index.do?mode=m_nomember_pay_cancel">
<input type="hidden" name="receiver" id="receiver" value="${param.receiver }"/>
<input type="hidden" name="orderno" id="orderno" value="${param.orderno }"/>
<input type="hidden" name="passwd" id="passwd" value="${param.passwd }"/>
<input type="hidden" name="cart_no" id="cart_no" value=""/>
</form>