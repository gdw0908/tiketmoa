<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>재제조</title>
<script type="text/javascript">
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
</head>
<body>
<div class="sm_wrap">
  <div class="sm_top"> <span class="select_box s_menu_type">
    <select id="url" name="url" class="select_sm">
		<option value="">메뉴를 선택해 주세요</option>
				<option value="/mobile/goods/contents_list.do?menu=menu9&part2=050901006003"<c:if test="${param.part2 == '050901006003'}"> selected="selected"</c:if>>알터네이터</option>
				<option value="/mobile/goods/contents_list.do?menu=menu9&part2=050901006001"<c:if test="${param.part2 == '050901006001'}"> selected="selected"</c:if>>A/C 콤프레서</option>
				<option value="/mobile/goods/contents_list.do?menu=menu9&part2=050901006002"<c:if test="${param.part2 == '050901006002'}"> selected="selected"</c:if>>스타트모터</option>
    </select>
    </span> <span class="sm_btn"><a href="javascript:;"><img src="/images/mobile/sub_2/sub_menu_a_1.gif" alt="메뉴이동" onclick = "go_url();"></a></span> </div>
</div>
	
      <div class="sub_wrap">
        <div class="sub_line">
        	<c:if test="${param.part2 == '050901006003'}">
            <h3><img src="/images/mobile/sub/sub_title_10_1.gif" alt="알터네이터"></h3>
            </c:if>
            <c:if test="${param.part2 == '050901006001'}">
            <h3><img src="/images/mobile/sub/sub_title_10_2.gif" alt="A/C콤프레서"></h3>
            </c:if>
            <c:if test="${param.part2 == '050901006002'}">
            <h3><img src="/images/mobile/sub/sub_title_10_3.gif" alt="스타트모터"></h3>
            </c:if>
          	<p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>
        
        <div class="sub_contents_img">
        	<c:if test="${param.part2 == '050901006003'}">
      		<p><img src="/images/sub/contents_img_01.gif" alt="알터네이터 문의"></p>
      		</c:if>
      		<c:if test="${param.part2 == '050901006001'}">
      		<p><img src="/images/sub/contents_img_02.gif" alt="A/C콤프레서 문의"></p>
      		</c:if>
      		<c:if test="${param.part2 == '050901006002'}">
      		<p><img src="/images/sub/contents_img_03.gif" alt="스타트모터 문의"></p>
      		</c:if>
      	</div>
	</div>
</body>
</html>
