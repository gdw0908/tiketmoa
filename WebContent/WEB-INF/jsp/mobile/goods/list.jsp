<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!-- 파라미터 -->
<c:set var="paramset" value=""/>
<c:forEach var="item" items="${pageContext.request.parameterNames}">
	<c:if test="${!(item eq 'totalpage' || item eq 'cpage' || item eq 'rows' || item eq 'sort' || item eq 'focus' || item eq 'show')}">
	<c:choose>
		<c:when test="${paramset eq '' }">
			<c:set var="paramset" value="${paramset }?${item }=${param[item] }"/>
		</c:when>
		<c:otherwise>
			<c:set var="paramset" value="${paramset }&${item }=${param[item] }"/>
		</c:otherwise>
	</c:choose>
	</c:if>
</c:forEach>
<c:choose>
	<c:when test="${paramset eq '' }">
		<c:set var="paramset" value="?"/>
	</c:when>
	<c:otherwise>
		<c:set var="paramset" value="${paramset }&"/>
	</c:otherwise>
</c:choose>
<!-- //파라미터 -->
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>상품검색</title>
<script type="text/javascript">
$(document).ready(function(){
	$("#submenu_open").toggle(function(){
		$("#sub_menu").slideToggle(250);
		this.src = "/images/mobile/sub/sub_menu_close.gif";
	}, function() {
		$("#sub_menu").slideToggle(250);
		this.src = "/images/mobile/sub/sub_menu_open.gif";
	});
});

function changeMenu(){
	if($("#menu_id").val() == ""){
		$("#part2_1").empty();
		$("#part2_1").append("<option value=''>전체</option>");
	}else{
		$.getJSON("/json/list/old_code.codeList.do", {upcodeno : "05090100"+$("#menu_id").val().replace("menu","")}, function(data){
			$("#part2_1").empty();
			$("#part2_1").append("<option value=''>전체</option>");
			$.each(data, function(i, o){
				$("#part2_1").append("<option value='"+o.code+"'>"+o.code_nm+"</option>");
			});
		});
	}
}


function changeCarmaker(){
	if($("#carmakerseq").val() == ""){
		$("#carmodelseq").empty();
		$("#carmodelseq").append("<option value=''>전체</option>");
		$("#cargradeseq").empty();
		$("#cargradeseq").append("<option value=''>전체</option>");
	}else{
		$("#cargradeseq").empty();
		$("#cargradeseq").append("<option value=''>전체</option>");
		$.getJSON("/json/list/old_code.carmodel.do", {carmakerseq : $("#carmakerseq").val()}, function(data){
			$("#carmodelseq").empty();
			$("#carmodelseq").append("<option value=''>전체</option>");
			$.each(data, function(i, o){
				$("#carmodelseq").append("<option value='"+o.carmodelseq+"'>"+o.carmodelnm+"</option>");
			});
		});
	}
}

function changeCarmodel(){
	$.getJSON("/json/list/old_code.cargrade.do", {carmakerseq: $("#carmakerseq").val(),  carmodelseq: $("#carmodelseq").val()}, function(data){
		$("#cargradeseq").empty();
		$("#cargradeseq").append("<option value=''>전체</option>");
		$.each(data, function(i, o){
			$("#cargradeseq").append("<option value='"+o.cargradeseq+"'>"+o.cargradenm+"</option>");
		});
	});
}

function changeSido(){
	$.getJSON("/json/list/code.sigungu.do", {sido: $("#sido").val()}, function(data){
		$("#sigungu").empty();
		$("#sigungu").append("<option value=''>시/군/구</option>");
		$("#dong").empty();
		$("#dong").append("<option value=''>읍/면/동</option>");
		$.each(data, function(i, o){
			$("#sigungu").append("<option value='"+o.sigungu+"'>"+o.dong_nm+"</option>");
		});
	});
}

