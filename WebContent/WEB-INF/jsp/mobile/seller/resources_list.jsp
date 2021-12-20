<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>주문현황</title>
<script type="text/javascript">
var param = {board_seq : "7",group_code : "2",order : "Y"};
var groupListParams = "${param.cate_seq}";
$(document).ready(function(){
	$.getJSON("/json/list/article.categoryList.do", param, function(data){
		var groupList = data;
		$.each(groupList, function(i, o){
			var selectYN = "";
			if(groupListParams == o.cate_seq){
				selectYN = "selected='selected'";
			}
			$("#cate_seq").append("<option value='"+o.cate_seq+"' "+selectYN+">"+o.subject+"</option>");
		});
	});
<c:if test="${sessionScope.member.group_seq eq '8' or sessionScope.member.group_seq eq '1'}">
	var cooperationParams = "${param.keyword}";
	$.getJSON("/json/list/seller.all_cooperation.do", "", function(data){
		var cooperationList = data;
		$.each(cooperationList, function(i, o){
			var selectYN = "";
			if(cooperationParams == o.seq){
				selectYN = "selected='selected'";
			}
			$("#keyword").append("<option value='"+o.seq+"' "+selectYN+">"+o.com_nm+"</option>");
		});
	});
</c:if>
});

function returnString(info){
	var infoArray = info.split("|+|");
	var returnValue = "";
	$(infoArray).each(function(i,v){
		if(i != 0){
			var array = v.split("|,|");
			returnValue += "<p><strong>"+array[0]+"</strong> : "+array[3].replace("kg","<strong>kg</strong>")+"</p>";
		}
	});
	document.write(returnValue);
}
</script>
</head>
<body>
	<div class="product_tab">
        <ul>
          <li><a href="seller_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab1_off.gif" alt="상품관리"></a></li>
          <li><a href="product_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab2_off.gif" alt="주문현황"></a></li>
          <li><a href="resources_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab3_on.gif" alt="자원관리"></a></li>
          <li><a href="selfcamera_list.do?menu=menu8"><img src="/images/mobile/sub/product_tab4_off.gif" alt="셀카현황"></a></li>
        </ul>
      </div>

      <div class="sub_wrap">
        <div class="sub_line">
          <h3><img src="/images/mobile/sub/sub_title_b_6.gif" alt="자원관리"></h3>
          <p><a href="tel:1544-6444"><img src="/images/mobile/sub/counsel.gif" alt="파츠모아 고객상담센터 1544-6444"></a></p>
        </div>
        <form name="f" method="post" action="resources_list.do">
        <input type="hidden" name="user" value="Y">
        <div class="r_s_box">
        	<c:if test="${sessionScope.member.group_seq eq '8' or sessionScope.member.group_seq eq '1'}">
        	<div>
				<span class="title">업체선택</span>
				<span class="r_s">
					<select id="keyword" name="keyword" class="select_1">
						<option value="">전체</option>
					</select>
				</span>
			</div>
			</c:if>
			<div>
				<span class="title">자원선택</span>
				<span class="r_s">
					<select id="cate_seq" name="cate_seq" class="select_1">
						<option value="">전체</option>
					</select>
				</span>
			</div>
			<div>
				<span class="title">조건선택</span>
				<span class="r_s">
					<select name="status" class="select_1">
						<option value="">전체</option>
						<option value="0" <c:if test="${param.status == '0' }">selected="selected"</c:if>>반출요청</option>
						<option value="1" <c:if test="${param.status == '1' }">selected="selected"</c:if>>반출진행</option>
						<option value="2" <c:if test="${param.status == '2' }">selected="selected"</c:if>>반출완료</option>
					</select>
				</span>
			</div>
		</div>
		<div class= "r_btn_type">
		<a href="javascript:document.f.submit();"><img src="/images/mobile/sub/r_search.gif" alt="검색"></a>
		</div>
		</form>
        <table class="r_style_1">
        <colgroup>
        <col width="22%">
        <col width="22%">
        <col width="22%">
        <col width="17%">
        <col width="17%">
        </colgroup>
        <thead>
        <tr>
          <th colspan="3">자원현황</th>
          <th rowspan="2">상태</th>
          <th rowspan="2">수정</th>
        </tr>
        <tr>
          <th>반출<br>희망일자</th>
          <th>반출<br>완료일자</th>
          <th>첨부파일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${data.list }" varStatus="status">
        <tr>
          <td colspan="3" class="r_main">
          	<c:if test="${sessionScope.member.group_seq eq '8' or sessionScope.member.group_seq eq '1'}">
          	<b>업체명 : <font color="blue">${item.com_nm }</font></b>
          	</c:if>
				<script type="text/javascript">
					returnString('${item.item_info}');				
				</script>
          </td>
          <td rowspan="2">${item.status == 0 ? '반출요청' : item.status == 1 ? '반출진행' : '반출완료'}</td>
          <td rowspan="2"><a href="resources_modify.do?board_seq=7&article_seq=${item.article_seq }"><img src="/images/mobile/sub_2/btn_type_d3.gif" alt="수정"></a></td>
        </tr>
        <tr>
          <td>${item.sdate }</td>
          <td>${item.edate }</td>
          <td>
          <c:forEach var="items" items="${data.filelist[status.count-1]}" varStatus="status">
          	<a href="/download.do?uuid=${items.uuid }">${items.attach_nm }</a><br/>
          </c:forEach>
          </td>
        </tr>
		</c:forEach>
        </tbody>
        </table>
        
        <div class="vr_btn">
			<a href="resources_insert.do?menu=menu8"><img src="/images/mobile/sub/btn_register.gif" alt="등록"></a>
		</div>
		
        <jsp:include page="/inc/paging2.do">
			<jsp:param  name="cpage" value="${param.cpage }"/>
			<jsp:param  name="rows" value="${param.rows }"/>
			<jsp:param  name="totalpage" value="${data.pageinfo.totalpage }"/>
		</jsp:include>
      </div>
</body>
</html>