<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<title>상품관리</title>
<script type="text/javascript" src="/lib/js/jquery.form.js"></script>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#user_price").keyup(function(event) {
		commissionCalc();
	});
});
function seller_del(){
	if(confirm("등록된 상품을 삭제하시겠습니까?")){
		document.frm.action = "seller_delete.do"; 
		document.frm.submit();
	}
}

function seller_modify(){
	f = document.frm;
	if(f.part1.value == ''){
		alert("부품분류를 선택하시기 바랍니다.");
		f.part1.focus();
		return false;
	}
	if(f.part2.value == ''){
		alert("부품종류를 선택하시기 바랍니다.");
		f.part2.focus();
		return false;
	}
	if(f.part3.value == ''){
		alert("부품명을 선택하시기 바랍니다.");
		f.part3.focus();
		return false;
	}
	if(f.carmakerseq.value == ''){
		alert("제조사를 선택하시기 바랍니다.");
		f.carmakerseq.focus();
		return false;
	}
	if(f.carmodelseq.value == ''){
		alert("차량명을 선택하시기 바랍니다.");
		f.carmodelseq.focus();
		return false;
	}
	if(f.cargradeseq.value == ''){
		alert("모델명을 선택하시기 바랍니다.");
		f.cargradeseq.focus();
		return false;
	}
	if(isNaN(f.user_price.value) || f.user_price.value == ''){
		alert("판매가격을 숫자만 입력하시기 바랍니다.");
		f.user_price.focus();
		return false;
	}
	if($("#smarteditor_mobile").length){
		oEditors.getById["smarteditor_mobile"].exec("UPDATE_CONTENTS_FIELD", []);
	}
	var carmodelseq = $("#carmodelseq option:selected").text();
	
	var part3 = $("#part3 option:selected").text();
	var caryyyy = "";
	if($("#caryyyy").val() != ""){
		caryyyy = " ("+$("#caryyyy option:selected").text()+")";
	}	
	$("#productnm").val(carmodelseq + " " + part3 + caryyyy);
	
	f.submit();
	return false;
}


function view_image(){
	var obj = $("#image_files").find("li");
	var view_image = "";
	var count = 0;
	$.each(obj,function(){
		if($(this).find("input[name=image_check]").is(":checked") == true){
			view_image = $(this).find("input[name=image_check]").val();
			count++;
		}
	});
	if(count == 1 ){
		$("#view_image").val(view_image);
	}else{
		alert('대표이미지는 1개 이상 설정할 수 없습니다.');
	}
}

function del_file(){
	var obj = $("#image_files").find("li");
	var del_files = $("#del_files").val();
	var count = 0;
	$.each(obj,function(){
		if($(this).find("input[name=image_check]").is(":checked") == true){
			if($(this).find("input[name=virtual_file_yn]").val() == 'N'){//실제 파일일 경우 파일명 넘기기
				del_files += $(this).find("input[name=image_check]").val()+",";
				fileClear($(this).find("input[name=fileNumber]").val());
				count++;
			}else{//실제 파일이 아닐경우
				fileClear($(this).find("input[name=fileNumber]").val());
			}
		}
	});
	if(count > 0 ){
		$("#del_files").val(del_files.substring(0,del_files.length-1));
	}
}

function fileClear(num){
	var html = 	'<input type="hidden" name="fileNumber" value="'+num+'">'
				+ '<input type="hidden" name="virtual_file_yn" value="Y">'
				+ '<input type="checkbox" name="image_check" value="" onclick="return false;">'
				+ '<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가" onclick="fileadd(\''+num+'\')">';
	$("#img_"+num).html(html);
}

function fileadd(num){
	$("#fileNum").val(num);
	$('#imageUploadFile').click();
	return false;	
}

function fileUpload(){
	var filename = $("#imageUploadFile").val();
	filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
	if(filename == ""){
		$("#fileNum").val('');
		return false;
	}
	if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
		alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
		return false;
	}
   	$("#fileupload").ajaxSubmit({
   		url : '/ajaxUpload.do',
   		iframe: true,
   		dataType : "json",
   		uploadProgress : function(event, position, total, percentComplete){
   		},
   		success : function(data){
   			ImageDraw(data);
   		},
   		error: function(e){
   			alert('이미지 등록에 실패하였습니다.');
   		}
   	});
}

