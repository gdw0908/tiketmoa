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
function go_delete(seq)
{
	if(confirm("삭제하시겠습니까?"))
	{
		location.replace("${servletPath}?mode=m_mydelete&seq=" + seq);
	}
}

function default_add(seq)
{
	if(confirm("기본 배송지로 등록 하시겠습니까?"))
	{
		location.replace("${servletPath}?mode=m_mydefault&seq=" + seq);
	}
}

function go_myAddressForm()
{
	jQuery("#myaddressForm").submit();
}

function go_update(seq)
{
	if(confirm("수정 하시겠습니까?"))
	{
		location.replace("${servletPath}?mode=m_myaddressForm&seq=" + seq);
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

		<div class="del_top">
		<span class="dt_l">배송지를 추가, 관리하세요.</span>
		<span class="dt_r"><a href="javascript:;"><img src="/images/sub_2/address_btn2.gif" alt="주소록 추가하기" onclick = "go_myAddressForm();"></a></span>
		</div>
		<c:forEach items="${list }" var="article" varStatus = "status">
        <div class="sub_table_1">
          <p class="st_line">
          <span class="st_l"><strong class="c1">배송지명</strong> : <c:choose><c:when test = "${article.default_yn eq 'Y'}">기본 배송지</c:when><c:otherwise>${article.receiver_title}</c:otherwise></c:choose></span>
          <span class="st_r"><a href="#"><span class="st_r"><a href="javascript:;"><img src="/images/mobile/sub_2/btn_type_d5.gif" alt="" onclick = "default_add(${article.seq});"></a></span></a></span>
          </p>
          <table>
          <colgroup>
          <col width="20%">
          <col width="">
          </colgroup>
          <tbody>

          <tr>
            <th scope="row">수취인<br>이름</th>
            <td>${article.receiver_nm}</td>
          </tr>

          <tr>
            <th scope="row">배송지<br>주소</th>
            <td>
              [${article.zip_cd}] ${article.addr1}
              ${article.addr2}
            </td>
          </tr>

          <tr>
            <th scope="row">수취인<br>휴대폰</th>
            <td>${article.cell}</td>
          </tr>
          <tr>
            <th scope="row">수취인<br>연락처</th>
            <td>${article.tel}</td>
          </tr>

          </tbody>
          </table>
        </div>
        <div class="btn_bottom_2">
		<a href="#"><img src="/images/mobile/sub_2/btn_type_d4.gif" alt="" onclick = "go_delete(${article.seq});"></a>
		<a href="#"><img src="/images/mobile/sub_2/btn_type_d3.gif" alt="" onclick = "go_update(${article.seq});"></a>
		</div>
		<br>
		</c:forEach>
      </div>
      <!-- fixed_btn -->
      <span class="my_menu"><a href="#"><img src="/images/mobile/common/btn_l.png" alt="my menu"></a></span>
      <span class="btn_regi"><a href="/html/mobile/sub/m08/m08_03.html"><img src="/images/mobile/common/btn_r.png" alt="상품등록"></a></span>
      <!-- //fixed_btn -->
    </div>
  </div>
  
  <form name = "myaddressForm" id = "myaddressForm" method = "post" action = "${servletPath}">
	<input type = "hidden" name = "mode" value = "m_myaddressForm"/>
 </form>
</body>
</html>