function changeSigungu(){
	$.getJSON("/json/list/code.dong.do", {sido: $("#sido").val(), sigungu: $("#sigungu").val()}, function(data){
		$("#dong").empty();
		$("#dong").append("<option value=''>읍/면/동</option>");
		$.each(data, function(i, o){
			$("#dong").append("<option value='"+o.dong+"'>"+o.dong_nm+"</option>");
		});
	});
}

function goSubmit(){
	$("#frm").submit();
}

function list(value){
	location.replace("${paramset}rows=" + value+"&show=${param.show}&sort=${param.sort}&focus=${param.focus}");
}

function frmreset(){
	<c:if test="${param.menu eq '' || param.menu eq null}">
	document.frm.menu.value = "";
	</c:if>
	document.frm.carmakerseq.value = "";
	document.frm.carmodelseq.value = "";
	document.frm.cargradeseq.value = "";
	document.frm.caryyyy.value = "";
	<c:if test="${param.menu eq 'menu1' || param.menu eq 'menu2' || param.menu eq 'menu3' || param.menu eq 'menu4' || param.menu eq '' || param.menu eq null}">
	document.frm.part2_1.value = "";
	</c:if>
	document.frm.grade.value = "";
	document.frm.sido.value = "";
	document.frm.sigungu.value = "";
	document.frm.dong.value = "";
	document.frm.keyword.value = "";
	document.frm.search_all_text.value = "";
}

function go_url(url){	
	location.replace(url);
}

function select_url(){
	if($("#url").val() == ""){
		alert("이동 할 메뉴를 선택해주세요.");
		return;
	}else{
		location.replace($("#url").val());
	}
}

function replaceApplication(){
	if(confirm("조회 건수가 없습니다.\n부품문의로 이동하시겠습니까?")){
		location.href="/mobile/mypage/application/index.do?menu=menu1";
	}
}
<c:if test="${fn:length(data.list) == 0}">
	replaceApplication();
