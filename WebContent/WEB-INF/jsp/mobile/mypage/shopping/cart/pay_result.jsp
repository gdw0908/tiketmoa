<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
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

function show_receipt() 
{
	if("${params.status}"== "ok")
	{
		var send_dt = frm.appr_tm.value;

		url="http://allthegate.com/customer/receiptLast3.jsp"
		url=url+"?sRetailer_id="+frm.sRetailer_id.value;   
		url=url+"&approve="+frm.approve.value;
		url=url+"&send_no="+frm.send_no.value;
		url=url+"&send_dt="+send_dt.substring(0,8);
		
		window.open(url, "window","toolbar=no,location=no,directories=no,status=,menubar=no,scrollbars=no,resizable=no,width=420,height=700,top=0,left=150");
	}
	else
	{
		alert("해당하는 결제내역이 없습니다");
	}
}
</script>
<c:set var="user_price" value="0"/>
<c:set var="discount_price" value="0"/>
<c:set var="fee_price" value="0"/>
<div class="wrap">
      <div class="sub_wrap">

        <div class="sub_2_line line_2">
          <h3><img src="/images/mobile/sub_2/sub_2_title_5_1_3.gif" alt="주문완료"></h3>
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
            <th scope="row" rowspan="3">
            <c:choose>
            	<c:when test = "${params.paytype eq 'card' }">
            		신용카드
            	</c:when>
            	<c:otherwise>
            		기타
            	</c:otherwise>
            </c:choose>
           
            </th>
            <td>결제금액 : <b class="b_num">${suf:getThousand(params.payamt) }</b>원</td>
          </tr>
          </tbody>
          </table>

        </div>

        <h5 class="pay_type">주문상품</h5>

        <div class="sub_list">

          <ul>

            <li>
			<c:forEach var="item" items="${data.list }" varStatus="status">
			<c:set var="user_price_l" value="0"/>
			<c:set var="discount_price_l" value="0"/>
			<c:set var="fee_price_l" value="0"/>
          	<c:choose>
	       		<c:when test="${(sessionScope.member.group_seq eq '3' or sessionScope.member.group_seq eq '9') && item.supplier_pricing_yn eq 'Y'}">
	       			<c:set var="user_price" value="${user_price + (item.supplier_price * item.qty) }"/>
					<c:set var="user_price_l" value="${item.supplier_price * item.qty }"/>
	       		</c:when>
	       		<c:otherwise>
	       			<c:if test="${item.discount_rate > 0}">
		        		<c:set var="user_price" value="${user_price + (item.user_price * item.qty) }"/>
	          			<c:set var="discount_price" value="${discount_price + ((item.user_price * item.qty) - (item.sale_price * item.qty)) }"/>
						<c:set var="user_price_l" value="${item.user_price * item.qty }"/>
						<c:set var="discount_price_l" value="${(item.user_price * item.qty) - (item.sale_price * item.qty) }"/>
	            	</c:if>
					<c:if test="${item.discount_rate == 0 || empty item.discount_rate}">
		        		<c:set var="user_price" value="${user_price + (item.user_price * item.qty) }"/>
						<c:set var="user_price_l" value="${item.user_price * item.qty }"/>
	            	</c:if>
	       		</c:otherwise>
       		</c:choose>
       		<c:if test="${item.cod_yn eq 'Y' }">
            	<c:set var="fee_price" value="${fee_price + item.fee_amt }"/>
            	<c:set var="fee_price_l" value="${item.fee_amt }"/>
            </c:if>
            <div>
              
			  <span class="img_box">
			  <span class="img_b1"><a href="#"><img src="${item.thumb }" alt=""></a></span>
			
			  </span>

			  <a href="#">

              <span class="info">

			  <span class="order_num"><strong>주문번호 : ${params.orderno }</strong></span>

              <span class="in_t1">
              <span class="first"><strong>${item.cargradenm } <c:if test = "${!item.caryyyy eq ''}">(${item.caryyyy })</c:if></strong></span>
              <span><strong>${item.productnm }</strong></span>
              <span><strong>${item.grade }등급</strong></span>
              </span>

              <span><strong>${item.com_nm}</strong> / ${item.sigungu_nm }</span>
              <span><strong>주문일 :</strong> ${dtf:simpleDateFormat(item.reg_dt, 'yyyy-MM-dd HH:mm:ss' , 'yyyy-MM-dd') }</span>
			  <span><strong>주문수량 : ${item.qty } 개</strong></span>
			  <span><strong>합계 : <b class="c2">${suf:getThousand(user_price_l - discount_price_l) } </b> 원</strong></span>

              </span>

			  </a>

            </div>
			</c:forEach>
            </li>
          </ul>

        </div>

        <div class="pricecheck">

          <div class="top">

            <p>
            <span class="pt_l">정상가격</span>
            <span class="pt_r"><b>${suf:getThousand(user_price) }</b> 원</span>
            </p>

            <p class="t_mar">
            <span class="pt_l">할인금액</span>
            <span class="pt_r minus"><b>${suf:getThousand(discount_price) }</b> 원</span>
            </p>
            
             <p class="t_mar">
            <span class="pt_l">선결제배송비</span>
            <span class="pt_r"><b>${suf:getThousand(fee_price_l) }</b> 원</span>
            </p>

          </div>

          <div class="bottom">

            <p>
            <span class="pt_l">총 구매금액</span>
           	<c:set var="actual_price" value="${user_price - discount_price + fee_price}" scope="request"/>
            <span class="pt_r"><b class="c1"><b>${suf:getThousand(actual_price) }</b></b> 원</span>
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
            <td>${params.ordernm }</td>
          </tr>
          <tr>
            <th scope="row">주소</th>
            <td>
              <p>(${params.zip1 } - ${params.zip2 }) ${params.addr1 }</p>
              <p>${params.addr2 }</p>
            </td>
          </tr>
          <tr>
            <th scope="row">이메일</th>
            <td>${params.useremail }</td>
          </tr>
          <tr>
            <th scope="row">주문자<br>휴대폰</th>
            <td>${params.cell1 } - ${params.cell2 } - ${params.cell3 }</td>
          </tr>
          <tr>
            <th scope="row">주문자<br>연락처</th>
            <td>${params.tel1 } - ${params.tel2 } - ${params.tel3 }</td>
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

        <div class="btn_bottom"><a href="/mobile/mypage/shopping/state/list.do?mode=m_list1"><img src="/images/sub_2/btn_pay_4.gif" alt="나의쇼핑정보"></a></div>

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
            <li>배송주소를 추가하거나 변경, 삭제 등의 관리는 나의 쇼핑정보 &gt; 나의정보에서 가능합니다. </li>
          </ul>

      </div>
  
  <form name="frm" method="post">
<!--영수증출력을위해서보내주는값-------------------->
<input type=hidden name=sRetailer_id value="${params.storeid }" /><!--상점아이디-->
<input type=hidden name=approve value="${params.admno }" /><!---승인번호-->
<input type=hidden name=send_no value="${params.dealno }" /><!--거래고유번호-->
<input type=hidden name=appr_tm value="${admtime }" /><!--승인시각-->
<!--영수증출력을위해서보내주는값-------------------->
</form>
</body>
</html>
