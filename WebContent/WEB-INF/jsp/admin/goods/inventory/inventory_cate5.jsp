<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.form.js"></script>
<script type="text/javascript" src="/lib/js/mc1.js"></script>
<script type = "text/javascript">




function goBody(target_url){
	location.href = target_url;
	location.target = "_blank";
}

function goPage(cpage){
	var f = document.partsInfoSearchForm;
	f.method.value = "list";
	f.cpage.value = cpage;
	f.submit();
	return false;
}

function go_delete(seq)
{
	if(seq == "" || seq == null)
	{
		alert("삭제할 대상이 없습니다.");
		return;
	}
	else
	{
		if(confirm("삭제하시겠습니까?")) location.replace("${servletPath}?method=delete&cpage=${params.cpage}&rows=${params.rows}&parttyp=${params.parttyp }&sellinfo=${params.sellinfo }&delyn=${params.delyn }&keyword=${params.keyword }&seq="+seq);
	}
}

function go_update()
{
	if(confirm("수정하시겠습니까?")) jQuery("form[name='carPartsInfoModify']").submit();
	
}

function showCarNameList(seq, defaultValue)
{
	getJSON("/json/list/category.getCarPartsSubList.do",{"seq":seq},function(data){
		$("body").data("carparts_list",data);
		var carparts_list = $("body").data("carparts_list");
		addOptions(carparts_list, "codeno", "codenm", $("#mkind"), defaultValue);	
	});
	
}

function showCarNameList1(seq, defaultValue)
{
	getJSON("/json/list/category.getCarPartsSubList.do",{"seq":seq},function(data){
		$("body").data("carparts_list",data);
		var carparts_list = $("body").data("carparts_list");
		addOptions(carparts_list, "carpartseq", "codenm", $("#mkind1"), defaultValue);	
	});
	
}

function getShopCodeSubList(seq)
{
	getJSON("/json/list/category.getShopCodeSubList.do",{"seq":seq},function(data){
		$("body").data("shopCodeSubList",data);
		var shopCodeSubList = $("body").data("shopCodeSubList");
		addOptions(shopCodeSubList, "codeno", "codenm", $("#partkind"), '');	
	});
	
}

function getShopCodeSubList1(seq)
{
	getJSON("/json/list/category.getShopCodeSubList.do",{"seq":seq},function(data){
		$("body").data("shopCodeSubList",data);
		var shopCodeSubList = $("body").data("shopCodeSubList");
		addOptions(shopCodeSubList, "codeno", "codenm", $("#partkind1"), '');	
	});
	
}

function getUpPartsNameList()
{
	if(jQuery('#keyword1').val() == "")
	{
		alert("부품명을 입력하세요.");
		jQuery('#keyword1').focus();
		return;
	}
	else
	{
		getJSON("/json/list/category.getUpPartsNameList.do",{"seq":jQuery('#keyword1').val(), "cpage" : "${params.cpage}", "rows" : "${params.rows}"},function(data){
			$("body").data("upPartsNameList",data);
			var upPartsNameList = $("body").data("upPartsNameList");
			addList(upPartsNameList, "carpart", "partnm", $("#upPartsNameList"), '');	
		});
	}
}

function uppartReset()
{
	jQuery("#uppart").val("");
	jQuery("#keyword1").val("");
}


</script>
</head>

