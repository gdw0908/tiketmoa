<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<script type = "text/javascript">


function phone_chk_submit(obj)
{
	if(jQuery("#member_nm").val() == "")
	{
		alert("이름을 입력하세요.");
		jQuery("#member_nm").val("");
		jQuery("#member_nm").focus();
		return false;
	}
	else if(jQuery("#cell1").val() == "" || isNaN(jQuery("#cell1").val()))
	{
		alert("전화번호를 입력하지 않았거나 숫자만 입력가능합니다.");	
		jQuery("#cell1").val("");
		jQuery("#cell1").focus();
		return false;
	}
	else if(jQuery("#cell2").val() == "" || isNaN(jQuery("#cell2").val()))
	{
		alert("전화번호를 입력하지 않았거나 숫자만 입력가능합니다.");	
		jQuery("#cell2").val("");
		jQuery("#cell2").focus();
		return false;
	}
	else if(jQuery("#cell3").val() == "" || isNaN(jQuery("#cell3").val()))
	{
		alert("전화번호를 입력하지 않았거나 숫자만 입력가능합니다.");	
		jQuery("#cell3").val("");
		jQuery("#cell3").focus();
		return false;
	}
	else
	{
		return true;
	}
}

function email_chk_submit(obj)
{
	if(jQuery("#member_nm1").val() == "")
	{
		alert("이름을 입력하세요.");
		jQuery("#member_nm1").val("");
		jQuery("#member_nm1").focus();
		return false;
	}
	else if(jQuery("#email").val() == "")
	{
		alert("이메일을 입력하세요.");	
		jQuery("#email").val("");
		jQuery("#email").focus();
		return false;
	}
	else if(!chk_email(jQuery("#email").val()))
	{
		alert("입력하신 이메일 형식이 올바르지 않습니다. 다시 입력하세요.");	
		jQuery("#email").val("");
		jQuery("#email").focus();
		return false;
	}
	else
	{
		return true;
	}
}

function busi_chk_submit(obj)
{
	if(jQuery("#busi_nm").val() == "")
	{
		alert("상호명을 입력하세요.");
		jQuery("#busi_nm").val("");
		jQuery("#busi_nm").focus();
		return false;
	}
	else if(jQuery("#busi_no1").val() == "" || isNaN(jQuery("#busi_no1").val()))
	{
		alert("사업자등록번호를 입력하지 않았거나 숫자만 입력가능합니다.");	
		jQuery("#busi_no1").val("");
		jQuery("#busi_no1").focus();
		return false;
	}
	else if(jQuery("#busi_no2").val() == "" || isNaN(jQuery("#busi_no2").val()))
	{
		alert("사업자등록번호를 입력하지 않았거나 숫자만 입력가능합니다.");	
		jQuery("#busi_no2").val("");
		jQuery("#busi_no2").focus();
		return false;
	}
	else if(jQuery("#busi_no3").val() == "" || isNaN(jQuery("#busi_no3").val()))
	{
		alert("사업자등록번호를 입력하지 않았거나 숫자만 입력가능합니다.");	
		jQuery("#busi_no3").val("");
		jQuery("#busi_no3").focus();
		return false;
	}
	else
	{
		return true;	
	}
}

function chk_email(value)
{
	var pattern = new RegExp(/^([\w]{1,})+[\w\.\-\_]+([\w]{1,})+@(?:[\w\-]{2,}\.)+[a-zA-Z]{2,}$/);
	
	return pattern.test(value);
}
</script>
<div class="wrap">
    <div class="j_wrap">

      <div class="j_visual"><img src="/images/mobile/join/jm_img1.gif" alt="국내최대 자동차 중고부품 쇼핑몰 PARTS MOA에 오신 것을 환영합니다"></div>

      <div class="join_tab">
        <a href="javascript:;"><img src="/images/mobile/join/se_tab1_on.gif" alt="개인회원 아이디찾기"></a>
        <a href="/mobile/join/id_search_busi.do"><img src="/images/mobile/join/se_tab2_off.gif" alt="사업자회원 아이디찾기"></a>
      </div>

      <div class="t_box1">
        <p>
        파츠모아쇼핑몰 회원정보에 등록되어있는 정보 중 1가지를 택하여 입력해 주세요. <strong>등록정보로 ID의 일부를 찾을 수 있습니다.<br>
        이름, 상호명은 띄어쓰기 없이 입력해 주세요.</strong>
        </p>
      </div>

      <div class="authentication auth_2">

        <div class="phone phone_2">
		<form name = "phoneSearch" method = "post" action = "/mobile/join/id_search_ok.do" onsubmit = "return phone_chk_submit(this);">
		  <input type = "hidden" name = "mode" value = "msearch"/>
          <dl class="type_2">
          <dt>휴대폰정보로 아이디찾기</dt>
          <dd><span class="standard">이름</span><span class="input_box"><input type="text" id="member_nm" name="member_nm" class="input_m2"></span></dd>
          <dd>
          <span class="standard">휴대폰</span>
          <span class="input_box">
           <input type="text" id="cell1" name="cell1" class="input_m2 ws_1" maxlength = "3">
          - <input type="text" id="cell2" name="cell2" class="input_m2 ws_1" maxlength = "4"> - <input type="text" id="cell3" name="cell3" class="input_m2 ws_1" maxlength = "4">
          </span>
          </dd>
          <dd class="btn"><input type= "image" src = "/images/join/id_auth_btn_off.gif"></dd>
          </dl>
		</form>
        </div>

        <div class="ipin">
		<form name = "emailSearch" method = "post" action = "/mobile/join/id_search_ok.do" onsubmit = "return email_chk_submit(this);">
	      <input type = "hidden" name = "mode" value = "msearch"/>
          <dl class="type_2 type_2_2">
          <dt>이메일정보로 아이디찾기</dt>
          <dd><span class="standard">이름</span><span class="input_box"><input type="text" id="member_nm1" name="member_nm1" class="input_m2"></span></dd>
          <dd>
          <span class="standard">이메일</span>
          <span class="input_box"><input type="text" id="email" name="email" class="input_m2 ws_2"></span>
          </dd>
          <dd class="btn"><input type = "image" src = "/images/join/id_auth_btn_off.gif"></dd>
          </dl>
		</form>
        </div>

      </div>

      <div class="b_gui_2 t_style">
        <p class="gui_l"><span class="text">아직 파츠모아 회원이 아니세요?</span><span class="gui_btn"><a href="/mobile/join/join_1.do"><img class="btn" src="/images/join/btn_join.gif" alt=""></a></span></p>
      </div>

	  <div class="b_gui_2 t_style">
        <p class="gui_l"><span class="text">아직 파츠모아 회원이 아니세요?</span><span class="gui_btn"><a href="/mobile/join/join_1.do"><img class="btn" src="/images/join/btn_pw_search.gif" alt=""></a></span></p>
      </div>

    </div>
  </div>
</body>
</html>
