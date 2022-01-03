<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta http-ｅquiv="X-UA-Compatible" content="IE=Edge">
</head>
<body>
<script type="text/javascript" src="/lib/js/jquery.form.js"></script>
<script type="text/javascript" src="/lib/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/lib/js/comment_carall.js"></script>
<script type="text/javascript" src="/lib/js/jquery.xml2json.js"></script>
<script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=<spring:eval expression="@config['navar.map.key']" />"></script>
<script type="text/javascript">
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
				+ '<img src="/images/mobile/sub/sub_res_imgn.gif" alt="파일추가" style="width:200px;height:140px;">';
	$("#img_"+num).html(html);
}

function fileUpload(num){
	$('#fileupload_'+num).submit();
}

function ImageDraw(num,yyyy,mm,uuid,attach_nm){
	var html = '<input type="hidden" name="virtual_file_yn" value="Y"/>'
	+ '<input type="checkbox" name="image_check" value="'+uuid+'"/>'
	+ '<img src="/upload/temp/'+uuid+'" style="width:200px;height:140px;">'
	+ '</label>';
	$("#img_"+num).html(html);
	$("#new_img"+num).html('<input type="hidden" name="new_files" value="'+yyyy+'/'+mm+'/'+uuid+'/'+attach_nm+'">');
}

</script>
<div id="sub">
	<div class="strapline">
		<h3><img src="/images/sub_2/h3_img_3.gif" alt="카올바로"></h3>
		<div class="state"> <span>홈</span> &gt; <span>고객센터</span> &gt; <span>카올바로</span> &gt; <span><strong>${view.set_type == '0' ? '견적요청' : '즉시신청'  }</strong></span></div>
	</div>
	<div class="contents">
	
	
	
      <div class="details_1" >
            <div id="galleryWrap">
              <div class="galleryView">
              	<c:if test="${empty files}">
					<div class="item">
                  		<div style='position:absolute;'><img src="/images/sub/noimg2.png"></div>
					</div>
				</c:if>
              <c:forEach var="item" items="${files }">
                <div class="item">
                  	<div style='position:absolute;'><img src='/upload/board/${item.yyyy }/${item.mm }/${item.uuid }'></div>
                </div>
              </c:forEach>
              </div>
              <div class="thumbnails">
                <div class="thumb_left"></div>
                <p class="thumb_left_2"></p>
                <div class="thumbnails_body">
                  <ul>
                  	<c:if test="${empty files}">
                  		<li>
		                  <div class="thumbitem" rel="1"  num="1" pg="1">
		                  	<img src="/images/sub/noimg2.png" align="absmiddle" rel="1"  class='thumbimg'>
		                  </div>
		                </li>
					</c:if>
                  	<c:forEach var="item" items="${files }" varStatus="status">
		                <li>
		                  <div class="thumbitem" rel="${status.index }"  num="${status.index }" pg="${status.index }"> <img src="/upload/board/${item.yyyy }/${item.mm }/${item.uuid }" align="absmiddle" rel="${status.index }"  class='thumbimg'> </div>
		                </li>
		            </c:forEach>
                  </ul>
                </div>
                <div class="thumb_right"></div>
                <p class="thumb_right_2"></p>
              </div>
            </div>
            <script type="text/javascript" src="/lib/js/gallery.js"></script> 
            <script type="text/javascript">
          jQuery(function($){
          var options = {};
          options['animSpeed'] = 0; //애니시간
          options['pauseTime'] = 5000; //대기시간
          options['dataViewType'] = "none";  //내용보기효과 'none','Randam','top','bottom','topleft','topright','bottomleft','bottomright'   none일경우 사용안함
          options['ImgViewType'] = "fade";  //이미지효과 'Randam','sliceDownRight','sliceDownLeft','sliceUpRight','sliceUpLeft','sliceUpDown','boxblockRight','fade','sliceLeft','sliceLeftUp','sliceRight','sliceRightUp','sliceLeftRight',               'boxRandom','boxblock','boxblockDown','boxblockUp','boxblockLeft'
          options['tailCut'] =4; //썸네일출력수
          $('#galleryWrap').galleryeffect(options);

          });

          </script>
            <div class="details_info" >
              <p class="details_title"><strong>${view.reg_nm }</strong> 님의 ${view.set_type == '0' ? '견적요청' : '즉시신청' }</p>
              <table class="details_style_1">
                <colgroup>
                <col width="35%">
                <col width="">
                </colgroup>
                <tbody>
                  <tr>
                    <th>지역</th>
                    <td>${view.sido_nm } ${view.sigungu_nm }</td>
                  </tr>
                  <tr>
                    <th>브랜드</th>
                    <td>${view.makernm }</td>
                  </tr>
                  
                  <tr>
                    <th>차량명 /<br /> 연식</th>
                    <td>${view.carinfo }</td>
                  </tr>
                  
                  <tr>
                    <th>요청사항</th>
                    <td>
                    <c:choose>
	                    <c:when test="${view.set_type == '1'}">${view.tow_type == '1' ? '직접방문' : view.tow_type == '2' ? '탁송요청' : '대차' }</c:when>
	                    <c:otherwise>
		                    보험수리 <c:choose>
		                    	<c:when test="${view.insurance_yn == 'Y'}">O</c:when>
		                    	<c:otherwise>X</c:otherwise>
		                  	</c:choose> , 
		                    렌터카 <c:choose>
		                    	<c:when test="${view.rent_yn == 'Y'}">O</c:when>
		                    	<c:otherwise>X</c:otherwise>
		                  	</c:choose> , 
		                    픽업요청 <c:choose>
		                    	<c:when test="${view.pickup_yn == 'Y'}">O</c:when>
		                    	<c:otherwise>X</c:otherwise>
		                  	</c:choose>
		                 </c:otherwise>
	                 </c:choose> 
                    </td>
                  </tr>
                  <c:if test="${view.set_type == '1'}">
                  <tr>
                    <th>견인희망일 /<br /> 시간</th>
                    <td>${view.tow_date } / ${view.tow_time }</td>
                  </tr>
                  </c:if>
                  <tr>
                    <th>문의내용</th>
                    <td>
                    	${view.content }
                    </td>
                  </tr>
				  
                </tbody>
              </table>
              <div class="vr_btn">
               <a href="quotation_list.do?cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }&amp;myarticle=${params.myarticle}"><img src="/images/article/board_btn3.gif" alt="목록으로"></a>
               <c:if test="${sessionScope.member.member_nm == view.reg_nm || view.member_yn == 'N'}">
               <a href="quotation_delete.do?seq=${params.seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }"><img src="/images/article/board_btn1.gif" alt="문의취소"></a>
               <a href="quotation_modifyForm.do?seq=${params.seq }&amp;cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }"><img src="/images/article/board_btn2.gif" alt="내용수정"></a>
               </c:if>
              </div>
            </div>
          </div>


