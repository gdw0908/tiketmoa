<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>파츠모아 통합관리 시스템</title>
<link href="/lib/css/cmsbase.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/cmsadmin.css" rel="stylesheet" type="text/css" />
<link href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/lib/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/lib/js/mc1.js"></script>

<script type = "text/javascript">

function goPage(cpage){
	var f = document.searchForm;
	f.method.value = "list";
	f.cpage.value = cpage;
	f.submit();
	return false;
}

function all_select()
{
	$("input[name=service]:checkbox").each(function() {
		$(this).prop("checked", true);
	});	
}

function all_diselect()
{
	$("input[name=service]:checkbox").each(function() {
		$(this).prop("checked", false);
	});	
}

function go_delete()
{
	var url = "";
	
	if( $(":checkbox[name='service']:checked").length == 0 )
	{
	    alert("최소 한개 이상은 선택해야합니다.");
	    return;
	}
	else
	{
		$("input[name=service]:checked").each(function() {

			url += $(this).val() + ",";
			
		});
		
		//alert("${servletPath}?method=delete&seq=" + url.substring(0, url.length -1));
		location.replace("${servletPath}?method=delete&seq=" + url.substring(0, url.length -1));
	}
}

function search_form_close()
{
	location.replace("${servletPath}");
}

function go_insert()
{
	var url = "";
	
	if( $(":checkbox[name='adService']:checked").length == 0 )
	{
	    alert("최소 한개 이상은 선택해야합니다.");
	    return;
	}
	else
	{
		$("input[name=adService]:checked").each(function() {
			
			url += $(this).val() + ",";
		});

		location.replace("${servletPath}?method=insert&seq=" + url.substring(0, url.length -1));
	}
}

var sw = 0;
function all_aDselect()
{
	if(sw == 0)
	{
		$("input[name=adService]:checkbox").each(function() {
			$(this).prop("checked", true);
		});
		
		sw = 1;
	}
	else
	{
		$("input[name=adService]:checkbox").each(function() {
			$(this).prop("checked", false);
		});
		
		sw = 0;
	}
	
	sw = 1;
	
}

var GlobalCarmkerSeq = "";

function getCarmodel(carmakerseq, subject)
{
	GlobalCarmkerSeq = carmakerseq;
	getJSON("/json/list/old_code.carmodel.do",{"carmakerseq" : carmakerseq},function(data){
		$("body").data("carmodel",data);
		var carmodel = $("body").data("carmodel");
		md_addOptions(carmodel, "carmodelseq", "carmodelnm", $("#carmodel"), '${params.carmodelseq }', subject);	
	});
}

function getCargrade(carmodelseq, subject)
{
	getJSON("/json/list/old_code.cargrade.do",{"carmodelseq" : carmodelseq, "carmakerseq" : GlobalCarmkerSeq},function(data){
		$("body").data("cargrade",data);
		var cargrade = $("body").data("cargrade");
		md_addOptions(cargrade, "cargradeseq", "cargradenm", $("#cargrade"), '${params.cargradeseq }', subject);	
	});
}

function getPart2List(seq, subject)
{
	getJSON("/json/list/category.getDeps2List.do",{"seq" : seq},function(data){
		$("body").data("getDeps2List",data);
		var getDeps2List = $("body").data("getDeps2List");
		md_addOptions(getDeps2List, "codeno", "codenm", $("#part2"), '${params.codeno }', subject);	
	});
}

function getDeps3List(seq, subject)
{
	getJSON("/json/list/category.getDeps3List.do",{"seq": seq},function(data){
		$("body").data("getDeps3List",data);
		var getDeps3List = $("body").data("getDeps3List");
		md_addOptions(getDeps3List, "carpartseq", "partnm", $("#part3"), '${params.carpartseq }', subject);	
	});
}

