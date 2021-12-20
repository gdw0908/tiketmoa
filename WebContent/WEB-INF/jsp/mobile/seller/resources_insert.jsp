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
<link rel="stylesheet" href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" type="text/css">
<script type="text/javascript" src="/lib/js/jquery.form.js"></script>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript">
var groupList = "";
var param = {board_seq : "7",group_code : "2",order : "Y"};
var count = 1;
var addbtn = '<span><a href="javascript:resourcesAdd()" class="btn"><img src="/images/mobile/sub/resources_2.gif" alt="추가"></a></span>';

$(document).ready(function(){
	$.getJSON("/json/list/article.categoryList.do", param, function(data){
		groupList = data;
		$("#cate_seq").empty();
		$.each(groupList, function(i, o){
			$("#cate_seq").append("<option value='"+o.cate_seq+"'>"+o.subject+"</option>");
		});
		var resources = "<div>" + $("#resourcesOrg").html() + addbtn + "</div>";
		$("#resourcesBox").append(resources);
	});
	$("#edate,#sdate").datepicker();
	<c:if test="${sessionScope.member.group_seq eq '8' or sessionScope.member.group_seq eq '1'}">
	$.getJSON("/json/list/seller.all_cooperation.do", "", function(data){
		var cooperationList = data;
		$.each(cooperationList, function(i, o){
			$("#title").append("<option value='"+o.seq+"'>"+o.com_nm+"</option>");
		});
	});
	</c:if>
});

function resourcesAdd(){
	var delbtn = '<span><a href="javascript:resourcesDel(\''+count+'\')"><img src="/images/mobile/sub/resources_3.gif" alt="삭제"></a></span>';
	var resources = "<div id='r"+count+"'>" + $("#resourcesOrg").html() + delbtn + "</div>";
	$("#resourcesBox").append(resources);
	count = count+1;
}

function resourcesDel(c){
	$("#r"+c).remove();
}

function statusChange(){
	if(document.frm.status.value == "2"){
		$("#edate").css("display","");
	}else{
		$("#edate").val("");
		$("#edate").css("display","none");
	}
}
function formAction(){
	var f = document.frm;
	if(f.sdate.value == ""){
		alert("반출희망 날짜를 선택하시기 바랍니다.");
		return false;
	}
	if(isNaN(f.item_weight.length)){
		if(f.item_weight.value == ""){
			alert("선택하신 폐자원물질의 중량을 입력하시기 바랍니다.111");
			return false;
		}
	}else{
		for(var i=0;i < f.item_weight.length;i++){
			if(f.item_weight[i].value == ""){
				alert("선택하신 폐자원물질의 중량을 입력하시기 바랍니다.222");
				return false;
			}
		}
	}
	if(f.status.value == "2" && f.edate.value == ""){
		alert("반출완료 날짜를 선택하시기 바랍니다.");
		return false;
	}	
	f.submit();
}
</script>
</head>
<body>

<div id="resourcesOrg" style="display:none;">
	<span class="in_type_2" id="cate_seq_list">
		<select id="cate_seq" name="cate_seq" class="select_1"></select>
	</span>
	<span class="in_type_c">
		<input type="text" id="item_weight" name="item_weight" class="input_r1">
	</span>
</div>


<div class="wrap">
  <form name="frm" id="frm" method="post" enctype="multipart/form-data" action="resources_insert.do">
  <input type="hidden" name="board_seq" value="7">
  <input type="hidden" name="parent_seq" value="0">  
  <div id="container">
    <div class="sub">

      <div class="regi_line">
        <h3><img src="/images/mobile/sub/sub_title_b_5.gif" alt="자원등록"></h3>
        <!--p><a href="#"><img src="/images/mobile/sub/mp_question.gif" alt=""></a></p-->
      </div>

      <div class="regi_contents">

        <div class="regi_wrap">

          <div class="resources resources_first">
          
			<h4 class="type_1">업체선택</h4>
			<div>
				<select name="title" id="title"></select> <font color="red">※ 선택한 업체명으로 글이 등록됩니다.</font>
			</div>
			
			
            <h4 class="type_1">반출희망날짜</h4>

			<div class="r_in_box">
			<span class="in_type_1"><img src="/images/mobile/sub/calendar.gif" alt="달력"></span>
            <span class="in_type_c"> <input type="text" id="sdate" name="sdate" class="input_r1" readonly="readonly"></span>
			<!-- <span><a href="#" class="btn"><img src="/images/mobile/sub/resources_1.gif" alt="설정/변경"></a></span> -->
			</div>

            <h4>자원물질</h4>
            <p class="r_t1"><strong>※ 중량단위를 꼭 입력해주시기 바랍니다.</strong></p>
				<div class="r_in_box" id="resourcesBox"></div>
          </div>

          <div class="resources">

            <h4>비고</h4>

            <div class="t_area">
              <textarea id="conts" name="conts" class="textarea_1"></textarea>
            </div>

          </div>

          <div class="resources">

            <h4>상태</h4>

            <div class="t_area">
              <select id="status" name="status" class="select_1" onchange="statusChange();">
              	<option value="0">반출요청</option>
	          	<option value="1">반출진행</option>
	          	<option value="2">반출완료</option>
              </select>
              <input type="text" id="edate" name="edate" class="input_r1" style="width:100px;position:absolute;margin-left:5px;display:none;"  readonly="readonly">
            </div>
			
          </div>
          
          <div class="r_in_box resources_last">
			  	<h4>첨부파일</h4>
			  	<div id="fileList">
              		<div id="file1"><input type="file" id="file" name="attach" style="margin-bottom:5px;"/> <a href="javascript:fileListAdd()"><img src="/images/article/file_btn_1.png" alt="추가"></a></div>
            	</div>
          </div>

        </div>

      </div>

      <div class="regi_bottom">
        <p><strong>※ 등록하실 내용을 다시한번 확인하시기 바랍니다.<br/>※ 첨부파일 등록은 PC버전에서만 가능합니다.</strong></p>
        <div class="regi_bottom_btn resources_btn">
          <span class="btn_r">
          <a href="javascript:formAction();"><img src="/images/mobile/sub/btn_register.gif" alt="등록"></a>
          </span>
        </div>
      </div>

      <span class="btn_regi"><a href="/mobile"><img src="/images/mobile/common/btn_home.png" alt="home"></a></span>

    </div>

  </div>
  </form>
</div>
</body>
</html>
