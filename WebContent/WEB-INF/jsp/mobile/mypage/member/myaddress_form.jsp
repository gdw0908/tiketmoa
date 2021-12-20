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

function myAddressFormCheck()
{
	if(jQuery("#receiver_nm").val() == "")
	{
		alert("수취인 이름을 입력하세요.");
		jQuery("#receiver_nm").val("");
		jQuery("#receiver_nm").focus();
		return false;
		
	}
	else if(jQuery("#zip_cd1").val() == "")
	{
		alert("주소 찾기 버튼을 이용하여 주소를 입력하세요\n \"오른쪽 주소록에 기본배송지로 저장\"\n 체크 시 기본 배송지로 등록 됩니다.");
		return false;
		
	}
	else if(jQuery("#receiver_title").val() == "")
	{
		alert("배송지명을 입력하세요\n \"오른쪽 수취인명과 동일하게 적용\"\n 체크 시 하면 수취인명과 동일하게 사용 가능합니다.");
		jQuery("#receiver_title").val("");
		jQuery("#receiver_title").focus();
		return false;
		
	}
	else if(jQuery("#tel").val() == "" || isNaN(jQuery("#tel").val()))
	{
		alert("수취인 휴대폰 번호를 입력하지 않았거나 숫자만 입력가능합니다.");
		jQuery("#tel").val("");
		jQuery("#tel").focus();
		return false;
		
	}
	else if(jQuery("#tel1").val() == "" || isNaN(jQuery("#tel1").val()))
	{
		alert("수취인 휴대폰 번호를 입력하지 않았거나 숫자만 입력가능합니다.");
		jQuery("#tel1").val("");
		jQuery("#tel1").focus();
		return false;
		
	}
	
	else if(jQuery("#tel2").val() == "" || isNaN(jQuery("#tel2").val()))
	{
		alert("수취인 휴대폰 번호를 입력하지 않았거나 숫자만 입력가능합니다.");
		jQuery("#tel2").val("");
		jQuery("#tel2").focus();
		return false;
		
	}
	
	else if(jQuery("#cell").val() == "" || isNaN(jQuery("#cell").val()))
	{
		alert("수취인 연락처를 입력하지 않았거나 숫자만 입력가능합니다.");
		jQuery("#cell").val("");
		jQuery("#cell").focus();
		return false;
		
	}
	else if(jQuery("#cell1").val() == "" || isNaN(jQuery("#cell1").val()))
	{
		alert("수취인 연락처를 입력하지 않았거나 숫자만 입력가능합니다.");
		jQuery("#cell1").val("");
		jQuery("#cell1").focus();
		return false;
		
	}
	else if(jQuery("#cell2").val() == "" || isNaN(jQuery("#cell2").val()))
	{
		alert("수취인 연락처를 입력하지 않았거나 숫자만 입력가능합니다.");
		jQuery("#cell2").val("");
		jQuery("#cell2").focus();
		return false;
		
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
	jQuery("#zip_cd1").val(zip[0]);
	jQuery("#zip_cd2").val(zip[1]);
	jQuery("#addr1").val(jibunAddr);
	jQuery("#addr2").val(addrDetail);
	
	
}

var addSw = 0;
function addOption()
{
	if(addSw == 0)
	{
		jQuery("#receiver_title").val(jQuery("#receiver_nm").val());
		jQuery("#receiver_title").attr("readonly",true);
		
		addSw = 1;
		
	}
	else
	{
		jQuery("#receiver_title").val("");
		jQuery("#receiver_title").focus();
		jQuery("#receiver_title").attr("readonly",false);
		
		addSw = 0;
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
          <h3><img src="/images/mobile/sub_2/sub_2_title_6_2.gif" alt="나의 배송지관리"></h3>
        </div>

        <div class="hs_line">
          <h4 class="hs_1" style="margin:0;">배송지 등록 <span>[ <span class="s_icon">표시된 항목은 필수사항입니다. ]</span></span></h4>
          <p>총 <b>${myaddress.total}</b> 개의 주소가 등록되어 있습니다</p>
        </div>
		<form name = "myAddressForm" id = "myAddressForm" method = "post" action = "${servletPath }" onsubmit = "return myAddressFormCheck()">
				<input type = "hidden" name = "mode" value = "${mode }"/>
				<input type = "hidden" name = "seq" value = "${myaddress.seq }"/>
        <div class="sub_table_1">
          <table>
          <colgroup>
          <col width="20%">
          <col width="">
          </colgroup>
          <tbody>

          <tr>
            <th scope="row"><span>수취인<br>이름</span></th>
            <td><input type="text" id="receiver_nm" name="receiver_nm" class="input_2 ws_3" value = "${myaddress.receiver_nm }"></td>
          </tr>

          <tr>
            <th scope="row"><span>배송지<br>주소</span></th>
            <td>
              <div class="input_box_1">
                <input type="text" id="zip_cd1" name="zip_cd1" class="input_2 ws_1" value = "${zip_cd1 }" readonly> - <input type="text" id="zip_cd2" name="zip_cd2" class="input_2 ws_1" value = "${zip_cd2 }" readonly>
                <a href="#"><img src="/images/sub_2/pay_s_btn2.gif" alt="주소찾기" onclick = "open_zipcode();"></a> <label><br><br><input type="checkbox" id="default_yn" name="default_yn" class="check"  value = "Y" <c:if test = "${myaddress.default_yn eq 'Y'}">checked</c:if>> 주소록에 기본배송지로 저장</label>
              </div>
              <div class="input_box_1">
                <input type="text" id="addr1" name="addr1" class="input_2 ws_2" value = "${myaddress.addr1 }" readonly>
              </div>
              <div class="last">
                <input type="text" id="addr2" name="addr2" class="input_2 ws_2" value = "${myaddress.addr2 }" readonly>
              </div>
            </td>
          </tr>

          <tr>
            <th scope="row"><span>배송지명</span></th>
            <td><input type="text" id="receiver_title" name="receiver_title" class="input_2 ws_3" value = "${myaddress.receiver_title }"> <label><br><br><input type="checkbox" id="" name="" class="check" onclick = "addOption();"> 수취인명과 동일하게 적용</label></td>
          </tr>

          <tr>
            <th scope="row"><span>수취인<br>휴대폰</span></th>
            <td>
              <input type="text" id="tel" name="tel" class="input_2 ws_1" value = "${tel }" maxlength = "3">
              -
              <input type="text" id="tel1" name="tel1" class="input_2 ws_1" value = "${tel1 }" maxlength = "4">
              -
              <input type="text" id="tel2" name="tel2" class="input_2 ws_1" value = "${tel2 }" maxlength = "4">
            </td>
          </tr>
          <tr>
            <th scope="row"><span>수취인<br>연락처</span></th>
            <td>
              <input type="text" id="cell" name="cell" class="input_2 ws_1" value = "${cell }" maxlength = "3">
              -
              <input type="text" id="cell1" name="cell1" class="input_2 ws_1" value = "${cell1 }" maxlength = "4">
              -
              <input type="text" id="cell2" name="cell2" class="input_2 ws_1" value = "${cell2 }" maxlength = "4">
            </td>
          </tr>

          </tbody>
          </table>
        </div>

		<div class="check_btn">
		
		<p class="cb_r">
          <a href="javascript:history.back(-1);"><img src="/images/mobile/sub_2/btn_type_d6.gif" alt=""></a>
          <input type = "image" src = "/images/mobile/sub_2/btn_type_d7.gif"></a>
        </p>
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
