<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%@ page import="com.mc.common.util.*" %>
<%
	String home_url = Util.getProperty("home.url");
String namesitecd = Util.getProperty("name.namesitecd");
String namesitepwd = Util.getProperty("name.namesitepwd");
String ipinsitecd = Util.getProperty("ipin.ipinsitecd");
String ipinsitepwd = Util.getProperty("ipin.ipinsitepwd");
	/* 실명인증 시작 */
    
	NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
	

    
	String sSiteCode = namesitecd;				// NICE로부터 부여받은 사이트 코드
	String sSitePassword = namesitepwd;		// NICE로부터 부여받은 사이트 패스워드
    
    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
   	String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
   	
   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
	String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지
		
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    String sReturnUrl = home_url+"/CheckPlusSafe/checkplus_success.jsp";      // 성공시 이동될 URL
    String sErrorUrl = home_url+"/CheckPlusSafe/checkplus_fail.jsp";          // 실패시 이동될 URL

    // 입력될 plain 데이타를 만든다.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
    
    String sMessage = "";
    String sEncData = "";
    
    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
    sEncData = niceCheck.getCipherData();
    
    /* 실명인증 끝*/
    
    /* IPIN 시작 */
    
    String sIpinSiteCode				= ipinsitecd;
	String sIpinSitePw					= ipinsitepwd;
	String sIpinReturnURL				= home_url+ "/IPIN/ipin_result.jsp";
	String sIpinCPRequest				= "";
	String sIpinEncData					= "";
	
	IPINClient pClient = new IPINClient();
	
	sIpinCPRequest = pClient.getRequestNO(sIpinSiteCode);
	
	session.setAttribute("CPREQUEST" , sIpinCPRequest);
	
	int iRtn = pClient.fnRequest(sIpinSiteCode, sIpinSitePw, sIpinCPRequest, sIpinReturnURL);
	
	sIpinEncData = pClient.getCipherData();
	
	
	/* IPIN 끝 */
%>
<script type = "text/javascript">
function openPop()
{
	if(document.getElementById("auth_member_nm_input").value == "")
	{
		alert("이름을 입력하세요.");
		document.getElementById("auth_member_nm_input").value = "";
		document.getElementById("auth_member_nm_input").focus();
		return;
	}
	else if(document.getElementById("member_id").value == "")
	{
		alert("아이디를 입력하세요.");
		document.getElementById("member_id").value = "";
		document.getElementById("member_id").focus();
		return;
	}
	else
	{
		if(document.pw_search_method.CheckUser[0].checked == true)
		{
			checkReadName();
		}
		else
		{
			iPinPop();
		}
		
	}
	
}

function checkReadName()
{
	window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
	document.form_chk.target = "popupChk";
	document.form_chk.submit();

}

function failCerti()
{
	alert("인증에 실패하였습니다. 다시 시도 하여주십시오.\n계속 문제가 발생할 경우 관리자에게 문의하시기 바랍니다.");
	return;
}

function go_next(str, ipin)
{
	alert("인증이 완료 되었습니다.");

	document.next_step.auth_member_nm.value = str;
	document.next_step.member_id.value = document.getElementById("member_id").value;
	document.next_step.auth_member_nm_1.value = document.getElementById("auth_member_nm_input").value;
	document.next_step.ipin.value = ipin;
	document.next_step.submit();
}

function iPinPop(){
	window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	document.form_ipin.target = "popupIPIN2";
	document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
	document.form_ipin.submit();
}

