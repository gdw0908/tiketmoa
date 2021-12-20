<%@ page import="java.text.*,java.net.*,java.lang.*" contentType="text/html; charset=euc-kr" %>
<% 
/***************************************************************************************************************
 * 올더게이트로 부터 입/출금 데이타를 받아서 상점에서 처리 한 후 
 * 올더게이트로 다시 응답값을 리턴한다.
 * 업체에 맞게 수정하여 작업하면 된다.
***************************************************************************************************************/

/*********************************** 올더게이트로 부터 넘겨 받는 값들 시작 *************************************/
String trcode     = request.getParameter("trcode" );					//거래코드
String service_id = request.getParameter("service_id" );				//상점아이디
String orderdt    = request.getParameter("orderdt" );				    //승인일자
String virno      = request.getParameter("virno" );				        //가상계좌번호
String deal_won   = request.getParameter("deal_won" );					//입금액
String ordno	  = request.getParameter("ordno");                      //주문번호
String inputnm	  = request.getParameter("inputnm");					//입금자명

/*********************************** 올더게이트로 부터 넘겨 받는 값들 끝 *************************************/

/***************************************************************************************************************
 * 상점에서 해당 거래에 대한 처리 db 처리 등....
 *
 * trcode = "1" ☞ 일반가상계좌 입금통보전문 (이지스효성 new 에스크로 포함)
 * trcode = "2" ☞ 일반가상계좌 취소통보전문 (이지스효성 new 에스크로 포함)
 *
 * ※ 에스크로가상계좌의 경우 입금자명 값은 통보전문에 들어가지 않습니다.



***************************************************************************************************************/

/******************************************처리 결과 리턴******************************************************/
String rResMsg  = "";
String rSuccYn  = "y";// 정상 : y 실패 : n

//정상처리 경우 거래코드|상점아이디|주문일시|가상계좌번호|처리결과|
rResMsg = trcode + "|" + service_id + "|" + orderdt + "|" + virno + "|" + rSuccYn + "|";

out.println( rResMsg );
/******************************************처리 결과 리턴******************************************************/
%>
