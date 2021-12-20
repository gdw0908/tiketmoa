<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<c:set var="view" value="${data.view }"/>
<c:set var="files" value="${data.files }"/>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>상품검색</title>
<script type="text/javascript" src="/lib/js/jcarousellite_1.0.1.js"></script>
<script type="text/javascript" src="/lib/js/jquery.bxslider.js"></script>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	other_listPage(1);
	
	$('#detail_image').bxSlider({
	  nextSelector: '#detail_right',
	  nextText: '<img class="detail_image" src="/images/mobile/sub/details_arrow_right.png" alt="다음">',
	  prevSelector: '#detail_left',
	  prevText:'<img class="detail_image" src="/images/mobile/sub/details_arrow_left.png" alt="이전">',
	  pagerType: 'short',
	  pagerSelector: '#detail_pager',
	});
	
	Kakao.init('4abdd73b12ee3bc587ac809e92594733');

	// 카카오톡 링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
	Kakao.Link.createTalkLinkButton({
	  container: '#kakao-link-btn',
	  label: '${view.part3_nm } / ${view.makernm } ${view.carmodelnm } ${view.cargradenm }',
	  image: {
	    src: "http://partsmoa.co.kr/" + jQuery("#detail_image_0").attr("src") + "_thumb",
	    width: '300',
	    height: '200'
	  },
	  webButton: {
	    text: 'Parts Moa 바로가기',
	    url: "http://partsmoa.co.kr/mobile/goods/view.do?menu=menu2&seq=${view.item_seq }" // 앱 설정의 웹 플랫폼에 등록한 도메인의 URL이어야 합니다.
	  }
	});
});

//다른상품
function other_listPage(page){
	$("#d_con2").load("/mobile/popup/goods/other_list.do?seq=${param.seq}&rows=2&cpage="+page);
}

function changeCarmaker(){
	$.getJSON("/json/list/old_code.carmodel.do", {carmakerseq : $("#carmakerseq").val()}, function(data){
		$("#carmodelseq").empty();
		$.each(data, function(i, o){
			$("#carmodelseq").append("<option value='"+o.carmodelseq+"'>"+o.carmodelnm+"</option>");
		});
	});
}

function changeCarmodel(){
	$.getJSON("/json/list/old_code.cargrade.do", {carmakerseq: $("#carmakerseq").val(),  carmodelseq: $("#carmodelseq").val()}, function(data){
		$("#cargradeseq").empty();
		$.each(data, function(i, o){
			$("#cargradeseq").append("<option value='"+o.cargradeseq+"'>"+o.cargradenm+"</option>");
		});
	});
}

