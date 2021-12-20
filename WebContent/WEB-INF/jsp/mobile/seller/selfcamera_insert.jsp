<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>상품관리</title>
<script type="text/javascript" src="/lib/js/jquery.form.js"></script>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var device = window.navigator.userAgent.search( "MobileApp Android") > -1 ? "android" : "";
var device2 = window.navigator.userAgent.search("Android") > -1 ? "android" : "";

$(document).ready(function(){
	
});

function changeCarmaker(){
	$.getJSON("/json/list/old_code.carmodel.do", {carmakerseq : $("#carmakerseq").val()}, function(data){
		$("#carmodelseq").empty();
		$("#carmodelseq").append('<option value="">차량명</option>');
		$.each(data, function(i, o){
			$("#carmodelseq").append("<option value='"+o.carmodelseq+"'>"+o.carmodelnm+"</option>");
		});
	});
}

function changeCarmodel(){
	$.getJSON("/json/list/old_code.cargrade.do", {carmakerseq: $("#carmakerseq").val(),  carmodelseq: $("#carmodelseq").val()}, function(data){
		$("#cargradeseq").empty();
		$("#cargradeseq").append('<option value="">모델명</option>');
		$.each(data, function(i, o){
			$("#cargradeseq").append("<option value='"+o.cargradeseq+"'>"+o.cargradenm+"</option>");
		});
	});
}




function selfcamera_insert(){
	f = document.frm;
	if($("#smarteditor_mobile").length){
		oEditors.getById["smarteditor_mobile"].exec("UPDATE_CONTENTS_FIELD", []);
	}
	
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
}

</script>
</head>
				
<body>
	<div class="regi_line">
        <h3><img src="/images/mobile/sub/sub_title_b_11.gif" alt="셀카등록"></h3>
      </div>
    <form name="fileupload" id="fileupload" action="/ajaxUpload.do" method="post" style="position:absolute; top:-100px;">
    	<input type="hidden" name="fileNum" id="fileNum" value="">
    	<input type="file" name="file" id="imageUploadFile" onchange="fileUpload();" style="position:absolute; top:-100px;">
    </form>
	<form name="frm" id="frm" action="selfcamera_insert.do" method="POST" onsubmit="return selfcamera_insert()">
	<input type="hidden" id="del_files" name="del_files" value="">
	<input type="hidden" id="view_image" name="view_image" value="">
	  <div class="regi_contents">
        <div class="regi_wrap">
          <div class="regi_img_box">
            <h4>이미지등록</h4>
            <p class="h4_text"><strong class="strong_c1">※</strong> 이미지는 <strong class="strong_c1">필수 1개 이상 최대 6개</strong>까지 등록가능합니다.</p>
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
            </ul>

            <div class="regi_img_btn">
              <span class="btn_l"><!-- <a href="javascript:view_image();"><img src="/images/mobile/sub/res_btn_1.gif" alt="대표이미지 설정"></a> --></span>
              <span class="btn_r">
              <a class="btn_delete" href="javascript:del_file();"><img src="/images/mobile/sub/res_btn_2.gif" alt="이미지삭제"></a>
              <!-- <a href="#"><img src="/images/mobile/sub/res_btn_3.gif" alt="이미지추가"></a> -->
              </span>
            </div>
          </div>
		
		<c:if test="${sessionScope.member.group_seq eq '8' or sessionScope.member.group_seq eq '1' }">
          <div class="regi_input">
            <h4>정보입력</h4>
            <table class="regi_style_1" style="margin-top:3%;">
            <colgroup>
            <col width="26%">
            <col width="">
            </colgroup>
            <tbody>
            <tr>
              <th scope="row">업체명</th>
              <td>
                <select name="com_seq" id="com_seq" class="select_sm">
                	<option value="">업체명</option>
                	<c:forEach var="item" items="${com_list }" varStatus="status">
                	<option value="${item.seq }" <c:if test="${item.seq eq view.com_seq }">selected="selected"</c:if>>${item.com_nm }</option>
                	</c:forEach>
                </select>
              </td>
            </tr>
            </tbody>
            </table>
          </div>
         </c:if>
         
          <div class="regi_explanation">
			<h4>내용</h4>
            <div class="re_text">
              <textarea name="content" id="smarteditor_mobile" style="width:100%;height:100px;min-width:100%; display:none;">
				차량명 : <br/>
				연  식 : <br/>
				비  고 : <br/>
              </textarea>
            </div>

          </div>

        </div>

      </div>

      <div class="regi_bottom">
        <div class="regi_bottom_btn">
          <span class="btn_l"><a class="rb_1" href="selfcamera_list.do?menu=menu8"><img src="/images/mobile/sub/list_btn.gif" alt="목록으로"></a></span>
          <span class="btn_r">
          <a class="rb_3" href="javascript:selfcamera_insert();"><img src="/images/mobile/sub/res_btn_6.gif" alt="셀카등록"></a>
          </span>
        </div>
      </div>

	  <span class="btn_regi"><a href="/mobile"><img src="/images/mobile/common/btn_home.png" alt="home"></a></span>
	</form>
</body>
</html>
