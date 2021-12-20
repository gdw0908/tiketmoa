<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<script type="text/javascript" src="/lib/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/lib/js/jquery.lck.util.js"></script>
<script type="text/javascript">
$(function(){
	$(".chk_all").on("click", function(){
		if($(this).prop("checked")){
			$("input[name='chk']").prop("checked", true);
		}else{
			$("input[name='chk']").prop("checked", false);
		}
		chkReset();
	});
	
	$("input[name='chk']").on("click", function(){
		chkReset();
	});
	
	$("input[name='qty']").on("keyup", function(e){
		$(this).val($.Number($(this).val()));
		//TODO 재고수량 가져와서 체크
		
		$(this).closest("tr").find("input[name='chk']").attr("qty", $(this).val());
// 		chkReset();
	});
	chkReset();
});

//배송비 선결제 설정
function changeCod(idx, val){
	var obj = $("input[name='chk']").eq(idx);
	var cart_no = obj.val();
	obj.attr("cod_yn", val);
	$.getJSON("/mypage/shopping/cart/index.do?mode=changeCod", {cart_no : cart_no, cod_yn : val}, function(data){
		if(data.rst == "1"){
			
		}else{
			alert("배송비 선결제/착불 변경에 실패하였습니다.");
		}
		chkReset();
	});
}

function changeQty(idx){
	alert(idx);
	var obj = $("input[name='chk']").eq(idx);
	var qty = $("input[name='qty']").eq(idx).val();
	$.getJSON("/mypage/shopping/cart/index.do?mode=qtyChange", {cart_no : obj.val(), item_seq : obj.attr("item_seq"), qty : qty}, function(data){
		if(data.rst == "1"){
			obj.attr("qty", qty);
		}else{
			alert("최대 구매하실수 있는 수량은 " + data.qty +" 입니다.");
			$("input[name='qty']").eq(idx).val(data.qty);
			obj.attr("qty", data.qty);
		}
		placeCalc(idx);
		chkReset();
	});
}

function placeCalc(idx){
	var obj = $("input[name='chk']").eq(idx);
	var html = "";
	if(("${sessionScope.member.group_seq}" == "3" || "${sessionScope.member.group_seq}" == "9") && obj.attr("supplier_pricing_yn")=="Y"){//협력사
		html += "<p><b class='c1'>"+$.addComma(obj.attr("supplier_price") * obj.attr("qty")) + " 원</b><p>";
	}else{
		if(obj.attr("discount_rate")>0){
			html += "<p><span class='price_un_2'>"+ $.addComma(obj.attr("user_price") * obj.attr("qty"))+"</span></p>";
			html += "<p><b class='c1'>"+$.addComma(obj.attr("sale_price") * obj.attr("qty")) + " 원</b><p>";
		}else{
			html += "<p><b class='c1'>"+$.addComma(obj.attr("user_price") * obj.attr("qty")) + " 원</b><p>";
		}
	}
	
	$(".price_calc").eq(idx).html(html);
}

function chkReset(){
	var user_price_sum = 0;
	var sale_price_sum = 0;
	var fee_price_sum = 0;
	$("input[name='chk']:checked").each(function(){
		var qty = $(this).attr("qty");
		if(("${sessionScope.member.group_seq}" == "3" || "${sessionScope.member.group_seq}" == "9") && $(this).attr("supplier_pricing_yn")=="Y"){//협력사
			user_price_sum += Number($(this).attr("user_price"))*qty;
			sale_price_sum += Number($(this).attr("supplier_price"))*qty;
		}else{
			if($(this).attr("discount_rate")>0){
				user_price_sum += Number($(this).attr("user_price"))*qty;
				sale_price_sum += Number($(this).attr("sale_price"))*qty;
			}else{
				user_price_sum += Number($(this).attr("user_price"))*qty;
				sale_price_sum += Number($(this).attr("user_price"))*qty;
			}
		}
		if($(this).attr("cod_yn")=="Y"){//선결제
			fee_price_sum += Number($(this).attr("fee_amt"));
		}
	});
	$("#select_cnt").text($("input[name='chk']:checked").size());
	$("#user_price").text($.addComma(user_price_sum));
	$("#discount_price").text($.addComma(user_price_sum-sale_price_sum));
	$("#fee_price").text($.addComma(fee_price_sum));//배송비
	$("#actual_price").text($.addComma(sale_price_sum + fee_price_sum));
}

function removeCart(){
	var rst = [];
	$("input[name='chk']:checked").each(function(){
		rst.push({cart_no:$(this).val()});
	});
	$.getJSON("/mypage/shopping/cart/index.do?mode=remove_cart", {jData : JSON.stringify({del : rst})}, function(data){
		location.href="/mobile/mypage/shopping/cart/index.do?mode=m_add_cart_list";
	});
}