function changeSido(){
	$.getJSON("/json/list/code.sigungu.do", {sido: $("#sido").val()}, function(data){
		$("#sigungu").empty();
		$("#sigungu").append("<option value=''>시/군/구</option>");
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

function cart(seq){
	<c:choose>
		<c:when test="${empty view.stock_num || view.stock_num <= 0}">
			alert("재고수량이 없습니다.");
		</c:when>
		<c:otherwise>
			location.href="/mobile/mypage/shopping/cart/index.do?mode=m_add_cart&seq="+seq+"&qty="+$("#qty").val();
		</c:otherwise>
	</c:choose>
}

function goSubmit(){
	$("#frm").submit();
}

function snsLink(gubun)
{
	var url = location.href;
	$.ajax({
		type : "POST",
		url : "/shorturl.do",
		data : {
			fullurl : "http://openapi.naver.com/shorturl.xml?url="+encodeURIComponent(url)
		},
		dataType : "text",
		success : function(transUrl){
			var title = "${view.part3_nm } / ${view.makernm } ${view.carmodelnm } ${view.cargradenm }";

			if(gubun == "twt"){
				window.open("http://twitter.com/home?status=" + title + ":" + transUrl);
			}else if(gubun == "face"){
				window.open("http://www.facebook.com/sharer/sharer.php?u=" + transUrl + "?t=" +title);
			}
		}
	});
}
</script>
</head>

<body>
<div class="s_details"><img src="/images/mobile/sub/sub_title_a_1_3.gif" alt="상품상세정보"></div>
<div class="sub_wrap">
  <div class="sd_pname">
    <p class="details_title"><strong>${view.part3_nm } </strong>/ ${view.makernm } ${view.carmodelnm } ${view.cargradenm }</p>
    <ul>
      <li><strong>판매가격  : </strong><span class="c1">
      	<c:choose>
          	<c:when test="${view.inquiry_yn eq 'Y' }"><span class="f_style_2">협의</span></c:when>
            <c:otherwise>
          	<c:if test="${!empty view.sale_price }">${suf:getThousand(view.sale_price) } 원</c:if>
        	<c:if test="${empty view.sale_price }">${suf:getThousand(view.user_price) } 원</c:if>
            </c:otherwise>
          </c:choose>
        </span></li>
      <!-- <li><strong>협력사가  : </strong> <span class="c2">${suf:getThousand(view.supplier_price) } 원</span></li> -->
    </ul>
  </div>
  <div class="d_big_box">
    <div class="d_big_img" id="detail_image">
      <c:forEach var="item" items="${files }" varStatus="status">
        <div><img id = "detail_image_${status.index }" class="detail_image" src='/upload/board/${item.yyyy }/${item.mm }/${item.uuid }'></div>
      </c:forEach>
    </div>
    <div class="d_big_btn"> <span class="a_left" id="detail_left"></span> <span class="a_right" id="detail_right"></span> <span class="p_center" id="detail_pager"></span> </div>
  </div>
  <div class="details_info">
    <p class="f_1"><strong>제품정보</strong></p>
    <table class="details_style_1">
      <colgroup>
      <col width="30%">
      <col width="">
      </colgroup>
      <tbody>
        <tr>
          <th>판매가격</th>
          <td class="big_f">
         	<c:choose>
             <c:when test="${view.inquiry_yn eq 'Y' }"><span class="f_style_2">협의</span></c:when>
             <c:otherwise>
               <c:if test="${view.discount_rate > 0}"> <p class="price_un">${suf:getThousand(view.user_price) }</p> ${suf:getThousand(view.sale_price) } </c:if>
               <c:if test="${view.discount_rate == 0 || empty view.discount_rate}"> <p class="f_style_2">${suf:getThousand(view.user_price) } <b>원</b></p> </c:if>
             </c:otherwise>
           </c:choose>
         </td>
        </tr>
        <!-- <tr>
            <th>협력사가</th>
            <td class="big_f">
              <span class="f_style_3">${suf:getThousand(view.supplier_price) } <b>원</b></span>
            </td>
          </tr> -->
        <tr>
          <th>배송비</th>
          <td>  <c:choose>
              	<c:when test="${view.fee_yn eq 'C' }">
              	착불
              	</c:when>
              	<c:when test="${view.fee_yn eq 'Y' }">
              	${view.fee_amount } 원
              	</c:when>
              	<c:otherwise>무료</c:otherwise>
              </c:choose></td>
        </tr>
        <tr>
          <th>제품분류</th>
          <td>${view.part1_nm } &gt; ${view.part2_nm }</td>
        </tr>
        <tr>
          <th> <p>차량명</p>
            <p>부품명</p>
          </th>
          <td><p>${view.makernm } ${view.carmodelnm } ${view.cargradenm }</p>
            <p>${view.part3_nm }</p></td>
        </tr>
        <tr>
          <th>상품코드</th>
          <td>${view.item_code }</td>
        </tr>
        <tr>
          <th> <p>연식</p>
            <p>등급</p>
          </th>
          <td><p>${view.caryyyy } 년</p>
            <p class="c1">${view.grade } 등급</p></td>
        </tr>
        <tr>
          <th>색상</th>
          <td>${view.color_nm }</td>
        </tr>
        <%-- <tr>
          <th>혜택</th>
          <td><c:if test="${!empty view.discount_rate }"><span class="f_style_1">${view.discount_rate }%↓</span></c:if></td>
        </tr> --%>
        <tr>
          <th>판매자정보</th>
          <td><p><strong>${view.com_nm }</strong></p>
            <p>${view.addr1 } ${view.addr2 }</p>
            <p><span class="phone"><strong>${view.staff_tel }</strong></span> <span><a href="#"></a></span></p></td>
        </tr>
        <tr>
          <th>수량</th>
          <td>
          <c:choose>
              <c:when test="${view.inquiry_yn eq 'Y' }"><span class="f_style_2">주문불가</span></c:when>
              <c:otherwise>
              <c:choose>
              	<c:when test="${empty view.stock_num || view.stock_num <= 0}"> 재고수량이 없습니다. </c:when>
              	<c:otherwise>
                <select class="select_1 ws_1" id="qty">
                  <c:forEach var="i" begin="1" end="${view.stock_num }">
                    <option value="${i }">${i }개</option>
                  </c:forEach>
                </select>
                </c:otherwise>
                </c:choose>
              </c:otherwise>
            </c:choose></td>
        </tr>
      </tbody>
    </table>
    <div class="d_info_btn"> 
    <c:choose>
      <c:when test="${view.inquiry_yn eq 'Y' }">
        <p class="d_info_guide">고객센터 <b class="c1">1544-6444</b> 로 연락주시기 바랍니다.</p>
      </c:when>
      <c:otherwise>
        <a href="/mobile/mypage/shopping/cart/index.do?mode=m_direct_order&seq=${param.seq }&qty=1"><img src="/images/sub/details_btn1.gif" alt="구매하기"></a> 
	    <a href="javascript:cart('${param.seq }')"><img src="/images/sub/details_btn2.gif" alt="장바구니"></a>
	    <a class="sns_type" href="javascript:snsLink('twt');"><img src="/images/sub/sns_twitter.png" alt="twitter"></a>
		<a class="sns_type" href="javascript:snsLink('face');"><img src="/images/sub/sns_facebook.png" alt="facebook"></a>
		<a class="sns_type" id = "kakao-link-btn" href="javascript:;"><img src="/images/sub/sns_kakaolink.png" alt="kakaolink"></a>
	      <!-- <a href="#none"><img src="/images/sub/details_btn3.gif" alt="관심상품"></a> -->
      </c:otherwise>
    </c:choose>
    </div>
  </div>
  <div class="h4_line">
    <h4><img src="/images/sub/details_h4_img1.gif" alt="상품설명"></h4>
  </div>
  <div class="details_self">
  	${view.conts }
  	<div class="default">
		<div class="default_box">
		<p class="s1">제품구매시 주의 사항입니다.</p>
		<p class="s2">문의사항은 1544-6444 문의 바랍니다.</p>
		</div>
		<ul>
		<li>배송비<br/>
		모든 배송비는 착불을 기본으로 합니다.<br/>
		- 배송비는 기본 5,000원으로 무게/부피에 따라서 배송비가 증가 됩니다.<br/>
		(범퍼 : 25,000~28,000원 &nbsp; 도어 : 27,000~30,000원 &nbsp; 본닛 : 28,000~35,000원)</li>
		<li>사진은 여건상 실상태 보다 다소 흐리게 나온점 양해바랍니다</li>
		<li><strong>호환여부 반드시 1544-6444번호로 문의바랍니다</strong></li>
		<li>대체로 검사시점의 킬로수인 경우가 많습니다<br>계기판 구매자는 미기재건은 정보가 없는 계기판이므로 <strong>킬로수 관계 없으신분 구매바랍니다</strong></li>
		<li>
		<strong>구매자 부주의로 인한 주문건 교환,반품 배송비용은 고객님 부담입니다</strong><br>
		구매 부품에 대한 명확한 확신이 없을시 반드시 문의바랍니다 <strong>7일이후 반품불가</strong><br>
		<strong>(상품 수령후 7일 이내에 반품건이 공급처에 도착해야됩니다)</strong><br>
		</li>
		<li><strong>가격이 현저히 높을시 1544-6444번호로 문의바랍니다</strong></li>
		<li><strong>모든제품은 착불 발송됩니다</strong> (도서산간, 지역별, 부피에 따라서 금액이 틀립니다.)</li>
		<li>범퍼 본넷 펜다등 <strong>부피나 중량이 큰 제품은 화물택배 발송시 파손이 빈번하여 꼭 수령후 확인 부탁드립니다.</strong></li>
		<li><strong>오디오는 테스트 완료후 출고하는 상품</strong>입니다. 오작동시 다른 원인을 파악하시기 바라고 반품을 원하시면<br><strong>배송비는 구매자님이 부담</strong>해주셔야 합니다.</li>
		<li>바디 부품(예 : 사이드 미러, 헤드 램프)의 경우  <strong>'좌'는 운전석, '우'는 조수석입니다.</strong> 운전자가 운전석에 앞을 보고 앉았을 때 기준입니다. 부품 주문 (구매) 시 착오 없으시기 바랍니다.</li>
		</ul>
	</div>
  
  </div>
  <div class="d_tab_box"> 
    
    <!-- tab -->
    <div id="tabNav_d1" class="details_tab">
      <h4 id="tabNavTitle0101" class="on"><a href="#" onclick="shwoTabNav('01', 3, 1); return false;" onfocus="this.onclick();">공급사정보</a></h4>
      <div id="tabNav0101" style="display:block;">
        <div class="d_con1">
          <div class="supply">
            <p class="details_title"><strong>${view.com_nm }</strong></p>
            <table class="details_style_2">
              <colgroup>
              <col width="45%">
              <col width="">
              </colgroup>
              <tbody>
                <tr>
                  <th> 
                    <p>대표자</p>
                    <p>전화번호</p>
                    <p>팩스번호</p>
                  </th>
                  <td>
                    <p>${view.ceo_nm }&nbsp;</p>
                    <p>${view.tel }&nbsp;</p>
                    <p>${view.fax }&nbsp;</p>
                  </td>
                </tr>
                <tr>
                  <th class="f_normal">사업장소재지</th>
                  <td><p>${view.addr1 }</p>
                    <p>${view.addr2 }</p></td>
                </tr>
                <tr>
                  <th class="f_normal">
                      <p><strong>담당자</strong></p>
                      <p><strong>전화번호</strong></p>
                      <c:if test="${!empty view.staff_tel2 }">
                      <p><strong>담당자2</strong></p>
                      <p><strong>전화번호2</strong></p>
                      </c:if>
                  </th>
                  <td>
                  	  <p>${view.staff_nm }</p>
                      <p>${view.staff_tel }</p>
                      <c:if test="${!empty view.staff_tel2 }">
                      <p>${view.staff_nm2 }</p>
                      <p>${view.staff_tel2 }</p>  
                      </c:if>
                  </td>
                </tr>
                <tr>
                  <th class="f_normal">업체분류</th>
                  <td>${view.comptyp2 } &gt; ${view.comptyp1 }</td>
                </tr>

               <%--  <tr>
                <th class="f_normal">사업자등록번호</th>
                <td>${view.busi_no }</td>
                </tr>
                
                <tr>
                <th class="f_normal">통신판매업신고번호</th>
                <td>${view.telesales_no }</td>
                </tr>
                
                <tr>
                <th class="f_normal">PARTSMOA 가입일</th>
                <td>${view.reg_date }</td>
                </tr> --%>
              </tbody>
            </table>
          </div>
          <p class="d_last">※ 제품과 관련된 자세한 문의사항은 판매 담당자의 연락처로 문의 바랍니다.</p>
        </div>
      </div>
      <h4 id="tabNavTitle0102"><a href="#" onclick="shwoTabNav('01', 3, 2); return false;" onfocus="this.onclick();">판매자 상품보기</a></h4>
      <div id="tabNav0102">
        <div class="d_con1" id="d_con2"> </div>
      </div>
      <h4 id="tabNavTitle0103"><a href="#" onclick="shwoTabNav('01', 3, 3); return false;" onfocus="this.onclick();">반품/교환/환불정보</a></h4>
      <div id="tabNav0103">
        <div class="d_con3">
          <div class="section">
              <h5 class="first">배송안내</h5>
              <div class="sec_box">
                <dl>
                  <dt>1.배송</dt>
                  <dd>택배 집하시간은 4시까지이며, 익일배송을 원칙으로 처리하여 드립니다.</dd>
                  <dd>단, 부피가 큰 부품이나 고객이 원할 경우 1톤, 다마스 차량으로 운송하며, 지방의 경우 화물택배로 배송하여드립니다.</dd>
                  <dd>기타 궁금하신 사항은 1544-6444 고객센터로 문의주시면 언제든지 상세히 답변 드리도록 하겠습니다.</dd>
                  <dd class="c1 b1">주문 예) 화물, 일반, 퀵서비스 선택 가능</dd>
                  <dt>2.배송비</dt>
                  <dd>모든 배송비는 착불을 기본으로 합니다. </dd>
                  <dd>- 택배 가능 부품(한사람이 들 수 있는 무게/부피가 작은 부품)은 기본이 5,000원이며, 무게/부피에 따라 배송비가 증가 됩니다. </dd>
                  <dd>- 택배 불가능한 부품은 경동택배를 통해 발송되며, 배송비는 기본 5,000원으로 무게/부피에 따라 배송비가 증가 됩니다</dd>
                  <dd class="c1">( 범퍼 : 25,000~28,000원  도어 : 27,000~30,000원    본닛 : 28,000~35,000원  )</dd>
                </dl>
              </div>
              <h5>결제안내</h5>
              <div class="sec_box">
                <dl class="sec_2">
                  <dt>1.현금결제</dt>
                  <dd>올더게이트를 이용하여 무통장입금 및 실시간 계좌이체 모두 가능합니다.</dd>
                  <dd>주문 후 3일 이내 입금이 안 될 경우, 자동으로 주문취소되며, 다시 주문해주셔야 합니다.</dd>
                  <dd>무통장입금을 하신 경우에는 주문자와 입금자가 동일해야 합니다.</dd>
                  <dd class="c1">- 부득이하게 다른 경우,</dd>
                  <dd class="c1">T: 1544-6444 고객센터로 연락하여 주시기 바랍니다.</dd>
                  <dd class="c1">- 계좌번호 안내</dd>
                  <dd class="c1 b1">T: 1544-6444 고객센터로 연락하여 주시기 바랍니다.</dd>
                  <dt>2.카드결제</dt>
                  <dd>파츠모아의 신용카드 결제는 올더게이트 전자결제를 이용하여 고객의 카드 정보를 안전하게 보호하며,<br>
                    신용카드를 이용한 결제는 즉시 주문처리가 가능하므로 빠르게 배송처리할 수 있습니다.</dd>
                </dl>
              </div>
              <h5>교환 및 반품안내</h5>
              <dl class="sec_3">
                <dt>1.교환안내</dt>
                <dd>상품을 배송 받은 날부터 7일 이내 교환은 언제든지 가능합니다. </dd>
                <dd class="c1">(주문하신 상품에 따라 배송기간이 조금 상이 할 수도 있음 / 동일 배송지의 1회만 가능)</dd>
                <dd>단, 고객님의 과실 혹은 단순 변심으로 인해 교환이 불가능할 수 있습니다.</dd>
                <dd class="b1">기타 궁금하신 사항은 1544-6444 고객센터로 문의 주시면 언제든지 상세히 답변 드리도록 하겠습니다.</dd>
                <dt>2.반품안내</dt>
                <dd>상품 특성상 포장을 개봉하시거나 상품을 사용하신 후에는 반품이 불가하오니 이점 유의하시기 바랍니다.</dd>
                <dd>단, 제품하자 시에는 1544-6444 고객센터로 문의 주시면 처리절차에 대해 친절하게 안내해 드리겠습니다.</dd>
                <dd class="c1" style="margin:12px 0 0 26px;">※ 파츠모아에 입고되서 판매하기까지의 절차와 주문, 결제, 배송 등에 대한 설명<br>
                  기존 판매 절차와 동일 하며, 파츠모아를 통하지 않고 거래 되는 부분에 대해서는 관련 책임을 지지 않습니다.</dd>
              </dl>
            </div>
        </div>
      </div>
    </div>
    <script type="text/javascript">
          function shwoTabNav(eName, totalNum, showNum) {
          	for(i=1; i<=totalNum; i++){
          		var zero = (i >= 10) ? "" : "0";
          		var e = document.getElementById("tabNav" + eName + zero + i);
          		var eTitle = document.getElementById("tabNavTitle" + eName + zero + i);
          		e.style.display = "none";
          		eTitle.className = "";
          	}

          	var zero = (showNum >= 10) ? "" : "0";
          	var e = document.getElementById("tabNav" + eName + zero + showNum);
          	var eTitle = document.getElementById("tabNavTitle" + eName + zero + showNum);
          	e.style.display = "block";
          	eTitle.className = "on";
          }
          </script> 
    <!-- //tab --> 
    
  </div>
</div>
</body>
</html>