<body>
<div id="main">
  <div class="titlebar">
    <h2>카테고리관리</h2>
    <div> <span>통합관리</span> &gt; <span>상품관리</span> &gt; <span>상품목록</span> &gt;<span class="bar_tx">카테고리관리</span> </div>
  </div>
  <div class="container"> 
    <div class="tab_menu">
      <ul class="tab">
        <li><a href="javascript:;" onclick = "goBody('/admin/goods/inventory/inventory_cate.do?codeno=0509');">공통코드</a></li>
        <li><a href="javascript:;" onclick = "goBody('/admin/goods/inventory/inventory_cate2.do');">제조사</a></li>
        <li><a href="javascript:;" onclick = "goBody('/admin/goods/inventory/inventory_cate3.do');">차량명</a></li>
        <li><a href="javascript:;" onclick = "goBody('/admin/goods/inventory/inventory_cate4.do');">차량모델명</a></li>
        <li class="on"><a href="javascript:;" onclick = "goBody('/admin/goods/inventory/inventory_cate5.do');">부품정보</a></li>
      </ul>
    </div>
    <div class="contents">
       <div class="btn_bottom" style="margin-top: 0px;">
        <div class="r_btn">
	        <form name="partsInfoSearchForm" action="${servletPath }" onsubmit="return goPage(1);" method = "post">
				<input type="hidden" name="cpage" value="${params.cpage }" />
				<input type="hidden" name="method" value="list" />
				<input type = "hidden" name = "rows" value = "${params.rows }"/>
				<input type = "hidden" name = "searchChk" value = "1"/>
		          <label style="margin-right: 10px;">
		            <span style="font-weight: bold;">부품종류</span>
		            <select title="부품종류선택" name = "parttyp" id = "parttyp">
		                  <option value = "" <c:if test = "${params.parttyp eq '' }">selected</c:if>>전체</option>
		                  <option value = "P" <c:if test = "${params.parttyp eq 'P' }">selected</c:if>>판매용</option>
		                  <option value = "R" <c:if test = "${params.parttyp eq 'R' }">selected</c:if>>재활용</option>
		           </select>
		          </label>
		          <label style="margin-right: 10px;">
		            <span style="font-weight: bold;">판매여부 종류</span>
		            <select title="판매여부 종류 선택" name = "sellinfo" id = "sellinfo">
		                  <option value = "" <c:if test = "${params.sellinfo eq '' }">selected</c:if>>전체</option>
		                  <option  value = "onesale" <c:if test = "${params.sellinfo eq 'onesale' }">selected</c:if>>개별판매</option>
		                  <option  value = "qtysale" <c:if test = "${params.sellinfo eq 'qtysale' }">selected</c:if>>수량류판매</option>
		                  <option  value = "weightsale" <c:if test = "${params.sellinfo eq 'weightsale' }">selected</c:if>>중량류판매</option>
		            </select>
		          </label>  
		          <label style="margin-right: 10px;">
		            <span style="font-weight: bold;">사용여부</span>
		            <select title="사용여부선택" name = delyn id = "delyn">
		                  <option value = "" <c:if test = "${params.delyn eq '' }">selected</c:if>>전체</option>
		                  <option value = "Y" <c:if test = "${params.delyn eq 'Y' }">selected</c:if>>사용</option>
		                  <option value = "N" <c:if test = "${params.delyn eq 'N' }">selected</c:if>>사영안함</option>
		            </select>
		          </label>  
	          
		          <span style="font-weight: bold;">부품명</span>
		          <input type="text" class="input_1" id="keyword" name="keyword" value = "${params.keyword }"/>
		          <span><input type = "image" src = "/images/admin/contents/s_btn_search.gif"></span>
	       	</form>
        </div>
        
      </div>
       <div class="category car five">
         <div class="category_left carleft">
             <table class="style_4" style="margin-top:0px;">
               <colgroup>
                 <col width="25%" />
                 <col width="*" />
               </colgroup>
               <tr>
                 <th>번호</th>
                 <th>부품명</th>
               </tr>
             	 <c:forEach items="${list }" var="partInfoList">
             	  <tr>
                 <td>${partInfoList.carpartseq }</td>
                 <td><a href = "javascript:;" onclick = "goBody('${servletPath}?seq=${partInfoList.carpartseq }&keyword=${params.keyword }&cpage=${params.cpage }&rows=${params.rows }&parttyp=${params.parttyp }&sellinfo=${params.sellinfo }&delyn=${params.delyn }&keyword=${params.keyword }');">${partInfoList.partnm }</a></td>
               </tr>
             	 </c:forEach>
               
             </table>
             <jsp:include page="/WEB-INF/jsp/paging.jsp" />
         </div>
         
         <div class="category_right carright" style="table-layout: fixed;">
           <table class="style_1">
             <colgroup>
               <col width="15%" />
               <col width="*" />
               <col width="15%" />
               <col width="*" />
             </colgroup>
             <tr>
               <th>부품코드</th>
               <td>${view.carpartseq }</td>
               <th>부품명</th>
               <td>${view.partnm }</td>
             </tr>
             <tr>
               <th>대분류</th>
               <td>${view.stockpartnm }</td>
               <th>중분류</th>
               <td>${view.partkindnm }</td>
             </tr>
             <tr>
               <th>상위부품</th>
               <td>${view.uppartnm }</td>
               <th>부품종류</th>
               <td>${view.parttypnm }</td>
             </tr>
             <tr>
               <th>모듈(assy)여부</th>
               <td>${view.assyynnm }</td>
               <th>별칭</th>
               <td>${view.partalias }</td>
             </tr>
             <tr>
               <th>표준중량</th>
               <td>${view.weight } KG</td>
               <th>표준작업시간</th>
               <td>${view.workhour } 분</td>
             </tr>
             <tr>
               <th>상위공정</th>
               <td>${view.upprocessnm }</td>
               <th>생산공정</th>
               <td>${view.process }</td>
             </tr>
             <tr>
               <th>개별판매여부</th>
               <td>${view.onesaleynnm }</td>
               <th>수량류판매여부</th>
               <td>${view.qtysaleynnm }</td>
             </tr>
             <tr>
               <th>중량류판매여부</th>
               <td>${view.weightsaleynnm }</td>
               <th>CO2감소량</th>
               <td>${view.co2 } KG</td>
             </tr>
             <tr>
               <th>세척여부</th>
               <td>${view.cleanynnm }</td>
               <th>세척구역</th>
               <td>${view.cleanzone }</td>
             </tr>
             <tr>
               <th>세척방법</th>
               <td>${view.cleanmethod }</td>
               <th>포장여부</th>
               <td>${view.packynnm }</td>
             </tr>
             <tr>
               <th>포장구역</th>
               <td>${view.packzone }</td>
               <th>포장여부</th>
               <td>${view.packmethod }</td>
             </tr>
             <tr>
               <th>촬영여부</th>
               <td>${view.photoynnm }</td>
               <th>촬영구역</th>
               <td>${view.photozone }</td>
             </tr>
             <tr>
               <th>촬영방법</th>
               <td>${view.photomethod }</td>
               <th>리빌드1</th>
               <td>${view.rebuild1 }</td>
             </tr>
             <tr>
               <th>리빌드2</th>
               <td>${view.rebuild2 }</td>
               <th>리빌드3</th>
               <td>${view.rebuild3 }</td>
             </tr>
             <tr>
               <th>쇼핑몰등록여부</th>
               <td>${view.shopynnm }</td>
               <th>쇼핑몰적용방법</th>
               <td>${view.shopmethod }</td>
             </tr>
             <tr>
               <th>쇼핑몰분류</th>
               <td>${view_StockPart.codenm }</td>
               <th>쇼핑몰상품</th>
               <td>${view_ShopPart.codenm }</td>
             </tr>
             <tr>
               <th>비고</th>
               <td>${view.etc }</td>
               <th>사용여부</th>
               <td>${view.delynnm }</td>
             </tr>
             <tr>
             	<th>이미지</th>
             	<td colspan = "3"><img src = "${view.photourl }" alt = ""/></td>
             </tr>
           </table>
           <div class="btn_bottom">
		        <div class="r_btn">
		        <c:choose>
		        	<c:when test = "${view.carpartseq eq null || view.carpartseq eq ''}">
		        		 <a href="#" id="dialog-link"><span class="bt_all"><span><input type="button" value="신규등록" onclick="" class="btall"/></span></span></a>
		        	</c:when>
		        	<c:otherwise>
		        		 <a href="#" id="dialog-link"><span class="bt_all"><span><input type="button" value="신규등록" onclick="" class="btall"/></span></span></a>
		          		 <a href="#" id="dialog-link2"><span class="bt_all"><span><input type="button" value="수정" onclick="" class="btall"/></span></span></a>
		          		 <span class="bt_all"><span><input type="button" value="삭제" onclick="go_delete(${view.carpartseq});" class="btall"/></span></span>
		        	</c:otherwise>
		        </c:choose>
		        </div>
		    </div>
         </div>
         <!-- 제조사 등록 팝업 (등록 동일)-->
       
	     <div id="dialog" title="부품등록" >
     	  <form id = "catePartsInfoName_insert" name = "catePartsInfoName_insert" method = "post" action = "${servletPath }" onsubmit = "return go_insert();" enctype="multipart/form-data">
	     	<input type = "hidden" name = "method" value = "insert"/>
	     	<input type = "hidden" name = "cpage" value = "${params.cpage }"/>
	     	<input type = "hidden" name = "rows" value = "${params.rows }"/>
	     	<input type = "hidden" name = "yyyy" id = "yyyy" value = ""/>
	     	<input type = "hidden" name = "mm" id = "mm" value = ""/>
	     	<input type = "hidden" name = "uuid" id = "uuid" value = ""/>
	     	<input type = "hidden" name = "attach_nm" id = "attach_nm" value = ""/>
	     	<input type = "hidden" name = "part_yn" id = "part_yn" value = "P"/>

	       <table class="style_1" style="table-layout: fixed;">
             <colgroup>
               <col width="15%;" />
               <col width="*" />
               <col width="15%;" />
               <col width="*" />
             </colgroup>
             <tr>
               <th>부품코드</th>
               <td><input type="text" name="carpartcode" id="carpartcode" class="input_1 color" maxlength = "6"/></td>
               <th>부품명</th>
               <td><input type="text" name="partnm" id="partnm" class="input_1 color" /></td>
             </tr>
             <tr>
               <th>대분류</th>
               <td>
                 <select title="대분류선택" onchange = "showCarNameList(this.value, '${view.mkind}');">
                   <option value = "">::선택::</option>
                   <c:forEach items="${deps1 }" var="deps1List">
                   	<option value = "${deps1List.codeno }">${deps1List.codenm }</option>
                   </c:forEach>
                 </select>
               </td>
               <th>중분류</th>
               <td>
                 <select title="중분류선택" id = "mkind" name = "mkind"></select>
               </td>
             </tr>
             <tr>
               <th>상위부품</th>
               <td>
                 <input type="text" name="uppartnm" id="uppartnm" class="input_1 color" readonly/>
                 <input type = "hidden" name = "uppart" id = "uppart" value = "1"/>
                 <input type = "hidden" name = "carpart" id = "carpart" value = ""/>
                 <a href="javascript:;" id="dialog-link3" ><img src="/images/admin/contents/invent_05.gif" alt="검색" onclick = ""/></a>
                 <a href="javascript:;" ><img src="/images/admin/contents/invent_03.gif" alt="초기화" onclick = "uppartReset();"/></a>
               </td>
               <th>부품종류</th>
               <td>
                 <select title="부품종류선택" name = "parttyp" id = "parttyp">
                   <option value = "P" selected>판매용</option>
                   <option value = "R">재활용</option>
                 </select>
               </td>
             </tr>
             <tr>
               <th>모듈(assy)여부</th>
               <td>
                 <select title="모듈선택" id = "assyyn" name = "assyyn">
                   <option value = "Y" selected>사용</option>
                   <option value = "N">사용안함</option>
                 </select>
               </td>
               <th>별칭</th>
               <td><input type="text" name="partalias" id="partalias" class="input_1" /></td>
             </tr>
             <tr>
               <th>표준중량</th>
               <td><input type="text" name="weight" id="weight" class="input_1 color" />KG</td>
               <th>표준작업시간</th>
               <td><input type="text" name="workhour" id="workhour" class="input_1 color" />분</td>
             </tr>
             <tr>
               <th>상위공정</th>
               <td>
                 <select title="상위선택" id = "upprocess" name = "upprocess">
                   <option value = "1" selected>본공정</option>
                   <option value = "2">후처리공정</option>
                 </select>
               </td>
               <th>생산공정</th>
               <td>
                 <select title="생산공정선택" id = "process" name = "process">
                   <option value = "1" selected>1</option>
                   <option value = "2">2</option>
                   <option value = "3">3</option>
                   <option value = "4">4</option>
                 </select>
               </td>
             </tr>
             <tr>
               <th>개별판매여부</th>
               <td>
                 <select title="모듈선택" id = "onesaleyn" name = "onesaleyn">
                   <option value = "Y" selected>사용</option>
                   <option value = "N">사용안함</option>
                 </select>
               </td>
               <th>수량류판매여부</th>
               <td>
                 <select title="모듈선택" id = "qtysaleyn" name = "qtysaleyn">
                   <option value = "Y" selected>사용</option>
                   <option value = "N">사용안함</option>
                 </select>
               </td>
             </tr>
             <tr>
               <th>중량류판매여부</th>
               <td>
                 <select title="모듈선택" id = "weightsaleyn" name = "weightsaleyn">
                  <option value = "Y" selected>사용</option>
                   <option value = "N">사용안함</option>
                 </select>
               </td>
               <th>CO2감소량</th>
               <td><input type="text" name="co2" id="co2" class="input_1 color" />KG</td>
             </tr>
             <tr>
               <th>세척여부</th>
               <td>
                 <select title="모듈선택" id = "cleanyn" name = "cleanyn">
                   <option value = "Y" selected>사용</option>
                   <option value = "N">사용안함</option>
                 </select>
               </td>
               <th>세척구역</th>
               <td><input type="text" name="cleanzone" id="cleanzone" class="input_1" /></td>
             </tr>
             <tr>
               <th>세척방법</th>
               <td><input type="text" name="cleanmethod" id="cleanmethod" class="input_1" /></td>
               <th>포장여부</th>
               <td>
                 <select title="모듈선택" id = "packyn" name = "packyn">
                   <option value = "Y" selected>사용</option>
                   <option value = "N">사용안함</option>
                 </select>
               </td>
             </tr>
             <tr>
               <th>포장구역</th>
               <td><input type="text" name="packzone" id="packzone" class="input_1" /></td>
               <th>포장방법</th>
               <td><input type="text" name="packmethod" id="packmethod" class="input_1" /></td>
             </tr>
             <tr>
               <th>촬영여부</th>
               <td>
                 <select title="모듈선택" id = "photoyn" name = "photoyn">
                   <option value = "Y" selected>사용</option>
                   <option value = "N">사용안함</option>
                 </select>
               </td>
               <th>촬영구역</th>
               <td><input type="text" name="photozone" id="photozone" class="input_1" /></td>
             </tr>
             <tr>
               <th>촬영방법</th>
               <td><input type="text" name="photomethod" id="photomethod" class="input_1" /></td>
               <th>리빌드1</th>
               <td><input type="text" name="rebuild1" id="rebuild1" class="input_1" /></td>
             </tr>
             <tr>
               <th>리빌드2</th>
               <td><input type="text" name="rebuild2" id="rebuild2" class="input_1" /></td>
               <th>리빌드3</th>
               <td><input type="text" name="rebuild3" id="rebuild3" class="input_1" /></td>
             </tr>
             <tr>
               <th>쇼핑몰등록여부</th>
               <td>
                 <select title="모듈선택" id = "shopyn" name = "shopyn">
                   <option value = "Y" selected>사용</option>
                   <option value = "N">사용안함</option>
                 </select>
               </td>
               <th>쇼핑몰적용방법</th>
               <td><input type="text" name="shopmethod" id="shopmethod" class="input_1" /></td>
             </tr>
             <tr>
               <th>쇼핑몰분류</th>
               <td>
                 <select title="분류선택" id = "stockpart" name = "stockpart" onchange = "getShopCodeSubList(this.value);">
                   <option value = "">::선택::</option>
                   <c:forEach items="${shopcodelist }" var="shopcode">
                   	<option value = "${shopcode.codeno }">${shopcode.codenm }</option>
                   </c:forEach>
                 </select>
               </td>
               <th>쇼핑몰상품</th>
               <td>
                 <select title="세부선택" id = "partkind" name = "partkind"></select>
               </td>
             </tr>
             <tr>
               <th>비고</th>
               <td><input type="text" name="etc" id="etc" class="input_1" /></td>
               <th>사용여부</th>
               <td>
                 <select title="모듈선택" id = "delyn" name = "delyn">
                   <option value = "Y" >사용안함</option>
                   <option value = "N" selected>사용</option>
                 </select>
               </td>
             </tr>
             <tr>
               <th>부품이미지</th>
               <td colspan="3">
                 <input type="file" name="file" id="file" onchange="uploadFile()"/>
               </td>
             </tr>
           </table>
           <div class="btn_bottom">
		        <div class="r_btn">
		         <span class="bt_all"><span><input type="submit" value="등록" class="btall"/></span></span>
		        </div>
		       </form>
		    </div>
	     </div>
	     
	      <!-- 제조사 수정 팝업 (수정 동일)-->
	      
	     <div id="dialog2" title="부품수정" >
	     	<form name = "carPartsInfoModify" id = "carPartsInfoModify" method = "post" action = "${servletPath }" onsubmit = "return go_update();" enctype="multipart/form-data">
	     	<input type = "hidden" name = carpartseq value = "${view.carpartseq}"/>
     		<input type = "hidden" name = "method" value = "update"/>
     		<input type = "hidden" name = "cpage" value = "${params.cpage }"/>
     		<input type = "hidden" name = "rows" value = "${params.rows }"/>
     		<input type = "hidden" name = "yyyy_mod" id = "yyyy_mod" value = ""/>
	     	<input type = "hidden" name = "mm_mod" id = "mm_mod" value = ""/>
	     	<input type = "hidden" name = "uuid_mod" id = "uuid_mod" value = ""/>
	     	<input type = "hidden" name = "attach_nm_mod" id = "attach_nm_mod" value = ""/>
	     	<input type = "hidden" name = "part_yn" id = "part_yn" value = "P"/>
	     	<input type = "hidden" name = "qry_method" value = "<c:choose><c:when test = "${view.part_yn eq 'I' }">qry_insert</c:when><c:otherwise>qry_update</c:otherwise></c:choose>"/>
	       <table class="style_1" style="table-layout: fixed;">
             <colgroup>
               <col width="15%;" />
               <col width="*" />
               <col width="15%;" />
               <col width="*" />
             </colgroup>
             <tr>
               <th>부품코드</th>
               <td><input type="text" name="carpartcode" id="carpartcode" class="input_1 color" value = "${view.carpartcode}"/></td>
               <th>부품명</th>
               <td><input type="text" name="partnm" id="partnm" class="input_1 color" value = "${view.partnm}"/></td>
             </tr>
             <tr>
               <th>대분류</th>
               <td>
                  <select title="대분류선택" onchange = "showCarNameList1(this.value, '${view.mkind}');">
                    <option value = "">::선택::</option>
                   <c:forEach items="${deps1 }" var="deps1List">
                   	<option value = "${deps1List.codeno }" <c:if test = "${view.codenm eq deps1List.codenm }">selected</c:if>>${deps1List.codenm }</option>
                   </c:forEach>
                 </select>
               </td>
               <th>중분류</th>
               <td>
                  <select title="중분류선택" id = "mkind1" name = "mkind"></select>
               </td>
             </tr>
             <tr>
               <th>상위부품</th>
               <td>
                 <input type="text" name="uppartnm" id="uppartnm" class="input_1 color" value = "${view.uppartnm }"/>
                 <input type = "hidden" name = "uppart" id = "uppart" value = "1"/>
                 <input type = "hidden" name = "carpart" id = "carpart" value = ""/>
                 <a href="javascript:;" id="dialog-link3" ><img src="/images/admin/contents/invent_05.gif" alt="검색" onclick = ""/></a>
                 <a href="javascript:;" ><img src="/images/admin/contents/invent_03.gif" alt="초기화" onclick = "uppartReset();"/></a>
               </td>
               <th>부품종류</th>
               <td>
                 <select title="부품종류선택" name = "parttyp" id = "parttyp">
                   <option value = "P" <c:if test = "${view.parttyp eq 'P'}">selected</c:if>>판매용</option>
                   <option value = "R" <c:if test = "${view.parttyp eq 'R'}">selected</c:if>>재활용</option>
                 </select>
               </td>
             </tr>
             <tr>
               <th>모듈(assy)여부</th>
               <td>
                 <select title="모듈선택" id = "assyyn" name = "assyyn">
                   <option value = "Y" <c:if test = "${view.assyyn eq 'Y'}">selected</c:if>>사용</option>
                   <option value = "N" <c:if test = "${view.assyyn eq 'N'}">selected</c:if>>사용안함</option>
                 </select>
               </td>
               <th>별칭</th>
               <td><input type="text" name="partalias" id="partalias" class="input_1" value = "${view.partalias}"/></td>
             </tr>
             <tr>
               <th>표준중량</th>
               <td><input type="text" name="weight" id="weight" class="input_1 color" value = "${view.weight }"/>KG</td>
               <th>표준작업시간</th>
               <td><input type="text" name="workhour" id="workhour" class="input_1 color" value = "${view.workhour }"/>분</td>
             </tr>
             <tr>
               <th>상위공정</th>
               <td>
                  <select title="상위선택" id = "upprocess" name = "upprocess">
                   <option value = "1" <c:if test = "${view.upprocess eq '1'}">selected</c:if>>본공정</option>
                   <option value = "2" <c:if test = "${view.upprocess eq '2'}">selected</c:if>>후처리공정</option>
                 </select>
               </td>
               <th>생산공정</th>
               <td>
                 <select title="생산공정선택" id = "process" name = "process">
                   <option value = "1" <c:if test = "${view.process eq '1'}">selected</c:if>>1</option>
                   <option value = "2" <c:if test = "${view.process eq '2'}">selected</c:if>>2</option>
                   <option value = "3" <c:if test = "${view.process eq '3'}">selected</c:if>>3</option>
                   <option value = "4" <c:if test = "${view.process eq '4'}">selected</c:if>>4</option>
                 </select>
               </td>
             </tr>
             <tr>
               <th>개별판매여부</th>
               <td>
                  <select title="모듈선택" id = "onesaleyn" name = "onesaleyn">
                   <option value = "Y" <c:if test = "${view.onsaleyn eq 'Y'}">selected</c:if>>사용</option>
                   <option value = "N" <c:if test = "${view.onsaleyn eq 'N'}">selected</c:if>>사용안함</option>
                 </select>
               </td>
               <th>수량류판매여부</th>
               <td>
                  <select title="모듈선택" id = "qtysaleyn" name = "qtysaleyn">
                   <option value = "Y" <c:if test = "${view.qtysaleyn eq 'Y'}">selected</c:if>>사용</option>
                   <option value = "N" <c:if test = "${view.qtysaleyn eq 'N'}">selected</c:if>>사용안함</option>
                 </select>
               </td>
             </tr>
             <tr>
               <th>중량류판매여부</th>
               <td>
                  <select title="모듈선택" id = "weightsaleyn" name = "weightsaleyn">
                  <option value = "Y" <c:if test = "${view.weightsaleyn eq 'Y'}">selected</c:if>>사용</option>
                   <option value = "N" <c:if test = "${view.weightsaleyn eq 'N'}">selected</c:if>>사용안함</option>
                 </select>
               </td>
               <th>CO2감소량</th>
               <td><input type="text" name="co2" id="co2" class="input_1 color" value = "${view.co2 }"/>KG</td>
             </tr>
             <tr>
               <th>세척여부</th>
               <td>
                  <select title="모듈선택" id = "cleanyn" name = "cleanyn">
                   <option value = "Y" <c:if test = "${view.cleanyn eq 'Y'}">selected</c:if>>사용</option>
                   <option value = "N" <c:if test = "${view.cleanyn eq 'N'}">selected</c:if>>사용안함</option>
                 </select>
               </td>
               <th>세척구역</th>
               <td><input type="text" name="cleanzone" id="cleanzone" class="input_1" value = "${view.cleanzone }"/></td>
             </tr>
             <tr>
               <th>세척방법</th>
               <td><input type="text" name="cleanmethod" id="cleanmethod" class="input_1" value = "${view.cleanmethod }"/></td>
               <th>포장여부</th>
               <td>
                 <select title="모듈선택" id = "packyn" name = "packyn">
                   <option value = "Y" <c:if test = "${view.packyn eq 'Y'}">selected</c:if>>사용</option>
                   <option value = "N" <c:if test = "${view.packyn eq 'N'}">selected</c:if>>사용안함</option>
                 </select>
               </td>
             </tr>
             <tr>
               <th>포장구역</th>
               <td><input type="text" name="packzone" id="packzone" class="input_1" value = "${view.packzone }"/></td>
               <th>포장방법</th>
               <td><input type="text" name="packmethod" id="packmethod" class="input_1" value = "${view.packmethod }"/></td>
             </tr>
             <tr>
               <th>촬영여부</th>
               <td>
                  <select title="모듈선택" id = "photoyn" name = "photoyn">
                   <option value = "Y" <c:if test = "${view.photoyn eq 'Y'}">selected</c:if>>사용</option>
                   <option value = "N" <c:if test = "${view.photoyn eq 'N'}">selected</c:if>>사용안함</option>
                 </select>
               </td>
               <th>촬영구역</th>
               <td><input type="text" name="photozone" id="photozone" class="input_1" value = "${view.photozone }"/></td>
             </tr>
             <tr>
               <th>촬영방법</th>
               <td><input type="text" name="photomethod" id="photomethod" class="input_1" value = "${view.photomethod }"/></td>
               <th>리빌드1</th>
               <td><input type="text" name="rebuild1" id="rebuild1" class="input_1" value = "${view.rebuild1 }"/></td>
             </tr>
             <tr>
               <th>리빌드2</th>
               <td><input type="text" name="rebuild2" id="rebuild2" class="input_1" value = "${view.rebuild2 }"/></td>
               <th>리빌드3</th>
               <td><input type="text" name="rebuild3" id="rebuild3" class="input_1" value = "${view.rebuild3 }"/></td>
             </tr>
             <tr>
               <th>쇼핑몰등록여부</th>
               <td>
                 <select title="모듈선택" id = "shopyn" name = "shopyn">
                   <option value = "Y" <c:if test = "${view.shopyn eq 'Y'}">selected</c:if>>사용</option>
                   <option value = "N" <c:if test = "${view.shopyn eq 'N'}">selected</c:if>>사용안함</option>
                 </select>
               </td>
               <th>쇼핑몰적용방법</th>
               <td><input type="text" name="shopmethod" id="shopmethod" class="input_1" value = "${view.shopmethod }"/></td>
             </tr>
             <tr>
               <th>쇼핑몰분류</th>
               <td>
                 <select title="분류선택" id = "stockpart" name = "stockpart" onchange = "getShopCodeSubList1(this.value);">
                   <option value = "">::선택::</option>
                   <c:forEach items="${shopcodelist }" var="shopcode">
                   	<option value = "${shopcode.codeno }" <c:if test = "${shopcode.codeno eq view_StockPart.codeno}">selected</c:if>>${shopcode.codenm }</option>
                   </c:forEach>
                 </select>
               </td>
               <th>쇼핑몰상품</th>
               <td>
                 <select title="세부선택" id = "partkind1" name = "partkind"></select>
               </td>
             </tr>
             <tr>
               <th>비고</th>
               <td><input type="text" name="etc" id="etc" class="input_1" value = "${view.etc }"/></td>
               <th>사용여부</th>
               <td>
                 <select title="사용여부" id = "delyn" name = "delyn">
                   <option value = "N" <c:if test = "${view.delyn eq 'N'}">selected</c:if>>사용</option>
                   <option value = "Y" <c:if test = "${view.delyn eq 'Y'}">selected</c:if>>사용안함</option>
                 </select>
               </td>
             </tr>
             <tr>
               <th>부품이미지</th>
               <td colspan="3">
                 <input type="file" name="file_mod" id="file_mod" onchange="uploadFile_mod()"/><br><br>
                 ${view.attach_nm }
               </td>
             </tr>
           </table>
           <div class="btn_bottom">
		        <div class="r_btn">
		         <span class="bt_all"><span><input type="submit" value="수정" class="btall"/></span></span>
		        </div>
		    </div>
		   </form>
	     </div>
	     
	     <!-- 부품검색 팝업 시작 -->
	    
	     <div id="dialog3" title="부품수정" >
	       <table class="style_1" >
	         <colgroup>
	           <col width="15%"/>
	           <col width="*" />
	         </colgroup>
	         <tr>
	           <th>부품명</th>
	           <td>
	             <input type="text" name="keyword1" id="keyword1" class="input_1"/>
	           </td>
	         </tr>
	       </table>
	       <div class="btn_bottom" style="margin-top: 5px;">
		        <div class="r_btn">
		         <span class="bt_all"><span><input type="button" value="검색" onclick="getUpPartsNameList();" class="btall"/></span></span>
		        </div>
		    </div>
		   <div style="overflow-y: scroll; height: 350px; border:1px solid #ededed; margin-top: 10px;">
	       <table class="style_4" id = "upPartsNameList" style="margin-top: 0px;" >
	         <tr>
	           <th>부품명</th>
	         </tr>
	        
	       </table>
	       </div> 
	     </div>
	     </iframe>
	     <!-- 부품검색 팝업 끝 -->
       </div>
    </div>
  </div>