</c:if>
</script>
</head>
<body>
	<form action="list.do" method="post" id="frm" name="frm">
	<c:choose>
		<c:when test="${param.menu == 'menu9' }">
		<div class="sm_wrap">
		  <div class="sm_top"> <span class="select_box s_menu_type">
		    <select id="url" name="url" class="select_sm">
				<option value="">메뉴를 선택해 주세요</option>
				<option value="/mobile/goods/list.do?menu=menu9&part2=050901006003"<c:if test="${param.part2 == '050901006003'}"> selected="selected"</c:if>>알터네이터</option>
				<option value="/mobile/goods/list.do?menu=menu9&part2=050901006001"<c:if test="${param.part2 == '050901006001'}"> selected="selected"</c:if>>A/C 콤프레서</option>
				<option value="/mobile/goods/list.do?menu=menu9&part2=050901006002"<c:if test="${param.part2 == '050901006002'}"> selected="selected"</c:if>>스타트모터</option>
		    </select>
		    </span> <span class="sm_btn"><a href="javascript:select_url();"><img src="/images/mobile/sub_2/sub_menu_a_1.gif" alt="메뉴이동"></a></span> </div>
		</div>
		</c:when>
		<c:otherwise>
		<!-- Start -->
      <div class="sm_wrap">
        <div class="sm_top">
          <span class="select_box">
			<select id="menu_id" name="menu" class="select_sm" onchange="changeMenu();">
				<option value="">부품을 선택해 주세요.</option>
				<option value="menu1" <c:if test="${param.menu eq 'menu1' }">selected="selected"</c:if>>바디</option>
				<option value="menu2" <c:if test="${param.menu eq 'menu2' }">selected="selected"</c:if>>의장</option>
				<option value="menu3" <c:if test="${param.menu eq 'menu3' }">selected="selected"</c:if>>엔진</option>
				<option value="menu4" <c:if test="${param.menu eq 'menu4' }">selected="selected"</c:if>>샤시</option>
			</select>
          </span>
          <span class="sm_btn"><img id="submenu_open" src="/images/mobile/sub/sub_menu_open.gif" alt="상세조건 검색버튼" style="cursor:pointer;"></span>
          <div class="sm_con" id="sub_menu" style="display:none;">
            <div class="con_1">
              <h3><img src="/images/mobile/sub/details_title.gif" alt="부품 상세검색"></h3>
              <p class="c1">※검색조건과 함께 찾으시는 부품을 선택해 주세요</p>
              <table class="sm_style_1">
              <colgroup>
              <col width="20%">
              <col width="">
              </colgroup>
              <tbody>

              <tr>
                <th scope="row">제조사</th>
                <td>
                  <select id="carmakerseq" name="carmakerseq" class="select_sm" onchange="changeCarmaker()">
                  	<option value="">전체</option>
                	<c:forEach var="item" items="${data.carmaker }">
                	<option value="${item.carmakerseq }" <c:if test="${item.carmakerseq eq param.carmakerseq }">selected="selected"</c:if>>${item.makernm }</option>
                	</c:forEach>
				  </select>
                </td>
              </tr>

              <tr>
                <th scope="row">차량명</th>
                <td>
                  <select id="carmodelseq" name="carmodelseq" class="select_sm" onchange="changeCarmodel()">
                    <option value="">전체</option>
                	<c:forEach var="item" items="${data.carmodel }">
                	<option value="${item.carmodelseq }" <c:if test="${item.carmodelseq eq param.carmodelseq }">selected="selected"</c:if>>${item.carmodelnm }</option>
                	</c:forEach>
              	  </select>
                </td>
              </tr>

              <tr>
                <th scope="row">모델명</th>
                <td>
              	  <select id="cargradeseq" name="cargradeseq" class="select_sm" >
              	    <option value="">전체</option>
                	<c:forEach var="item" items="${data.cargrade }">
                	<option value="${item.cargradeseq }" <c:if test="${item.cargradeseq eq param.cargradeseq }">selected="selected"</c:if>>${item.cargradenm }</option>
                	</c:forEach>
              	</select>
                </td>
              </tr>

              <tr>
                <th scope="row">연식</th>
                <td>
                  <select id="caryyyy" name="caryyyy" class="select_sm">
                    <option value="">전체</option>
              		<c:forEach var="item" begin="1995" end="${dtf:getTime('yyyy') }">
              			<option value="${item }" <c:if test="${item eq param.caryyyy }">selected="selected"</c:if>>${item }년</option>
               		</c:forEach>
              	  </select>
                </td>
              </tr>

              <tr>
                <th scope="row">세부부품</th>
                <td>
                  <select id="part2_1" name="part2_1" class="select_sm">
                  		<option value="">전체</option>
	              	<c:forEach var="item" items="${data.part2 }">
	              		<option value="${item.code }" <c:if test="${item.code eq param.part2_1 }">selected="selected"</c:if>>${item.code_nm }</option>
	              	</c:forEach>
	              </select>
                </td>
              </tr>

              <tr>
                <th scope="row">등급</th>
                <td>
                  <select id="grade" name="grade" class="select_sm">
              			<option value="">전체</option>
              		<c:forEach var="item" items="${data.grade }">
              			<option value="${item.code }" <c:if test="${item.code eq param.grade }">selected="selected"</c:if>>${item.code_nm }</option>
              		</c:forEach>
              	  </select>
                </td>
              </tr>

              </tbody>
              </table>
            </div>
            <div class="con_2">
              <table class="sm_style_1">
              <colgroup>
              <col width="20%">
              <col width="">
              </colgroup>
              <tbody>

              <tr>
                <th scope="row">지역별</th>
                <td class="s_type_2">
                  <span>
                  <select id="sido" name="sido" class="select_sm" onchange="changeSido()">
	              	<option value="">시/도</option>
	              	<c:forEach var="item" items="${data.sido }">
	              		<option value="${item.sido }" <c:if test="${item.sido eq param.sido }">selected="selected"</c:if>>${item.dong_nm }</option>
	              	</c:forEach>
	              </select>
                  </span>

                  <span>
                  <select id="sigungu" name="sigungu" class="select_sm" onchange="changeSigungu()">
	              	<option value="">시/군/구</option>
	              	<c:forEach var="item" items="${data.sigungu }">
	              		<option value="${item.sigungu }" <c:if test="${item.sigungu eq param.sigungu }">selected="selected"</c:if>>${item.dong_nm }</option>
	              	</c:forEach>
	              </select>
                  </span>
                  <span class="last">
                  <select id="dong" name="dong" class="select_sm">
	              <option value="">읍/면/동</option>
	              	<c:forEach var="item" items="${data.dong }">
	              		<option value="${item.dong }" <c:if test="${item.dong eq param.dong }">selected="selected"</c:if>>${item.dong_nm }</option>
	              	</c:forEach>
	              </select>
                  </span>
                </td>
              </tr>

              <tr>
                <th scope="row">조건 내 검색</th>
                <td class="i_type_2">
                <input type="hidden" name="search_all_text" class="input_1" value="${param.search_all_text }">
                  <p>
                  <span class="input_t"><input type="text" name="keyword" class="input_1" value="${param.keyword }"></span>
                  <span class="btn">
                  <a href="javascript:;" onclick="frmreset();"><img src="/images/mobile/common/btn_reset.gif" alt="초기화"></a>
                  <a href="javascript:goSubmit();"><img src="/images/mobile/common/btn_search.gif" alt="검색"></a>
                  </span>
                  </p>
                </td>
              </tr>
              </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
		<!-- End -->
		</c:otherwise>
	</c:choose>
	
	
	
	
      <div class="sub_wrap">
        <div class="sub_line">
          <c:choose>
      		<c:when test="${param.menu eq 'menu1' }"><h3><img src="/images/mobile/sub/sub_title_1.gif" alt="바디 부품정보"></h3></c:when>
      		<c:when test="${param.menu eq 'menu2' }"><h3><img src="/images/mobile/sub/sub_title_2.gif" alt="의장 부품정보"></h3></c:when>
      		<c:when test="${param.menu eq 'menu3' }"><h3><img src="/images/mobile/sub/sub_title_3.gif" alt="엔진 부품정보"></h3></c:when>
      		<c:when test="${param.menu eq 'menu4' }"><h3><img src="/images/mobile/sub/sub_title_4.gif" alt="샤시 부품정보"></h3></c:when>
      		<c:when test="${param.menu eq 'menu5' }"><h3><img src="/images/mobile/sub/sub_title_5.gif" alt="국산차 부품정보"></h3></c:when>
      		<c:when test="${param.menu eq 'menu6' }"><h3><img src="/images/mobile/sub/sub_title_6.gif" alt="수입차 부품정보"></h3></c:when>
      		<c:when test="${param.menu eq '' || param.menu eq null}"><h3><img src="/images/mobile/sub/sub_title_search.gif" alt="통합검색"></h3></c:when>
      		<c:when test="${param.menu eq 'menu9' && param.part2 eq '050901006003'}"><h3><img src="/images/mobile/sub/sub_title_10_1.gif" alt="알터네이터"></h3></c:when>
      		<c:when test="${param.menu eq 'menu9' && param.part2 eq '050901006001'}"><h3><img src="/images/mobile/sub/sub_title_10_2.gif" alt="A/C콤프레서"></h3></c:when>
      		<c:when test="${param.menu eq 'menu9' && param.part2 eq '050901006002'}"><h3><img src="/images/mobile/sub/sub_title_10_3.gif" alt="스타트모터"></h3></c:when>
      	  </c:choose>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>


		<c:if test="${!(fn:length(data.list) == 0 && param.menu == 'menu9') }">
        <div class="sc_top">
          <ul class="sc_tab">
            <li class="first"><a <c:if test = "${empty param.focus}">class="on"</c:if> href="javascript:go_url('${paramset }show=${param.show }&rows=${param.rows }');">신상품</a></li>
            <li><a <c:if test = "${param.focus eq '1'}">class="on"</c:if> href="javascript:go_url('${paramset }sort=row&focus=1&show=${param.show }&rows=${param.rows }');">낮은가격</a></li>
            <li class="last"><a <c:if test = "${param.focus eq '2'}">class="on"</c:if> href="javascript:go_url('${paramset }sort=high&focus=2&show=${param.show }&rows=${param.rows }');">높은가격</a></li>
          </ul>
		  <!-- <span><strong>총 부품 : <b>${suf:getThousand(data.pagination.totalcount) }</b> 개</strong></span> -->
          <div class="sc_type">
            <select id="rows" name="rows" class="select_1" onchange="list(this.value);">
            <option value = "10" <c:if test = "${param.rows eq '10'}">selected</c:if>>10개</option>
            <option value = "30" <c:if test = "${param.rows eq '30'}">selected</c:if>>30개</option>
            <option value = "50" <c:if test = "${param.rows eq '50'}">selected</c:if>>50개</option>
            </select>
          </div>
        </div>
		</c:if>
		
		
        <c:choose>
        <c:when test="${fn:length(data.list) == 0 && param.menu == 'menu9'}">
        	<div class="sub_contents_img">
        	<c:if test="${param.part2 == '050901006003'}">
      		<p><img src="/images/sub/contents_img_01.gif" alt="알터네이터 문의"></p>
      		</c:if>
      		<c:if test="${param.part2 == '050901006001'}">
      		<p><img src="/images/sub/contents_img_02.gif" alt="A/C콤프레서 문의"></p>
      		</c:if>
      		<c:if test="${param.part2 == '050901006002'}">
      		<p><img src="/images/sub/contents_img_03.gif" alt="스타트모터 문의"></p>
      		</c:if>
      		</div>
        </c:when>
        <c:otherwise>
		<!-- start -->
        <div class="sub_list">
          <ul>
          	<c:forEach var="item" items="${data.list }">
				<li>
                <a href="view.do?menu=menu2&seq=${item.item_seq }">
				<span class="img"><img src="${item.thumb }" alt="${item.part3_nm }"></span>
				<span class="info">
				<span class="in_t1">
				<span class="first"><strong>${item.carmodelnm } (${item.caryyyy })</strong></span>
				<span><strong>${item.part3_nm }</strong></span>
				<span><strong>${item.grade }등급</strong></span>
				</span>
<%-- 				<span><strong>${item.com_nm }</strong> / ${item.sigungu_nm }</span> --%>
				<span><strong>상품코드</strong> / ${item.item_code }</span>
				<span class="t_money">
				<c:choose>
		          	<c:when test="${item.inquiry_yn eq 'Y' }"><span class="c2">협의</span></c:when>
		            <c:otherwise>
		          	<c:if test="${!empty item.sale_price }">
		              <span class="c2">판매가격 : ${suf:getThousand(item.sale_price) } 원</span>
	            	</c:if>
					<c:if test="${empty item.sale_price }">
		              <span class="c2">판매가격 : ${suf:getThousand(item.user_price) } 원</span>
	            	</c:if>
		            </c:otherwise>
          		</c:choose>
				</span>
				</span>
				</a>
				</li>
			</c:forEach>
          </ul>
        </div>
		

        <jsp:include page="/inc/paging2.do">
			<jsp:param  name="cpage" value="${param.cpage }"/>
			<jsp:param  name="rows" value="${param.rows }"/>
			<jsp:param  name="totalpage" value="${data.pagination.totalpage }"/>
		</jsp:include>
		<!-- end -->
		</c:otherwise>
		</c:choose>
      </div>
      </form>
</body>
</html>