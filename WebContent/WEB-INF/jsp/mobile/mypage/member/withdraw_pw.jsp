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

function withdrawFormChk()
{
	if(jQuery("#member_pw").val() == "")
	{
		alert("비밀번호를 입력하세요.");
		jQuery("#member_pw").val("");
		jQuery("#member_pw").focus();
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

          <div class="t_box2">
            <p class="last">파츠모아 <strong>회원탈퇴 시 비밀번호 인증</strong>이 필요합니다. 가입하신 비밀번호를 다시한번 입력하시기 바랍니다.</p>
          </div>
		<form name = "withdrawForm" id = "withdrawForm" method = "post" action = "${servletPath }" onsubmit = "return withdrawFormChk();">
		<input type = "hidden" name = "mode" value = "mwithdraw1">
          <div class="secession_input"><input type="password" id="member_pw" name="member_pw" placeholder="비밀번호를 입력해주세요."></div>

          <div class="secession_btn"><input type = "image" src = "/images/sub_2/btn_secession_1_off.gif"></div>
		</form>
        </div>

      </div>
      <!-- fixed_btn -->
      <span class="my_menu"><a href="#"><img src="/images/mobile/common/btn_l.png" alt="my menu"></a></span>
      <span class="btn_regi"><a href="/html/mobile/sub/m08/m08_03.html"><img src="/images/mobile/common/btn_r.png" alt="상품등록"></a></span>
      <!-- //fixed_btn -->

    </div>

  </div>
</body>
</html>
