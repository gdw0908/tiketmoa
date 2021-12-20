<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>상품관리</title>
<script type="text/javascript">
function list(value){
	location.replace("?menu=${param.menu }&rows=" + value);
}
$( document ).ready(function() {
	$("img").each(function(){
		if($(this).attr("src") == "/upload/board///_thumb"){
			$(this).attr("src", "/images/common/no_image.gif");
		}
	})	
	$("img").on("error", function(){
		$(this).off("error").attr("src", "/images/common/no_image.gif");
	});
});
</script>
</head>
<body>
	<div class="product_tab">
        <ul>
          <li><a href="seller_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab1_off.gif" alt="상품관리"></a></li>
          <li><a href="product_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab2_off.gif" alt="주문현황"></a></li>
          <li><a href="resources_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab3_off.gif" alt="자원관리"></a></li>
          <li><a href="selfcamera_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab4_on.gif" alt="셀카현황"></a></li>
        </ul>
      </div>

      <div class="sub_wrap">
        <div class="sub_line">
          <h3><img src="/images/mobile/sub/sub_title_b_7.gif" alt="셀카목록"></h3>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>
        <div class="sc_top">
          <ul class="sc_tab">
            <li class="first"><a class="on" href="#">전체</a></li>
          </ul>
          <div class="sc_type">
            <select id="rows" name="rows" class="select_1" onchange = "list(this.value);">
            <option value = "10" <c:if test = "${param.rows eq '10'}">selected</c:if>>10개</option>
            <option value = "30" <c:if test = "${param.rows eq '30'}">selected</c:if>>30개</option>
            <option value = "50" <c:if test = "${param.rows eq '50'}">selected</c:if>>50개</option>
            </select>
          </div>
        </div>

        <div class="sub_list">
          <ul>
          	<c:forEach var="item" items="${list }" varStatus="status">
            <li>
            <div>
			  <span class="img_box">
			  	<span class="img_b1"><a href="selfcamera_modify.do?menu=menu8&amp;seq=${item.seq }"><img src="${item.thumb }" alt="이미지1"></a></span>
			  	<span class="img_btn a_type"><a href="selfcamera_modify.do?menu=menu8&amp;seq=${item.seq }"><img src="/images/mobile/sub/btn_mod_s1.gif" alt="셀카수정"></a></span>
			  </span>
			  <a href="selfcamera_modify.do?menu=menu8&amp;seq=${item.seq }">
              	<span class="info">
              		<span style="margin-top:10px;"><strong>업&nbsp;체&nbsp;명 : </strong>${item.com_nm }</span>
              		<span style="margin-top:10px;"><strong>등&nbsp;록&nbsp;일 : </strong>${item.reg_dt }</span>
			  		<span style="margin-top:10px;"><strong>지&nbsp;&nbsp;&nbsp;&nbsp;역 : </strong>${item.dong_nm }</span>
			  		<span style="margin-top:10px;"><strong>전화번호 : </strong>${item.staff_tel }</span>
			  		<span style="margin-top:10px;">
			  			<strong>상&nbsp;&nbsp;&nbsp;&nbsp;태 : </strong>
			  			${item.state == '0' ? '등록' : item.state == '1' ? '검토중' : item.state == '2' ? '반려' : item.state == '3' ? '구매완료' : '삭제' }
			  		</span>
              </span>
			 </a>
            </div>
            </li>
			</c:forEach>
          </ul>
        </div>
		<div class="vr_btn">
			<a href="selfcamera_insert.do?menu=menu8"><img src="/images/mobile/sub/btn_register.gif" alt="등록"></a>
		</div>
		
        <jsp:include page="/inc/paging2.do">
			<jsp:param  name="cpage" value="${param.cpage }"/>
			<jsp:param  name="rows" value="${param.rows }"/>
			<jsp:param  name="totalpage" value="${pagination.totalpage }"/>
		</jsp:include>
      </div>
</body>
</html>