function search_email_form_fnc()
{
	if(document.getElementById("email_member_nm").value == "")
	{
		alert("이름을 입력하세요.");
		document.getElementById("email_member_nm").focus();
		document.getElementById("email_member_nm").value = "";
		return false;
	}
	else if(document.getElementById("email_member_id").value == "")
	{
		alert("아이디를 입력하세요.");
		document.getElementById("email_member_id").focus();
		document.getElementById("email_member_id").value = "";
		return false;
	}
	else if(document.getElementById("email").value == "")
	{
		alert("이메일을 입력하세요.");
		document.getElementById("email").focus();
		document.getElementById("email").value = "";
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
        <a href="javascript:;"><img src="/images/mobile/join/pw_tab1_on.gif" alt="개인회원 아이디찾기"></a>
        <a href="/mobile/join/pw_search_busi.do"><img src="/images/mobile/join/pw_tab2_off.gif" alt="사업자회원 아이디찾기"></a>
      </div>

      <div class="t_box1">
        <p><strong>개인회원이신경우</strong> :&nbsp;&nbsp;&nbsp;① 휴대폰 또는 아이핀 또는 이메일 인증정보 기재&nbsp;&nbsp;&nbsp;② 본인인증 완료 후 비밀번호 재발급</p>
        <p><strong>사업자회원이신경우</strong> :&nbsp;&nbsp;&nbsp;① 사업자 인증정보 기재&nbsp;&nbsp;&nbsp;② 이메일 전송 선택&nbsp;&nbsp;&nbsp;③ 선택한 인증 방식으로 비밀번호 재발급</p>
      </div>

	  <div class="authentication auth_2">

            <div class="phone phone_3">

              <dl class="type_2">
              <dt>
              휴대폰/아이핀 본인인증
              <span>본인명의의 휴대폰 번호나 아이핀으로 가입 및 본인여부를 확인합니다.<br>
              타인명의/법인휴대폰 회원님은 휴대폰 본인인증이 불가합니다.</span>
              </dt>
              <form name = "pw_search_method">
              <dd><span class="standard_ra">인증방식</span>
              <span><label><input type="radio" id="CheckUser" name="CheckUser" class="radio" value = "phone" checked> 휴대폰</label></span>
              <span><label><input type="radio" id="CheckUser" name="CheckUser" class="radio" value = "ipin"> 아이핀</label></span>
              </dd>
              </form>
              <dd><span class="standard">이름</span><span class="input_box"><input type="text" id="auth_member_nm_input" name="auth_member_nm_input" class="input_m2 ws_2"></span></dd>
              <dd>
              <span class="standard">아이디</span>
              <span class="input_box"><input type="text" id="member_id" name="member_id" class="input_m2 ws_2"></span>
              </dd>
              <dd class="btn"><img class="btn" src="/images/join/pw_auth_btn_off.gif" alt="" onclick = "openPop();" style = "cursor:pointer;"></dd>
              </dl>

            </div>

            <div class="ipin ipin_3">

              <dl class="type_2 type_2_2">
              <dt>
              이메일 본인인증
              <span>회원님이 가입하신 이메일주소를 통해 비밀번호를 찾을 수 있습니다.</span>
              <form name = "search_email_form" id = "search_email_form" method = "post" action = "/mobile/join/pw_search_ok.do" onsubmit = "return search_email_form_fnc();">
              <input type = "hidden" name = "mode" id = "mode" value = "mpw_search"/>
              </dt>
              <dd><span class="standard">이름</span><span class="input_box"><input type="text" id="email_member_nm" name="member_nm" class="input_m2 ws_2"></span></dd>
              <dd><span class="standard">아이디</span><span class="input_box"><input type="text" id="email_member_id" name="member_id" class="input_m2 ws_2"></span></dd>
              <dd>
              <span class="standard">이메일</span>
              <span class="input_box"><input type="text" id="email" name="email" class="input_m2 ws_2"></span>
              </dd>
              <dd class="btn"><input type = "image" src = "/images/join/pw_auth_btn_off.gif"></dd>
              </dl>
			  </form>
            </div>

          </div>

    </div>
  </div>
  
  <form name="form_chk" method="post">
	<input type="hidden" name="m" value="checkplusSerivce">
	<input type="hidden" name="EncodeData" value="<%= sEncData %>">
	</form>
	
	<form name="form_ipin" method="post">
		<input type="hidden" name="m" value="pubmain">
	   	<input type="hidden" name="enc_data" value="<%= sIpinEncData %>">
	</form>
	
	<form name="vnoform" method="post">
		<input type="hidden" name="enc_data">
	</form>
	
	<form name = "next_step" id = "next_step" method = "post" action = "/mobile/join/pw_search_ok.do">
		<input type = "hidden" name = "auth_member_nm" id = "auth_member_nm" value = ""/>
		<input type = "hidden" name = "mode" id = "mode" value = "pw_search"/>
		<input type = "hidden" name = "member_id" id = "member_id" value = ""/>
		<input type = "hidden" name = "ipin" id = "ipin" value = ""/>
		<input type = "hidden" name = "auth_member_nm_1" id = "auth_member_nm_1" value = ""/>
	</form>
</body>
</html>
