<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="com.mc.common.util.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%
/**********************************************************************************************
*
* 파일명 : AGS_pay_result.jsp
* 작성일자 : 2009/1/16
*
* 소켓결제결과를 처리합니다.
*
* Copyright AEGIS ENTERPRISE.Co.,Ltd. All rights reserved.
*
**********************************************************************************************/
request.setCharacterEncoding("UTF-8");

//공통사용
String AuthTy 		= request.getParameter("AuthTy");												//결제형태
String SubTy 		= request.getParameter("SubTy");												//서브결제형태
String rStoreId 	= request.getParameter("rStoreId");												//업체ID
String rOrdNo 		= request.getParameter("rOrdNo");												//주문번호
String rAmt 		= request.getParameter("rAmt");													//거래금액
String rProdNm 		= request.getParameter("rProdNm");	//상품명
String rOrdNm 		= request.getParameter("rOrdNm");	//주문자명

String AGS_HASHDATA = request.getParameter("AGS_HASHDATA");	// 주문 해쉬값

//소켓통신결제(신용카드,핸드폰,일반가상계좌)시 사용
String rSuccYn 		= request.getParameter("rSuccYn");												//성공여부
String rApprTm 		= request.getParameter("rApprTm");												//승인시각
String rResMsg 		= request.getParameter("rResMsg");	//실패사유

//신용카드공통
String rBusiCd 		= request.getParameter("rBusiCd");				//전문코드
String rApprNo 		= request.getParameter("rApprNo");				//승인번호
String rCardCd 		= request.getParameter("rCardCd");				//카드사코드

//신용카드(안심,일반)
String rMembNo 		= request.getParameter("rMembNo");												//가맹점번호
String rAquiCd 		= request.getParameter("rAquiCd");												//매입사코드
String rBillNo 		= request.getParameter("rBillNo");												//전표번호
String rCardNm 		= request.getParameter("rCardNm");	//카드사명
String rAquiNm 		= request.getParameter("rAquiNm");	//매입사명

//신용카드(ISP)
String rDealNo 		= request.getParameter("rDealNo");				//거래고유번호

//계좌이체
String ICHE_AMOUNT 	= request.getParameter("ICHE_AMOUNT");															//이체금액
String ICHE_OUTBANKNAME = request.getParameter("ICHE_OUTBANKNAME");		//이체계좌은행명
String ICHE_OUTBANKMASTER = request.getParameter("ICHE_OUTBANKMASTER");	//이체계좌소유주

//핸드폰
String rHP_TID 		= request.getParameter("rHP_TID");				//핸드폰결제TID
String rHP_DATE 		= request.getParameter("rHP_DATE");			//핸드폰결제날짜
String rHP_HANDPHONE 	= request.getParameter("rHP_HANDPHONE");	//핸드폰결제핸드폰번호
String rHP_COMPANY 	= request.getParameter("rHP_COMPANY");			//핸드폰결제통신사명(SKT,KTF,LGT)

//ARS
String rARS_PHONE = request.getParameter("rARS_PHONE");		//ARS결제전화번호

//가상계좌
String rVirNo 		= request.getParameter("rVirNo");				//가상계좌번호
String VIRTUAL_CENTERCD = request.getParameter("VIRTUAL_CENTERCD" );//입금가상계좌은행코드

String mTId 		= request.getParameter("mTId" );				

//이지스에스크로
String ES_SENDNO	= request.getParameter("ES_SENDNO" );			//이지스에스크로(전문번호)

//*******************************************************************************
//* MD5 결제 데이터 정상여부 확인
//* 결제전 AGS_HASHDATA 값과 결제 후 rAGS_HASHDATA의 일치 여부 확인
//* 형태 : 상점아이디(StoreId) + 주문번호(OrdNo) + 결제금액(Amt)
//*******************************************************************************

int rAmt_hash = Integer.parseInt(rAmt);

StringBuffer sb = new StringBuffer();
sb.append(rStoreId);
sb.append(rOrdNo);
sb.append(rAmt_hash);

byte[] bNoti = sb.toString().getBytes();
MessageDigest md = MessageDigest.getInstance("MD5");
byte[] digest = md.digest(bNoti);

