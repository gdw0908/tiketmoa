<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type = "text/javascript">
function go_url()
{
	if(jQuery("#url").val() == "")
	{
		alert("이동 할 메뉴를 선택해주세요.");
		return;
	}
	else
	{
		location.replace(jQuery("#url").val());
	}
	
}
</script>
<div class="sm_wrap">
  <div class="sm_top"> <span class="select_box s_menu_type">
    <select id="url" name="url" class="select_sm">
      <option value="">메뉴를 선택해 주세요</option>
      <option value="/mobile/mypage/notice/index.do?menu=menu2">공지사항</option>
      <option value="/mobile/mypage/story/index.do?menu=menu2">파츠모아 이야기</option>
      <option value="/mobile/mypage/forces/index.do?menu=menu2">협력사문의</option>
      <option value="/mobile/mypage/carallbaro/index.do?menu=menu2">카올바로</option>
    </select>
    </span> <span class="sm_btn"><a href="javascript:;"><img src="/images/mobile/sub_2/sub_menu_a.gif" alt="메뉴이동" onclick = "go_url();"></a></span> </div>
</div>
<div class="sub_wrap">
  <div class="sub_line">
    <h3><img src="/images/mobile/sub_2/sub_2_title_4.gif" alt="카올바로"></h3>
    <p><a href="tel:1522-2119"><img src="/images/mobile/sub/cartel.gif" alt="카올바로 고객상담센터 1522-2119"></a></p>
  </div>
	<div class="contents">
		<ul>
			<li style="margin:30px 0 4px 0;">
				<a href="quotation_fastForm.do"><img src="/images/container/sbn_5.gif" alt="즉시신청" style="width:49%;"/></a>
				<a href="quotation_insertForm.do"><img src="/images/container/sbn_6.gif" alt="견적요청" style="width:49%;float:right;"/></a>				
			</li>
			<li style="margin:0 0 4px 0;"><a href="quotation_list.do?menu=menu2"><img src="/images/container/sbn_1.gif" alt="견적사례" style="width:100%;"/></a></li>
			<li style="margin:0 0 4px 0;"><a href="carallbaro_list.do?type_state=1&amp;menu=menu2"><img src="/images/container/sbn_2.gif" alt="BEST" style="width:100%;"/></a></li>
			<li style="margin:0 0 4px 0;"><a href="carallbaro_list.do?type_state=2&amp;menu=menu2"><img src="/images/container/sbn_3.gif" alt="수입차" style="width:100%;"/></a></li>
			<li><a href="carallbaro_list.do?type_state=3&amp;menu=menu2"><img src="/images/container/sbn_4.gif" alt="국산차" style="width:100%;"/></a></li>
		</ul>
	</div>
</div>