<div class="comment_box">
  <ul id="comment_list">
  <c:forEach items="${comment }" var="comment" varStatus = "status">
    <li<c:if test="${comment.lvl > 0 }"> class="comm_2"</c:if> id="comment${comment.comment_seq}">
	    <div class="comment_top">
	      <p class="ct_l">
	      <c:choose>
	      	<c:when test="${comment.seq == null }">
	      		<strong<c:if test="${comment.lvl > 0 }"> class="comm_arrow"</c:if>>${comment.reg_nm != null ? comment.reg_nm : comment.reg_id }</strong> <span>${comment.reg_dt }</span>
	      	</c:when>
	      	<c:otherwise>
	      		<strong<c:if test="${comment.lvl > 0 }"> class="comm_arrow"</c:if>><a href="javascript:openMap('${comment.seq }');">${comment.reg_nm != null ? comment.reg_nm : comment.reg_id } <img src="/images/common/info.gif" alt="업체정보보기" style="height:20px;margin-top:-3px;"/></a></strong> <span>${comment.reg_dt }</span>
	      	</c:otherwise>
	      </c:choose>
	      </p>
	      <p class="ct_r">
	      <c:if test="${sessionScope.member.member_id == comment.reg_id}">
	      <%-- <a href="#comment${comment.comment_seq}" onclick="commentDel('${comment.comment_seq}')"><img src="/images/article/comm_btn_1.png" alt="삭제"></a>
	      <a href="#comment${comment.comment_seq}" onclick="commentUpdate('${comment.comment_seq}','${params.img }')"><img src="/images/article/comm_btn_2.png" alt="수정"></a> --%>
	      </c:if>
	      <a href="#comment${comment.comment_seq}" onclick="commentReplyOnOff('${comment.comment_seq}','open')">답글</a>
	      </p>
	    </div>
	    <form name="commentUpdate${comment.comment_seq }" action="/pc/mypage/comment/index.do" method="post" onsubmit="return commentReply(this);">
	      <input type="hidden" name="comment_seq" value="${comment.comment_seq }"/>
	      <input type="hidden" name="mode" value="commentReplyUpdate"/>
	      <div class="comm_text" id="comm_text${comment.comment_seq}">
		      <p id="conts${comment.comment_seq}"><c:if test="${comment.lvl > 0 }"><strong>@${comment.reply_id }</strong></c:if> ${comment.conts }</p>
	      </div>
	    </form>
	    <div class="area_box" id="commentReply${comment.comment_seq}" style="display:none;"><!-- 댓글 로그인 사용자만 -->
	      <form name="comment${comment.comment_seq }" action="/pc/mypage/comment/index.do" method="post" onsubmit="return commentReply(this);">
	      <c:if test="${sessionScope.member == null }">
	       이름 : <input type="text" name="member_nm" value="" style="width:100px;"/><input type="hidden" name="password" value="." style="width:100px;"/>
	      </c:if>
	      <input type="hidden" name="reply_id" value="${comment.reg_id }"/>
	      <input type="hidden" name="comment_seq" value="${comment.comment_seq }"/>
	      <input type="hidden" name="mode" value="commentReply"/>
	      <c:choose>
	    		<c:when test="${comment.password == null }">
	    		<p><strong class="comm_arrow">${sessionScope.member.member_id } @${comment.reg_id } 님께 댓글쓰기</strong> <a class="mod" href="#comment${comment.comment_seq}" onclick="commentReplyOnOff('${comment.comment_seq}','close')"><img src="/images/article/comm_btn_3.png" alt="취소"></a></p>
	    		</c:when>
	    		<c:otherwise>
	    		<p><strong class="comm_arrow">${sessionScope.member.member_id } @${comment.reg_nm } 님께 댓글쓰기</strong> <a class="mod" href="#comment${comment.comment_seq}" onclick="commentReplyOnOff('${comment.comment_seq}','close')"><img src="/images/article/comm_btn_3.png" alt="취소"></a></p>
	    		</c:otherwise>
	    	</c:choose>
	      <div>
	        <span class="textarea"><textarea class="textarea_1" name="conts"></textarea></span>
	        <a href="javascript:void(0);" class="comm_btn" onclick="commentReply(document.comment${comment.comment_seq });"><img src="/images/article/comm_btn_en.gif" alt="입력하기"></a>
	      </div>
	      </form>
    	</div>
	    <%-- <c:if test="${sessionScope.member != null and sessionScope.member.carall == 'Y'}">
	    <div class="area_box" id="commentReply${comment.comment_seq}" style="display:none;"><!-- 댓글 로그인 사용자만 -->
	      <form name="comment${comment.comment_seq }" action="/pc/mypage/comment/index.do" method="post" onsubmit="return commentReply(this);">
	      <input type="hidden" name="reply_id" value="${comment.reg_id }"/>
	      <input type="hidden" name="comment_seq" value="${comment.comment_seq }"/>
	      <input type="hidden" name="mode" value="commentReply"/>
	      <p><strong class="comm_arrow">${sessionScope.member.member_id } @${comment.reg_id } 님께 댓글쓰기</strong> <a class="mod" href="#comment${comment.comment_seq}" onclick="commentReplyOnOff('${comment.comment_seq}','close')"><img src="/images/article/comm_btn_3.png" alt="취소"></a></p>
	      <div>
	        <span class="textarea"><textarea class="textarea_1" name="conts"></textarea></span>
	        <a href="#" class="comm_btn" onclick="commentReply(document.comment${comment.comment_seq });"><img src="/images/article/comm_btn_en.gif" alt="입력하기"></a>
	      </div>
	      </form>
    	</div>
    	</c:if> --%>
    </li>
  </c:forEach>
  <c:choose>
  <c:when test="${sessionScope.member.carall eq 'Y'}">
  <li>
    <div class="area_box area_box_2">
    <p class="comm_txt">댓글은 <b>1000</b> 자 내외로 작성해주시기 바랍니다.</p>
      <form name="comment" action="/pc/mypage/comment/index.do" method="post" onsubmit="return commentReply(this);">
      <input type="hidden" name="mode" value="commentInsert"/>
      <input type="hidden" name="article_seq" value="${view.seq }"/>
      <div>
        <span class="textarea"><textarea class="textarea_1" name="conts"></textarea></span>
        <a href="javascript:void(0);" class="comm_btn" onclick="commentReply(document.comment);"><img src="/images/article/comm_btn_en.gif" alt="입력하기"></a>
      </div>
      </form>
    </div>
    </li>  
  </c:when>
  <c:otherwise>
  <li>
    <div class="area_box area_box_2">
    <p class="comm_txt">댓글은 <b>1000</b> 자 내외로 작성해주시기 바랍니다.</p>
      <form name="comment" action="/pc/mypage/comment/index.do" method="post" onsubmit="return commentReply(this);">
      이름 : <input type="text" name="member_nm" value="" style="width:100px;"/><input type="hidden" name="password" value="." style="width:100px;"/>
      <input type="hidden" name="mode" value="commentInsert"/>
      <input type="hidden" name="article_seq" value="${view.seq }"/>
      <div>
        <span class="textarea"><textarea class="textarea_1" name="conts"></textarea></span>
        <a href="javascript:void(0);" class="comm_btn" onclick="commentReply(document.comment);"><img src="/images/article/comm_btn_en.gif" alt="입력하기"></a>
      </div>
      </form>
    </div>
    </li>
  </c:otherwise>
  </c:choose>
  </ul>
</div>

<p class="pa_guide">PARTSMOA 쇼핑몰에 관련한 상세한 상담이 필요하신 사항은 고객센터 문의전화 (1544-6444)로 연락주시면 친절히 상담해 드리겠습니다.</p>

<form name="commentDelete" action="/mypage/comment/index.do" method="post" onsubmit="return commentDel(this);">
<input type="hidden" name="mode" value="commentDel"/>
<input type="hidden" name="comment_seq" value=""/>
</form>
<div id="modal_dialog" title="업체정보"></div>



	</div>
</div>
</body>
</html>