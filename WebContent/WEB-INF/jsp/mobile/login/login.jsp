<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<script type="text/javascript" src="/lib/js/jquery.cookie.js"></script>
<script type = "text/javascript">

function login_proc(obj)
{
	if(obj.member_id.value == "")
	{
		alert("아이디를 입력하세요.");
		obj.member_id.focus();
		return false;
	}
	else if(obj.member_pw.value == "")
	{
		alert(" 패스워드를 입력하세요.");
		obj.member_pw.focus();
		return false;
	}
	else
	{
		if(obj.id_save.checked){
			$.cookie("save_id", obj.member_id.value, { path: '/', expires: 365 });
		}else{
			$.cookie("save_id", "", { path: '/', expires: -1 });
		}

		return true;	
	}
}

jQuery(document).ready(function(){
	
	if(!!$.cookie("save_id")){
		jQuery("#member_id").val($.cookie("save_id"));
		jQuery("#id_save").attr("checked", true);
	}
})
</script>
  <div class="login_wrap">
    <div class="l_img"><img src="/images/login/login_bg.gif" alt="PARTS MOA 국내최대 자동차 중고부품 쇼핑몰 PARTS MOA에 오신 것을 환영합니다"></div>
    <div class="join_tab">
      <a href="javascript:;"><img src="/images/mobile/login/log_tab1_on.gif" alt="회원로그인"></a>
      <a href="/mobile/login/login.do?mode=mnomember"><img src="/images/mobile/login/log_tab2_off.gif" alt="비회원"></a>
    </div>
    <form name = "login_form" id = "login_form" method = "post" action = "/mobile/login/login.do" onsubmit = "return login_proc(this);">
    <input type = "hidden" name = "mode" value = "mProc"/>
    <input type = "hidden" name = "member" value = "1"/>
    <fieldset>
    <legend>로그인</legend>
    <div class="login_con">
      <div class="login_box">
        <div class="l_left">
          <p><input type="text" id="member_id" name="member_id" placeholder="아이디"></p>
          <p class="last"><input type="password" id="member_pw" name="member_pw" placeholder="패스워드"></p>
        </div>
        <div class="l_btn"><input type = "image" src = "/images/login/btn_login.gif"></div>
      </div>
      <div class="btn_lnk">
        <ul>
          <li class="first"><label><input type="checkbox" id="id_save" name="id_save" class="check"> 아이디저장</label></li>
          <li><a href="/mobile/join/join_1.do">회원가입</a></li>
          <li><a href="/mobile/join/id_search_user.do">아이디 찾기</a></li>
          <li><a href="/mobile/join/pw_search_user.do">비밀번호 찾기</a></li>
        </ul>
      </div>
    </div>
    </fieldset>
   </form>
  </div>