function goStep2(){
	$("#m_carfrm").submit();
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
  <div class="sub">
    <div class="sm_wrap">
      <div class="sm_top"> <span class="select_box s_menu_type">
        <select id="go_url_value" name="go_url_value" class="select_sm">
          <option value = "" >메뉴를 선택해 주세요</option>
         <option value = "m_add_cart_list.cart" <c:if test = "${params.mode eq 'm_add_cart_list'}">selected</c:if>>장바구니</option>
          <option value = "m_list1.state" <c:if test = "${params.mode eq 'm_list1'}">selected</c:if>>주문/배송조회</option>
          <option value = "m_list2.state" <c:if test = "${params.mode eq 'm_list2'}">selected</c:if>>취소/반품/교환 조회</option>
          <option value = "m_list3.state" <c:if test = "${params.mode eq 'm_list3'}">selected</c:if>>환불/입금내역</option>
        </select>
        </span> <span class="sm_btn"><a href="javascript:go_url();"><img src="/images/mobile/sub_2/sub_menu_a.gif" alt="상세조건 검색버튼"></a></span> </div>
    </div>
    <div class="sub_wrap">
      <div class="sub_2_line line_2">
        <h3><img src="/images/mobile/sub_2/sub_2_title_5.gif" alt="장바구니"></h3>
      </div>
      <ul class="cart_list_1">
        <li>장바구니에 담긴 상품은 7일동안 보관되며 자동으로 삭제됩니다.</li>
        <li class="last"><strong>주문하실 상품을 선택 해 주세요.</strong></li>
      </ul>
      <h4 class="hs_1">회원정보</h4>
      <form id="m_carfrm" name="m_carfrm" action="/mobile/mypage/shopping/cart/index.do" method="get">
        <input type="hidden" name="mode" value="m_step2"/>
        <div class="sub_list">
          <ul>
            <c:choose>
      	<c:when test = "${fn:length(data_list.list) == 0}">
      	<p class="none_img"><img src="/images/sub_2/none_cart.gif" alt="상품없음이미지"></p>
			<p class="none_text">상품이 존재하지 않습니다.</p>

      	</c:when>
      	<c:otherwise>
      		<c:forEach var="item" items="${data_list.list }" varStatus="status">
              <li>
                <p class="check_line">
                  <label>
                    <input type="checkbox" name="chk" value="${item.cart_no }" item_seq="${item.item_seq }" sale_price="${item.sale_price }" user_price="${item.user_price }" qty="${item.qty }" discount_rate="${item.discount_rate }" supplier_pricing_yn="${item.supplier_pricing_yn }" supplier_price="${item.supplier_price }" cod_yn="${item.cod_yn }" fee_amt="${item.fee_amt}">
                    선택</label>
                </p>
                <div> <a href="/mobile/goods/view.do?menu=menu2&seq=${item.item_seq }"> <span class="img"><img src="${item.thumb }" alt=""></a></span> <span class="info"> <span class="in_t1"> <span class="first"><strong><c:if test = "${not empty item.cargradenm }">${item.cargradenm } (${item.caryyyy })</c:if></strong></span> <span><strong>${item.productnm}</strong></span> <span><strong>${item.grade }등급</strong></span> </span> <span><strong>${item.com_nm}</strong> / ${item.sigungu_nm }</span> <span>상품등록 : ${dtf:simpleDateFormat(item.reg_dt, 'yyyy-MM-dd HH:mm:ss' , 'yyyy-MM-dd') }</span> <span class="t_money"> 
                  <!-- <span class="c1">협력가 : ${suf:getThousand(item.sale_price * item.qty) } 원</span>  --> 
                  <span class="c2">일반가 : ${suf:getThousand(item.user_price * item.qty) } 원</span> <span >배송비 :
                  <c:choose>
                    <c:when test="${item.fee_yn eq 'C' }"> 착불 </c:when>
                    <c:when test="${item.fee_yn eq 'Y' }">
                      <select name="cod_yn" onchange="changeCod('${status.index }', this.value)">
                        <option value="Y" <c:if test="${item.cod_yn eq 'Y'}">selected="selected"</c:if>>선결제</option>
                        <option value="N" <c:if test="${item.cod_yn eq 'N'}">selected="selected"</c:if>>착불</option>
                      </select>
                      <br />
                      (${suf:getThousand(item.fee_amt) } 원) </c:when>
                    <c:otherwise>무료</c:otherwise>
                  </c:choose>
                  </span> </span> </span>
                  <p class="btn_2"> <span class="b2_l"> <span class="text">수량</span> <span>
                    <input type="text" name="qty" class="input_m1 ws_2" value="${item.qty }" min="0" autocomplete="off">
                    </span> <a href="javascript:changeQty('${status.index }')"><img src="/images/sub_2/cart_btn1.gif" alt="변경"></a> </span> 
                    <!-- <span class="b2_r"> <a href="/mobile/mypage/shopping/cart/index.do?mode=m_direct_order&seq=${item.item_seq }&qty=${item.qty }"><img src="/images/mobile/sub_2/btn_type_a1.gif" alt="즉시구매" ></a> </span>  --> 
                  </p>
                </div>
              </li>
            </c:forEach>
      	</c:otherwise>
      </c:choose>
          </ul>
        </div>
      </form>
      <div class="all_check">
        <p class="all_l">
          <label>
            <input type="checkbox" class="chk_all">
            전체선택</label>
        </p>
        <p class="all_r"><a href="javascript:removeCart()"><img src="/images/mobile/sub_2/btn_type_b1.gif" alt="선택삭제"></a></p>
      </div>
      <h4 class="hs_1">결제예정금액</h4>
      <div class="pricecheck">
        <div class="top">
          <p class="first"> <span class="pt_l">정상가격</span> <span class="pt_r"><b id="user_price">0</b> 원</span> </p>
          <p> <span class="pt_l">할인금액</span> <span class="pt_r minus"><b id="discount_price">0</b> 원</span> </p>
          <p> <span class="pt_l">선결제배송비</span> <span class="pt_r"><b id="fee_price">0</b> 원</span> </p>
        </div>
        <div class="bottom">
          <p> <span class="pt_l">총 구매금액</span> <span class="pt_r"><b id="actual_price" class="c1">0</b> 원</span> </p>
        </div>
      </div>
      <div class="btn_bottom">
      <a href="javascript:goStep2()"><img src="/images/sub_2/btn_payment.gif" alt="주문결제"></a>
      <a href="/mobile/"><img src="/images/sub_2/btn_pay_5.gif" alt="계속쇼핑하기"></a>
      </div>
    </div>
  </div>
</div>
