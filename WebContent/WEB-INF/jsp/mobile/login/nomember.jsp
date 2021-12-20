<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="com.mc.common.util.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<script type="text/javascript" src="/lib/js/jquery.cookie.js"></script>
<script type = "text/javascript">
function non_member(){
	if($("#receiver").val() == ""){
		alert("구매자를 입력해주세요.");
		$("#receiver").focus();
		return;
	}else if($("#orderno").val() == ""){
		alert("구매번호를 입력해주세요.");
		$("#orderno").focus();
		return;
	}else if($("#passwd").val() == ""){
		alert("주문비밀번호를 입력해주세요.");
		$("#passwd").focus();
		return;
	}else{
		$("#nonMemberFrm").submit();
	}
	
}
</script>

<div class="wrap">
  <div class="login_wrap">
    <div class="l_img"><img src="/images/login/login_bg.gif" alt="PARTS MOA 국내최대 자동차 중고부품 쇼핑몰 PARTS MOA에 오신 것을 환영합니다"></div>
    <div class="join_tab"> <a href="/mobile/login/login.do?mode=mlogin"><img src="/images/mobile/login/log_tab1_off.gif" alt="회원로그인"></a> <a href="javascript:;"><img src="/images/mobile/login/log_tab2_on.gif" alt="비회원"></a> </div>
    <div class="t_box1">
      <p> <strong class="c1">비회원으로 구매한 이력이 있는 경우에만 주문/배송조회가 가능합니다.</strong> 주문/배송조회 이외의 서비스는 회원가입 후 이용이 가능합니다.<br>
        <br>
        <strong class="c1">주문번호가 기억나지 않으실 경우 고객센테로 문의주시기 바랍니다.</strong> <strong>(주문번호는 주문시 휴대폰으로 발송되오니 확인 바랍니다)</strong> </p>
    </div>
    <div class="licensee_2 licensee_pw">
      <form id="nonMemberFrm" name="nonMemberFrm" method = "post" action = "/mobile/mypage/shopping/state/non_member.do">
        <input type = "hidden" name = "member" value = "1"/>
        <input type = "hidden" name = "mode" value = "m_nomember_view"/>
        <dl class="type_2">
          <dt>주문번호를 입력해 주세요</dt>
          <dd><span class="standard">구매자</span><span class="input_box">
            <input type="text" id="receiver" name="receiver" class="input_m2 ws_2">
            </span></dd>
          <dd><span class="standard">주문번호</span><span class="input_box">
            <input type="text" id="orderno" name="orderno" class="input_m2 ws_2">
            </span></dd>
          <dd> <span class="standard">주문비밀번호</span> <span class="input_box">
          	<input type="text" name="fakevalue" value="none" style="display:none">
            <input type="password" id="passwd" name="passwd" class="input_m2 ws_2">
            </span> </dd>
        </dl>
      </form>
    </div>
    <div class="pw_s_btn"> <a href="javascript:non_member()"><img class="btn" src="/images/login/no_btn_1_off.gif" alt=""></a> </div>
    <div class="b_gui_2">
      <p class="gui_l"><span class="text">아직 파츠모아 회원이 아니세요?</span><span class="gui_btn"><a href="/mobile/join/join_1.do"><img class="btn" src="/images/join/btn_join.gif" alt=""></a></span></p>
    </div>
  </div>
</div>
