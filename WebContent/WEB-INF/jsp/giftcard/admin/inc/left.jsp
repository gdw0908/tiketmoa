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
  <!-- <div><a href="#"><img src="/images/admin/left/l4_03.gif" alt="메뉴닫기"/></a></div> -->
</div>

<!-- 레프트메뉴부분 -->
<div class="menuwrap">
  <ul>
  <c:choose>
  <c:when test = "${sessionScope.member.group_seq ne '8' and (sessionScope.member.carall eq 'N' or sessionScope.member.group_seq eq '1' )}">
    <li>
      <div> <span class="name1"><a href="#">상품권관리</a></span> </div>
      <ul>
        <li>
          <div> <span class="name2"><a href="#">상품등록</a></span> </div>
          <ul>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/giftcard/admin/goods/part/index.do')">상품권등록</a></span> </div>
            </li>
            <!-- <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/car/index.do?gubun=2')">수입차(부품용)등록</a></span> </div>
            </li>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/admin/goods/car/index.do?gubun=3')">수출용(차량)등록</a></span> </div>
            </li> -->
          </ul>
        </li>
        <li>
          <div> <span class="name2"><a href="#">상품목록</a></span> </div>
          <ul>
            <li class="last">
              <div> <span class="name3"><a href="#" onclick="goBody('/giftcard/admin/goods/inventory/inventory_cate2.do')">카테고리관리</a></span> </div>
            </li>
          </ul>
        </li>  
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
      </ul>
    </li>
    </c:when>
   </c:choose>
  </ul>
</div>
</body>
</html>
