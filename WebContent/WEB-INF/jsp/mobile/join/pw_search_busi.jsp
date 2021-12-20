<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<script type = "text/javascript">

function busi_search_form_chk()
{
	if(document.getElementById("busi_member_id").value == "")
	{
		alert("아이디를 입력하세요.");
		document.getElementById("busi_member_id").value = "";
		document.getElementById("busi_member_id").focus();
		return false;
	}
	else if(document.getElementById("com_nm").value == "")
	{
		alert("상호명을 입력하세요.");
		document.getElementById("com_nm").value = "";
		document.getElementById("com_nm").focus();
		return false;
	}
	else if(document.getElementById("busi_no1").value == "" || isNaN(document.getElementById("busi_no1").value))
	{
		alert("사업자등록번호를 입력하지 않았거나 숫자만 입력가능합니다.");
		document.getElementById("busi_no1").value = "";
		document.getElementById("busi_no1").focus();
		return false;
	}
	else if(document.getElementById("busi_no2").value == "" || isNaN(document.getElementById("busi_no2").value))
	{
		alert("사업자등록번호를 입력하지 않았거나 숫자만 입력가능합니다.");
		document.getElementById("busi_no2").value = "";
		document.getElementById("busi_no2").focus();
		return false;
	}
	else if(document.getElementById("busi_no3").value == "" || isNaN(document.getElementById("busi_no3").value))
	{
		alert("사업자등록번호를 입력하지 않았거나 숫자만 입력가능합니다.");
		document.getElementById("busi_no3").value = "";
		document.getElementById("busi_no3").focus();
		return false;
	}
	else
	{
		if(confirm("개인회원은 개인탭에서 기업회원은 기업탭에서 검색 을 하셔야 정확하게 비밀번호를 찾으 실수 있습니다. 진행하시겠습니까?"))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}
</script>
<div class="wrap">
    <div class="j_wrap">
      <div class="pw_visual">
        파츠모아쇼핑몰 회원정보에 등록되어있는 정보 중 1가지를 택하여 입력해 주세요. <strong>등록정보로 ID의 비밀번호를 재발급 받으실 수 있습니다.<br>
        이름, 상호명은 띄어쓰기 없이 입력해 주세요. (아이핀으로 회원가입을 하신경우, 아이핀 인증을 통해 아이디를 찾을 수 있습니다.)</strong>
      </div>

      <div class="join_tab">
        <a href="/mobile/join/pw_search_user.do"><img src="/images/mobile/join/pw_tab1_off.gif" alt="개인회원 아이디찾기"></a>
        <a href="javascript:;"><img src="/images/mobile/join/pw_tab2_on.gif" alt="사업자회원 아이디찾기"></a>
      </div>

      <div class="t_box1">
        <p><strong>개인회원이신경우</strong> :&nbsp;&nbsp;&nbsp;① 휴대폰 또는 아이핀 또는 이메일 인증정보 기재&nbsp;&nbsp;&nbsp;② 본인인증 완료 후 비밀번호 재발급</p>
        <p><strong>사업자회원이신경우</strong> :&nbsp;&nbsp;&nbsp;① 사업자 인증정보 기재&nbsp;&nbsp;&nbsp;② 이메일 인증 방식으로 비밀번호 재발급</p>
      </div>

      <div class="licensee_2 licensee_pw">
 		<form name = "busi_search_form" id = "busi_search_form" method = "post" action = "/mobile/join/pw_search_ok.do" onsubmit = "return busi_search_form_chk();">
	            <input type = "hidden" name = "mode" id = "mode" value = "mpw_search"/>
        <dl class="type_2">
        <dt>사업자 회원정보로 비밀번호찾기</dt>
        <dd><span class="standard">아이디</span><span class="input_box"><input type="text" id="busi_member_id" name="member_id" class="input_m2 ws_2"></span></dd>
        <dd><span class="standard">상호명</span><span class="input_box"><input type="text" id="busi_nm" name="busi_nm" class="input_m2 ws_2"></span></dd>
        <dd>
        <span class="standard">사업자<br>등록번호</span>
        <span class="input_box"><input type="text" id="busi_no1" name="busi_no1" class="input_m2 ws_3" maxlength = "3"> - <input type="text" id="busi_no2" name="busi_no2" class="input_m2 ws_3" maxlength = "2"> - <input type="text" id="busi_no3" name="busi_no3" class="input_m2 ws_3" maxlength = "5"></span>
        </dd>

        </dl>

      </div>

      <div class="pw_s_btn"><input type = "image" src = "/images/join/pw_btn1_off.gif"></div>
	</form>
    </div>
</div>
</body>
</html>
