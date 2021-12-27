<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>파츠모아 통합관리 시스템</title>
<link href="/lib/css/cmsbase.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/cmsadmin.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" type="text/css">
<script type="text/javascript" src="/lib/js/jquery-1.10.2.min.js"></script> 
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script> 
<script type="text/javascript" src="/lib/js/jquery.ui.datepicker-ko.js"></script>
<script>
$(document).ready(function(){
	$('#year').val('${params.year}');
	$('#month').val('${params.month}');
});

function go_search(){
	$('#frm').attr('action', '/giftcard/admin/calculate/month_search.do');
	$('#frm').submit();
}

function go_excel(){
	
	<c:if test="${empty list }">
	alert('조회된 데이터가 없습니다.');
	return;
	</c:if>
	
	$('#frm').attr('action', '/giftcard/admin/calculate/month_excel.do');
	$('#frm').submit();
}


</script>
</head>
<body>
<div id="main">
  <div class="titlebar">
    <h2>월정산조회</h2>
    <div> <span>통합관리</span> &gt; <span>정산관리</span> &gt; <span class="bar_tx">월정산조회</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
    <form action="/giftcard/admin/calculate/month_search.do" method = "post" name = "frm" id = "frm">
      <table class="style_1">
         <colgroup>
          <col width="10%" />
          <col width="*" />
          </colgroup>
        <tr>
          <th>조회조건</th>
          <td>
            <select title="업체개별선택"  name = "com_seq" >
            	<option value = "">업체전체</option>
            	<c:forEach items = "${com_list }" var = "vo">
            	<option value = "${vo.com_seq }" <c:if test = "${vo.com_seq == params.com_seq}">selected</c:if>>${vo.com_nm }</option>
            	</c:forEach>
            </select>
          </td>
        </tr> 
        <tr>
          <th>기간선택</th>
          <td>
            <select title="년도선택" name = "year" id = "year" style="width: 100px;">
                <option value = "2021">2021</option>
            </select>
            <select title="월선택" name = "month" id = "month" style="width: 100px;">
                <option value = "01">1월</option>
                <option value = "02">2월</option>
                <option value = "03">3월</option>
                <option value = "04">4월</option>
                <option value = "05">5월</option>
                <option value = "06">6월</option>
                <option value = "07">7월</option>
                <option value = "08">8월</option>
                <option value = "09">9월</option>
                <option value = "10">10월</option>
                <option value = "11">11월</option>
                <option value = "12">12월</option>
            </select>
          </td>
        </tr>
      </table>
      <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span><input type="button" value="조회 " onclick="go_search();" class="btall"/></span></span> 
          </div>
      </div>
      </form>
      <table class="style_6">
        <colgroup>
          <col width="10%" />
          <col width="7%" />
          <col width="6%" />
          <col width="6%" />
          <col width="6%" />
          <col width="6%" />
          <col width="6%" />
          <col width="6%" />
          <col width="6%" />
          <col width="6%" />
          <col width="12%" />
          <col width="*" />
        </colgroup>
        <tr>
          <th rowspan="2">업체명</th>
          <th colspan="2">판매금액</th>
          <th colspan="2">취소/환불 총액</th>
          <th rowspan="2">판매총액</th>
          <th rowspan="2">주문총액</th>
          <th colspan="3">공제내역</th>
          <th rowspan="2">총정산액</th>
          <th rowspan="2">송금액</th>
        </tr>
        <tr>
          <th>카드</th>
          <th>현금</th>
          <th>카드</th>
          <th>현금</th>
          <th>카드</th>
          <th>현금</th>
          <th>본사수수료</th>
        </tr>
        
        <c:forEach items = "${list }" var = "vo">
        <tr>
          <td>${vo.com_nm == null ? '합계' : vo.com_nm }</td>
          <td><fmt:formatNumber type="number" pattern="###,###" value="${vo.card}" /></td>
          <td><fmt:formatNumber type="number" pattern="###,###" value="${vo.iche + vo.virtual}" /></td>
          <td><fmt:formatNumber type="number" pattern="###,###" value="${vo.cancel_card_sum + vo.refund_card_sum}" /></td>
          <td><fmt:formatNumber type="number" pattern="###,###" value="${vo.cancel_cash_sum + refund_cash_sum}" /></td>
          <td><fmt:formatNumber type="number" pattern="###,###" value="${vo.total}" /></td>
          <td><fmt:formatNumber type="number" pattern="###,###" value="${vo.order_sum}" /></td>
          <td><fmt:formatNumber type="number" pattern="###,###" value="${vo.card_pg_commission}" /></td>
          <td><fmt:formatNumber type="number" pattern="###,###" value="${vo.iche_pg_commission + vo.virtual_pg_commission}" /> </td>
          <td><fmt:formatNumber type="number" pattern="###,###" value="${vo.u_m_commission + c_m_commission}" /></td>
          <td><fmt:formatNumber type="number" pattern="###,###" value="${vo.total}" /> - <fmt:formatNumber type="number" pattern="###,###" value="${vo.cancel_card_sum + vo.refund_card_sum + vo.cancel_cash_sum + refund_cash_sum}" /> - <fmt:formatNumber type="number" pattern="###,###" value="${vo.card_pg_commission + vo.iche_pg_commission + vo.virtual_pg_commission + vo.u_m_commission + c_m_commission}" /></td>
          <td><fmt:formatNumber type="number" pattern="###,###" value="${vo.total - (vo.cancel_card_sum + vo.refund_card_sum + vo.cancel_cash_sum + refund_cash_sum) - (vo.u_m_commission + c_m_commission)}" /></td>
        </tr>
        </c:forEach>
        
      </table>
      <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span><input type="button" value="엑셀다운로드" onclick="go_excel();" class="btall"/></span></span> 
          </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>
