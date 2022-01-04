<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>남성시장 관리시스템</title>
<link href="/lib/css/cmsbase.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/cmsadmin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/lib/js/jquery-1.9.1.js"></script>
<script type="text/javascript">
$(function(){
	$(".menuwrap ul li ul").hide();
	$(".menuwrap .name2 a").on("click", function(){
		$(".menuwrap .name2").closest("div").siblings("ul").hide();
		$(this).closest("div").siblings("ul").show();
	});
	$(".menuwrap .name1 a").on("click", function(){
		$(".menuwrap .name1").closest("div").siblings("ul").hide();
		$(this).closest("div").siblings("ul").show();
	});
	$(".menuwrap a").on("click", function(){
		$(this).closest("li").siblings("li").removeClass("on");
		$(this).closest("li").addClass("on");
	});
});

function goBody(target_url){
	parent.bodyFrame.location.href = target_url;
}
</script>
</head>
<body id="leftwrap">
<!-- 메뉴관리탭부분 -->
<div class="menutap">
  <ul>
    <li class="leftmenu1"><a href="#" class="on">시스템관리</a></li>
  </ul>
  <div><a href="#"><img src="/images/admin/left/l4_03.gif" alt="메뉴닫기"/></a></div>
</div>

<!-- 레프트메뉴부분 -->
<div class="menuwrap">
  <ul>
  <c:choose>
  <c:when test = "${sessionScope.member.group_seq ne '8' and (sessionScope.member.carall eq 'N' or sessionScope.member.group_seq eq '1' )}">
    <li>
      <div> <span class="name1"><a href="#">상품관리</a></span> </div>
      <ul>
        <li>
          <div> <span class="name2"><a href="#">상품등록</a></span> </div>
          <ul>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/part/index.do')">부품등록</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/car/index.do?gubun=2')">수입차(부품용)등록</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/car/index.do?gubun=3')">수출용(차량)등록</a></span> </div>
            </li>
          </ul>
        </li>
        <c:if test = "${sessionScope.member.group_seq eq '1'}">
        <li>
          <div> <span class="name2"><a href="#">상품목록</a></span> </div>
          <ul>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/inventory/inventory_cate.do?codeno=0509')">카테고리관리</a></span> </div>
            </li>
            <li class="last">
             <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/inventory/event_index.do')">이벤트상품관리</a></span> </div>
            </li> 
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/inventory/inventory_md_1.do')">MD상품관리</a></span> </div>
            </li>
          </ul>
        </li>
        </c:if>
         <li>
          <div> <span class="name2"><a href="#">주문관리</a></span> </div>
          <ul>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/spell/index.do?tab=all')">전체</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/spell/index.do?tab=1')">주문접수</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/spell/index.do?tab=2')">결제완료</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/spell/index.do?tab=3')">결제취소중</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/spell/index.do?tab=4')">결제취소완료</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/spell/index.do?tab=5')">배송준비중</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/spell/index.do?tab=6')">반품신청중</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/spell/index.do?tab=7')">교환신청중</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/spell/index.do?tab=8')">환불신청중</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/spell/index.do?tab=9')">거래완료</a></span> </div>
            </li>
          </ul>
        </li>
        <!-- 
         <li>
          <div> <span class="name2"><a href="#">매출관리</a></span> </div>
          <ul>
            <li class="last">
              <div> <span class="name3"><a href="#">통합관리</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#">상점별관리</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#">카드결제관리</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#">현금결제관리</a></span> </div>
            </li>
          </ul>
        </li>
         -->
      </ul>
    </li>
    <!-- 협력업체관리시작-->
    <li>
      <div> <span class="name1"><a href="#">협력업체관리</a></span> </div>
      <ul>
        <li>
            <div> <span class="name2"><a href="#">업체신청</a></span> </div>
            <ul>
               <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/supply/cooperation/index.do')">협력업체신청</a></span> </div>
               </li>
               <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/supply/repair/index.do')">정비업체신청</a></span> </div>
               </li>
               <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/supply/carallbaro/index.do')">카올바로지점신청</a></span> </div>
               </li>
            </ul>
        </li>
      </ul>
    </li>
    <c:if test = "${sessionScope.member.group_seq eq '1'}">
    <!-- 회원관리시작-->
    <li>
      <div> <span class="name1"><a href="#" onClick="goBody('/admin/member/index.do')">회원관리</a></span> </div>
    </li>
    </c:if>
    <c:if test = "${sessionScope.member.group_seq eq '1'}">
    <!-- 시스템관리 시작-->
    <li>
      <div> <span class="name1"><a href="#">시스템관리</a></span> </div>
      <ul>
        <li>
          <div> <span class="name2"><a href="#">게시판관리</a></span> </div>
          <ul>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/notice/index.do')">공지사항</a></span> </div>
             </li>
             <!-- <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/QA/index.do')">자주묻는질문</a></span> </div>
             </li> -->
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/forces/index.do')">협력사문의</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/carallbaro_board/index.do')">카올바로 사례</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/carallbaro/index.do')">카올바로 신청</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/mantoman/index.do')">카올바로(구)</a></span> </div>
             </li>
             <!-- <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/late/index.do')">구매후기</a></span> </div>
             </li> -->
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/application/index.do')">국산차 부품문의</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/application_import/index.do')">수입차 부품문의</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/mantoman_late/index.do')">정비사례</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/story/index.do')">파츠모아 이야기</a></span> </div>
             </li>
          </ul>
        </li>
        <li>
          <div> <span class="name2"><a href="#">팝업관리</a></span> </div>
          <ul>
            <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/popup/maindisplay/index.do')">메인화면관리</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/popup/popdisplay/index.do')">상단팝업관리</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/popup/quickdisplay/index.do')">퀵메뉴관리</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/popup/bannerdisplay/index.do')">광고배너관리</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/popup/layerdisplay/index.do')">레이어팝업관리</a></span> </div>
             </li>
          </ul>
        </li>
        <li>
          <div> <span class="name2"><a href="#">설정관리</a></span> </div>
          <ul>
            <li class="last">
                <div> <span class="name3"><a href="#">PG번호</a></span> </div>
             </li>
          </ul>
        </li>
        <li>
          <div> <span class="name2"><a href="#">SMS/이메일관리</a></span> </div>
          <ul>
            <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/send/sms/index.do')">SMS관리</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/send/email/send/index.do')">이메일관리</a></span> </div>
             </li>
          </ul>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/giftcard/admin/system/code/index.do')">공통코드관리</a></span> </div>
        </li>
        <li>
      </ul>
    </li>
    </c:if>
    <c:if test = "${sessionScope.member.group_seq eq '3' and sessionScope.member.carall eq 'N'}"><!-- 협력사 문의 게시판 공개 -->
    <!-- 시스템관리 시작-->
    <li>
      <div> <span class="name1"><a href="#">시스템관리</a></span> </div>
      <ul>
        <li class="last">
          <div> <span class="name2"><a href="#">게시판관리</a></span> </div>
          <ul>
          	 <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/mantoman/index.do')">카올바로(구)</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/application/index.do')">국산차 부품문의</a></span> </div>
             </li>
             <li class="last">
                <div> <span class="name3"><a href="#" onclick="goBody('/admin/system/board/application_import/index.do')">수입차 부품문의</a></span> </div>
             </li>
          </ul>
        </li>
      </ul>
    </li>
    </c:if>
    <c:if test = "${sessionScope.member.group_seq eq '1'}">
     <!-- 통계관리시작-->
    <li>
      <div> <span class="name1"><a href="#" onclick="goBody('/admin/statistics/statistics.do')">통계관리</a></span> </div>
    </li>
    </c:if>
     <!-- 정산관리시작-->
    <li>
      <div> <span class="name1"><a href="#">정산관리</a></span> </div>
      <ul>
        <!-- <li class="last">
          <div> <span class="name2"><a href="#">일일정산등록</a></span> </div>
        </li> -->
        <c:if test = "${sessionScope.member.group_seq eq '1'}">
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/calculate/deadline_cancel.do')">대기중 데이터 관리</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/calculate/deadline.do')">마감정산등록</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/calculate/confirm_list.do')">마감정산조회</a></span> </div>
        </li>
        </c:if>
        <li class="last">
          <div> <span class="name2" ><a href="#" onclick="goBody('/admin/calculate/day_search.do')">일정산조회</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/calculate/week_search.do')">주정산조회</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/calculate/month_search.do')">월별정산조회</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/calculate/branch_search.do')">분기별정산조회</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/calculate/year_search.do')">년도별정산조회</a></span> </div>
        </li>
      </ul>
    </li>
    <li>
      <div> <span class="name1"><a href="#">매출조회</a></span> </div>
      <ul>
        <!-- <li class="last">
          <div> <span class="name2"><a href="#">일일정산등록</a></span> </div>
        </li> -->
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/sales/sales_period.do')">기간별조회</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/sales/sales_day.do')">일조회</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2" ><a href="#" onclick="goBody('/admin/sales/sales_month.do')">월조회</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/sales/sales_quarter.do')">분기조회</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/sales/sales_year.do')">년조회</a></span> </div>
        </li>
       
      </ul>
    </li>
    <li>
      <div> <span class="name1"><a href="#">자원/셀카 관리</a></span> </div>
      <ul>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/resources/index.do')">자원관리</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/system/selfcamera/index.do')">셀카관리</a></span> </div>
        </li>
      </ul>
    </li>
    
    <li>
      <div> <span class="name1"><a href="#">관리자게시판</a></span> </div>
      <ul>
      	<c:if test = "${sessionScope.member.group_seq eq '1'}">
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/system/board/adminBoard/index.do')">관리자게시판</a></span> </div>
        </li>
        </c:if>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/system/board/adminBoard2/index.do')">회원사 공지 게시판</a></span> </div>
        </li>
      </ul>
    </li>
    </c:when>
    <c:otherwise>
    <c:if test="${sessionScope.member.carall eq 'N' }">
    <li>
      <div> <span class="name1"><a href="#">자원/셀카 관리</a></span> </div>
      <ul>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/resources/index.do')">자원관리</a></span> </div>
        </li>
      </ul>
    </li>
    </c:if>
    <c:if test="${sessionScope.member.carall eq 'Y' }">
    <li class="last">
      <div> <span class="name1"><a href="#" onclick="goBody('/admin/supply/carallbaro/index.do')">카올바로지점신청</a></span> </div>
    </li>
    <li>
      <div> <span class="name1"><a href="#">카올바로</a></span> </div>
      <ul>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/system/carallbaro_board/index.do')">카올바로 사례</a></span> </div>
        </li>
        <li class="last">
          <div> <span class="name2"><a href="#" onclick="goBody('/admin/system/carallbaro/index.do')">카올바로 신청</a></span> </div>
        </li>
      </ul>
    </li>
    </c:if>
    </c:otherwise>
   </c:choose>
  </ul>
</div>
</body>
</html>
