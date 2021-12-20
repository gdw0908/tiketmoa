<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<script type = "text/javascript">
function inputEmail2(value)
{
	if(value == "")
	{
		jQuery("#email1").attr("readonly",false);
		jQuery("#email1").val("");
		jQuery("#email1").focus();
	}
	else
	{
		jQuery("#email1").attr("readonly",true);
		jQuery("#email1").val(value);
	}
}
function open_zipcode()
{
	var param = "";
	
	if(arguments[0]){
		param = "?fun="+arguments[0];
	}
	
	window.open("/addr/road.jsp"+param,"addr","width=570,height=420");
}

function setAddr(roadAddrPart1, addrDetail, zipNo, jibunAddr)
{
	var zip = zipNo.split("-");
	jQuery("#zip_cd").val(zip[0]);
	jQuery("#zip_cd1").val(zip[1]);
	jQuery("#addr1").val(jibunAddr);
	jQuery("#addr2").val(addrDetail);
	
	
}

function CheckPassword(uid, upw) 
{
	if(upw == "")
	{
		return false;
	}
	
    if(!/^[a-zA-Z0-9]{6,15}$/.test(upw))
    { 
        return false;
    }
  
    var chk_num = upw.search(/[0-9]/g); 
    var chk_eng = upw.search(/[a-z]/ig); 

    if(chk_num < 0 || chk_eng < 0)
    { 
        return false;
    }
    
    if(/(\w)\1\1\1/.test(upw))
    {
        return false;
    }
    
    if(upw.search(uid)>-1)
    {
        return false;
    }
    
    return true;
}