</div>
<script type="text/javascript" src="/lib/js/jquery-1.10.2.min.js"></script> 
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script> 
<script type="text/javascript" src="/lib/js/jquery.form.js"></script>
<script>
$("input.date").datepicker({
		showOn: "button",      
		buttonImage: "/images/admin/contents/calendar.png",
});

$( "#tabs" ).tabs();
$( "#dialog" ).dialog({
	autoOpen: false,
	width: 750,
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

$( "#dialog3" ).dialog({
	autoOpen: false,
	width: 650,
});

// Link to open the dialog
$( "#dialog-link3" ).click(function( event ) {
	$( "#dialog3" ).dialog( "open" );
	event.preventDefault();
});

function uploadFile()
{
	var filename = $("#file").val();
	filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
	if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
		alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
		return false;
	}
	
	$("#catePartsInfoName_insert").ajaxSubmit({
		url : '/ajaxUpload.do',
		async: false,
		iframe: true,
		dataType : "json",
		uploadProgress : function(event, position, total, percentComplete){
		},
		success : function(data){
			//$scope.addFile(data);
			jQuery("#uuid").val(data.uuid);
			jQuery("#yyyy").val(data.yyyy);
			jQuery("#attach_nm").val(data.attach_nm);
			jQuery("#mm").val(data.mm);
	
			return true;
		},
		error: function(e){
			
			return false;
		}
	});
}

function uploadFile_mod()
{
	var filename = $("#file_mod").val();
	filename = filename.slice(filename.indexOf(".") + 1).toLowerCase();
	if($.inArray(filename, ["gif", "jpg", "jpeg", "png", "bmp"]) < 0 ){
		alert("gif, jpg, jpeg, png, bmp 파일만 올려주시기 바랍니다.");
		return false;
	}
	
	$("#carPartsInfoModify").ajaxSubmit({
		url : '/ajaxUpload.do',
		async: false,
		iframe: true,
		dataType : "json",
		uploadProgress : function(event, position, total, percentComplete){
		},
		success : function(data){
			//$scope.addFile(data);
			jQuery("#uuid_mod").val(data.uuid);
			jQuery("#yyyy_mod").val(data.yyyy);
			jQuery("#attach_nm_mod").val(data.attach_nm);
			jQuery("#mm_mod").val(data.mm);
	
			return true;
		},
		error: function(e){
			
			return false;
		}
	});
}

function go_insert()
{
	if(jQuery("#carpartcode").val() == "" || isNaN(jQuery("#carpartcode").val()))
	{
		alert("부품코드를 입력하지 않았거나 숫자만 입력 가능합니다.");
		jQuery("#carpartcode").val("");
		jQuery("#carpartcode").focus();
		return false;
		
	}
	else if(jQuery("#partnm").val() == "")
	{
		alert("부품명을 입력하세요.");
		jQuery("#partnm").val("");
		jQuery("#partnm").focus();
		return false;
		
	}
	else if(jQuery("#uppartnm").val() == "")
	{
		alert("상위부품 선택하세요.");
		return false;
	}
	else if(jQuery("#partalias").val() == "")
	{
		alert("별칭을 입력하세요.");
		jQuery("#partalias").val("");
		jQuery("#partalias").focus();
		return false;
		
	}
	else if(jQuery("#weight").val() == "")
	{
		alert("표준중량을 입력하세요.");
		jQuery("#weight").val("");
		jQuery("#weight").focus();
		return false;
		
	}
	else if(jQuery("#workhour").val() == "")
	{
		alert("표준작업시간을 입력하세요.");
		jQuery("#workhour").val("");
		jQuery("#workhour").focus();
		return false;
		
	}
	else if(jQuery("#co2").val() == "")
	{
		alert("CO2감소량을 입력하세요.");
		jQuery("#co2").val("");
		jQuery("#co2").focus();
		return false;
		
	}
	else if(jQuery("#cleanzone").val() == "")
	{
		alert("세척구역을 입력하세요.");
		jQuery("#cleanzone").val("");
		jQuery("#cleanzone").focus();
		return false;
		
	}
	else if(jQuery("#cleanmethod").val() == "")
	{
		alert("세척방법을 입력하세요.");
		jQuery("#cleanmethod").val("");
		jQuery("#cleanmethod").focus();
		return false;
		
	}
	else if(jQuery("#packzone").val() == "")
	{
		alert("포장구역을 입력하세요.");
		jQuery("#packzone").val("");
		jQuery("#packzone").focus();
		return false;
		
	}
	else if(jQuery("#packmethod").val() == "")
	{
		alert("포장방법을 입력하세요.");
		jQuery("#packmethod").val("");
		jQuery("#packmethod").focus();
		return false;
		
	}
	else if(jQuery("#photozone").val() == "")
	{
		alert("촬영구역을 입력하세요.");
		jQuery("#photozone").val("");
		jQuery("#photozone").focus();
		return false;
		
	}
	else if(jQuery("#photomethod").val() == "")
	{
		alert("촬영방법을 입력하세요.");
		jQuery("#photomethod").val("");
		jQuery("#photomethod").focus();
		return false;
		
	}
	else if(jQuery("#rebuild1").val() == "")
	{
		alert("리빌드1을 입력하세요.");
		jQuery("#rebuild1").val("");
		jQuery("#rebuild1").focus();
		return false;
		
	}
	else if(jQuery("#rebuild2").val() == "")
	{
		alert("리빌드2을 입력하세요.");
		jQuery("#rebuild2").val("");
		jQuery("#rebuild2").focus();
		return false;
		
	}
	else if(jQuery("#rebuild3").val() == "")
	{
		alert("리빌드3을 입력하세요.");
		jQuery("#rebuild3").val("");
		jQuery("#rebuild3").focus();
		return false;
		
	}
	else if(jQuery("#shopmethod").val() == "")
	{
		alert("쇼핑몰적용방법을 입력하세요.");
		jQuery("#shopmethod").val("");
		jQuery("#shopmethod").focus();
		return false;
		
	}
	else if(jQuery("#etc").val() == "")
	{
		alert("비고를 입력하세요.");
		jQuery("#etc").val("");
		jQuery("#etc").focus();
		return false;
		
	}
	
	else
	{
		return true;
	}

}
</script>
</body>
</html>
