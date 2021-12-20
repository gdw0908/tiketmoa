<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<link rel="stylesheet" href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" type="text/css">
<script type="text/javascript" src="/lib/js/jquery.form.js"></script>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript">
var device = window.navigator.userAgent.search( "MobileApp Android") > -1 ? "android" : "";
var device2 = window.navigator.userAgent.search("Android") > -1 ? "android" : "";
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
				+ '<img src="/images/mobile/sub/sub_res_imgn2.gif" alt="파일추가" onclick="fileadd(\''+num+'\')">';
	$("#img_"+num).html(html);
	filecount--;
}

function fileadd(num){
	$("#fileNum").val(num);
	
	if(device == "android"){
		window.Android.open();
	}else{
		$('#imageUploadFile').click();
	}
	return false;	
}

function fileUpload(){
	var filename = $("#imageUploadFile").val();
	var url = "/ajaxUpload.do";
	filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
	if(filename == ""){
		$("#fileNum").val('');
		return false;
	}
	if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
		alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
		return false;
	}
	/*if(device2 == "android"){
		url = "/ajaxUpload_for_android.do";
	}*/
   	$("#fileupload").ajaxSubmit({
   		url : url,
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
	filecount++;
}
</script>
</head>
<body>
	<div class="sub_wrap">
		<div class="sub_line">
			<h3><img src="/images/mobile/sub_2/sub_2_title_4.gif" alt="카올바로"></h3>
			<p><a href="tel:1522-2119"><img src="/images/mobile/sub/cartel.gif" alt="카올바로 고객상담센터 1522-2119"></a></p>
		</div>
		<form name="fileupload" id="fileupload" action="/ajaxUpload.do" method="post" style="position:absolute; top:-100px;">
			<input type="hidden" name="fileNum" id="fileNum" value="">
			<input type="file" name="file" id="imageUploadFile" onchange="fileUpload();" style="position:absolute; top:-100px;">
		</form>
		<form name="wFrm" id="wFrm" action="quotation_fast.do" method="post" enctype="multipart/form-data" onsubmit="return carallbaroSubmit(this);">
			<input type="hidden" id="del_files" name="del_files" value="">
			<input type="hidden" id="view_image" name="view_image" value="">
			<div class="regi_wrap regi_wrap_2">
				<div class="regi_img_box">
					<h4>이미지등록</h4>
					<p class="h4_text">※ 이미지는 <strong class="strong_c1">필수 1개 이상 최대 4개</strong>까지 등록가능합니다.</p>
			
					<ul id="image_files">
						<li>
			              	<div>
			              		<label id="img_1">
			              		<c:if test="${!empty files[0].uuid }">
			              			<input type="hidden" name="fileNumber" value="1">
			              			<input type="hidden" name="virtual_file_yn" value="N"> 
			              			<input type="checkbox" name="image_check" value="${files[0].uuid }">
			              			<img src="/upload/board/${files[0].yyyy }/${files[0].mm }/${files[0].uuid }" alt="${files[0].attach_nm }">
			              		</c:if>
			              		<c:if test="${empty files[0].uuid }">
			              			<input type="hidden" name="fileNumber" value="1">
			              			<input type="hidden" name="virtual_file_yn" value="Y">
			              			<input type="checkbox" name="image_check" value="" onclick="return false;">
			              			<img src="/images/mobile/sub/sub_res_imgn2.gif" alt="파일추가" onclick="fileadd('1')">
			              		</c:if>
			              		</label>
			              	</div>
		              	</li>
		              	<li class="right">
			              	<div>
			              		<label id="img_2">
			              		<c:if test="${!empty files[1].uuid }">
			              			<input type="hidden" name="fileNumber" value="2">
			              			<input type="hidden" name="virtual_file_yn" value="N"> 
			              			<input type="checkbox" name="image_check" value="${files[1].uuid }">
			              			<img src="/upload/board/${files[1].yyyy }/${files[1].mm }/${files[1].uuid }" alt="${files[1].attach_nm }">
			              		</c:if>
			              		<c:if test="${empty files[1].uuid }">
			              			<input type="hidden" name="fileNumber" value="2">
			              			<input type="hidden" name="virtual_file_yn" value="Y">
			              			<input type="checkbox" name="image_check" value="" onclick="return false;">
			              			<img src="/images/mobile/sub/sub_res_imgn2.gif" alt="파일추가" onclick="fileadd('2')">
			              		</c:if>
			              		</label>
			              	</div>
		              	</li>
		              	<li>
			              	<div>
			              		<label id="img_3">
			              		<c:if test="${!empty files[2].uuid }">
			              			<input type="hidden" name="fileNumber" value="3">
			              			<input type="hidden" name="virtual_file_yn" value="N"> 
			              			<input type="checkbox" name="image_check" value="${files[2].uuid }">
			              			<img src="/upload/board/${files[2].yyyy }/${files[2].mm }/${files[2].uuid }" alt="${files[2].attach_nm }">
			              		</c:if>
			              		<c:if test="${empty files[2].uuid }">
			              			<input type="hidden" name="fileNumber" value="3">
			              			<input type="hidden" name="virtual_file_yn" value="Y">
			              			<input type="checkbox" name="image_check" value="" onclick="return false;">
			              			<img src="/images/mobile/sub/sub_res_imgn2.gif" alt="파일추가" onclick="fileadd('3')">
			              		</c:if>
			              		</label>
			              	</div>
		              	</li>
		              	<li class="right">
			              	<div>
			              		<label id="img_4">
			              		<c:if test="${!empty files[3].uuid }">
			              			<input type="hidden" name="fileNumber" value="4">
			              			<input type="hidden" name="virtual_file_yn" value="N"> 
			              			<input type="checkbox" name="image_check" value="${files[3].uuid }">
			              			<img src="/upload/board/${files[3].yyyy }/${files[3].mm }/${files[3].uuid }" alt="${files[3].attach_nm }">
			              		</c:if>
			              		<c:if test="${empty files[3].uuid }">
			              			<input type="hidden" name="fileNumber" value="4">
			              			<input type="hidden" name="virtual_file_yn" value="Y">
			              			<input type="checkbox" name="image_check" value="" onclick="return false;">
			              			<img src="/images/mobile/sub/sub_res_imgn2.gif" alt="파일추가" onclick="fileadd('4')">
			              		</c:if>
			              		</label>
			              	</div>
		              	</li>
            		</ul>
              		<div class="regi_img_btn"> 
              			<span class="btn_r"> <a class="btn_delete" href="javascript:del_file();"><img src="/images/mobile/sub/res_btn_2.gif" alt="이미지삭제"></a></span>
              		</div>
            	</div>
            	
            	
            	<table class="write_style_1" style="margin-top:30px;">
              		<colgroup>
              			<col width="30%">
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
						    		- <input type="number" pattern="[0-9]*" inputmode="numeric" id="charge_tel2" name="charge_tel2" class="input_3 ws_2"> - <input type="number" pattern="[0-9]*" inputmode="numeric" id="charge_tel3" name="charge_tel3" class="input_3 ws_2">
								</p>
								<p class="ph_text">※ 입력하신 개인정보는 별도 요청이 없을 경우 6개월 보관 후 삭제되며, 문의 사항 확인이나 답변의 전달을 위해 고객님께 연락을 취하는 용도 이외에는 사용되지 않습니다. 또한 항목에 체크하실 경우 이에 동의하는 것으로 간주하며, 동의하지 않을 경우, 게시가 이루어지지 않습니다. <label><input type="checkbox" id="agree" name="agree" class="check"> 동의합니다</label></p>
							</td>
						</tr>
						<tr>
							<th>브랜드</th>
							<td>
								<select name="carmakerseq" id="carmakerseq" class="select_1 ws_2" >
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
								<select name="sido_cd" id="sido_cd" class="select_1" onchange="changeSido()">
									<option value="">시/도</option>
								<c:forEach items="${sido_cd }" var="item" varStatus="status">
									<option value="${item.sido }">${item.dong_nm }</option>
								</c:forEach>
								</select>
								<select name="sigungu_cd" id="sigungu_cd" class="select_1">
									<option value="">시/군/구</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">차량명 / 연식</th>
							<td>
								<input type="text" id="carinfo" name="carinfo" class="input_1">
							</td>
						</tr>
						<tr>
							<th scope="row">견인희망일 / 시간</th>
							<td>
								<input type="text" id="tow_date" name="tow_date" class="input_3 ws_2" readonly="readonly"/>
								<input type="text" id="tow_time" name="tow_time" class="input_3 ws_2">
							</td>
						</tr>
						<tr>
							<th scope="row">요청사항</th>
							<td>
								<label><input type="radio" name="tow_type" value="1" checked="checked"/> 직접방문</label>
								<label><input type="radio" name="tow_type" value="2" /> 탁송요청</label>
								<label><input type="radio" name="tow_type" value="3" /> 대차</label>
							</td>
						</tr>
						
		                <tr>
		                  <th scope="row" class="w_main">문의내용<br />
		                    <span>(2000자 입력가능)</span></th>
		                  <td>
			                  <textarea cols="" rows="" name="content" style="width:100%;height:100px;min-width:100%; display:none;" id="smarteditor_mobile"></textarea>
		                  </td>
		                </tr>
              		</tbody>
            	</table>
            	<div class="section">
					<p style="color:red;font-weight: bold;">
						· 각종 수입차는 전국 어디든지 딜리버리 서비스 가능<br/>
						· 국산차는 카올바로 센터로 입고후 최상의 정비<br/>
						· 탁송비용은 지역에 따라 차이가 발생합니다.
					</p>
					<p style="color:red;font-weight: bold;">※ 중고부품을 활용한 정비가 가능하기 때문에 탁송비가 발생하더라도 착한정비, 반값정비가 가능합니다.</p>
				</div>
				<div class="vr_btn">
					<input type="image" src="/images/article/board_btn7.gif" alt="즉시신청" class="vr_regi_1" style="height:25px;"/>  
					<a class="vr_regi_2" href="quotation_list.do?cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }"><img src="/images/article/board_btn5.gif" alt="입력취소" style="height:25px;"></a>
				</div>
				<div style="margin-top:20px;">
					<a href="tel:031-961-4677"><img src="/images/mobile/carallbaro_tel.gif" alt="031-961-4677 전화하기" style="width:100%;"/></a> 
				</div>
			</div>
		</form>
	</div>
</body>
</html>