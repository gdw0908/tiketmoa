<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<link rel="stylesheet" href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" type="text/css">
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/lib/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/lib/js/jquery.lck.util.js"></script>
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
$(function(){
	
	$("#sdate,#edate").datepicker();
	
	$.ajaxSetup ({
		cache: false
	});
	
	$("td[orderno]").each(function(){
		var _o = $("td[orderno='"+$(this).attr("orderno")+"']");
		var size = _o.size();
		if(size > 1){
			$(this).attr("rowspan", size);
			_o.last().remove();
		}
	});
});

function refunds_popup(cart_no){
	
	location.replace("/mobile/mypage/shopping/state/index.do?mode=m_refunds&cart_no=" + cart_no);
	return;
}

function cancel_popup(cart_no){
	location.replace("/mobile/mypage/shopping/state/index.do?mode=m_cancel_popup&cart_no=" + cart_no);
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

function week(){
	var sdt = new Date();
	sdt.setDate(sdt.getDate() - 7);
	var edt = new Date();
	
	$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
	$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
}
function day15(){
	var sdt = new Date();
	sdt.setDate(sdt.getDate() - 15);
	var edt = new Date();
	
	$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
	$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
}
function month1(){
	var today = new Date();
	var sdt = new Date(today.getFullYear(), today.getMonth()-1, today.getDate());
	var edt = new Date();
	
	$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
	$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
}
function month3(){
	var today = new Date();
	var sdt = new Date(today.getFullYear(), today.getMonth()-3, today.getDate());
	var edt = new Date();
	
	$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
	$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
}
function bmonth(){
	var today = new Date();
	var sdt = new Date(today.getFullYear(), today.getMonth()-1, 1);
	var edt = new Date(today.getFullYear(), today.getMonth(), 0);
	
	$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
	$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
}
function cmonth(){
	var today = new Date();
	var sdt = new Date(today.getFullYear(), today.getMonth(), 1);
	var edt = new Date(today.getFullYear(), today.getMonth()+1, 0);
	
	$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
	$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
}

function goSubmit(){
	$("#searchFrm").submit();
}

function track(cart_no){
	window.open("/popup/mypage/shopping/state/index.do?mode=track&cart_no="+cart_no,"delivery","width=1000,height=750, scrollbars=yes, resizable=yes"); 
}

function go_url()
{
	var sp_value = "";
	if(jQuery("#go_url_value").val() == "")
	{
		alert("이동할 메뉴를 선택하세요.");
		return ;
	}
	else
	{
		sp_value = jQuery("#go_url_value").val().split(".");
		location.replace("/mobile/mypage/shopping/" + sp_value[1] + "/list.do?menu=menu3&mode=" + sp_value[0]);
	}
	
}
</script>
<div class="wrap">
	 <div class="sm_wrap">
      <div class="sm_top"> <span class="select_box s_menu_type">
        <select id="go_url_value" name="go_url_value" class="select_sm">
          <option value = "">메뉴를 선택해 주세요</option>
          <option value = "m_add_cart_list.cart" <c:if test = "${params.mode eq 'm_add_cart_list'}">selected</c:if>>장바구니</option>
          <option value = "m_list1.state" <c:if test = "${params.mode eq 'm_list1'}">selected</c:if>>주문/배송조회</option>
          <option value = "m_list2.state" <c:if test = "${params.mode eq 'm_list2'}">selected</c:if>>취소/반품/교환 조회</option>
          <option value = "m_list3.state" <c:if test = "${params.mode eq 'm_list3'}">selected</c:if>>환불/입금내역</option>
        </select>
        </span> <span class="sm_btn"><a href="javascript:go_url();"><img src="/images/mobile/sub_2/sub_menu_a.gif" alt="상세조건 검색버튼"></a></span> </div>
    </div>
      <div class="sub_wrap">

        <div class="sub_2_line line_2">
          <h3><img src="/images/mobile/sub_2/sub_2_title_5_4.gif" alt="환불/입금내역"></h3>
        </div>

		<div class="p_o_line">

		<div class="period_line">
          <form id="searchFrm" name="searchFrm" action="/mobile/mypage/shopping/state/list.do?mode=m_list3" method="post">
          <div class="sub_tab">
            <ul class="tab">
              <li class="first"><a class="first" href="#" onClick="week();">1주일</a></li>
              <li><a href="#"onclick="day15();">15일</a></li>
              <li><a href="#"onclick="month1();">1개월</a></li>
              <li><a href="#"onclick="month3();">3개월</a></li>
              <li class="cut"><a class="first" href="#"onclick="bmonth();">전월</a></li>
              <li><a href="#"onclick="cmonth();">당월</a></li>
            </ul>
            </div>
            <div class="p_o_line">
            <img src="/images/mobile/sub/calendar.gif" alt="달력">
              <input type="text" class="input_m1" id="sdate" name="sdate" value ="${param.sdate }">
              ~
              <img src="/images/mobile/sub/calendar.gif" alt="달력">
              <input type="text" class="input_m1" id="edate" name="edate" value ="${param.edate }">
              <span class="btn"><a href="javascript:goSubmit();"><img src="/images/sub_2/btn_inquiry.gif" alt="조회하기"></a></span> </div>
          </form>
        </div>

      </div>
		<c:choose>
      	<c:when test = "${fn:length(data.list) == 0}">
      	<p class="none_img"><img src="/images/sub_2/none_cart.gif" alt="상품없음이미지"></p>
			<p class="none_text">상품이 존재하지 않습니다.</p>

      	</c:when>
      	<c:otherwise>
      		<c:forEach var="item" items="${data.list }" varStatus="status">
        <div class="sub_list sub_list_a1">
          <p class="s_top_line">
          <span class="st_l">${dtf:simpleDateFormat(item.orderdate, 'yyyy-MM-dd HH:mm:ss' , 'yyyy-MM-dd') }</span>
          </p>

          <ul>

            <li>

            <div>

              <span class="img_box">
              <span class="img_b1"><c:if test="${item.status eq '7' || item.status eq '8' }"><a href="javascript:track('${item.cart_no}');"></c:if>
                <img src="${item.thumb }" alt="${item.productnm }">
                <c:if test="${item.status eq '7' || item.status eq '8' }"></a></c:if></span>
              	<c:if test="${item.status eq '7' || item.status eq '8' }">  
              		<span class="img_btn btn_s1">
              			<a href="javascript:track('${item.cart_no}');"><img src="/images/mobile/sub_2/btn_type_d1.gif" alt="배송추적"></a>
              		</span>
              	</c:if>
             
              </span>

              <span class="info">

              <span class="order_num"><strong>주문번호 : ${item.orderno }</strong></span>

              <span class="in_t1">
              <span class="first"><strong>${item.cargradenm } (${item.caryyyy })</strong></span>
              <span><strong>${item.productnm}</strong></span>
              <span><strong>${item.grade }등급</strong></span>
              </span>

              <span><strong>${item.com_nm}</strong> / ${item.sigungu_nm }</span>
              <span><strong>주문일 :</strong> ${dtf:simpleDateFormat( item.reg_dt, 'yyyy-MM-dd HH:mm:ss' , 'yyyy-MM-dd') }</span>
              <span><strong>주문상태 : <b class="c1">${item.status_nm }</b></strong></span>
              <span><strong>주문수량 : ${item.qty } 개</strong></span>
              <span><strong>합계 : <b class="c2">${suf:getThousand(item.amt) }</b> 원</strong></span>
			 	<c:if test="${item.cod_yn eq 'Y' }">
           	 		<span>
           	 			<strong>배송비 : <b class="c2">${suf:getThousand(item.fee_amt) }</b> 원</strong>
           	 		</span>
           	 	</c:if>
           	  <span class="btn_s1">
			       <c:if test="${item.status eq '1' }"> <a href="javascript:;" onClick="cancel_popup('${item.cart_no}');"><img src="/images/mobile/sub_2/btn_type_d2.gif" alt="취소신청"></a> </c:if>
			       <c:if test="${item.status eq '8' || item.status eq '18'}">
			         <a href="#"><img src="/images/mobile/sub_2/btn_type_d12.gif" alt="수취확인"></a>
			       </c:if>
			       <c:if test="${item.status eq '8' || item.status eq '18' }">
			         <a href="#" onClick="return_popup('${item.cart_no}');"><img src="/images/mobile/sub_2/btn_type_d9.gif" alt="반품신청"></a>
			       </c:if>
			       <c:if test="${item.status eq '8' }">
			         <a href="#" onClick="exchange_popup('${item.cart_no}');"><img src="/images/mobile/sub_2/btn_type_d10.gif" alt="교환신청"></a>
			       </c:if>
			       <c:if test="${item.status eq '11' || item.status eq '12' }">
			         <a href="#" onClick="refunds_popup('${item.cart_no}');"><img src="/images/mobile/sub_2/btn_type_d11.gif" alt="환불신청"></a>
			       </c:if>
   				</span>
              
              </span>

              </span>

            </div>

            </li>

          </ul>

        </div>
		</c:forEach>
      	</c:otherwise>
      </c:choose>
      </div>
  </div>