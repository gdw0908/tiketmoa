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
    <h2>차량등록</h2>
    <div> <span>통합관리</span> &gt; <span>상품관리</span> &gt; <span>상품등록</span> &gt;<span class="bar_tx">차량등록</span> </div>
  </div>
  <div class="container"> 
    <!-- <div class="tab_menu">
      <ul class="tab">
        <li><a href="#">이달의 우수상점</a></li>
        <li class="on"><a href="#">상점소개</a></li>
      </ul>
    </div>  -->
    <div class="contents">
      <div class="contents_view">
        <table class="style_1">
          <colgroup>
          <col width="10%" />
          <col width="*" />
          </colgroup>
          <tr>
            <th>차량정보</th>
            <td class="selsize">
               <select title="제조사선택">
                 <option>제조사</option>
               </select>
               <select title="차량명선택">
                 <option>차량명</option>
               </select>
               <select title="모델명선택">
                 <option>모델명</option>
               </select>
               <select title="연식선택">
                 <option>연식</option>
               </select>
               <select title="색상선택">
                 <option>색상</option>
               </select>
            </td>
          </tr>
          <tr>
            <th>부품정보</th>
            <td class="selsize">
              <select title="등급선택">
                 <option>등급</option>
               </select>
               <select title="부품분류선택">
                 <option>부품분류</option>
               </select>
               <select title="부품종류선택">
                 <option>부품종류</option>
               </select>
               <select title="부품선택">
                 <option>부품</option>
               </select>
            </td>
          </tr>
          <tr>
            <th>상품사진</th>
            <td class="p_label">
              <p>
              <label><span>전면</span> <input type="file" name="" id="" /></label>
              <label><span>후면</span> <input type="file" name="" id="" /></label>
              </p>
              <p>
              <label><span>내부</span> <input type="file" name="" id="" /></label>
              <label><span>A뒷범퍼</span> <input type="file" name="" id="" /></label>
              </p>
              <p>
              <label><span>C뒷휀다(우)</span> <input type="file" name="" id="" /></label>
              <label><span>D트렁크</span> <input type="file" name="" id="" /></label>
              </p>
              <p>
              <label><span>E뒷휀다(좌)</span> <input type="file" name="" id="" /></label>
              <label><span>F뒷도어(우)</span> <input type="file" name="" id="" /></label>
              </p>
              <p>
              <label><span>G루프</span> <input type="file" name="" id="" /></label>
              <label><span>H뒷도어(좌)</span> <input type="file" name="" id="" /></label>
              </p>
              <p>
              <label><span>I앞도어(우)</span> <input type="file" name="" id="" /></label>
              <label><span>J뒷도어(좌)</span> <input type="file" name="" id="" /></label>
              </p>
              <p>
              <label><span>K앞휀다(우)</span> <input type="file" name="" id="" /></label>
              <label><span>M본네트</span> <input type="file" name="" id="" /></label>
              </p>
              <p>
              <label><span>O앞휀다(좌)</span> <input type="file" name="" id="" /></label>
              <label><span>Q앞범퍼</span> <input type="file" name="" id="" /></label>
              </p>
              <p>
              <label><span>계기판</span> <input type="file" name="" id="" /></label>
              <label><span>측면1</span> <input type="file" name="" id="" /></label>
              </p>
              <p>
              <label><span>측면2</span> <input type="file" name="" id="" /></label>
              <label><span>엔진룸</span> <input type="file" name="" id="" /></label>
              </p>
              
            </td>
          </tr>
          <tr>
            <th>판매가격</th>
            <td>
              <input type="text" class="input_1" id="" name="" />원
              <p style="font-size:11px; padding:5px 0 0 0px;">*판매가격과 세일가격은 숫자만 입력 가능합니다.</p>
            </td>
          </tr>
          <tr>
            <th>세일가격</th>
            <td>
              <input type="text" class="input_1" id="" name="" />원
              <p style="font-size:11px; padding:5px 0 0 0px;">*판매가격과 세일가격은 숫자만 입력 가능합니다.</p>
            </td>
          </tr>
          <tr>
            <th>세일기간</th>
            <td class="selsize">
              <input type="text" class="input_1 date" id="" name="" /> ~ <input type="text" class="input_1 date" id="" name="" />
              <label style="margin-left:25px;">
                할인율
                <select title="할인율선택">
                 <option>0%</option>
               </select>
              </label>
              <p style="font-size:11px; padding:5px 0 0 0px;">*세일가격 입력시 입력된 세일가를 기준으로 할인률 등록.</p>
            </td>
          </tr>
          <tr>
            <th>배송료</th>
            <td>
                <select title="배송료선택">
                 <option>무료</option>
               </select>
               <label>
                 배송료<input type="text" class="input_1" id="" name="" style="margin-left:5px;"/>원
               </label>
            </td>
          </tr>
          <tr>
            <th>재고관리</th>
            <td>
               <label>
                재고연동여부
                <select title="재고연동여부선택">
                 <option>연동</option>
               </select>
              </label>
              <label style="margin-left:25px;">
                 재고수량<input type="text" class="input_1" id="" name="" style="margin-left:5px;"/>개
               </label>
            </td>
          </tr>
          
          <tr>
            <th>검색태그</th>
            <td>
              <input type="text" class="input_1" id="" name="" />
              <p style="font-size:11px; padding:5px 0 0 0px;">*검색시 상품명과 검색태그가 사용됩니다.</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">*이상품은 가장 잘 표현할 수 있는 단어들을 콤마(,) 로 구분해서 등록해 주세요.</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">*최대 200자까지 등록 가능합니다.</p>
            </td>
          </tr>
          <tr>
            <th>상품타입</th>
            <td class="chbox">
              <label><input type="checkbox" id="" name="" />베스트</label>
              <label><input type="checkbox" id="" name="" />이벤트</label>
              <label><input type="checkbox" id="" name="" />신상품</label>
              <label><input type="checkbox" id="" name="" />인기</label>
              <label><input type="checkbox" id="" name="" />추천</label>
              <label><input type="checkbox" id="" name="" />세일</label>
              <label><input type="checkbox" id="" name="" />기획</label>
              <p style="font-size:11px; padding:10px 0 0 0px;">- 베스트 : 상품이 실제로 많이 팔리는 제품이 아니라 관리자가 임의로 지정한 것임</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 이벤트 : 이벤트 매장에 노출</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 신상품 : 신상품 매장에 및 탭에 노출</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 인기 : 인기 상품 매장에 노출</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 추천 : 추천상품매장에 노출</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 세일 : 세일상품 매장및 탭에 노출 체크 박스 체크시 특별세일, 세일기간 선택 활성화</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 기획 : 기획 상품 매장 및 탭에 노출</p>
            </td>
          </tr>
          <tr>
            <th>승인여부</th>
            <td>
              <select title="승인여부">
                 <option>승인여부</option>
               </select>
            </td>
          </tr>
          <tr>
            <th>공급사등록</th>
            <td>
              <select title="공급사등록">
                 <option>등록된 협력업체</option>
               </select>
            </td>
          </tr>
          <tr>
            <th>내용</th>
            <td>에디터기능</td>
          </tr>
        </table>
        <div class="btn_bottom">
          <div class="r_btn">
            <span><a href="#"><img src="/images/admin/contents/btn_2.gif" alt="등록" /></a></span>
            <span><a href="#"><img src="/images/admin/contents/btn_1.gif" alt="삭제" /></a></span>
            <span><a href="#"><img src="/images/admin/contents/btn_3.gif" alt="목록" /></a></span>
          </div>
        </div>
        <!-- 부품 검색모달팝업 -->
        <div id="dialog" title="부품검색" >
          <div class="seldiv">
            <select title="제조사 선택">
                 <option>제조사</option>
            </select>
            <select title="차량 선택">
                 <option>차량</option>
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
            <select title="등급 선택">
                 <option>등급</option>
            </select>
            <select title="부품 대분류 선택">
                 <option>부품분류(대분류)</option>
            </select>
            <select title="부품 소분류 선택">
                 <option>부품분류(소분류)</option>
            </select>
            <select title="상세부품명 선택">
                 <option>상세부품명</option>
            </select>
          </div>
          <div class="btn_bottom">
            <div class="r_btn">
             <span><a href="#"><img src="/images/admin/contents/pop_search.gif" alt="검색" /></a></span>
            </div> 
          </div>
          <table class="style_3">
            <tr>
              <th>제조사</th>
              <th>차량명</th>
              <th>모델명</th>
              <th>연식</th>
              <th>색상</th>
              <th>등급</th>
              <th>부품<br/><span style="font-weight:normal;">(대분류)</span></th>
              <th>부품<br/><span style="font-weight:normal;">(소분류)</span></th>
              <th>상세부품명</th>
            </tr>
            <tr>
              <td>쉐보레</td>
              <td>아스트로벤</td>
              <td>프레스티지</td>
              <td>2013</td>
              <td>화이트</td>
              <td>A</td>
              <td>바디</td>
              <td>프론트범퍼</td>
              <td>프론트범퍼가드</td>
            </tr>
            <tr>
              <td>쉐보레</td>
              <td>아스트로벤</td>
              <td>프레스티지</td>
              <td>2013</td>
              <td>화이트</td>
              <td>A</td>
              <td>바디</td>
              <td>프론트범퍼</td>
              <td>프론트범퍼가드</td>
            </tr>
            <tr>
              <td>쉐보레</td>
              <td>아스트로벤</td>
              <td>프레스티지</td>
              <td>2013</td>
              <td>화이트</td>
              <td>A</td>
              <td>바디</td>
              <td>프론트범퍼</td>
              <td>프론트범퍼가드</td>
            </tr>
            <tr>
              <td>쉐보레</td>
              <td>아스트로벤</td>
              <td>프레스티지</td>
              <td>2013</td>
              <td>화이트</td>
              <td>A</td>
              <td>바디</td>
              <td>프론트범퍼</td>
              <td>프론트범퍼가드</td>
            </tr>
            <tr>
              <td>쉐보레</td>
              <td>아스트로벤</td>
              <td>프레스티지</td>
              <td>2013</td>
              <td>화이트</td>
              <td>A</td>
              <td>바디</td>
              <td>프론트범퍼</td>
              <td>프론트범퍼가드</td>
            </tr>
          </table>
          <div class="paging"> <span id="pagingWrap"> <a class="p_first2" href="#">&lt;&lt;</a> <a class="p_first" href="#">&lt;</a> <a href="#" class="on">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a class="p_last" href="#">&gt;</a> <a class="p_last2" href="#">&gt;&gt;</a> </span> </div>
          
        </div>
        
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


</script>
</body>
</html>