function ImageDraw(data){
	var num = $("#fileNum").val();
	var html = 	'<input type="hidden" name="fileNumber" value="'+num+'">'
	+ '<input type="hidden" name="virtual_file_yn" value="Y">'
	+ '<input type="checkbox" name="image_check" value="'+data.uuid+'">'
	+ '<input type="hidden" name="new_files" value="'+data.yyyy+'/'+data.mm+'/'+data.uuid+'/'+data.attach_nm+'">'
	+ '<img src="/upload/temp/'+data.uuid+'">';
	$("#img_"+num).html(html);
}
</script>
</head>
				
<body>
	<div class="regi_line">
        <h3><img src="/images/mobile/sub/sub_title_b_3.gif" alt="상품등록"></h3>
      </div>
    <form name="fileupload" id="fileupload" action="/ajaxUpload.do" method="post" style="position:absolute; top:-100px;">
    	<input type="hidden" name="fileNum" id="fileNum" value="">
    	<input type="file" name="file" id="imageUploadFile" onchange="fileUpload();" style="position:absolute; top:-100px;">
    </form>
	<form name="frm" id="frm" action="seller_modify.do" method="POST" onsubmit="return seller_modify()">
	<input type="hidden" name="item_seq" value="${view.item_seq }">
	<input type="hidden" id="del_files" name="del_files" value="">
	<input type="hidden" id="view_image" name="view_image" value="">
	<input type="hidden" id="productnm" name="productnm" value="">
	  <div class="regi_contents">
        <div class="regi_wrap">
          <div class="regi_img_box">
            <h4>부품이미지등록</h4>
            <p class="h4_text"><strong class="strong_c1">※</strong> 이미지는 <strong class="strong_c1">필수 1개 이상 최대 8개</strong>까지 등록가능합니다.</p>
            <ul id="image_files">
              <li>
              	<div>
              		<label id="img_1">
              		<c:if test="${!empty data.files[0].uuid }">
              			<input type="hidden" name="fileNumber" value="1">
              			<input type="hidden" name="virtual_file_yn" value="N"> 
              			<input type="checkbox" name="image_check" value="${data.files[0].uuid }">
              			<img src="/upload/board/${data.files[0].yyyy }/${data.files[0].mm }/${data.files[0].uuid }" alt="${data.files[0].attach_nm }">
              		</c:if>
              		<c:if test="${empty data.files[0].uuid }">
              			<input type="hidden" name="fileNumber" value="1">
              			<input type="hidden" name="virtual_file_yn" value="Y">
              			<input type="checkbox" name="image_check" value="" onclick="return false;">
              			<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가" onclick="fileadd('1')">
              		</c:if>
              		</label>
              	</div>
              </li>
              <li class="right">
              	<div>
              		<label id="img_2">
              		<c:if test="${!empty data.files[1].uuid }">
              			<input type="hidden" name="fileNumber" value="2">
              			<input type="hidden" name="virtual_file_yn" value="N"> 
              			<input type="checkbox" name="image_check" value="${data.files[1].uuid }">
              			<img src="/upload/board/${data.files[1].yyyy }/${data.files[1].mm }/${data.files[1].uuid }" alt="${data.files[1].attach_nm }">
              		</c:if>
              		<c:if test="${empty data.files[1].uuid }">
              			<input type="hidden" name="fileNumber" value="2">
              			<input type="hidden" name="virtual_file_yn" value="Y">
              			<input type="checkbox" name="image_check" value="" onclick="return false;">
              			<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가" onclick="fileadd('2')">
              		</c:if>
              		</label>
              	</div>
              </li>
              
              <li>
              	<div>
              		<label id="img_3">
              		<c:if test="${!empty data.files[2].uuid }">
              			<input type="hidden" name="fileNumber" value="3">
              			<input type="hidden" name="virtual_file_yn" value="N"> 
              			<input type="checkbox" name="image_check" value="${data.files[2].uuid }">
              			<img src="/upload/board/${data.files[2].yyyy }/${data.files[2].mm }/${data.files[2].uuid }" alt="${data.files[2].attach_nm }">
              		</c:if>
              		<c:if test="${empty data.files[2].uuid }">
              			<input type="hidden" name="fileNumber" value="3">
              			<input type="hidden" name="virtual_file_yn" value="Y">
              			<input type="checkbox" name="image_check" value="" onclick="return false;">
              			<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가" onclick="fileadd('3')">
              		</c:if>
              		</label>
              	</div>
              </li>
              
              <li class="right">
              	<div>
              		<label id="img_4">
              		<c:if test="${!empty data.files[3].uuid }">
              			<input type="hidden" name="fileNumber" value="4">
              			<input type="hidden" name="virtual_file_yn" value="N"> 
              			<input type="checkbox" name="image_check" value="${data.files[3].uuid }">
              			<img src="/upload/board/${data.files[3].yyyy }/${data.files[3].mm }/${data.files[3].uuid }" alt="${data.files[3].attach_nm }">
              		</c:if>
              		<c:if test="${empty data.files[3].uuid }">
              			<input type="hidden" name="fileNumber" value="4">
              			<input type="hidden" name="virtual_file_yn" value="Y">
              			<input type="checkbox" name="image_check" value="" onclick="return false;">
              			<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가" onclick="fileadd('4')">
              		</c:if>
              		</label>
              	</div>
              </li>
              
              <li>
              	<div>
              		<label id="img_5">
              		<c:if test="${!empty data.files[4].uuid }">
              			<input type="hidden" name="fileNumber" value="5">
              			<input type="hidden" name="virtual_file_yn" value="N"> 
              			<input type="checkbox" name="image_check" value="${data.files[4].uuid }">
              			<img src="/upload/board/${data.files[4].yyyy }/${data.files[4].mm }/${data.files[4].uuid }" alt="${data.files[4].attach_nm }">
              		</c:if>
              		<c:if test="${empty data.files[4].uuid }">
              			<input type="hidden" name="fileNumber" value="5">
              			<input type="hidden" name="virtual_file_yn" value="Y">
              			<input type="checkbox" name="image_check" value="" onclick="return false;">
              			<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가" onclick="fileadd('5')">
              		</c:if>
              		</label>
              	</div>
              </li>
              <li class="right">
              	<div>
              		<label id="img_6">
              		<c:if test="${!empty data.files[5].uuid }">
              			<input type="hidden" name="fileNumber" value="6">
              			<input type="hidden" name="virtual_file_yn" value="N"> 
              			<input type="checkbox" name="image_check" value="${data.files[5].uuid }">
              			<img src="/upload/board/${data.files[5].yyyy }/${data.files[5].mm }/${data.files[5].uuid }" alt="${data.files[5].attach_nm }">
              		</c:if>
              		<c:if test="${empty data.files[5].uuid }">
              			<input type="hidden" name="fileNumber" value="6">
              			<input type="hidden" name="virtual_file_yn" value="Y">
              			<input type="checkbox" name="image_check" value="" onclick="return false;">
              			<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가" onclick="fileadd('6')">
              		</c:if>
              		</label>
              	</div>
              </li>
              
              <li>
              	<div>
              		<label id="img_7">
              		<c:if test="${!empty data.files[6].uuid }">
              			<input type="hidden" name="fileNumber" value="7">
              			<input type="hidden" name="virtual_file_yn" value="N"> 
              			<input type="checkbox" name="image_check" value="${data.files[6].uuid }">
              			<img src="/upload/board/${data.files[6].yyyy }/${data.files[6].mm }/${data.files[6].uuid }" alt="${data.files[6].attach_nm }">
              		</c:if>
              		<c:if test="${empty data.files[6].uuid }">
              			<input type="hidden" name="fileNumber" value="7">
              			<input type="hidden" name="virtual_file_yn" value="Y">
              			<input type="checkbox" name="image_check" value="" onclick="return false;">
              			<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가" onclick="fileadd('7')">
              		</c:if>
					</label>
				</div>
			  </li>
              <li class="right">
              	<div>
              		<label id="img_8">
              		<c:if test="${!empty data.files[7].uuid }">
              			<input type="hidden" name="fileNumber" value="8">
              			<input type="hidden" name="virtual_file_yn" value="N"> 
              			<input type="checkbox" name="image_check" value="${data.files[7].uuid }">
              			<img src="/upload/board/${data.files[7].yyyy }/${data.files[7].mm }/${data.files[7].uuid }" alt="${data.files[7].attach_nm }">
              		</c:if>
              		<c:if test="${empty data.files[7].uuid }">
              			<input type="hidden" name="fileNumber" value="8">
              			<input type="hidden" name="virtual_file_yn" value="Y">
              			<input type="checkbox" name="image_check" value="" onclick="return false;">
              			<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가" onclick="fileadd('8')">
              		</c:if>
              		</label>
              	</div>
              </li>
            </ul>
            <!-- <p><strong class="strong_c2">※ 대표이미지를 선택하지 않을 시 첫번째 이미지로 자동등록됩니다.</strong></p> -->

            <div class="regi_img_btn">
              <span class="btn_l"><!-- <a href="javascript:view_image();"><img src="/images/mobile/sub/res_btn_1.gif" alt="대표이미지 설정"></a> --></span>
              <span class="btn_r">
              <a class="btn_delete" href="javascript:del_file();"><img src="/images/mobile/sub/res_btn_2.gif" alt="이미지삭제"></a>
              <!-- <a href="#"><img src="/images/mobile/sub/res_btn_3.gif" alt="이미지추가"></a> -->
              </span>
            </div>
          </div>

          <div class="regi_input">

            <h4>부품정보입력</h4>
            <p class="h4_text"><strong class="strong_c1">※ 빨간색 항목은 필수사항</strong>이며 정확히 입력해 주시기 바랍니다.</p>

            <table class="regi_style_1" style="margin-top:3%;">
            <colgroup>
            <col width="26%">
            <col width="">
            </colgroup>
            <tbody>

            <tr>
              <th scope="row">※ 부품분류</th>
              <td>
                <select name="part1" class="select_sm">
                	<option value="">부품분류</option>
                	<c:forEach var="item" items="${data.part1 }" varStatus="status">
                	<option value="${item.code }" <c:if test="${item.code eq view.part1 }">selected="selected"</c:if>>${item.code_nm }</option>
                	</c:forEach>
                </select>
              </td>
            </tr>

            <tr>
              <th scope="row">※ 부품종류</th>
              <td>
                <select name="part2" class="select_sm">
                	<option value="">부품종류</option>
                	<c:forEach var="item" items="${data.part2 }" varStatus="status">
                	<option value="${item.code }" <c:if test="${item.code eq view.part2 }">selected="selected"</c:if>>${item.code_nm }</option>
                	</c:forEach>
                </select>
              </td>
            </tr>

            <tr>
              <th scope="row">※ 부품명</th>
              <td>
                <select name="part3" id="part3" class="select_sm">
                	<option value="">부품명</option>
                	<c:forEach var="item" items="${data.part3 }" varStatus="status">
                	<option value="${item.code }" <c:if test="${item.code eq view.part3 }">selected="selected"</c:if>>${item.code_nm }</option>
                	</c:forEach>
                </select>
              </td>
            </tr>

            

            <tr>
              <th scope="row">※ 제조사</th>
              <td>
                <select name="carmakerseq" class="select_sm">
                	<option value="">제조사</option>
                	<c:forEach var="item" items="${data.carmakerseq }" varStatus="status">
                	<option value="${item.carmakerseq }" <c:if test="${item.carmakerseq eq view.carmakerseq }">selected="selected"</c:if>>${item.makernm }</option>
                	</c:forEach>
                </select>
              </td>
            </tr>

            <tr>
              <th scope="row">※ 차량명</th>
              <td>
                <select name="carmodelseq" id="carmodelseq" class="select_sm">
                	<option value="">차량명</option>
                	<c:forEach var="item" items="${data.carmodel }" varStatus="status">
                	<option value="${item.carmodelseq }" <c:if test="${item.carmodelseq eq view.carmodelseq }">selected="selected"</c:if>>${item.carmodelnm }</option>
                	</c:forEach>
                </select>
              </td>
            </tr>

            <tr>
              <th scope="row">※ 모델명</th>
              <td>
                <select name="cargradeseq" class="select_sm">
                	<option value="">모델명</option>
                	<c:forEach var="item" items="${data.cargrade }" varStatus="status">
                	<option value="${item.cargradeseq }" <c:if test="${item.cargradeseq eq view.cargradeseq }">selected="selected"</c:if>>${item.cargradenm }</option>
                	</c:forEach>
                </select>
              </td>
            </tr>

            <tr>
              <th scope="row" class="c1">연식</th>
              <td>
                <select name="caryyyy" id="caryyyy" class="select_sm">
                	<option value="">연식</option>
                	<c:forEach var="item" begin="1995" end="${dtf:getTime('yyyy') }">
              		<option value="${item }" <c:if test="${item eq view.caryyyy }">selected="selected"</c:if>>${item }년</option>
               		</c:forEach>
                </select>
              </td>
            </tr>

			<tr>
              <th scope="row" class="c1">등급</th>
              <td>
                <select name="grade" class="select_sm">
                	<option value="">등급</option>
                	<c:forEach var="item" items="${data.grade }" varStatus="status">
                	<option value="${item.code }" <c:if test="${item.code eq view.grade }">selected="selected"</c:if>>${item.code_nm }</option>
                	</c:forEach>
                </select>
              </td>
            </tr>

            <tr>
              <th scope="row" class="c1">색상</th>
              <td>
                <select name="color" class="select_sm">
                	<option value="">색상</option>
	                <c:forEach var="item" items="${data.color }" varStatus="status">
	               	<option value="${item.code }" <c:if test="${item.code eq view.color }">selected="selected"</c:if>>${item.code_nm }</option>
	               	</c:forEach>
                </select>
              </td>
            </tr>

            </tbody>
            </table>

          </div>

          <div class="regi_price_box">

            <div class="price_1">

              <h4>일반회원 판매가격설정</h4>

              <p class="h4_text">※ <strong>일반회원에게 노출</strong>되는 가격입니다.
              판매가격은 숫자만 입력가능합니다.</p>

              <div class="p_input">

                <p>
                <span><strong>사용여부</strong></span>
                <span>
                <select name="user_pricing_yn" class="select_1">
                	<option value="Y" <c:if test="${view.user_pricing_yn eq 'Y' }">selected="selected"</c:if>>사용</option>
                	<option value="N" <c:if test="${view.user_pricing_yn eq 'N' }">selected="selected"</c:if>>사용안함</option>
                </select>
                </span>
                </p>
                <p>
                <span><strong>판매가격</strong></span>
                <span>
                <input type="number" pattern="[0-9]*" inputmode="numeric" min="0" id="user_price" name="user_price" class="input_r1" value="${view.user_price }" > 원
                </span>
                </p>

              </div>

            </div>

            <div class="price_2">

              <h4>협력사 판매가격설정</h4>

              <p class="h4_text">※ <strong>협력사회원간 노출</strong>되는 가격입니다.
              일반회원에게는 노출되지 않습니다.</p>

              <div class="p_input">

                <p>
                <span><strong>사용여부</strong></span>
                <span>
                <select name="supplier_pricing_yn" class="select_1" onchange="commissionCalc()">
                <option value="Y" <c:if test="${view.supplier_pricing_yn eq 'Y' }">selected="selected"</c:if>>사용</option>
                <option value="N" <c:if test="${view.supplier_pricing_yn eq 'N' || view.supplier_pricing_yn eq ''}">selected="selected"</c:if>>사용안함</option>
                </select>
                </span>
                </p>
                <p>
                <span><strong>판매가격</strong></span>
                <span>
                <input type="text" name="supplier_price" class="input_r1" value="${view.supplier_price }" readonly="readonly"> 원
                </span>
                </p>

              </div>

            </div>



          </div>

          <div class="regi_info">

            <h4>기타정보입력</h4>

            <p class="h4_text"><strong class="strong_c1">※ ERP코드관리 및 사용자 수수료율은 PC에서 관리가능합니다.</strong></p>
            <div class="ri_input">
              <span><strong>검색태그</strong></span>
              <span><input type="text" name="search_tag" class="input_r1" value="${view.search_tag }" placeholder="밤바, 후론트밤바, 가드, 중고범퍼"></span>
            </div>

            <p>※  검색시 상품명과 검색태그가 사용됩니다.  최대 200자까지 등록 가능합니다.
            이상품은 가장 잘 표현할 수 있는 단어들을 콤마( , ) 로 구분해서 등록해 주세요.
            <strong>예시) 밤바, 후론트밤바, 가드, 중고범퍼, 케이파이브, 흰색범퍼</strong>
            </p>

          </div>

          <div class="regi_explanation">

            <h4>부품설명</h4>
            <p class="h4_text">※ 부품의 상세한 설명을 입력해주세요.</p>

            <div class="re_text">
              <textarea name="conts" id="smarteditor_mobile" style="width:100%;height:100px;min-width:100%; display:none;">${view.conts }</textarea>
            </div>

          </div>

        </div>

      </div>

      <div class="regi_bottom">
        <p><strong>※ 쇼핑몰 운영정책에 위배되는 상품은 삭제처리 될 수 있으니 다시한번 검토 바랍니다.</strong></p>
        <div class="regi_bottom_btn">
          <span class="btn_l"><a class="rb_1" href="seller_list.do?menu=menu8"><img src="/images/mobile/sub/list_btn.gif" alt="목록으로"></a></span>
          <span class="btn_r">
          <a class="rb_2" href="javascript:seller_del();"><img src="/images/mobile/sub/res_btn_4.gif" alt="등록취소"></a>
          <a class="rb_3" href="javascript:seller_modify();"><img src="/images/mobile/sub/res_btn_5.gif" alt="상품등록"></a>
          </span>
        </div>
      </div>

	  <span class="btn_regi"><a href="/mobile"><img src="/images/mobile/common/btn_home.png" alt="home"></a></span>
	</form>
</body>
</html>