StringBuffer strBuf = new StringBuffer();
for (int i=0 ; i < digest.length ; i++) {
    int c = digest[i] & 0xff;
    if (c <= 15){
        strBuf.append("0");
    }
    strBuf.append(Integer.toHexString(c));
}

String rAGS_HASHDATA = strBuf.toString();
String errResMsg ="";
if (!(rAGS_HASHDATA.equals(AGS_HASHDATA))) errResMsg = "결재금액 변조 발생. 확인 바람.";

%>
<c:set var="user_price" value="0"/>
<c:set var="discount_price" value="0"/>
<c:set var="fee_price" value="0"/>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>상품검색</title>
<script type="text/javascript" src="/lib/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/lib/js/jquery.lck.util.js"></script>
<script language=javascript>//"지불처리중"팝업창 닫는 부분 (AGS_pay.html에서 submit 전에 띄운 팝업 창을 닫는 스크립트)
<!--
var openwin = window.open("AGS_progress.html","popup","width=300,height=160");
openwin.close();
-->
</script>
<script language=javascript>
<!--
/*************************************************************************
* ◈ 영수증 출력을 위한 자바스크립트
*		
*	영수증 출력은 [카드결제]시에만 사용하실 수 있습니다.
*  
*   ※당일 결제건에 한해서 영수증 출력이 가능합니다.
*     당일 이후에는 아래의 주소를 팝업으로 띄워 내역 조회 후 출력하시기 바랍니다.
*	  ▷ 팝업용 결제내역조회 패이지 주소 : 
*	     	 http://www.allthegate.com/support/card_search.html
*
*************************************************************************/
function show_receipt() 
{
	if("<%=rSuccYn%>"== "y" && "<%=AuthTy%>" =="card")
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
-->
</script>
</head>
<body>
	<div class="c_wrap">
      <div id="sub">
        <div class="strapline">
          <h3><img src="/images/sub_2/h3_img_4_1.gif" alt="나의쇼핑"></h3>
          <div class="state"> <span>홈</span> &gt; <span>고객센터</span> &gt; <span><strong>나의쇼핑</strong></span> </div>
        </div>
        <div class="contents">
          <div class="title_rocation">
            <h4><img src="/images/sub_2/h4_img3.gif" alt="주문완료"></h4>
            <ul>
              <li><img src="/images/sub_2/cart_r1.gif" alt="장바구니"></li>
              <li><img src="/images/sub_2/cart_r2.gif" alt="주문/결제"></li>
              <li><img src="/images/sub_2/cart_r3_on.gif" alt="주문완료"></li>
            </ul>
          </div>
          <p class="shopping_img"><img src="/images/sub_2/shopping_img_1.gif" alt="PARTS MOA를 이용해 주셔서 감사합니다 주문하신 내역은 나의 쇼핑정보에서 다시 확인이 가능합니다"></p>
          <h5 class="pay_type">결제내역</h5>

          <div class="cart_style_2">

            <table>
            <colgroup>
            <col width="20%">
            <col width="">
            </colgroup>
            <tbody>
            <tr>
              <th scope="row" rowspan="2">
              			<%

							if(AuthTy.equals("card"))
							{
								if(SubTy.equals("isp"))
								{
									out.println( "신용카드결제-안전결제(ISP)");
								}	
								else if(SubTy.equals("visa3d"))
								{
									out.println( "신용카드결제-안심클릭");
								}
								else if(SubTy.equals("normal"))
								{
									out.println( "신용카드결제-일반결제");
								}
								
							}
							else if(AuthTy.equals("iche"))
							{
								out.println( "계좌이체");
							}
							else if(AuthTy.equals("hp"))
							{
								out.println( "핸드폰결제");
							}
							else if(AuthTy.equals("ars"))
							{
								out.println( "ARS결제");
							}
							else if(AuthTy.equals("virtual"))
							{
								out.println( "가상계좌결제");
							}
							%>
              </th>
              <td>결제금액 : <b class="b_num"><%=StringUtil.getThousand(rAmt) %></b>원</td>
            </tr>
            <tr> 
              <td>납부방식 : ${param.rCardNm }</td>
            </tr>
            </tbody>
            </table>

          </div>
          
          <h5 class="pay_type">주문내역</h5>

          <table class="cart_style_1">
          <caption>
          장바구니 리스트
          </caption>
          <colgroup>
          <col width="">
          <col width="7%">
          <col width="10.5%">
          <col width="9%">
          <col width="9%">
          <col width="10%">
          <col width="15%">
          </colgroup>
          <thead>
          <tr>
            <th scope="col">제품정보</th>
            <th scope="col">수량</th>
            <th scope="col">가격</th>
            <th scope="col">할인</th>
            <th scope="col">배송비</th>
            <th scope="col">합계</th>
            <th scope="col">주문번호/영수증</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="item" items="${data.list }" varStatus="status">
			<c:set var="user_price_l" value="0"/>
			<c:set var="discount_price_l" value="0"/>
			<c:set var="fee_price_l" value="0"/>
          	<c:choose>
	       		<c:when test="${(sessionScope.member.group_seq eq '3' or sessionScope.member.group_seq eq '9') && item.supplier_pricing_yn eq 'Y'}">
	       			<c:set var="user_price" value="${user_price + (item.supplier_price * item.qty) }"/>
					<c:set var="user_price_l" value="${item.supplier_price * item.qty }"/>
					<c:set var="discount_price_l" value="${(item.user_price * item.qty) - (item.supplier_price * item.qty) }"/>
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
          <tr>
            <td class="cart_main">
              <div class="product_box">
                <div class="pb_l"> <a href="#"><img src="${item.thumb }" alt=""></a> </div>
                <div class="pb_r ws_3">
                  <p>
                  <a href="#">
                  <span><strong>${item.part3_nm }</strong></span>
                  <span><strong>${item.carmodelnm } ${item.cargradenm } (${item.caryyyy })</strong></span>
                  <span>${item.grade }등급 / ${item.com_nm }</span>
                  </a>
                  </p>
                </div>
              </div>
            </td>
            <td>${item.qty }개</td>
            <td>
            	<c:choose>
              		<c:when test="${(sessionScope.member.group_seq eq '3' or sessionScope.member.group_seq eq '9') && item.supplier_pricing_yn eq 'Y'}">
              			${suf:getThousand(item.supplier_price) }
              		</c:when>
              		<c:otherwise>
	              		${suf:getThousand(item.user_price) }
              		</c:otherwise>
              	</c:choose> 원 
              	<c:if test="${item.qty>1 }"> x ${item.qty}</c:if>
            </td>
            <td>
            	<p class="first">
              	<c:choose>
              		<c:when test="${(sessionScope.member.group_seq eq '3' or sessionScope.member.group_seq eq '9') && item.supplier_pricing_yn eq 'Y'}">
              			${suf:getThousand(item.user_price - item.supplier_price) }
              		</c:when>
              		<c:otherwise>
              			<c:if test="${item.discount_rate > 0}">
			              ${suf:getThousand(item.user_price - item.sale_price) }
		            	</c:if>
						<c:if test="${item.discount_rate == 0 || empty item.discount_rate}">
			              0
		            	</c:if>
              		</c:otherwise>
              	</c:choose> 원 
              	<c:if test="${item.qty>1 }"> x ${item.qty}</c:if>
              	</p>
            </td>
            <td>
            	${fee_price_l } 원
            </td>
            <td>
            	${suf:getThousand(user_price_l - discount_price_l + fee_price_l) } 원
            </td>
            <c:if test="${status.first }">
            <td class="b_none" rowspan="${fn:length(data.list) }">
              <p class="first"><%=rOrdNo%></p>
              <c:choose>
              	<c:when test="${data.resultInfo.paytyp eq 'card' }">
              		<p><input type="button" value="영수증" onclick="javascript:show_receipt();"/></p>
              	</c:when>
              	<c:otherwise>
<!--               <p><a href="#"><img src="/images/sub_2/pay_c_btn1.gif" alt="현금영수증신청"></a></p> -->
              	</c:otherwise>
              </c:choose>
            </td>
            </c:if>
          </tr>
          </c:forEach>
          </tbody>
          </table>

          <div class="pricecheck">

            <div class="p_check1">
              <div class="top">
                <span class="pt_l"><strong>정상가격</strong></span>
                <span class="pt_r">선택상품 : <b>${fn:length(data.list) }</b>개</span>
              </div>
              <div class="bottom">
                <p><b>${suf:getThousand(user_price) }</b>원</p>
                <p class="pb_type"><span class="pb_l">선결제배송비</span><span class="pb_r"><b>${suf:getThousand(fee_price) }</b>원</span></p>
              </div>
            </div>
            <div class="p_check2">
              <div class="top">
                <span class="pt_l"><strong>할인금액</strong></span>
                <span class="pt_r"><a href="#"><img src="/images/sub_2/guide_btn1.gif" alt="?"></a></span>
              </div>
              <div class="bottom">
                <p class="minus"><b>${suf:getThousand(discount_price) }</b>원</p>
              </div>
            </div>
            
            <div class="p_check3">
              <div class="top">
                <span class="pt_l"><strong>총 구매금액</strong></span>
              </div>
              <div class="bottom">
              	<c:set var="actual_price" value="${user_price - discount_price + fee_price}" scope="request"/>
                <p class="equal"><b>${suf:getThousand(actual_price) }</b>원</p>
              </div>
            </div>

          </div>

          <div class="info_b1">

            <div class="info_l">

              <h5 class="pay_type">주문회원 정보</h5>

              <div class="sub_table_1">
                <table>
                <colgroup>
                <col width="30%">
                <col width="">
                </colgroup>
                <tbody>
                <tr>
                  <th scope="row">주문자</th>
                  <td>${data.resultInfo.order_nm }</td>
                </tr>
                <tr>
                  <th scope="row">주소</th>
                  <td>
                    <p>(${data.resultInfo.zipcd }) ${data.resultInfo.addr }</p>
                    <p>${data.resultInfo.addrdetail }</p>
                  </td>
                </tr>
                <tr>
                  <th scope="row">이메일</th>
                  <td>${data.resultInfo.email }</td>
                </tr>
                <tr>
                  <th scope="row">주문자 휴대폰</th>
                  <td>${data.resultInfo.rehp }</td>
                </tr>
                <tr>
                  <th scope="row">주문자 연락처</th>
                  <td>${data.resultInfo.retel }</td>
                </tr>
                </tbody>
                </table>
              </div>

            </div>

            <div class="info_r">

              <h5 class="pay_type">배송정보 내역</h5>

              <div class="sub_table_1">
                <table>
                <colgroup>
                <col width="30%">
                <col width="">
                </colgroup>
                <tbody>
                <tr>
                  <th scope="row">수취인</th>
                  <td>${data.resultInfo.receiver }</td>
                </tr>
                <tr>
                  <th scope="row">배송지 주소</th>
                  <td>
                    <p>(${data.resultInfo.re_zipcd }) ${data.resultInfo.re_addr1 }</p>
                    <p>${data.resultInfo.re_addr2 }</p>
                  </td>
                </tr>
                <tr>
                  <th scope="row">수취인 휴대폰</th>
                  <td>${data.resultInfo.re_cell }</td>
                </tr>
                <tr>
                  <th scope="row">수취인 연락처</th>
                  <td>${data.resultInfo.re_tel }</td>
                </tr>
                </tbody>
                </table>
              </div>

            </div>

          </div>

          <h5 class="pay_type">배송시 요청사항</h5>

          <div class="sub_table_1">
            <table>
            <colgroup>
            <col width="20%">
            <col width="">
            </colgroup>
            <tbody>
            <tr>
              <th scope="row">배송시요청사항</th>
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

          <div class="pay_btn"> <a href="/mypage/shopping/state/index.do?mode=list1"><img src="/images/sub_2/btn_pay_4.gif" alt="나의쇼핑정보"></a> </div>

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
            <li>배송주소를 추가하거나 변경, 삭제 등의 관리는 나의 쇼핑정보 > 나의정보에서 가능합니다. </li>
          </ul>

        </div>
      </div>
    </div>
<form name="frm" method="post">
<!--영수증출력을위해서보내주는값-------------------->
<input type=hidden name=sRetailer_id value="<%=rStoreId%>" /><!--상점아이디-->
<input type=hidden name=approve value="<%=rApprNo%>" /><!---승인번호-->
<input type=hidden name=send_no value="<%=rDealNo%>" /><!--거래고유번호-->
<input type=hidden name=appr_tm value="<%=rApprTm%>" /><!--승인시각-->
<!--영수증출력을위해서보내주는값-------------------->
</form>
</body>