function userModfiyFormCheck()
{
	if(jQuery("#member_pw_df").val() == "")
	{
		alert("기존 비밀번호를 입력하세요.");
		jQuery("#member_pw_df").val("");
		jQuery("#member_pw_df").focus();
		return false;
		
	}
	
	else if(!CheckPassword('${userData.member_id }', jQuery("#member_pw").val() ))
	{
		alert("비밀번호는 아이디와 같을 수 없으며\n6~15글자 이내, 영문 대/소문자, 숫자를 조합해야합니다.");	
		jQuery("#member_pw").val("");
		jQuery("#member_pw").focus();
		return false;
	}
	
	else if(jQuery("#member_pw").val() != jQuery("#member_pw_check").val())
	{
		alert("새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.");
		jQuery("#member_pw").val("");
		jQuery("#member_pw_check").val("");
		jQuery("#member_pw").focus();
		return false;
		
	}
	/*
	else if(jQuery("#tel1").val() == "" || isNaN(jQuery("#tel1").val()))
	{
		alert("전화번호를 입력하지 않았거나 숫자만 입력가능합니다.");
		jQuery("#tel1").val("");
		jQuery("#tel1").focus();
		return false;
		
	}
	else if(jQuery("#tel2").val() == "" || isNaN(jQuery("#tel2").val()))
	{
		alert("전화번호를 입력하지 않았거나 숫자만 입력가능합니다.");
		jQuery("#tel2").val("");
		jQuery("#tel2").focus();
		return false;
		
	}
	*/
	else if(jQuery("#cell").val() == "" || isNaN(jQuery("#cell").val()))
	{
		alert("휴대폰번호를 입력하지 않았거나 숫자만 입력가능합니다.");
		jQuery("#cell").val("");
		jQuery("#cell").focus();
		return false;
		
	}
	else if(jQuery("#cell1").val() == "" || isNaN(jQuery("#cell1").val()))
	{
		alert("휴대폰번호를 입력하지 않았거나 숫자만 입력가능합니다.");
		jQuery("#cell1").val("");
		jQuery("#cell1").focus();
		return false;
		
	}
	else if(jQuery("#cell2").val() == "" || isNaN(jQuery("#cell2").val()))
	{
		alert("휴대폰번호를 입력하지 않았거나 숫자만 입력가능합니다.");
		jQuery("#cell2").val("");
		jQuery("#cell2").focus();
		return false;
		
	}
	else if(jQuery("#email").val() == "")
	{
		alert("이메일을 입력하세요.");
		jQuery("#email").val("");
		jQuery("#email").focus();
		return false;
		
	}
	else if(jQuery("#email1").val() == "")
	{
		alert("이메일을 선택하거나 직접등록을 통하여 직접 입력을 해야합니다.");
		jQuery("#email1").val("");
		return false;
		
	}
	else if(jQuery("#zip_cd").val() == "")
	{
		alert("주소를 입력해야 합니다 주소검색 버튼을 통하여 입력해주세요.");
		jQuery("#zip_cd").val("");
		jQuery("#zip_cd1").val("");
		jQuery("#addr1").val("");
		jQuery("#addr1").val("");
		return false;
		
	}
	else
	{
		if(confirm("수정 하시겠습니까?"))
		{
			return true;
		}
		else
		{
			return false;
		}
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
          <h3><img src="/images/mobile/sub_2/sub_2_title_6_1.gif" alt="회원정보변경"></h3>
        </div>

        <h4 class="hs_1">회원정보 <span>[ <span class="s_icon_2">표시된 항목은 필수사항입니다. ]</span></span></h4>
		 <form name = "userModifyForm" id = "userModifyForm" method = "post" action = "${servletPath}" onsubmit = "return userModfiyFormCheck();">
		 <input type = "hidden" name = "mode" value = "muserModify">
		 <input type = "hidden" name = "member_seq" value = "${userData.member_seq }">
        <div class="user_info_box">
          <table class="user_table_1">
          <colgroup>
          <col width="25%">
          <col width="">
          </colgroup>
          <tbody>

          <tr>
            <th scope="row"><span>아이디</span></th>
            <td class="fs_style_1">${userData.member_id }</td>
          </tr>

          <tr>
            <th scope="row"><span>기존<br>비밀번호</span></th>
            <td><input type="password" id="member_pw_df" name="member_pw_df" class="input_m2 ws_1" placeholder="현재 비밀번호를 입력해 주세요"></td>
          </tr>

          <tr>
            <th scope="row">새<br>비밀번호</th>
            <td><input type="password" id="member_pw" name="member_pw" class="input_m2 ws_1" placeholder="새 비밀번호를 입력해 주세요"> <span class="c1">※ 6~15자의 영문과 숫자만 사용 가능합니다.</span></td>
          </tr>

          <tr>
            <th scope="row">새 비밀번호 확인</th>
            <td><input type="password" id="member_pw_check" name="member_pw_check" class="input_m2 ws_1" placeholder="새 비밀번호를 다시한번 입력해 주세요"></td>
          </tr>

          <tr>
            <th scope="row">이름<br>(실명)</th>
            <td class="fs_style_1">${userData.member_nm }</td>
          </tr>

          <tr>
            <th scope="row">전화번호</th>
            <td>
             <select id="tel" name="tel" class="select_u1">
                  <option value = "02" <c:if test = "${tel eq '02'}">selected</c:if>>02</option>
		          <option value = "051" <c:if test = "${tel eq '051'}">selected</c:if>>051</option>
		          <option value = "053" <c:if test = "${tel eq '053'}">selected</c:if>>053</option>
		          <option value = "032" <c:if test = "${tel eq '032'}">selected</c:if>>032</option>
		          <option value = "062" <c:if test = "${tel eq '062'}">selected</c:if>>062</option>
		          <option value = "042" <c:if test = "${tel eq '042'}">selected</c:if>>042</option>
		          <option value = "052" <c:if test = "${tel eq '052'}">selected</c:if>>052</option>
		          <option value = "044" <c:if test = "${tel eq '044'}">selected</c:if>>044</option>
		          <option value = "031" <c:if test = "${tel eq '031'}">selected</c:if>>031</option>
		          <option value = "033" <c:if test = "${tel eq '033'}">selected</c:if>>033</option>
		          <option value = "043" <c:if test = "${tel eq '043'}">selected</c:if>>043</option>
		          <option value = "041" <c:if test = "${tel eq '041'}">selected</c:if>>041</option>
		          <option value = "063" <c:if test = "${tel eq '063'}">selected</c:if>>063</option>
		          <option value = "061" <c:if test = "${tel eq '061'}">selected</c:if>>061</option>
		          <option value = "054" <c:if test = "${tel eq '054'}">selected</c:if>>054</option>
		          <option value = "055" <c:if test = "${tel eq '055'}">selected</c:if>>055</option>
		          <option value = "064" <c:if test = "${tel eq '064'}">selected</c:if>>064</option>
		          <option value = "070" <c:if test = "${tel eq '070'}">selected</c:if>>070</option>
	          	  <option value = "080" <c:if test = "${tel eq '080'}">selected</c:if>>080</option>
                </select>
              - <input type="text" id="tel1" name="tel1" class="input_m2 ws_2" value = "${tel1 }" maxlength = "4"> - <input type="text" id="tel2" name="tel2" value = "${tel2 }" class="input_m2 ws_2" maxlength = "4">
            </td>
          </tr>

          <tr>
            <th scope="row"><span>휴대폰<br>번호</span></th>
            <td>
             <input type="text" id="cell" name="cell" class="input_m2 ws_2" value = "${cell }" maxlength = "3">
              
              - <input type="text" id="cell1" name="cell1" class="input_m2 ws_2" value = "${cell1 }" maxlength = "4"> - <input type="text" id="cell2" name="cell2" class="input_m2 ws_2" value = "${cell2 }" maxlength = "4">
            </td>
          </tr>

          <tr>
            <th scope="row" class="fs_1">알림 설정</th>
            <td><label><input type="checkbox" id="sms_yn" name="sms_yn" class="check" value = "Y" <c:if test = "${userData.sms_yn eq 'Y' }">checked</c:if>> 휴대폰 알림문자를 받겠습니다.</label></td>
          </tr>

          <tr>
            <th scope="row"><span>이메일</span></th>
            <td>
              <input type="text" id="email" name="email" class="input_m2 ws_4" value = "${email }"> @ <input type="text" id="email1" name="email1" class="input_m2 ws_4" value = "${email1 }">
               <select id="choice_email" name="choice_email" class="select_1" style="margin-top:10px;" onchange = "inputEmail2(this.value);">
		          <option value = "" <c:if test = "${email1 ne 'hanmail.net' || email1 ne 'naver.com' || email1 ne 'daum.net' || email1 ne 'nate.com' || email1 ne 'gmail.com' || email1 ne 'korea.com' || email1 ne 'dreamwiz.com' || email1 ne 'hotmail.com' || email1 ne 'yahoo.co.kr' || email1 ne 'sportal.or.kr'}">selected</c:if>>직접입력</option>
		          <option value="hanmail.net" <c:if test = "${email1 eq 'hanmail.net' }">selected</c:if>>hanmail.net</option>
		          <option value="naver.com" <c:if test = "${email1 eq 'naver.com'  }">selected</c:if>>naver.com</option>
		          <option value="daum.net" <c:if test = "${email1 eq 'daum.net'  }">selected</c:if>>daum.net</option>
		          <option value="nate.com" <c:if test = "${email1 eq 'nate.com'  }">selected</c:if>>nate.com</option>
		          <option value="gmail.com" <c:if test = "${email1 eq 'gmail.com'  }">selected</c:if>>gmail.com</option>
		          <option value="korea.com" <c:if test = "${email1 eq 'korea.com'  }">selected</c:if>>korea.com</option>
		          <option value="dreamwiz.com" <c:if test = "${email1 eq 'dreamwiz.com'  }">selected</c:if>>dreamwiz.com</option>
		          <option value="hotmail.com" <c:if test = "${email1 eq 'hotmail.com'  }">selected</c:if>>hotmail.com</option>
		          <option value="yahoo.co.kr" <c:if test = "${email1 eq 'yahoo.co.kr'  }">selected</c:if>>yahoo.co.kr</option>
		          <option value="sportal.or.kr" <c:if test = "${email1 eq 'sportal.or.kr'  }">selected</c:if>>sportal.or.kr</option>
		        </select>
            </td>
          </tr>

          <tr>
            <th scope="row" class="fs_1">광고성<br>메일 수신</th>
            <td><label><input type="checkbox" id="email_yn" name="email_yn" value = "Y" class="check" <c:if test = "${userData.email_yn eq 'Y' }">checked</c:if>> 수신함</label> <label style="margin-left:15px;"><input type="checkbox" id="email_yn" name="email_yn" value = "N" class="check" <c:if test = "${userData.email_yn eq 'N' }">checked</c:if>> 수신안함</label> <span class="c2">※ 주요 공지사항 및 알림 등은 설정에 관계 없이 발송됩니다.</span></td>
          </tr>

          <tr>
            <th scope="row"><span>주소</span></th>
            <td class="adress">
              <p><input type="text" id="zip_cd" name="zip_cd" class="input_m2 ws_2" readonly value = "${zip_code1 }"> - <input type="text" id="zip_cd1" name="zip_cd1" class="input_m2 ws_2" readonly value = "<c:if test="${!(zip_code2 == null or zip_code2 == '' or zip_code2 == 'null') }">${zip_code2 }</c:if>">
              <a href="javascript:open_zipcode();"><img src="/images/mobile/sub_2/address_btn_m1.gif" alt="주소검색"></a> </p>
              <p><input type="text" id="addr1" name="addr1" class="input_m2 ws_3" value = "${userData.addr1 }" readonly></p>
              <p class="last"><input type="text" id="addr2" name="addr2" class="input_m2 ws_3" value = "${userData.addr2 }" ></p>
            </td>
          </tr>

          </tbody>
          </table>
        </div>

        <div class="btn_bottom"><input type = "image" src = "/images/sub_2/btn_mod.gif"></div>
		</form>
      </div>
      <!-- fixed_btn -->
      <span class="my_menu"><a href="#"><img src="/images/mobile/common/btn_l.png" alt="my menu"></a></span>
      <span class="btn_regi"><a href="/html/mobile/sub/m08/m08_03.html"><img src="/images/mobile/common/btn_r.png" alt="상품등록"></a></span>
      <!-- //fixed_btn -->

    </div>

  </div>
</body>
</html>
