<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<c:set var="view" value="${data.view }"/>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>주문현황</title>
<script type="text/javascript">
function list(value){
	location.replace("?menu=${param.menu }&rows=" + value);
}
</script>
</head>
<body>
	<div class="sub_wrap">
        <div class="sub_line">
          <h3><img src="/images/mobile/sub/sub_title_b_4.gif" alt="주문관리"></h3>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>

        <div class="pricecheck">

          <div class="top">

            <p>
            <span class="pt_l">주문날짜</span>
            <span class="pt_r">${view.orderdate}</span>
            </p>

            <p class="t_mar">
            <span class="pt_l">주문번호</span>
            <span class="pt_r">${view.orderno}</span>
            </p>

            <p class="t_mar">
            <span class="pt_l">결제유형</span>
            <span class="pt_r">${view.paytyp_nm}</span>
            </p>

          </div>

          <div class="bottom">

            <p>
            <span class="pt_l">총 구매금액</span>
            <span class="pt_r"><b class="c1">${suf:getThousand(view.amt) }</b> 원</span>
            </p>

          </div>

        </div>

        <h5 class="pay_type">상품정보</h5>

        <div class="sub_table_1">
          <table>
          <colgroup>
          <col width="25%">
          <col width="">
          </colgroup>
          <tbody>
          <tr>
            <th scope="row">상품명</th>
            <td>${view.productnm}</td>
          </tr>
          <tr>
            <th scope="row">주문상태</th>
            <td><strong class="c1">${view.status_nm}</strong></td>
          </tr>
          <tr>
            <th scope="row">업체명</th>
            <td>${view.com_nm}</td>
          </tr>
          <tr>
            <th scope="row">제조사</th>
            <td>${view.makernm}</td>
          </tr>
          <tr>
            <th scope="row">차종명</th>
            <td>${view.carmodelnm}</td>
          </tr>
          <tr>
            <th scope="row">부품명</th>
            <td>${view.part3_nm}</td>
          </tr>
          <tr>
            <th scope="row">판매가격</th>
            <td><b>${suf:getThousand(view.user_price) } 원</b></td>
          </tr>
          <tr>
            <th scope="row">수량</th>
            <td><b>${view.qty} 개</b></td>
          </tr>
          <tr>
            <th scope="row">배송비</th>
            <td>${suf:getThousand(view.basong_amt) } 원</td>
          </tr>
          <tr>
            <th scope="row">차종명</th>
            <td><b class="c2">${view.carmodelnm} 원</b></td>
          </tr>
          </tbody>
          </table>
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
            <td>${view.order_nm}</td>
          </tr>
          <tr>
            <th scope="row">주소</th>
            <td>
              <p>(${view.zipcd}) ${view.addr}</p>
              <p>${view.addrdetail}</p>
            </td>
          </tr>
          <tr>
            <th scope="row">이메일</th>
            <td>${view.email}</td>
          </tr>
          <tr>
            <th scope="row">주문자<br>휴대폰</th>
            <td>${view.rehp}</td>
          </tr>
          <tr>
            <th scope="row">주문자<br>연락처</th>
            <td>${view.retel}</td>
          </tr>
          <!-- <tr>
            <th scope="row">거래완료일</th>
            <td></td>
          </tr> -->
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
            <th scope="row">주문자</th>
            <td>${view.receiver}</td>
          </tr>
          <tr>
            <th scope="row">주소</th>
            <td>
              <p>(${view.re_zip_cd}) ${view.re_addr1}</p>
              <p>${view.re_addr2}</p>
            </td>
          </tr>
          <!-- <tr>
            <th scope="row">이메일</th>
            <td></td>
          </tr>
          <tr>
            <th scope="row">주문자<br>휴대폰</th>
            <td></td>
          </tr> -->
          <tr>
            <th scope="row">주문자<br>연락처</th>
            <td>${view.re_cell}</td>
          </tr>
          <tr>
            <th scope="row">배송시<br>요청사항</th>
            <td>${view.message}</td>
          </tr>
          </tbody>
          </table>
        </div>

        <h5 class="pay_type">교환/환불/주문취소 정보</h5>

        <div class="sub_table_1">
          <table>
          <colgroup>
          <col width="25%">
          <col width="">
          </colgroup>
          <tbody>

          <tr>
            <th scope="row">교환<br>신청일</th>
            <td>${view.ch_dt}</td>
          </tr>

          <tr>
            <th scope="row">교환제품<br>도착일</th>
            <td>${view.ch_d_dt}</td>
          </tr>

          <tr>
            <th scope="row">교환제품<br>발송일</th>
            <td>${view.ch_b_dt}</td>
          </tr>

          <tr>
            <th scope="row">교환<br>송장번호</th>
            <td>${view.ch_c_no}</td>
          </tr>

          <tr>
            <th scope="row">교환<br>배송비</th>
            <td> 원</td>
          </tr>

          <tr>
            <th scope="row">반품<br>신청일</th>
            <td>${view.ban_dt}</td>
          </tr>

          <tr>
            <th scope="row">반품제품<br>도착일</th>
            <td>${view.ban_d_dt}</td>
          </tr>

          <tr>
            <th scope="row">반품<br>배송일</th>
            <td>${view.ban_b_dt}</td>
          </tr>

          <tr>
            <th scope="row">환불<br>신청일</th>
            <td>${view.han_dt}</td>
          </tr>

          <tr>
            <th scope="row">환불제품<br>도착일</th>
            <td>${view.han_d_dt}</td>
          </tr>

          <tr>
            <th scope="row">환불<br>완료일</th>
            <td>${view.han_c_dt}</td>
          </tr>

          <tr>
            <th scope="row">환불<br>배송비</th>
            <td> 원</td>
          </tr>

          <tr>
            <th scope="row">결제취소<br>신청일</th>
            <td>${view.pay_c_dt}</td>
          </tr>

          <tr>
            <th scope="row">결제취소<br>완료일</th>
            <td>${view.pay_e_dt}</td>
          </tr>

          <tr>
            <th scope="row">주문<br>취소일</th>
            <td>${view.order_c_dt}</td>
          </tr>

          <tr>
            <th scope="row">사유</th>
            <td>${view.sayu}</td>
          </tr>

          </tbody>
          </table>
        </div>

<!--         <h5 class="pay_type">상품정보</h5>

        <div class="sub_table_1">
          <table>
          <colgroup>
          <col width="25%">
          <col width="">
          </colgroup>
          <tbody>
          <tr>
            <th scope="row">주문상태</th>
            <td>
              <select id="" name="" class="select_1">
              <option>주문접수</option>
              </select>
            </td>
          </tr>
          <tr>
            <th scope="row">승인시<br>배송비</th>
            <td><input type="text" id="" name="" class="input_m2"> 원</td>
          </tr>
          <tr>
            <th scope="row">일자</th>
            <td><img src="/images/mobile/sub/calendar.gif" alt="달력"> <input type="text" id="" name="" class="input_m2 ws_5"> - <input type="text" id="" name="" class="input_m2 ws_5"> - <input type="text" id="" name="" class="input_m2 ws_5"></td>
          </tr>
          <tr>
            <th scope="row">송장번호</th>
            <td><input type="text" id="" name="" class="input_m2"></td>
          </tr>
          <tr>
            <th scope="row">사유</th>
            <td>
			<textarea class="textarea_1"></textarea>
			</td>
          </tr>
          </tbody>
          </table>
        </div> -->
       </div>
</body>
</html>