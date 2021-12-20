<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>파츠모아 통합관리 시스템</title>
<link href="/lib/css/cmsbase.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/cmsadmin.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="main">
  <div class="titlebar">
    <h2>차량목록</h2>
    <div> <span>통합관리</span> &gt; <span>상품관리</span> &gt; <span>상품등록</span> &gt;<span class="bar_tx">차량목록</span> </div>
  </div>
  <div class="container"> 
    <!-- <div class="tab_menu">
      <ul class="tab">
        <li><a href="#">이달의 우수상점</a></li>
        <li class="on"><a href="#">상점소개</a></li>
      </ul>
    </div>  -->
    <div class="contents">
      <table class="style_1">
         <colgroup>
          <col width="10%" />
          <col width="*" />
          </colgroup>
        <tr>
          <th>상세검색</th>
          <td><div> <span>
              <label><span style="font-weight:bold; padding-right:5px;">차량명</span>
                <input type="text" class="input_1" id="" name="" />
              </label>
              <span><a href="#" id="dialog-link"><img src="/images/admin/contents/s_btn_search.gif" alt="검색" /></a></span> </span> <span style="margin-left:50px;">
              <label><span style="font-weight:bold; padding-right:5px;">매장명</span>
                <input type="text" class="input_1" id="" name="" />
              </label>
              <span><a href="#" id="dialog-link2"><img src="/images/admin/contents/s_btn_search.gif" alt="검색" /></a></span> </span> </div>
            <div class="seldiv" style="margin-top:20px;">             
              <select title="국산차/수입차 선택">
                <option>국산차</option>
              </select>
              <select title="지역별 선택">
                <option>지역별</option>
              </select>
              <select title="제조사 선택">
                <option>제조사</option>
              </select>
              <select title="차량명 선택">
                <option>차량명</option>
              </select>
              <select title="모델명 선택">
                <option>모델명</option>
              </select>
              <select title="연식 선택">
                <option>연식</option>
              </select>
              <select title="색상 선택">
                <option>색상</option>
              </select>
            </div></td>
        </tr>
        <tr>
          <th>기간조회</th>
          <td>
            <div>
                <span class="bt_alls"><span><input type="button" value="어제" onclick="" class="btalls"/></span></span>
                <span class="bt_alls"><span><input type="button" value="오늘" onclick="" class="btalls"/></span></span>
                <span class="bt_alls"><span><input type="button" value="일주" onclick="" class="btalls"/></span></span>
                <span class="bt_alls"><span><input type="button" value="한달" onclick="" class="btalls"/></span></span>
                <span class="bt_alls"><span><input type="button" value="당월" onclick="" class="btalls"/></span></span>
                <span class="bt_alls"><span><input type="button" value="전월" onclick="" class="btalls"/></span></span>
                <span class="bt_alls"><span><input type="button" value="전체" onclick="" class="btalls"/></span></span>
            </div> 
            <div style="margin-top:10px;">
              <input type="text" class="input_1 date" id="" name="" /> ~ <input type="text" class="input_1 date" id="" name="" />
            </div>
          </td>
        </tr>
      </table>
      <div class="btn_bottom" style="margin-top: 10px;">
        <div class="r_btn">
          <span class="bt_all"><span><input type="button" value="검색" onclick="" class="btall"/></span></span> 
        </div>
      </div>
      
      <div class="top_line" style="margin-top:20px;">
        <div class="select_box"> <span><b>639</b> 건[1/64페이지]</span> </div>
      </div>
      <table class="style_3">
        <colgroup>
          <col width="*" />
          <col width="5%" />
          <col width="12%" />
          <col width="12%" />
          <col width="10%" />
          <col width="12%" />
          <col width="12%" />
          <col width="5%" />
          <col width="5%" />
          <col width="5%" />
          <col width="7%" />
          <col width="8%" />
        </colgroup>
        <tr>
          <th>
            <input type="checkbox" id="" name="" />
          </th>
          <th>번호</th>
          <th>상품ERP코드</th>
          <th>상품일련번호</th>
          <th>상품사진</th>
          <th>상품명</th>
          <th>상품위치</th>
          <th>제조사</th>
          <th>등록일</th>
          <th>승인여부</th>
          <th>판매상태</th>
          <th>공급업체</th>
        </tr>
        <tr>
          <td>
            <input type="checkbox" id="" name="" />
          </td>
          <td>116</td>
          <td>IT201501160118</td>
          <td>IT201501160118</td>
          <td>
            <img src="" alt="상품사진" />
          </td>
          <td>EF쏘나타 사각멤버</td>
          <td>바디 > 쏘나타 > 리어도어</td>
          <td>현대</td>
          <td>2015-11-11<br/>14:40:21</td>
          <td>승인</td>
          <td>정상</td>
          <td>인선모터스</td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" id="" name="" />
          </td>
          <td>116</td>
          <td>IT201501160118</td>
          <td>IT201501160118</td>
          <td>
            <img src="" alt="상품사진" />
          </td>
          <td>EF쏘나타 사각멤버</td>
          <td>바디 > 쏘나타 > 리어도어</td>
          <td>현대</td>
          <td>2015-11-11<br/>14:40:21</td>
          <td>승인</td>
          <td>정상</td>
          <td>인선모터스</td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" id="" name="" />
          </td>
          <td>116</td>
          <td>IT201501160118</td>
          <td>IT201501160118</td>
          <td>
            <img src="" alt="상품사진" />
          </td>
          <td>EF쏘나타 사각멤버</td>
          <td>바디 > 쏘나타 > 리어도어</td>
          <td>현대</td>
          <td>2015-11-11<br/>14:40:21</td>
          <td>승인</td>
          <td>정상</td>
          <td>인선모터스</td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" id="" name="" />
          </td>
          <td>116</td>
          <td>IT201501160118</td>
          <td>IT201501160118</td>
          <td>
            <img src="" alt="상품사진" />
          </td>
          <td>EF쏘나타 사각멤버</td>
          <td>바디 > 쏘나타 > 리어도어</td>
          <td>현대</td>
          <td>2015-11-11<br/>14:40:21</td>
          <td>승인</td>
          <td>정상</td>
          <td>인선모터스</td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" id="" name="" />
          </td>
          <td>116</td>
          <td>IT201501160118</td>
          <td>IT201501160118</td>
          <td>
            <img src="" alt="상품사진" />
          </td>
          <td>EF쏘나타 사각멤버</td>
          <td>바디 > 쏘나타 > 리어도어</td>
          <td>현대</td>
          <td>2015-11-11<br/>14:40:21</td>
          <td>승인</td>
          <td>정상</td>
          <td>인선모터스</td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" id="" name="" />
          </td>
          <td>116</td>
          <td>IT201501160118</td>
          <td>IT201501160118</td>
          <td>
            <img src="" alt="상품사진" />
          </td>
          <td>EF쏘나타 사각멤버</td>
          <td>바디 > 쏘나타 > 리어도어</td>
          <td>현대</td>
          <td>2015-11-11<br/>14:40:21</td>
          <td>승인</td>
          <td>정상</td>
          <td>인선모터스</td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" id="" name="" />
          </td>
          <td>116</td>
          <td>IT201501160118</td>
          <td>IT201501160118</td>
          <td>
            <img src="" alt="상품사진" />
          </td>
          <td>EF쏘나타 사각멤버</td>
          <td>바디 > 쏘나타 > 리어도어</td>
          <td>현대</td>
          <td>2015-11-11<br/>14:40:21</td>
          <td>승인</td>
          <td>정상</td>
          <td>인선모터스</td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" id="" name="" />
          </td>
          <td>116</td>
          <td>IT201501160118</td>
          <td>IT201501160118</td>
          <td>
            <img src="" alt="상품사진" />
          </td>
          <td>EF쏘나타 사각멤버</td>
          <td>바디 > 쏘나타 > 리어도어</td>
          <td>현대</td>
          <td>2015-11-11<br/>14:40:21</td>
          <td>승인</td>
          <td>정상</td>
          <td>인선모터스</td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" id="" name="" />
          </td>
          <td>116</td>
          <td>IT201501160118</td>
          <td>IT201501160118</td>
          <td>
            <img src="" alt="상품사진" />
          </td>
          <td>EF쏘나타 사각멤버</td>
          <td>바디 > 쏘나타 > 리어도어</td>
          <td>현대</td>
          <td>2015-11-11<br/>14:40:21</td>
          <td>승인</td>
          <td>정상</td>
          <td>인선모터스</td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" id="" name="" />
          </td>
          <td>116</td>
          <td>IT201501160118</td>
          <td>IT201501160118</td>
          <td>
            <img src="" alt="상품사진" />
          </td>
          <td>EF쏘나타 사각멤버</td>
          <td>바디 > 쏘나타 > 리어도어</td>
          <td>현대</td>
          <td>2015-11-11<br/>14:40:21</td>
          <td>승인</td>
          <td>정상</td>
          <td>인선모터스</td>
        </tr>
        
        
      </table>
      <div class="paging"> <span id="pagingWrap"> <a class="p_first2" href="#">&lt;&lt;</a> <a class="p_first" href="#">&lt;</a> <a href="#" class="on">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a href="#">6</a> <a href="#">7</a> <a href="#">8</a> <a href="#">9</a> <a href="#">10</a> <a class="p_last" href="#">&gt;</a> <a class="p_last2" href="#">&gt;&gt;</a> </span> </div>
      <div class="btn_bottom" style="margin-top: 10px;">
        <div class="r_btn">
          <span class="bt_all"><span><input type="button" value="등록" onclick="" class="btall"/></span></span> 
          <span class="bt_all"><span><input type="button" value="일괄등록" onclick="" class="btall"/></span></span> 
          <span class="bt_all"><span><input type="button" value="선택삭제" onclick="" class="btall"/></span></span> 
          <span class="bt_all"><span><input type="button" value="선택취소" onclick="" class="btall"/></span></span> 
        </div>
      </div>
       <!-- 부품 검색모달팝업 -->
        <div id="dialog" title="부품검색" >
          <div class="seldiv">
            <select title="국산차/수입차 선택">
                <option>국산차</option>
              </select>
              <select title="지역별 선택">
                <option>지역별</option>
              </select>
              <select title="제조사 선택">
                <option>제조사</option>
              </select>
              <select title="차량명 선택">
                <option>차량명</option>
              </select>
              <select title="모델명 선택">
                <option>모델명</option>
              </select>
              <select title="연식 선택">
                <option>연식</option>
              </select>
              <select title="색상 선택">
                <option>색상</option>
              </select>
          </div>
          <div class="btn_bottom">
            <div class="r_btn">
             <span><a href="#"><img src="/images/admin/contents/pop_search.gif" alt="검색" /></a></span>
            </div> 
          </div>
          <table class="style_3">
            <colgroup>
              <col width="8%" />
              <col width="10%" />
              <col width="*" />
              <col width="23%" />
              <col width="10%" />
              <col width="10%" />
              <col width="6%" />
            </colgroup>
            <tr>
              <th><input type="checkbox" id="" name="" /></th>
              <th>제조사</th>
              <th>차량명</th>
              <th>모델명</th>
              <th>연식</th>
              <th>색상</th>
              <th>등급</th>
            </tr>
            <tr>
              <td><input type="checkbox" id="" name="" /></td>
              <td>쉐보레</td>
              <td>아스트로벤</td>
              <td>프레스티지</td>
              <td>2013</td>
              <td>화이트</td>
              <td>A</td>
            </tr>
            <tr>
              <td><input type="checkbox" id="" name="" /></td>
              <td>쉐보레</td>
              <td>아스트로벤</td>
              <td>프레스티지</td>
              <td>2013</td>
              <td>화이트</td>
              <td>A</td>
            </tr>
            <tr>
              <td><input type="checkbox" id="" name="" /></td>
              <td>쉐보레</td>
              <td>아스트로벤</td>
              <td>프레스티지</td>
              <td>2013</td>
              <td>화이트</td>
              <td>A</td>
            </tr>
            <tr>
              <td><input type="checkbox" id="" name="" /></td>
              <td>쉐보레</td>
              <td>아스트로벤</td>
              <td>프레스티지</td>
              <td>2013</td>
              <td>화이트</td>
              <td>A</td>
            </tr>
            <tr>
              <td><input type="checkbox" id="" name="" /></td>
              <td>쉐보레</td>
              <td>아스트로벤</td>
              <td>프레스티지</td>
              <td>2013</td>
              <td>화이트</td>
              <td>A</td>
            </tr>
          </table>
          <div class="paging"> <span id="pagingWrap"> <a class="p_first2" href="#">&lt;&lt;</a> <a class="p_first" href="#">&lt;</a> <a href="#" class="on">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a class="p_last" href="#">&gt;</a> <a class="p_last2" href="#">&gt;&gt;</a> </span> </div>
          
        </div>
        <!-- 매장 검색모달팝업 -->
        <div id="dialog2" title="매장검색" >
          <table class="style_1">
            <colgroup>
              <col width="15%" />
              <col width="*" />
              </colgroup>
            <tr>
              <th>매장업체명</th>
              <td>
                 <label>
                   <input type="text" class="input_1" id="" name="" />
                 </label>
                 <span><a href="#"><img src="/images/admin/contents/s_btn_search.gif" alt="검색" /></a></span> 
              </td>
            </tr>
          </table>
          <table class="style_3">
            <tr>
              <th>매장업체명</th>
              <th>사업자번호</th>
            </tr>
            <tr>
              <td>인선모터스</td>
              <td>123123123123</td>
            </tr>
            <tr>
              <td>인선모터스</td>
              <td>123123123123</td>
            </tr>
            <tr>
              <td>인선모터스</td>
              <td>123123123123</td>
            </tr>
            <tr>
              <td>인선모터스</td>
              <td>123123123123</td>
            </tr>
            <tr>
              <td>인선모터스</td>
              <td>123123123123</td>
            </tr>
          </table>
          <div class="paging"> <span id="pagingWrap"> <a class="p_first2" href="#">&lt;&lt;</a> <a class="p_first" href="#">&lt;</a> <a href="#" class="on">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a class="p_last" href="#">&gt;</a> <a class="p_last2" href="#">&gt;&gt;</a> </span> </div>
        </div>
        
        
    </div>
  </div>
</div>
<script type="text/javascript" src="/lib/js/jquery-1.10.2.min.js"></script> 
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script> 
<script>
$("input.date").datepicker({
		showOn: "button",      
		buttonImage: "/images/admin/contents/calendar.png",
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

$( "#dialog2" ).dialog({
	autoOpen: false,
	width: 650,
});

// Link to open the dialog
$( "#dialog-link2" ).click(function( event ) {
	$( "#dialog2" ).dialog( "open" );
	event.preventDefault();
});


</script>
</body>
</html>
