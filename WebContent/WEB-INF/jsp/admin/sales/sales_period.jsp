<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>파츠모아 통합관리 시스템</title>
<link href="/lib/css/cmsbase.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/cmsadmin.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/lib/js/jquery-1.10.2.min.js"></script> 
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script> 
<script type="text/javascript" src="/lib/js/jquery.ui.datepicker-ko.js"></script>
<script type = "text/javascript">

$(document).ready(function(){
	$("input.date").datepicker({
		showOn: "button",      
		buttonImage: "/images/admin/contents/calendar.png"
	});
});

function go_search(){

	if($('#start_date').val() != '' && $('#end_date').val() == ''){
		alert('검색기간을 선택해주세요.');
		$('#end_date').focus();
		return;
	}
	
	if($('#end_date').val() != '' && $('#start_date').val() == ''){
		alert('검색기간을 선택해주세요.');
		$('#start_date').focus();
		return;
	}
	
	$("#cpage").val(1);
	$('#frm').attr('action', '/admin/sales/sales_period.do');
	$('#frm').submit();
}

function go_excel(){
	
	<c:if test="${empty list }">
	alert('조회된 데이터가 없습니다.');
	return;
	</c:if>
	
	$('#frm').attr('action', '/admin/sales/period_excel.do');
	$('#frm').submit();
}

function dialog_pop(order_comseq,t){
	$("#modal_dialog2" ).dialog({
		autoOpen: false,
		modal : true,
		width:"1200",
		height:"700"
	});
	$("#modal_dialog2").load("/admin/sales/view_detail.do", {com_seq : order_comseq, start_date : "${params.start_date}" , end_date : "${params.end_date}" , type:t});
	$("#modal_dialog2").dialog({title:'자세히보기'}).dialog("open");
}

</script>
</head>
<body>
<div id="main">
  <div class="titlebar">
    <h2>매출조회 - 기간별조회</h2>
    <div> <span>통합관리</span> &gt; <span>매출조회</span> &gt; <span class="bar_tx">매출조회 - 기간별조회</span> </div>
  </div>
  <div class="container">
    <div class="contents">
     <form action="/admin/sales/sales_period.do" method = "post" name = "frm" id = "frm">
      <input type = "hidden" name = "cpage" id = "cpage" />
      <table class="style_1">
        <colgroup>
        <col width="15%" />
        <col width="" />
        </colgroup>
        <tbody>
        <c:if test = "${sessionScope.member.group_seq eq '1'}">
          <tr>
            <th>조회조건</th>
            <td><select title="업체개별선택"  name = "com_nm" >
            	<option value = "">업체전체</option>
            	<c:forEach items = "${com_list }" var = "vo">
            	<option value = "${vo.member_id }" <c:if test = "${vo.member_id == params.com_nm}">selected</c:if>>${vo.com_nm }</option>
            	</c:forEach>
            </select>
          </td>
              
          </tr>
          </c:if>
          <tr>
            <th>기간선택</th>
            <td><input type="text" class="input_1 date" id="start_date" name = "start_date" value = "${params.start_date }" />
              ~
            <input type="text" class="input_1 date" id="end_date" name = "end_date" value = "${params.end_date }" /></td>
          </tr>
        </tbody>
      </table>
      <div class="btn_bottom">
        <div class="r_btn"> <span class="bt_all"><span>
          <input type="button" value="조회" onclick="go_search();" class="btall"/>
          </span></span> </div>
      </div>
       </form>
      <table class="style_6">
        <colgroup>
        <col width="12%" />
        <col width="11%" />
        <col width="17%" />
        <col width="14%" />
        <col width="14%" />
        <col width="10%" />
        <col width="" />
        </colgroup>
        <thead>
          <tr>
            <th rowspan="2">협력업체명</th>
            <th>주문건수</th>
            <th rowspan="2">매출총액</th>
            <th colspan="2">확정금액+결제예정금액</th>
           
          </tr>
          <tr>
            <th>주문수량</th>
            <th>카드</th>
            <th>현금</th>
          </tr>
        </thead>
        <tbody>
         <c:forEach items = "${list }" var = "vo">
          <tr>
            <td rowspan="2"><c:if test="${vo.com_nm != null }"><a href="javascript:dialog_pop('${vo.com_seq }','N1')"></c:if>${vo.com_nm }<c:if test="${vo.com_nm != null }"></a></c:if></td>
            <td>${vo.ordercount }</td>
            <td rowspan="2">${suf:getThousand(vo.bf_discount) }</td>
            <td rowspan="2">${suf:getThousand(vo.card) }</td>
            <td rowspan="2">${suf:getThousand(vo.virtual + vo.iche) }</td>
          </tr>
          <tr>
            <td>${vo.orderqty }</td>
          </tr>
         </c:forEach>
          
        </tbody>
      </table>
      
      <div class="btn_bottom">
        <div class="r_btn"> <span class="bt_all"> <span>
          <input type="button" value="엑셀 다운로드" onclick="go_excel();" class="btall"/>
          </span> </span> </div>
      </div>
    </div>
  </div>
</div>
<div id="modal_dialog2"></div>
</body>
</html>