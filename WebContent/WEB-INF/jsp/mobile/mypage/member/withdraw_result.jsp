<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>

<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>partsmoa</title>
<link rel="stylesheet" href="/lib/css/mobile.css" type="text/css">
<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js"></script>
</head>

<body>
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

            <p>정상적으로 회원탈퇴되었습니다. 파츠모아 쇼핑몰을 이용해 주셔서 감사합니다.</p>
            <p class="last">기타 문의는 고객센터전화 <b>1544-6444</b>로 문의주시기 바랍니다. </p>
          </div>

          <div class="btn_bottom"><a href="/mobile"><img src="/images/join/join4_btn_1.gif" alt="메인화면"></a></div>

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