function md_addOptions(array, value, text, obj, defaultValue, subject){
	var html = "";
	html += "<option value = ''>" + subject + " 선택</option>";
	$.each(array, function(){
		obj.empty();
		html += "<option value='" + this[value] + "' ";
		if(this[value] == defaultValue)
			html += "selected='selected'";
		html += ">" + this[text] + "</option>";
	});
	
	obj.append(html);
}
</script>
</head>
<body>
<div id="main">
  <div class="titlebar">
    <h2>MD상품관리</h2>
    <div> <span>통합관리</span> &gt; <span>상품관리</span> &gt; <span>상품목록</span> &gt;<span class="bar_tx">MD상품관리</span> </div>
  </div>
  <div class="container"> 
    <div class="tab_menu">
      <ul class="tab">
        <li><a href="/admin/goods/inventory/inventory_md_1.do">자주찾는서비스</a></li>
        <li class="on"><a href="/admin/goods/inventory/inventory_md_2.do">MD상품관리</a></li>
      </ul>
    </div> 
    <div class="contents">
      <div class="md2">
        <ul>
        <c:forEach items="${goodsList }" var="goodsList">
          <li>
          	<div class="md2pic">
              <p class="md2picimg"><img src="${goodsList.thumb }" alt="${goodsList.productnm }" /></p>
              <p class="md2picch"><input type="checkbox" name="service" id="service" value = "${goodsList.item_seq }"/></p>
            </div>
            <p class="mdname">${goodsList.productnm }</p>
            <p class="mdsupply">공급사명 : ${goodsList.com_nm }</p>
            <p class="mdsupply" style="font-weight: bold; color: red;">수량 :${goodsList.stock_num }</p>
          </li>
           </c:forEach>
        </ul>
      </div>
      <div class="btn_bottom" style="margin-top: 45px;">
        <div class="l_btn">
          <span class="bt_all"><span><input type="button" value="전체선택" onclick="all_select();" class="btall"/></span></span> 
          <span class="bt_all"><span><input type="button" value="선택취소" onclick="all_diselect();" class="btall"/></span></span>
          <span class="bt_all"><span><input type="button" value="선택삭제" onclick="go_delete();" class="btall"/></span></span> 
          <a href="#" id="dialog-link" ><span class="bt_all"><span><input type="button" value="등록" onclick="" class="btall"/></span></span> </a>
        </div>
      </div>
     
      <!-- 부품 검색모달팝업 -->
        <div id="dialog" title="부품검색" >
         <form name="searchForm" action="${servletPath }" onsubmit="return goPage(1);" method = "post">
				<input type="hidden" name="cpage" value="${params.cpage }" />
				<input type="hidden" name="method" value="list" />
				<input type = "hidden" name = "rows" value = "${params.rows }"/>
				<input type = "hidden" name = "read" value = "true"/>
          <div class="seldiv">
            <select title="제조사 선택" name = "carmakerseq" id = "carmaker" onchange = "getCarmodel(this.value, '제조사');">
            	<option value = "">제조사 선택</option>
             <c:forEach items="${goodsSearchCarmaker }" var="goodsSearchCarmaker">
             	
            	<option value = "${goodsSearchCarmaker.carmakerseq }" <c:if test = "${params.carmakerseq eq goodsSearchCarmaker.carmakerseq }">selected</c:if>>${goodsSearchCarmaker.makernm }</option>
            </c:forEach>
            
            </select>
            <select title="차량 선택" name = "carmodelseq" id = "carmodel" onchange = "getCargrade(this.value, '차량');">
            	<option value = "">차량 선택</option>
            </select>
            <select title="모델명 선택" name = "cargradeseq" id = "cargrade" onchange = "getCargrade(this.value, '모델명');">
            	<option value = "">모델명 선택</option>
            </select>
            <select title="연식 선택" name = "caryyyy" id = "caryyyy">
            	<option value = "">연식 선택</option>
            	<c:forEach var="i" begin="1" end="10" step="1">
			  <option value='<c:out value="${i }"/>' <c:if test = "${params.caryyyy eq i }">selected</c:if>>
			  <c:out value="${i }"/></option>
			 </c:forEach>
            </select>
            <select title="색상 선택" name = "color" id = "color">
            	<option value = "">색상 선택</option>
                 <option value = "화이트(흰색)" <c:if test = "${params.color eq '화이트(흰색)' }">selected</c:if>>화이트(흰색)</option>
                 <option value = "블랙(검정색)" <c:if test = "${params.color eq '블랙(검정색)' }">selected</c:if>>블랙(검정색)</option>
                 <option value = "그레이계열" <c:if test = "${params.color eq '그레이계열' }">selected</c:if>>그레이계열</option>
                 <option value = "노란색계열" <c:if test = "${params.color eq '노란색계열' }">selected</c:if>>노란색계열</option>
                 <option value = "파란색계열" <c:if test = "${params.color eq '파란색계열' }">selected</c:if>>파란색계열</option>
                 <option value = "기타색상" <c:if test = "${params.color eq '기타색상' }">selected</c:if>>기타색상</option>
                 <option value = "레드(빨간색계열)" <c:if test = "${params.color eq '레드(빨간색계열)' }">selected</c:if>>레드(빨간색계열)</option>
                 <option value = "초록색계열" <c:if test = "${params.color eq '초록색계열' }">selected</c:if>>초록색계열</option>
                 <option value = "실버" <c:if test = "${params.color eq '실버' }">selected</c:if>>실버</option>
                 <option value = "골드" <c:if test = "${params.color eq '골드'}">selected</c:if>>골드</option>
            </select>
            <select title="등급 선택" name = "grade" id = "grade">
                 <option value = "">등급 선택</option>
                 <option value = "A" <c:if test = "${params.grade eq 'A'}">selected</c:if>>A등급</option>
                 <option value = "B" <c:if test = "${params.grade eq 'B'}">selected</c:if>>B등급</option>
                 <option value = "C" <c:if test = "${params.grade eq 'C'}">selected</c:if>>C등급</option>
            </select>
            <select title="부품 대분류 선택" name = "part1" id = "part1" onchange = "getPart2List(this.value);">
            	<option value = "">부품 대분류 선택</option>
                 <c:forEach items="${goodsSearchcodemst }" var="goodsSearchcodemst">
            	<option value = "${goodsSearchcodemst.code }" <c:if test = "${params.part1 eq goodsSearchcodemst.code}">selected</c:if>>${goodsSearchcodemst.code_nm }</option>
            </c:forEach>
                 
            </select>
            <select title="부품 소분류 선택" name = "part2" id = "part2" onchange = "getDeps3List(this.value);">
            <option value = "">부품 소분류 선택</option>
            </select>
            <select title="상세부품명 선택" name = "part3" id = "part3">
            <option value = "">상세부품명 선택</option>
            </select>
          </div>
          <!-- <div>상품코드검색<input type = "text" name = "item_code" value = "" id = "item_code" class="input_1" /></div> -->
          <table class="style_1">
            <colgroup>
              <col width="20%" />
              <col width="*" />
            </colgroup>
            <tr>
              <th>상품코드검색</th>
              <td><input type = "text" name = "item_code" value = "" id = "item_code" class="input_1" style="width: 75%;"/></td>
            </tr>
          </table>
          <div class="btn_bottom">
            <div class="r_btn">
             <span><input type = "image" src = "/images/admin/contents/pop_search.gif"></span>
            </div> 
          </div>
          <div>
	          <table class="style_3" style="table-layout: fixed;">
	            <colgroup>
	              <col width="5%" />
	              <col width="6%" />
	              <col width="13%" />
	              <col width="8%" />
	              <col width="6%" />
	              <col width="5%" />
	              <col width="5%" />
	              <col width="6%" />
	              <col width="15%" />
	              <col width="*%" />
	            </colgroup>
	            <tr>
	              <th><input type="checkbox" id="ServiceAll" name="ServiceAll"  onclick = "all_aDselect();"/></th>
	              <th>제조사</th>
	              <th>차량명</th>
	              <th>모델명</th>
	              <th>연식</th>
	              <th>색상</th>
	              <th>등급</th>
	              <th>부품<br/><span style="font-weight:normal;">(대분류)</span></th>
	              <th>부품<br/><span style="font-weight:normal;">(소분류)</span></th>
	              <th>상세부품명</th>
	            </tr>
	            <c:forEach items="${goodsSearchList }" var="goodsSearchList">
	            <tr>
	              <td><input type="checkbox" id="adService" name="adService" value = "${goodsSearchList.item_seq }"/></td>
	              <td>${goodsSearchList.makernm }</td>
	              <td>${goodsSearchList.carmodelnm }</td>
	              <td>${goodsSearchList.cargradenm }</td>
	              <td>${goodsSearchList.caryyyy }</td>
	              <td>${goodsSearchList.color_nm }</td>
	              <td>${goodsSearchList.grade }</td>
	              <td>${goodsSearchList.part1_nm }</td>
	              <td>${goodsSearchList.part2_nm }</td>
	              <td>${goodsSearchList.part3_nm }</td>
	            </tr>
	            </c:forEach>
	          </table>
	          
	          
	       </div>   
           <div class="btn_bottom">
           <jsp:include page="/WEB-INF/jsp/paging.jsp" />
            <div class="r_btn"> 
              <span class="bt_all"><span>
              <input type="button" value="선택등록" onclick="go_insert();" class="btall"/>
              </span></span> 
              <span class="bt_all"><span>
              <input type="button" value="닫기" onclick="search_form_close();" class="btall"/>
              </span></span> 
           </div>
          </div>
          </form>
        </div>
      
    </div>
  </div>
</div>
<script type="text/javascript" src="/lib/js/jquery-1.10.2.min.js"></script> 
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script> 
<script>
$("input.date").datepicker({
		showOn: "button",      
		buttonImage: "/images/admin/contents/calendar.png",
});

$( "#tabs" ).tabs();
$( "#dialog" ).dialog({
	autoOpen: false,
	width: 800,
});

// Link to open the dialog
$( "#dialog-link" ).click(function( event ) {
	$( "#dialog" ).dialog( "open" );
	event.preventDefault();
});

$( "#dialog2" ).dialog({
	autoOpen: false,
	width: 650,
});

// Link to open the dialog
$( "#dialog-link2" ).click(function( event ) {
	$( "#dialog2" ).dialog( "open" );
	event.preventDefault();
});

jQuery(document).ready(function(){
	
	if("${params.read}")
	{
		$( "#dialog" ).dialog( "open" );
	}
	else
	{
		$( "#dialog" ).dialog( "close" );
	}
});

</script>
</body>
</html>
