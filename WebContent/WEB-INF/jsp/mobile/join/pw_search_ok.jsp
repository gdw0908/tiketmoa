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

	  <div class="pw_last">

          <div class="licensee_3">
			<c:choose>
          		<c:when test = "${not empty article }">
		            <dl class="type_2">
		            <dt>성공적으로 비밀번호가 발급되었습니다.</dt>
		            <dd><span class="standard">아이디</span><span>: ${article.member_id }</span></dd>
		            <dd>
		            <span class="standard">비밀번호<br>확인</span>
		            <c:choose>
		            	<c:when test = "${not empty article.busi_nm }">
		            	 <span>: 회원정보 이메일 (${article.email })</span>
		            	</c:when>
		            	<c:otherwise>
		            	 <span>: 회원정보 휴대폰 (${article.cell })</span>
		            	</c:otherwise>
		            </c:choose>
		            </dd>
		            </dl>
				</c:when>
				<c:otherwise>
          			<dl class="type_2">
		            <dt>일치하는 회원 정보가 없습니다.</dt>
		            </dl>
          		</c:otherwise>
          	</c:choose>
			<div class="btn_bottom">
			<a href="/"><img class="btn" src="/images/join/join4_btn_1.gif" alt=""></a>
			<a href="/mobile/login/login.do?mode=mlogin"><img class="btn" src="/images/join/join4_btn_2.gif" alt=""></a>
			</div>

          </div>

          <div class="b_gui_2">
            <p><strong>위의 방법으로도 찾지 못했다면, 파츠모아쇼핑몰 고객센터로 문의주십시오</strong><br>
            고객센터 전화문의 : 1566-6444 (상담가능시간: 평일 오전 9시~오후 6시)</p>
          </div>

        </div>

    </div>
  </div>
</body>
</html>
