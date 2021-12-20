<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>남성시장 관리시스템</title>
<link href="/lib/css/cmsbase.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/cmsadmin.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="main">
  <div class="titlebar">
    <h2>상점소개</h2>
    <div> <span>홈페이지 관리</span> &gt; <span>상점소개</span> &gt; <span class="bar_tx">상점소개</span> </div>
  </div>
  <div class="container"> 
    <!-- <div class="tab_menu">
      <ul class="tab">
        <li><a href="#">이달의 우수상점</a></li>
        <li class="on"><a href="#">상점소개</a></li>
      </ul>
    </div>  -->
    <div class="contents">
      <div class="top_line">
        <div class="search_box">
          <select class="select_1">
            <option>제목</option>
            <option>내용</option>
            <option>이름</option>
          </select>
          <input type="text" class="input_1" name="" id="" />
          <a href="#"><img src="/images/admin/contents/btn_search.gif" alt="검색" /></a> </div>
        <div class="select_box"> <span><b>639</b> 건[1/64페이지]</span>
          <select class="select_1" name="" id="">
            <option>전체보기</option>
            <option>농산물</option>
            <option>수산/건어물</option>
            <option>정육/축산물</option>
            <option>반찬/식자재</option>
            <option>의류/신발</option>
            <option>가정용품</option>
            <option>음식점/떡집</option>
            <option>근린생활서비스</option>
          </select>
          <select class="select_1">
            <option>년도보기</option>
            <option>2014년</option>
            <option>2013년</option>
          </select>
          <select class="select_1">
            <option>월별보기</option>
            <option>12월</option>
            <option>11월</option>
          </select>
        </div>
      </div>
      <div class="contents_view">
        <table class="style_1">
          <colgroup>
          <col width="5%" />
          <col width="" />
          <col width="10%" />
          <col width="10%" />
          <col width="8%" />
          <col width="7%" />
          <col width="9%" />
          <col width="6%" />
          <col width="6%" />
          </colgroup>
          <tr>
            <th>번호</th>
            <th>주소</th>
            <th>업종</th>
            <th>주요품목</th>
            <th>대표자</th>
            <th>조회수</th>
            <th>등록날짜</th>
            <th>수정</th>
            <th>삭제</th>
          </tr>
          <tr>
            <td>10</td>
            <td>서울특별시 동작구 동작대로 29길 40</td>
            <td>식당/음식</td>
            <td>칼국수,만두</td>
            <td>황기순</td>
            <td>99999</td>
            <td>2014.11.11</td>
            <td><a href="#" id="dialog-link"><img src="/images/admin/contents/s_btn_3.gif" alt="수정" /></a></td>
            <td><a href="#"><img src="/images/admin/contents/s_btn_1.gif" alt="삭제" /></a></td>
          </tr>
          <tr>
            <td>10</td>
            <td>서울특별시 동작구 동작대로 29길 40</td>
            <td>식당/음식</td>
            <td>칼국수,만두</td>
            <td>황기순</td>
            <td>99999</td>
            <td>2014.11.11</td>
            <td><a href="#" ><img src="/images/admin/contents/s_btn_3.gif" alt="수정" /></a></td>
            <td><a href="#"><img src="/images/admin/contents/s_btn_1.gif" alt="삭제" /></a></td>
          </tr>
          <tr>
            <td>10</td>
            <td>서울특별시 동작구 동작대로 29길 40</td>
            <td>식당/음식</td>
            <td>칼국수,만두</td>
            <td>황기순</td>
            <td>99999</td>
            <td>2014.11.11</td>
            <td><a href="#"><img src="/images/admin/contents/s_btn_3.gif" alt="수정" /></a></td>
            <td><a href="#"><img src="/images/admin/contents/s_btn_1.gif" alt="삭제" /></a></td>
          </tr>
        </table>
        <div class="paging"> <span id="pagingWrap"> <a class="p_first2" href="#">&lt;&lt;</a> <a class="p_first" href="#">&lt;</a> <a href="#" class="on">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a href="#">6</a> <a href="#">7</a> <a href="#">8</a> <a href="#">9</a> <a href="#">10</a> <a class="p_last" href="#">&gt;</a> <a class="p_last2" href="#">&gt;&gt;</a> </span> </div>
        <div class="btn_bottom">
          <div class="r_btn">
            <span><a href="#"><img src="/images/admin/contents/btn_2.gif" alt="등록" /></a></span>
            <span><a href="#"><img src="/images/admin/contents/btn_1.gif" alt="삭제" /></a></span>
            <span><a href="#"><img src="/images/admin/contents/btn_3.gif" alt="목록" /></a></span>
          </div>
        </div>
        <!-- 모달팝업 -->
        <div id="dialog" title="이벤트 추가" > </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript" src="/lib/js/jquery-1.10.2.min.js"></script> 
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script> 
<script>
$("input.date").datepicker({
		showOn: "button",      
		buttonImage: "/images/admin/calendar.gif",
});

$( "#tabs" ).tabs();
$( "#dialog" ).dialog({
	autoOpen: false,
	width: 650,
});

// Link to open the dialog
$( "#dialog-link" ).click(function( event ) {
	$( "#dialog" ).dialog( "open" );
	event.preventDefault();
});


</script>
</body>
</html>
