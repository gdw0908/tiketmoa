<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<script type="text/javascript">
$(document).ready(function(){
//submenu
$("#submenu_a_open").toggle(function(){
$("#sub_menu_a").slideToggle(250);
this.src = "/images/mobile/sub/sub_menu_a_close.gif";
}, function() {
$("#sub_menu_a").slideToggle(250);
this.src = "/images/mobile/sub/sub_menu_a_open.gif";
});

});


function withdrawFormAgreeChk()
{
	if( $(":checkbox[name='agree']:checked").length == 0 )
	{
		alert("체크박스에 체크를 해주세요.");
		return false;
	}
}
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
<div class="wrap">
	<div class="sm_wrap">
        <div class="sm_top">
          <span class="select_box s_menu_type">
          <select id="url" name="url" class="select_sm">
          <option value = "">메뉴를 선택해 주세요</option>
          <option value = "/mobile/mypage/member/index.do?mode=<c:choose><c:when test = "${not empty sessionData.busi_no }">mbusi</c:when><c:otherwise>muser</c:otherwise></c:choose>">회원정보 변경</option>
          <option value = "/mobile/mypage/member/index.do?mode=m_myaddress">나의 배송지관리</option>
          <option value = "/mobile/mypage/member/index.do?mode=mwithdraw">회원탈퇴</option>
          </select>
          </span>
          <span class="sm_btn"><a href="javascript:;"><img src="/images/mobile/sub_2/sub_menu_a.gif" alt="상세조건 검색버튼" onclick = "go_url();"></a></span>
        </div>
      </div>
      <div class="sub_wrap">
        <div class="sub_2_line line_2">
          <h3><img src="/images/mobile/sub_2/sub_2_title_6_3.gif" alt="회원탈퇴"></h3>
        </div>
        <div class="secession_con">
            <p class="sece_t_text">※ 파츠모아쇼핑몰의 회원탈퇴를 하시는 여러분께 알려드리는 사항입니다.</p>
            <div class="t_box2">
              <p><strong>기존 아이디로 재가입이 불가능 합니다. </strong></p>
              <p><strong>회원 탈퇴 신청 아이디는 즉시 탈퇴 처리되며, 이후 영구적으로 사용이 중지되므로 새로운 아이디로만 재가입이 가능 합니다.</strong></p>
              <p class="last"><strong>사이트 이용중 게시하신 게시물은 삭제되지 않습니다. 또한, 탈퇴 아이디로 등록하신 게시물은 삭제 및 수정이 불가능 합니다.</strong></p>
            </div>
            <form name = "withdrawFormAgree" id = "withdrawFormAgree" method = "post" action = "${servletPath }" onsubmit = "return withdrawFormAgreeChk();">
			<input type = "hidden" name = "mode" value = "mwithdraw2">
            <div class="secession_checkbox"><label><input type="checkbox" id="agree" name="agree" class="check">위 사항에 모두 확인하였으며 파츠모아쇼핑몰의 회원탈퇴를 신청합니다.</label></div>
            <div class="btn_bottom">
              <a href="/mobile"><img src="/images/sub_2/btn_secession_2.gif" alt=""></a>
              <input type = "image" src = "/images/sub_2/btn_secession_3.gif">
            </div>
            </form>
          </div>
      </div>
      <!-- fixed_btn -->
      <span class="my_menu"><a href="#"><img src="/images/mobile/common/btn_l.png" alt="my menu"></a></span>
      <span class="btn_regi"><a href="/html/mobile/sub/m08/m08_03.html"><img src="/images/mobile/common/btn_r.png" alt="상품등록"></a></span>
      <!-- //fixed_btn -->
    </div>
  </div>
