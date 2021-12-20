<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div id="sub">
  <div class="strapline">
		<h3><img src="/images/sub_2/h3_img_3.gif" alt="카올바로"></h3>
		<div class="state"> <span>홈</span> &gt; <span>고객센터</span> &gt; <span><strong>카올바로</strong></span></div>
	</div>
  <div class="contents">
    <div class="write_top">
      <h4>카올바로</h4>
      <p><strong>PARTSMOA</strong> 카올바로에 즉시신청/견적요청을 등록하시면 빠른 시일내에 답변 드리겠습니다.</p>
    </div>
    <form name="wFrm" id="wFrm" action="${servletPath }" method="post">
      <input type="hidden" name="seq" value="${params.seq }"/>
      <table class="write_style_1">
        <colgroup>
        <col width="20%">
        <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th scope="row">비밀번호</th>
            <td><input type="password" id="pass" name="pass" class="input_3" value=""/></td>
          </tr>
        </tbody>
      </table>
      <div class="vr_btn"> <input type="image" src="/images/sub_2/d_btn_4.gif" alt="확인"> <a href="quotation_list.do?cpage=${params.cpage }&amp;rows=${params.rows }&amp;condition=${params.condition }&amp;keyword=${params.keyword }"><img src="/images/article/board_btn5.gif" alt="입력취소"></a> </div>
    </form>
  </div>
</div>
