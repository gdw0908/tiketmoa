<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>파츠모아</title>
<script type="text/javascript">
$( document ).ready(function() {
	/*
	$("#mdpart").jCarouselLite({
		visible : 1,
		speed : 500,
		auto : 3000,
		circular : true,
		vertical : true,
		easing : "swing",
		btnPrev : "#mdpart_prev",
		btnStop : "#mdpart_pause",
		btnStart : "#mdpart_play"

	});
	*/
	lastest_part(1, 1);
	lastest_part(1, 2);
});

function lastest_part(page, tab){
	var obj = $("#newpart");
	if(tab == "1"){
		obj = $("#mdpart");	
	}
	obj.load("/mobile/popup/latest_part.do?cpage="+page+"&tab="+tab);
}
function mobile_prev(obj){
	var tab = "2";
	if(obj == "md"){
		tab = "1";	
	}
	
	var page = $("#"+obj+"page").text().split("/");
	var page_num = "";	
	if(page[0] == "1"){
		page_num = page[1]
	}else{
		page_num = parseInt(page[0])-1;
	}
	lastest_part(page_num,tab);
}
function mobile_next(obj){
	var tab = "2";
	if(obj == "md"){
		tab = "1";	
	}
	
	var page = $("#"+obj+"page").text().split("/");
	var page_num = "";	
	if(page[0] == page[1]){
		page_num = "1"
	}else{
		page_num = parseInt(page[0])+1;
	}
	lastest_part(page_num,tab);
}
</script>
</head>
<body>
    <div class="main_visual">
    <c:choose>
      <c:when test="${fn:length(list.mobile_popup) > 0}">
      <c:forEach var="item" items="${list.mobile_popup }" varStatus="status">
      	<c:choose>
	      	<c:when test="${item.link_yn == 'Y' }">
      			<a href="${item.link_url }" target="${item.link_target }"><img src="${item.file_path }" alt="${item.alt }"></a>
      		</c:when>
      		<c:otherwise>
      			<img src="${item.file_path }" alt="${item.alt }">
      		</c:otherwise>
      	</c:choose>
      </c:forEach>
      </c:when>
      <c:otherwise>
      	<img src="/images/mobile/main/main_visual.png" alt="PARTSMOA">
      </c:otherwise>
    </c:choose>
    </div>
    <div class="c_wrap">
    
        <!-- <div class="component">
          <div class="com_h">
            <h3><img src="/images/mobile/main/component_title.gif" alt="부품문의"></h3>
            <span><a href="#"><img src="/images/mobile/main/roll_more.gif" alt="더 많은 상품보기"></a></span>
          </div>
          
          <div class="com_m">
          <p><a href="/mobile/mypage/application/index.do" class="cm_l"><img src="/images/mobile/main/component_kor.gif" alt="국산차 문의하기"></a></p>
          <p><a href="/mobile/mypage/application_import/index.do" class="cm_r"><img src="/images/mobile/main/component_import.gif" alt="수입차 문의하기"></a></p>
          </div>
          
        </div> -->
        
        
        <div class="parts_story">
        	<a href="/mobile/mypage/story/index.do"><img src="/images/container/partsmoa_story.png" alt="파츠모아 이야기"/></a>
        </div>
        
        <div class="com_m">
          <p><a href="/mobile/mypage/application/index.do" class="cm_l"><img src="/images/mobile/main/component_kor.gif" alt="국산차 문의하기"></a></p>
          <p><a href="/mobile/mypage/application_import/index.do" class="cm_r"><img src="/images/mobile/main/component_import.gif" alt="수입차 문의하기"></a></p>
        </div>
        
        <!-- <div class="car_all">
        <a href="/mobile/mypage/mantoman/index.do?menu=menu2"><img src="/images/mobile/main/car_all.gif" alt="착한정비!! 카올바로!! 바로가기"></a>
        </div> -->
        
        <div class="btn_line">
        	<h3><img src="/images/mobile/main/car_all_title.png" alt="착한정비 카올바로"/></h3>
        	<ul>
        		<li><a href="/mobile/mypage/carallbaro/quotation_insertForm.do?menu=menu2"><img src="/images/mobile/main/car_all_btn1.png" alt="견적내기"/></a></li>
        		<li><a href="/mobile/mypage/carallbaro/quotation_fastForm.do?menu=menu2"><img src="/images/mobile/main/car_all_btn2.png" alt="즉시신청"/></a></li>
        		<li><a href="/mobile/mypage/carallbaro/index.do?menu=menu2"><img src="/images/mobile/main/car_all_btn3.png" alt="사례보기"/></a></li>
        	</ul>
        </div>
        
        <div class="btn_line btn_line_2">
        	<h3><img src="/images/mobile/main/cc_title.png" alt="협력사 전용메뉴"/></h3>
        	<ul>
        		<li><a href="/mobile/seller/selfcamera_insert.do?menu=menu8"><img src="/images/mobile/main/cc_btn1.png" alt="셀카등록"/></a></li>
        		<li><a href="/mobile/seller/resources_insert.do?menu=menu8"><img src="/images/mobile/main/cc_btn2.png" alt="자원등록"/></a></li>
        		<li><a href="/mobile/seller/seller_insert.do?menu=menu8"><img src="/images/mobile/main/cc_btn3.png" alt="부품등록"/></a></li>
        	</ul>
        </div>

      <div class="notice">
        <h3><img src="/images/mobile/main/notice_title.gif" alt="PARTS MOA 공지사항"></h3>
        <ul>
          <c:forEach var="item" items="${list.notice }" varStatus="status" begin="0" end="1" step="1">
			<li><a href="/mobile/mypage/notice/index.do?mode=view&article_seq=${item.article_seq }&cpage=1&rows=10&condition=&keyword=">${item.title }</a><span>${item.reg_dt }</span></li>
          </c:forEach>
        </ul>
        <span class="more"><a href="/mobile/mypage/notice/index.do"><img src="/images/mobile/main/btn_more.gif" alt="더보기"></a></span>
      </div>


      <div class="main_rollbox">

        <div class="roll_head">
          <div class="rh_l">
            <h3><img src="/images/mobile/main/lately_title.gif" alt="최근입고상품"></h3>
            <!--span><a href="#"><img src="/images/mobile/main/roll_more.gif" alt="더 많은 상품보기"></a></span-->
          </div>
          <div class="rh_r">
            <!-- <span class="first">총 <b class="c1" id="newcount">1,866</b> </span> -->
            <span class="first" id="newpage"><b>1</b>/1</span>
            <span><a href="javascript:;" onclick="mobile_prev('new')"><img src="/images/mobile/main/roll_prev.gif" alt="이전"></a><a href="javascript:;" onclick="mobile_next('new')"><img src="/images/mobile/main/roll_next.gif" alt="다음"></a></span>
          </div>
        </div>

        <!-- lately_roll -->
        <div class="lately_roll" id="newpart">
          <ul class="lately_list">
            <li>
            <div>
              <a href="/html/mobile/sub/m01/m01_03.html"> <span class="img"><img src="/images/mobile/main/product_1.gif" alt=""></span> <span class="text">제네시스쿠페 (2012)</span> <span class="text">컴비네이션램프 후미등 </span> </a>
              <p class="mb_3"><strong>판매가격  : </strong> <span class="c1">9,000,000 원</span></p>
              <p class="mb_3"><strong>협력사가  : </strong> <span class="c2">9,000,000 원</span></p>
            </div>
            </li>
            <li>
            <div>
              <a href="/html/mobile/sub/m01/m01_03.html"> <span class="img"><img src="/images/mobile/main/product_2.gif" alt=""></span> <span class="text">제네시스쿠페 (2012)</span> <span class="text">컴비네이션램프 후미등 </span> </a>
              <p class="mb_3"><strong>판매가격  : </strong> <span class="c1">9,000,000 원</span></p>
              <p class="mb_3"><strong>협력사가  : </strong> <span class="c2">9,000,000 원</span></p>
            </div>
            </li>
          </ul>

        </div>
        <!-- //lately_roll -->

      </div>

      <div class="main_rollbox">
        <div class="roll_head">
          <div class="rh_l">
            <h3><img src="/images/mobile/main/md_title.gif" alt="md추천상품"></h3>
            <!--span><a href="#"><img src="/images/mobile/main/roll_more.gif" alt="더 많은 상품보기"></a></span-->
          </div>
          <div class="rh_r" id="mdpart_btn">
            <!-- <span class="first">총 <b class="c1" id="mdcount">0</b> </span> -->
            <span class="first" id="mdpage"><b>1</b>/1</span>
            <span><a href="javascript:;" onclick="mobile_prev('md')"><img src="/images/mobile/main/roll_prev.gif" alt="이전"></a><a href="javascript:;" onclick="mobile_next('md')"><img src="/images/mobile/main/roll_next.gif" alt="다음"></a></span>
          </div>
        </div>

        <!-- lately_roll -->
        <div class="lately_roll" id="mdpart">
        </div>
        <!-- //lately_roll -->

      </div>
	  
      <div class="guide">
        <div class="g_main"><a href="tel:1544-6444"><img src="/images/mobile/main/g_main.png" alt="PARTS MOA 고객센터 평일 08:30 ~ 19:00 토,일,공휴일 휴무 1544-6444, FAX / 031.961.4699 help@Insun.com"></a></div>
        <!-- div class="g_exhibition">
          <h3><img src="/images/mobile/main/ex_title.gif" alt="수입완차 전시관"></h3>
          <div class="exhibition">
            <a href="#"> <span class="img"><img src="/images/mobile/main/ex_img_1.gif" alt=""></span> <span class="text"> <span><strong>BMW</strong> 3시리즈 <strong>318i</strong> 세단 <strong>E46</strong></span> <span>99-02 / 265,874km</span> </span> </a>
            <p class="ic"><img src="/images/container/md_b_btn3.gif" alt="무료배송"> <img src="/images/container/ic_m_1.gif" alt="이전가능"></p>
            <p class="btn"><a href="#"><img src="/images/mobile/main/guide_btn1.gif" alt=""></a></p>
          </div>
        </div-->
      </div>

    </div>
</body>
</html>