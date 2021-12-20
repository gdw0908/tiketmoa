<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

var check = 0;

function getDeps2List(seq, count, order)
{
	for(var i = 1 ; i <= count ; i ++)
	{
		if(i == order)
		{
			jQuery("#dep1_" + i + " > a").addClass("on");
		}
		else
		{
			jQuery("#dep1_" + i + " > a").removeClass("on");
		}
	}
	
	
	getJSON("/json/list/category.getDeps2List.do",{"seq":"0" + seq},function(data){
		$("body").data("getDeps2List",data);
		var getDeps2List = $("body").data("getDeps2List");
		addDeps2List(getDeps2List, "codeno", "codenm", $("#getDeps2List"), '', "count", "rowseq");	
	});
	
}

function addDeps2List(array, codeno, codenm, obj, defaultValue, count, rowseq){
	var html = "";
	$.each(array, function(){
		obj.empty();
		html += "<li id = 'dep2_" + this[rowseq] + "'>";
		html += "<a onclick = 'getDeps3List(" + this[codeno]+ ", " + this[rowseq] + ", " + this[count] + ");'>" + this[codenm] + "</a>";
		html += "</li>";
	});
	obj.append(html);
}

function getDeps3List(seq, order , count)
{
	for(var i = 1 ; i <= count ; i ++)
	{
		if(i == order)
		{
			jQuery("#dep2_" + i + " > a").addClass("on");
		}
		else
		{
			jQuery("#dep2_" + i + " > a").removeClass("on");
		}
	}
	
	getJSON("/json/list/category.getDeps3List.do",{"seq":"0" + seq},function(data){
		
		$("body").data("getDeps3List",data);
		var getDeps3List = $("body").data("getDeps3List");
		addDeps3List(getDeps3List, "carpartseq", "partnm", $("#getDeps3List"), '', "count", "rowseq");	
	});

	check  = 1;
}

function addDeps3List(array, carpartseq, partnm, obj, defaultValue, count, rowseq){
	
	
	var html = "";
	$.each(array, function(){
		obj.empty();
		html += "<li id = 'dep3_" + this[rowseq] + "'>";
		html += "<label>";
		html += "<input type = 'checkbox' id = 'service' name = 'service' value = '" + this[carpartseq] + "'/>" + this[partnm];
		html += "</label>";
		html += "</li>";
		
		/*  <li><a href=""class="on"><label><input type="checkbox" id="" name="" />라지에이터그릴</label></a></li>*/
	});

	obj.append(html);
	
}

function go_insert()
{
	var url = "";
	if(check == 0)
	{
		alert("부품 선택 후 등록이 가능합니다.");
		return;
	}
	else
	{
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
			
			location.replace("${servletPath}?method=insert&seq=" + url.substring(0, url.length -1));
		}
	}
}

function all_select()
{
	$("input[name=adservice]:checkbox").each(function() {
		$(this).prop("checked", true);
	});	
}

function all_diselect()
{
	$("input[name=adservice]:checkbox").each(function() {
		$(this).prop("checked", false);
	});	
}

function go_delete()
{
	var url = "";
	
	if( $(":checkbox[name='adservice']:checked").length == 0 )
	{
	    alert("최소 한개 이상은 선택해야합니다.");
	    return;
	}
	else
	{
		$("input[name=adservice]:checked").each(function() {

			url += $(this).val() + ",";
			
		});
		
		location.replace("${servletPath}?method=delete&seq=" + url.substring(0, url.length -1));
	}
}

</script>
</head>
<body>
<div id="main">
  <div class="titlebar">
    <h2>자주찾는서비스</h2>
    <div> <span>통합관리</span> &gt; <span>상품관리</span> &gt; <span>상품목록</span> &gt;<span class="bar_tx">자주찾는서비스</span> </div>
  </div>
  <div class="container"> 
     <div class="tab_menu">
      <ul class="tab">
        <li class="on"><a href="/admin/goods/inventory/inventory_md_1.do">자주찾는서비스</a></li>
        <li><a href="/admin/goods/inventory/inventory_md_2.do">MD상품관리</a></li>
      </ul>
    </div> 
    <div class="contents">
      <div class="search_boxlist_wrap">
        <div class="search_boxlist s1">
          <h4>부품분류</h4>
          <ul>
          	<!-- <li><a href="" class="on">현대</a></li>  -->
          	<c:forEach items="${deps1List }" var="deps1List">
          		<li id = "dep1_${deps1List.rowseq}"><a href="javascript:;" onclick = "getDeps2List(${deps1List.codeno}, ${deps1List.count }, ${deps1List.rowseq });">${deps1List.codenm }</a></li>
          	</c:forEach>
          </ul>
        </div>
        <div class="search_boxlist s2">
          <h4>부품종류</h4>
          <ul id = "getDeps2List"></ul>
        </div>
        <div class="search_boxlist s5">
          <h4>부품</h4>
          <ul id = "getDeps3List"></ul>
          
        </div>
        
      </div>
      
      <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span>
          <input type="button" value="선택등록" onclick="go_insert();" class="btall"/>
          </span></span> 
        </div>
      </div>
      <table class="style_1" style="margin-top:15px;">
        <colgroup>
          <col width="10%" />
          <col width="*" />
        </colgroup>
        <tr>
          <th>자주찾는서비스</th>
          <td class="chbox1">
            <div >
               <c:forEach items="${serviceList }" var="serviceList">
                <label><input type="checkbox" id="adservice" name="adservice" value = "${serviceList.carpartseq }"/>${serviceList.partnm }</label>
             </c:forEach>
            </div>
          </td>
        </tr>
      </table>
      <div class="btn_bottom">
        <div class="r_btn">
          <span class="bt_all"><span><input type="button" value="전체선택" onclick="all_select();" class="btall"/></span></span> 
          <span class="bt_all"><span><input type="button" value="선택취소" onclick="all_diselect();" class="btall"/></span></span> 
          <span class="bt_all"><span><input type="button" value="선택삭제" onclick="go_delete();" class="btall"/></span></span> 
        </div>
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

</script>

</body>
</html>
