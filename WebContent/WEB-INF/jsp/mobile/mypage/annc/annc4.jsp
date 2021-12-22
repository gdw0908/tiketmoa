<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type = "text/javascript">
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

<div class="sm_wrap">
        <div class="sm_top">
          <span class="select_box s_menu_type">
          <select id="url" name="url" class="select_sm">
          <option value="">메뉴를 선택해 주세요</option>
          <option value="/mobile/mypage/annc/annc1.do?menu=menu6">서비스이용약관</option>
          <option value="/mobile/mypage/annc/annc2.do?menu=menu6">전자금융거래약관</option>
          <option value="/mobile/mypage/annc/annc3.do?menu=menu6">개인정보수집</option>
          <option value="/mobile/mypage/annc/annc4.do?menu=menu6">이메일수집</option>
          </select>
          </span>
          <span class="sm_btn"><a href="javascript:;"><img src="/images/mobile/sub_2/sub_menu_a.gif" alt="상세조건 검색버튼" onclick = "go_url();"></a></span>
        </div>
      </div>

<div class="sub_wrap">
  <div class="sub_line">
    <h3><img src="/images/mobile/sub_2/sub_2_title_9_4.gif" alt="이메일수집"></h3>
    <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
  </div>
  <div class="section" style="padding:15px 0 0 0;">
      <p class="first"><strong>안녕하세요. &lt;파츠모아&gt;입니다.</strong></p>
      <p>2015년 04월 15일부터 파츠모아 쇼핑몰 사이트에 게시된 전자우편(e-mail)주소를 전자우편 수집 프로그램이나 그 밖의 기술적 장치를 이용하여 무단으로 수집하는 것을 거부하며, 이를 위반 시 정보통신망이용 촉진 및 정보보호 등에 관한 법률(＇이하＇ 정보통신망법)에 의해 형사 처벌됨을 유념하시기 바랍니다.</p>
      <p>* 정보통신망법 제50조의 2 (전자우편주소의 무단 수집행위 등 금지)</p>
      <ol>
        <li>① 누구든지 전자우편주소의 수집을 거부하는 의사가 명시된 인터넷 홈페이지에서 자동으로 전자우편주소를 수집하는 프로그램 그 밖의 기술적 장치를 이용하여 전자우편주소를 수집하여서는 아니 된다.</li>
        <li>② 누구든지 제1항의 규정을 위반하여 수집된 전자우편주소를 판매•유통하여서는 아니 된다.</li>
        <li>③ 누구든지 제1항 및 제2항의 규정에 의하여 수집•판매 및 유통이 금지된 전자우편주소임을 알고 이를 정보전송에 이용하여서는 아니 된다.</li>
      </ol>
      <p><span class="c1">☞ 위반 시 1천만 원 이하의 벌금</span></p>
      <p>감사합니다.</p>
    </div>
</div>