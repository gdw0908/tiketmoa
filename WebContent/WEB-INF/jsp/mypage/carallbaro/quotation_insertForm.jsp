<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript" src="/lib/js/jquery.form.js"></script>
<script type="text/javascript" src="/lib/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript">
var filecount = 0;
$(document).ready(function(){
	$("#tow_date").datepicker();
})
function changeSido(){
	$.getJSON("/json/list/code.sigungu.do", {sido: $("#sido_cd").val()}, function(data){
		$("#sigungu_cd").empty();
		$("#sigungu_cd").append("<option value=''>시/군/구</option>");
		$.each(data, function(i, o){
			$("#sigungu_cd").append("<option value='"+o.sigungu+"'>"+o.dong_nm+"</option>");
		});
	});
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
	var obj = $(".regi_img_input").find("div");
	var del_files = $("#del_files").val();
	var count = 0;
	$.each(obj,function(){
		if($(this).find("label>input:checkbox").is(":checked") == true){
			if($(this).find("label>input[name=virtual_file_yn]").val() == 'N'){//실제 파일일 경우 파일명 넘기기
				del_files += $(this).find("label>input[name=image_check]").val()+",";
				fileClear($(this).find("input[name=fileNumber]").val());
				count++;
			}else{
				fileClear($(this).find("input[name=fileNumber]").val());
			}
        }
	});
	if(count > 0 ){
		$("#del_files").val(del_files.substring(0,del_files.length-1));
	}
}

function fileClear(num){
	var html = 	'<input type="hidden" name="virtual_file_yn" value="Y">'
				+ '<input type="checkbox" name="image_check" value="" onclick="return false;">'
				+ '<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가" >';
	$("#img_"+num).html(html);
	filecount--;
}

function fileUpload(num){
	$('#fileupload_'+num).submit();
}

function ImageDraw(num,yyyy,mm,uuid,attach_nm){
	var html = '<input type="hidden" name="virtual_file_yn" value="Y"/>'
	+ '<input type="checkbox" name="image_check" value="'+uuid+'"/>'
	+ '<img src="/upload/temp/'+uuid+'" >'
	+ '</label>';
	$("#img_"+num).html(html);
	$("#new_img"+num).html('<input type="hidden" name="new_files" value="'+yyyy+'/'+mm+'/'+uuid+'/'+attach_nm+'">');
	filecount++;
}

