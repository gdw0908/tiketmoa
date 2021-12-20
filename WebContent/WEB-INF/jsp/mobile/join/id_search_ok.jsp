<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<div class="wrap">
    <div class="j_wrap">

      <div class="j_visual"><img src="/images/mobile/join/jm_img1.gif" alt="국내최대 자동차 중고부품 쇼핑몰 PARTS MOA에 오신 것을 환영합니다"></div>

      <div class="join_tab">
        <a href="http://mediacore2.kr/partsmoa/mobile/join/id_search_a1.html"><img src="/images/mobile/join/se_tab1_on.gif" alt="개인회원 아이디찾기"></a>
        <a href="http://mediacore2.kr/partsmoa/mobile/join/id_search_a2.html"><img src="/images/mobile/join/se_tab2_off.gif" alt="사업자회원 아이디찾기"></a>
      </div>

	  <div class="licensee_3">

            <dl class="type_2">
      <c:choose>
     	<c:when test = "${not empty article.member_nm }">
            <dt>찾으시는 아이디는 다음과 같습니다.</dt>
            <dd><span class="standard">아이디</span><span>: ${fn:substring(article.member_id, 0 , 2) }****</span></dd>
            <dd>
            <span class="standard">등록일</span>
            <span>: ${fn:substring(article.reg_dt, 0, 4)}년 ${fn:substring(article.reg_dt, 5, 7)}월 ${fn:substring(article.reg_dt, 8, 10)}일</span>
            </dd>
			</c:when>
            	<c:otherwise>
            		<dt>해당 정보가 없습니다.</dt>
            	</c:otherwise>
            </c:choose>
            </dl>

			<div class="btn_bottom">
			<a href="/mobile/"><img class="btn" src="/images/join/join4_btn_1.gif" alt=""></a>
			<a href="/mobile/login/login.do?mode=mlogin"><img class="btn" src="/images/join/join4_btn_2.gif" alt=""></a>
			</div>

          </div>

      <div class="b_gui_2 t_style">
        <p class="gui_l"><span class="text">아직 파츠모아 회원이 아니세요?</span><span class="gui_btn"><a href="#"><img class="btn" src="/images/join/btn_join.gif" alt=""></a></span></p>
      </div>

	  <div class="b_gui_2 t_style">
        <p class="gui_l"><span class="text">아직 파츠모아 회원이 아니세요?</span><span class="gui_btn"><a href="#"><img class="btn" src="/images/join/btn_pw_search.gif" alt=""></a></span></p>
      </div>

    </div>
  </div>
</body>
</html>
