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
//submenu
$("#submenu_a_open").toggle(function(){
$("#sub_menu_a").slideToggle(250);
this.src = "/images/mobile/sub/sub_menu_a_close.gif";
}, function() {
$("#sub_menu_a").slideToggle(250);
this.src = "/images/mobile/sub/sub_menu_a_open.gif";
});

});


function refunds_send(cart_no){
	location.replace("/mobile/mypage/shopping/state/index.do?mode=m_refunds_result&cart_no=" + cart_no + "&sayu=" + $('#sayu').val());
	return;
}

function cancelBank(f){
	if(f.bank.value == ""){
		alert("환불 받으실 은행을 선택해 주시기 바랍니다.");
		f.bank.focus();
		return false;
	}
	if(f.accountNo.value == ""){
		alert("환불 받으실 계좌번호를 입력해 주시기 바랍니다.");
		f.accountNo.focus();
		return false;
	}
	
	location.replace("/mobile/mypage/shopping/state/index.do?mode=m_refunds_result&cart_no=" + f.cart_no.value + "&sayu=" + $('#sayu').val() + "&form_submit="+f.form_submit.value+"&bank="+f.bank.value+"&accountNo="+f.accountNo.value);
	return;
}
</script>

<div class="wrap">
  <div class="sub_wrap">
    <div class="sub_2_line line_2">
      <h3><img src="/images/mobile/sub_2/sub_2_title_5_2_3_4.gif" alt="환불신청"></h3>
    </div>
    <div class="address_pop">
      <ul>
        <li>※ 환불상품의 정보 및 환불예정금액을 확인해 주세요.</li>
      </ul>
      <h4 class="hs_1">환불요청 주문정보</h4>
      <div class="sub_list sub_list_a1">
        <p class="s_top_line"> <span class="st_l">${dtf:simpleDateFormat(item.orderdate, 'yyyy-MM-dd HH:mm:ss' , 'yyyy-MM-dd') }</span> 
          <!-- <span class="st_r"><a href="#"><img src="/images/mobile/sub_2/s_top_btn1.gif" alt="주문/배송조회"></a></span>  --> 
        </p>
        <ul>
          <li>
            <div> <span class="img_box"> <span class="img_b1"><a href="#"><img src="${item.thumb }" alt=""></a></span> </span> <span class="info"> <span class="order_num"><strong>주문번호 : ${item.orderno }</strong></span> <span class="in_t1"> <span class="first"><strong>${item.cargradenm } (${item.caryyyy })</strong></span> <span><strong>${item.productnm}</strong></span> <span><strong>${item.grade }등급</strong></span>
              <c:if test="${item.discount_rate > 0}"> <span class="f_style_1">${item.discount_rate }%↓</span> </c:if>
              </span> <span><strong>${item.com_nm}</strong> / ${item.sigungu_nm }</span> <span class="cancel_i1"><strong>환불사유 : </strong>
              <input type="text" id="sayu" name="sayu" class="input_m2">
              <!-- a class="btn_x" href="javascript:$('#sayu').val('')"><img src="/images/sub_2/c_input_cancel.gif" alt=""></a--></span> <span><strong>합계 : <b class="c2">${suf:getThousand(item.amt) }</b> 원</strong></span> </span> </div>
          </li>
        </ul>
      </div>
      <c:if test="${item.paytyp != 'card' }">
      <form id="cancelFrm" name="cancelFrm" method="post">
	  <input type="hidden" name="cart_no" value="${item.cart_no }">
	  <input type="hidden" name="form_submit" value="Y">
      <table class="cart_style_1 refunds_style_1" style="margin-top:30px;">
        <colgroup>
        <col width="50%">
        <col width="50%">
        </colgroup>
        <thead>
          <tr>
            <th scope="col">은행</th>
            <th scope="col">계좌번호</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>
            <select id="bank" name="bank" class="select_1">
            	<option value="">은행 선택</option>
            <c:forEach var="bank" items="${bank }" varStatus="status">
            	<option value="${bank.code_seq }">${bank.code_nm }</option>
            </c:forEach>
            </select>
            </td>
            <td class="b_none"><input type="text" id="accountNo" name="accountNo" class="input_m2"></td>
          </tr>
        </tbody>
      </table>
      </form>
      <p class="type_2">※ 환불받을 계좌는 본인명의로 되어있어야만 정상적인 환불절차가 이루어집니다.</p>
      </c:if>
      <div class="btn_bottom"> <a href="javascript:history.back();"><img src="/images/sub_2/btn_cancel_2.gif" alt="이전단계"></a> 
      <c:if test="${item.paytyp != 'card' }">
	  <a href="javascript:;" onclick="cancelBank(document.cancelFrm);"><img src="/images/sub_2/btn_cancel_d1.gif" alt="환불신청"></a>
	  </c:if>
	  <c:if test="${item.paytyp == 'card' }">
	  <a href="javascript:;" onclick="refunds_send('${item.cart_no}')"><img src="/images/sub_2/btn_cancel_d1.gif" alt="환불신청"></a>	  
	  </c:if>
      </div>
    </div>
  </div>
</div>