</script>
 <div id="sub">
        <div class="strapline">
			<h3><img src="/images/sub_2/h3_img_3.gif" alt="카올바로"></h3>
			<div class="state"> <span>홈</span> &gt; <span>고객센터</span> &gt; <span>카올바로</span> &gt; <span><strong>견적요청</strong></span></div>
		</div>
        <div class="contents">
    <iframe name="hiddenFrame" class="i_hide"></iframe>
    <div class="regi_img_box">
		<h5>이미지등록</h5>
		<p class="h4_text">※ 이미지는 <strong class="strong_c1">필수 1개 이상 최대 4개</strong>까지 등록가능합니다.</p>
		<div class="regi_img_input">
			<div>
				<form name="fileupload" target="hiddenFrame" id="fileupload_1" action="/ajaxUploadCarAll.do" method="post" enctype="multipart/form-data"><!--  style="position:absolute; top:-100px;" -->
					<input type="hidden" name="fileNumber" value="1"/>
					<label id="img_1">
						<c:if test="${!empty data.files[0].uuid }">
			      			<input type="hidden" name="virtual_file_yn" value="N"/> 
			      			<input type="checkbox" name="image_check" value="${data.files[0].uuid }"/>
			      			<img src="/upload/board/${data.files[0].yyyy }/${data.files[0].mm }/${data.files[0].uuid }" alt="${data.files[0].attach_nm }"/>
			      		</c:if>
			      		<c:if test="${empty data.files[0].uuid }">
			      			<input type="hidden" name="virtual_file_yn" value="Y"/>
			      			<input type="checkbox" name="image_check" value="" onclick="return false;"/>
			      			<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가"/>
			      		</c:if>
					</label>
					<p>
						<input type="file" name="file" id="imageUploadFile" onchange="fileUpload('1')"/>
					</p>
				</form>
			</div>
			<div>
				<form name="fileupload" target="hiddenFrame" id="fileupload_2" action="/ajaxUploadCarAll.do" method="post" enctype="multipart/form-data"><!--  style="position:absolute; top:-100px;" -->
					<input type="hidden" name="fileNumber" value="2"/>
					<label id="img_2">
						<c:if test="${!empty data.files[1].uuid }">
			      			<input type="hidden" name="virtual_file_yn" value="N"/> 
			      			<input type="checkbox" name="image_check" value="${data.files[1].uuid }"/>
			      			<img src="/upload/board/${data.files[1].yyyy }/${data.files[1].mm }/${data.files[1].uuid }" alt="${data.files[1].attach_nm }"/>
			      		</c:if>
			      		<c:if test="${empty data.files[1].uuid }">
			      			<input type="hidden" name="virtual_file_yn" value="Y"/>
			      			<input type="checkbox" name="image_check" value="" onclick="return false;"/>
			      			<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가"/>
			      		</c:if>
					</label>
					<p>
						<input type="file" name="file" id="imageUploadFile" onchange="fileUpload('2')"/>
					</p>
				</form>
			</div>
			<div>
				<form name="fileupload" target="hiddenFrame" id="fileupload_3" action="/ajaxUploadCarAll.do" method="post" enctype="multipart/form-data"><!--  style="position:absolute; top:-100px;" -->
					<input type="hidden" name="fileNumber" value="3"/>
					<label id="img_3">
						<c:if test="${!empty data.files[2].uuid }">
			      			<input type="hidden" name="virtual_file_yn" value="N"/> 
			      			<input type="checkbox" name="image_check" value="${data.files[2].uuid }"/>
			      			<img src="/upload/board/${data.files[2].yyyy }/${data.files[2].mm }/${data.files[2].uuid }" alt="${data.files[2].attach_nm }"/>
			      		</c:if>
			      		<c:if test="${empty data.files[2].uuid }">
			      			<input type="hidden" name="virtual_file_yn" value="Y"/>
			      			<input type="checkbox" name="image_check" value="" onclick="return false;"/>
			      			<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가"/>
			      		</c:if>
					</label>
					<p>
						<input type="file" name="file" id="imageUploadFile" onchange="fileUpload('3')"/>
					</p>
				</form>
			</div>
			<div class="last">
				<form name="fileupload" target="hiddenFrame" id="fileupload_4" action="/ajaxUploadCarAll.do" method="post" enctype="multipart/form-data"><!--  style="position:absolute; top:-100px;" -->
					<input type="hidden" name="fileNumber" value="4"/>
					<label id="img_4">
						<c:if test="${!empty data.files[3].uuid }">
			      			<input type="hidden" name="virtual_file_yn" value="N"/> 
			      			<input type="checkbox" name="image_check" value="${data.files[3].uuid }"/>
			      			<img src="/upload/board/${data.files[3].yyyy }/${data.files[3].mm }/${data.files[3].uuid }" alt="${data.files[3].attach_nm }"/>
			      		</c:if>
			      		<c:if test="${empty data.files[3].uuid }">
			      			<input type="hidden" name="virtual_file_yn" value="Y"/>
			      			<input type="checkbox" name="image_check" value="" onclick="return false;"/>
			      			<img src="/images/mobile/sub/sub_res_imgn.gif" style="width:200px;"alt="파일추가"/>
			      		</c:if>
					</label>
					<p>
						<input type="file" name="file" id="imageUploadFile" onchange="fileUpload('4')"/>
					</p>
				</form>
			</div>
		</div>
		<div class="regi_img_btn">
			<span class="btn_r">
				<a class="btn_delete" href="javascript:del_file();"><img src="/images/mobile/sub/res_btn_2.gif" alt="이미지삭제"/></a>
			</span>
		</div>
    </div>
	<form name="wFrm" id="wFrm" action="quotation_insert.do" method="post" enctype="multipart/form-data"  onsubmit="return carallbaroSubmit(this);">
		<div>
			<span id="new_img1"></span>
			<span id="new_img2"></span>
			<span id="new_img3"></span>
			<span id="new_img4"></span>			
		</div>
		<table class="write_style_1">
			<colgroup>
				<col width="20%">
				<col width="">
			</colgroup>
			<tbody>
				<c:if test="${sessionScope.member == null }">
				<tr>
					<th scope="row">이름</th>
					<td><input type="text" id="member_nm" name="member_nm" class="input_1" style="width:100px;"></td>
				</tr>
				<tr>
					<th scope="row">비밀번호</th>
					<td><input type="password" id="password" name="password" class="input_1" style="width:100px;"></td>
				</tr>
				</c:if>
				<tr>
					<th scope="row">전화번호</th>
					<td>
						<p>
							<select id="charge_tel1" name="charge_tel1" class="select_u1">
							<c:forEach items="${code }" var="code" varStatus="status">
								<option value="${code.code }">${code.code }</option>
							</c:forEach>
				    		</select>
				    		- <input type="text" id="charge_tel2" name="charge_tel2" class="input_3 ws_2"> - <input type="text" id="charge_tel3" name="charge_tel3" class="input_3 ws_2">
						</p>
						<p class="ph_text">※ 입력하신 개인정보는 별도 요청이 없을 경우 6개월 보관 후 삭제되며, 문의 사항 확인이나 답변의 전달을 위해 고객님께 연락을 취하는 용도 이외에는 사용되지 않습니다. 또한 항목에 체크하실 경우 이에 동의하는 것으로 간주하며, 동의하지 않을 경우, 게시가 이루어지지 않습니다. <label><input type="checkbox" id="agree" name="agree" class="check"> 동의합니다</label></p>
					</td>
				</tr>
				<tr>
					<th>브랜드</th>
					<td>
						<select name="carmakerseq" class="select_1 ws_2" >
							<option value="">브랜드</option>
						<c:forEach items="${carmaker }" var="item" varStatus="status">
							<option value="${item.carmakerseq }">${item.makernm }</option>
						</c:forEach>	
						</select>
					</td>
				</tr>
				<tr>
					<th>지역</th>
					<td>
						<select name="sido_cd" id="sido_cd" class="select_1 ws_2" onchange="changeSido()">
							<option value="">시/도</option>
						<c:forEach items="${sido_cd }" var="item" varStatus="status">
							<option value="${item.sido }">${item.dong_nm }</option>
						</c:forEach>
						</select>
						<select name="sigungu_cd" id="sigungu_cd" class="select_1 ws_2">
							<option value="">시/군/구</option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row">차량명 / 연식</th>
					<td>
						<input type="text" id="carinfo" name="carinfo" class="input_1" style="width:337px;">
					</td>
				</tr>
				<tr>
					<th scope="row">요청사항</th>
					<td>
						<label><input type="checkbox" name="insurance_yn" value="Y"/> 보험수리</label>
						<label><input type="checkbox" name="rent_yn" value="Y" /> 픽업서비스</label>
						<label><input type="checkbox" name="pickup_yn" value="Y" /> 렌터카</label>
					</td>
				</tr>
				<tr>
					<th scope="row" class="w_main">문의내용<br /><span>(2000자 입력가능)</span></th>
					<td><textarea cols="" rows="" name="content" style="width:100%;" id="smarteditor"></textarea></td>
				</tr>
			</tbody>
		</table>
		<div class="section">
			<p style="color:red;font-weight: bold;">
				정비품목은 도어, 범퍼, 휀다, 본네트, 테일램프, 라디에이터그릴, 헤드램프, 트렁크판낼, (재제조 부품 : 알터네이터, A/C 콤프레서, 스타트모터) 최상급 중고부품을 사용한 견적입니다.
			</p>
			<p style="color:red;font-weight: bold;">
				(견적은 실제 상태 확인에 따라서 차이가 있을수 있습니다.)
			</p>
		</div>
		<div class="vr_btn">
			<input type="image" src="/images/article/board_btn8.gif" alt="요청하기"/>  
			<a href="quotation_list.do?cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }"><img src="/images/article/board_btn5.gif" alt="입력취소"></a>
		</div>
	</form>
	</div>
</div>