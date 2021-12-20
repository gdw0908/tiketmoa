<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="main">
  <div class="titlebar">
    <h2>차량등록</h2>
    <div> <span>통합관리</span> &gt; <span>상품관리</span> &gt; <span>상품등록</span> &gt;<span class="bar_tx">차량등록</span> </div>
  </div>
  <div class="container"> 
    <div class="contents">
    <form id="wFrm" name="frm" method="post" novalidate="novalidate" enctype="multipart/form-data">
		<div class="contents_view">
        <table class="style_1" style="table-layout:fixed;">
          <colgroup>
          <col width="10%" />
          <col width="*" />
          <col width="10%" />
          <col width="*" />
          </colgroup>
          <tr>
            <th>차량정보</th>
            <td class="selsize" colspan="3">
	          	<select title="제조사선택" data-ng-model="form.carmakerseq" data-ng-options="item.carmakerseq as item.makernm for item in carmaker" data-ng-change="changeCarmaker()" required>
	          		<option value="">제조사</option>
	            </select>
	          	<select title="차량명선택" data-ng-model="form.carmodelseq" data-ng-options="item.carmodelseq as item.carmodelnm for item in carmodel" data-ng-change="changeCarmodel()" required>
	          		<option value="">차량명</option>
	            </select>
	          	<select title="모델명선택" data-ng-model="form.cargradeseq" data-ng-options="item.cargradeseq as item.cargradenm for item in cargrade" required>
	          		<option value="">모델명</option>
	            </select>
	          	<select title="연식선택" data-ng-model="form.caryyyy" data-ng-options="item as item for item in [1995, main.year()]|range:4">
	          		<option value="">연식</option>
	            </select>
	          	<select title="색상선택" data-ng-model="form.color" data-ng-options="item.code as item.code_nm for item in color">
	          		<option value="">색상</option>
	            </select>
            </td>
          </tr>
          <tr>
            <th>부품정보</th>
            <td class="selsize" colspan="3">
	          	<select title="등급선택" data-ng-model="form.grade" data-ng-options="item.code as item.code_nm for item in grade">
	          		<option value="">등급</option>
	            </select>
	          	<select title="부품분류선택" data-ng-model="form.part1" data-ng-options="item.code as item.code_nm for item in part1" data-ng-change="changePart1()" >
	          		<option value="">부품분류</option>
	            </select>
	          	<select title="부품종류선택" data-ng-model="form.part2" data-ng-options="item.code as item.code_nm for item in part2" data-ng-change="changePart2()" >
	          		<option value="">부품종류</option>
	            </select>
	          	<select title="부품선택" data-ng-model="form.part3" data-ng-options="item.code as item.code_nm for item in part3" >
	          		<option value="">부품</option>
	            </select>
            </td>
          </tr>
          <tr>
            <th>상품사진</th>
            <td colspan="3" class="p_label">
              <p>
              <label><span>전면</span> <input type="file" name="file" id="file1" onchange="angular.element(this).scope().uploadFile('1')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;"><img data-ng-if="!!form.files[0].uuid" data-ng-src="/upload/temp/{{form.files[0].uuid}}" alt="사진" style="width: 100px; height: 70px;"/></span>
              </label>
              <label><span>후면</span> <input type="file" name="file" id="file2" onchange="angular.element(this).scope().uploadFile('2')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[1].uuid" data-ng-src="/upload/temp/{{form.files[1].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              </p>
              <p>
              <label><span>내부</span> <input type="file" name="file" id="file3" onchange="angular.element(this).scope().uploadFile('3')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[2].uuid" data-ng-src="/upload/temp/{{form.files[2].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              <label><span>A뒷범퍼</span> <input type="file" name="file" id="file4" onchange="angular.element(this).scope().uploadFile('4')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[3].uuid" data-ng-src="/upload/temp/{{form.files[3].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              </p>
              <p>
              <label><span>C뒷휀다(우)</span> <input type="file" name="file" id="file5" onchange="angular.element(this).scope().uploadFile('5')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[4].uuid" data-ng-src="/upload/temp/{{form.files[4].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              <label><span>D트렁크</span> <input type="file" name="file" id="file6" onchange="angular.element(this).scope().uploadFile('6')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[5].uuid" data-ng-src="/upload/temp/{{form.files[5].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              </p>
              <p>
              <label><span>E뒷휀다(좌)</span> <input type="file" name="file" id="file7" onchange="angular.element(this).scope().uploadFile('7')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[6].uuid" data-ng-src="/upload/temp/{{form.files[6].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              <label><span>F뒷도어(우)</span> <input type="file" name="file" id="file8" onchange="angular.element(this).scope().uploadFile('8')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[7].uuid" data-ng-src="/upload/temp/{{form.files[7].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              </p>
              <p>
              <label><span>G루프</span> <input type="file" name="file" id="file9" onchange="angular.element(this).scope().uploadFile('9')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[8].uuid" data-ng-src="/upload/temp/{{form.files[8].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              <label><span>H뒷도어(좌)</span> <input type="file" name="file" id="file10" onchange="angular.element(this).scope().uploadFile('10')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[9].uuid" data-ng-src="/upload/temp/{{form.files[9].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              </p>
              <p>
              <label><span>I앞도어(우)</span> <input type="file" name="file" id="file11" onchange="angular.element(this).scope().uploadFile('11')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[10].uuid" data-ng-src="/upload/temp/{{form.files[10].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              <label><span>J뒷도어(좌)</span> <input type="file" name="file" id="file12" onchange="angular.element(this).scope().uploadFile('12')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[11].uuid" data-ng-src="/upload/temp/{{form.files[11].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              </p>
              <p>
              <label><span>K앞휀다(우)</span> <input type="file" name="file" id="file13" onchange="angular.element(this).scope().uploadFile('13')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[12].uuid" data-ng-src="/upload/temp/{{form.files[12].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              <label><span>M본네트</span> <input type="file" name="file" id="file14" onchange="angular.element(this).scope().uploadFile('14')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[13].uuid" data-ng-src="/upload/temp/{{form.files[13].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              </p>
              <p>
              <label><span>O앞휀다(좌)</span> <input type="file" name="file" id="file15" onchange="angular.element(this).scope().uploadFile('15')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[14].uuid" data-ng-src="/upload/temp/{{form.files[14].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              <label><span>Q앞범퍼</span> <input type="file" name="file" id="file16" onchange="angular.element(this).scope().uploadFile('16')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[15].uuid" data-ng-src="/upload/temp/{{form.files[15].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              </p>
              <p>
              <label><span>계기판</span> <input type="file" name="file" id="file17" onchange="angular.element(this).scope().uploadFile('17')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[16].uuid" data-ng-src="/upload/temp/{{form.files[16].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              <label><span>측면1</span> <input type="file" name="file" id="file18" onchange="angular.element(this).scope().uploadFile('18')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[17].uuid" data-ng-src="/upload/temp/{{form.files[17].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              </p>
              <p>
              <label><span>측면2</span> <input type="file" name="file" id="file19" onchange="angular.element(this).scope().uploadFile('19')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[18].uuid" data-ng-src="/upload/temp/{{form.files[18].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              <label><span>엔진룸</span> <input type="file" name="file" id="file20" onchange="angular.element(this).scope().uploadFile('20')"/>
              <span style="display: block; padding: 3px 15px 3px 0px;">
              <img data-ng-if="!!form.files[19].uuid" data-ng-src="/upload/temp/{{form.files[19].uuid}}" alt="사진" style="width: 100px; height: 70px;"/>
              </span>
              </label>
              </p>
            </td>
          </tr>
          <tr>
            <th>사용자 판매가격 설정</th>
            <td>
              <select title="사용자 판매가격 설정 선택" data-ng-model="form.user_pricing_yn" data-ng-init="form.user_pricing_yn='Y'">
                 <option value="Y">사용</option>
                 <option value="N">사용안함</option>
               </select>
            </td>
            <th>사용자 판매가격</th>
            <td>
              <input type="text" class="input_1" data-ng-model="form.user_price" data-ng-pattern="/^[0-9]+$/" data-ng-change="salePrice();supplierPrice();"/>원
              <label style="margin-left: 10px;">
                <input type="checkbox" data-ng-model="form.inquiry_yn" data-ng-true-value="Y" data-ng-false-value="N" data-ng-init="form.inquiry_yn='N'"/><span>고객센터문의</span>
              </label>
              <p style="font-size:11px; padding:5px 0 0 0px;">*판매가격과 세일가격은 숫자만 입력 가능합니다.</p>
            </td>
          </tr>
          <tr>
            <th>공급사 판매가격 설정</th>
            <td>
				<select title="공급사 판매가격 설정 선택" data-ng-model="form.supplier_pricing_yn" data-ng-init="form.supplier_pricing_yn='N'" data-ng-change="supplierPrice()">
                 <option value="Y">사용</option>
                 <option value="N">사용안함</option>
               	</select>
            </td>
            <th>공급사 판매가격</th>
            <td>
              <input type="text" class="input_1" data-ng-model="form.supplier_price" data-ng-pattern="/^[0-9]+$/" readonly="readonly"/>원
              <p style="font-size:11px; padding:5px 0 0 0px;">*판매가격과 세일가격은 숫자만 입력 가능합니다.</p>
            </td>
          </tr>
          <tr>
            <th>세일가격</th>
            <td colspan="3">
              <input type="text" class="input_1" data-ng-model="form.sale_price" data-ng-pattern="/^[0-9]+$/" readonly="readonly"/>원
              <p style="font-size:11px; padding:5px 0 0 0px;">*판매가격과 세일가격은 숫자만 입력 가능합니다.</p>
            </td>
          </tr>
          <tr>
            <th>세일기간</th>
            <td class="selsize" colspan="3">
              <input type="text" class="input_1" data-ng-model="form.sale_sdate" datepicker/> ~ <input type="text" class="input_1" data-ng-model="form.sale_edate" datepicker/>
              <label style="margin-left:25px;">
                할인율
	          	<select title="할인율선택" data-ng-model="form.discount_rate2" data-ng-options="item+'' as item+'%' for item in [1, 100]|range" data-ng-change="salePrice()">
                 <option value="">0%</option>
               </select>
              </label>
            </td>
          </tr>
          <tr>
            <th>배송료</th>
            <td colspan="3">
				<select title="배송료선택" data-ng-model="form.fee_yn" data-ng-init="form.fee_yn='C'" data-ng-change="form.fee_yn=='C'||form.fee_yn=='N'?form.fee_amount='':''">
                 <option value="C">착불</option>
                 <option value="N">무료</option>
                 <option value="Y">유료</option>
               	</select>
               <label>
                 배송료<input type="text" class="input_1" style="margin-left:5px;" data-ng-model="form.fee_amount" data-ng-disabled="form.fee_yn=='C'||form.fee_yn=='N'" data-ng-pattern="/^[0-9]+$/"/>원
               </label>
            </td>
          </tr>
          <tr>
            <th>재고관리</th>
            <td colspan="3">
               <label>
                재고연동여부
                <select title="재고연동여부선택" data-ng-model="form.stock_yn" data-ng-init="form.stock_yn='Y'">
                 <option value="Y">연동함</option>
                 <option value="N">연동안함</option>
               </select>
              </label>
              <label style="margin-left:25px;">
                 재고수량<input type="text" class="input_1" style="margin-left:5px;" data-ng-model="form.stock_num" data-ng-pattern="/^[0-9]+$/" data-ng-init="form.stock_num='1'" required="required"/>개
               </label>
            </td>
          </tr>
          <tr>
            <th>ERP코드관리</th>
            <td colspan="3"><input type="text" class="input_1" data-ng-model="form.erp_code"/></td>
          </tr>
<!--           <tr> -->
<!--             <th>수수료관리</th> -->
<!--             <td colspan="3"> -->
<!--               <input type="text" class="input_1" data-ng-model="form.commission" data-ng-pattern="/^[0-9\.]+$/"/>% -->
<!--             </td> -->
<!--           </tr> -->
          <tr>
            <th>검색태그</th>
            <td colspan="3">
              <input type="text" class="input_1" style="width:90%;" data-ng-model="form.search_tag"/>
              <p style="font-size:11px; padding:5px 0 0 0px;">*검색시 상품명과 검색태그가 사용됩니다.</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">*이상품은 가장 잘 표현할 수 있는 단어들을 콤마(,) 로 구분해서 등록해 주세요.</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">*최대 200자까지 등록 가능합니다.</p>
            </td>
          </tr>
          <tr>
            <th>상품타입</th>
            <td class="chbox" colspan="3">
              <label><input type="checkbox" data-ng-model="form.bestyn" data-ng-true-value="Y" data-ng-false-value="N" data-ng-init="form.bestyn='N'"/>베스트</label>
              <label><input type="checkbox" data-ng-model="form.eventyn" data-ng-true-value="Y" data-ng-false-value="N" data-ng-init="form.eventyn='N'"/>이벤트</label>
              <label><input type="checkbox" data-ng-model="form.newyn" data-ng-true-value="Y" data-ng-false-value="N" data-ng-init="form.newyn='N'"/>신상품</label>
              <label><input type="checkbox" data-ng-model="form.publicyn" data-ng-true-value="Y" data-ng-false-value="N" data-ng-init="form.publicyn='N'"/>인기</label>
              <label><input type="checkbox" data-ng-model="form.recommyn" data-ng-true-value="Y" data-ng-false-value="N" data-ng-init="form.recommyn='N'"/>추천</label>
              <label><input type="checkbox" data-ng-model="form.saleyn" data-ng-true-value="Y" data-ng-false-value="N" data-ng-init="form.saleyn='N'"/>세일</label>
              <label><input type="checkbox" data-ng-model="form.planyn" data-ng-true-value="Y" data-ng-false-value="N" data-ng-init="form.planyn='N'"/>기획</label>
              <p style="font-size:11px; padding:10px 0 0 0px;">- 베스트 : 상품이 실제로 많이 팔리는 제품이 아니라 관리자가 임의로 지정한 것임</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 이벤트 : 이벤트 매장에 노출</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 신상품 : 신상품 매장에 및 탭에 노출</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 인기 : 인기 상품 매장에 노출</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 추천 : 추천상품매장에 노출</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 세일 : 세일상품 매장및 탭에 노출 체크 박스 체크시 특별세일, 세일기간 선택 활성화</p>
              <p style="font-size:11px; padding:5px 0 0 0px;">- 기획 : 기획 상품 매장 및 탭에 노출</p>
            </td>
          </tr>
          <c:if test="${sessionScope.member.group_seq eq '1' || sessionScope.member.member_id eq 'insun'}">
          <tr>
            <th>승인여부</th>
            <td colspan="3">
              <select title="승인여부" data-ng-model="form.approval" data-ng-init="form.approval='Y'">
                 <option value="Y">승인</option>
                 <option value="N">비승인</option>
               </select>
            </td>
          </tr>
          </c:if>
          <tr>
            <th>공급사</th>
            <td colspan="3" data-ng-if="param.group_seq=='1'">
            	<select title="공급사등록" data-ng-model="form.com_seq" data-ng-options="item.seq as item.com_nm for item in cooperationList|filter: {com_nm:form.com_keyword}" required data-ng-change="supplierPrice()">
	          		<option value="">등록된 협력업체</option>
	            </select>
               <input type="text" data-ng-model="form.com_keyword" placeholder="협력업체 검색"/>
            </td>
            <td colspan="3" data-ng-if="param.group_seq=='3'">
            	{{form.com_nm}}
            </td>
          </tr>
          <tr>
            <th>내용</th>
            <td colspan="3">
            	<textarea style="width:100%;" id="conts" data-ng-model="form.conts" smarteditor></textarea>
            </td>
          </tr>
        </table>
      
		<div class="btn_bottom">
			<div class="r_btn">
			    <span class="bt_all">
			    	<span><input type="button" value="저장" class="btall" data-ng-click="save()"/></span>
			    </span> 
			    <span class="bt_all">
			    	<span><input type="button" value="취소" class="btall" data-ng-click="list()"/></span>
			    </span> 
			</div>
      	</div>
		</div>
      </form>
    </div>
  </div>
</div>