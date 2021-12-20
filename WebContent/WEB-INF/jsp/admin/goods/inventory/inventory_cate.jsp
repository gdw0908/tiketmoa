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
<script type = "text/javascript">
function go_insert()
{
	if(jQuery("#codeName_form").val() == "")
	{
		alert("코드명을 입력하세요.");
		jQuery("#codeName_form").focus();
		return;
	}
	else if(jQuery("#codeRef_form").val() == "")
	{
		alert("코드설명을 입력하세요.");
		jQuery("#codeRef_form").focus();
		return;
	}
	else
	{
		if(confirm("등록 하시겠습니까?"))
		{
			jQuery("input[name='method']").val("insert");
			jQuery("input[name='codeName']").val(jQuery("#codeName_form").val());
			jQuery("input[name='codeRef']").val(jQuery("#codeRef_form").val());
			jQuery("form[name='cate']").submit();
		}
	}
	
}

function go_delete(codeno)
{
	if(confirm("상위 메뉴일 경우 사용안할 경우 해당 하위메뉴까지 사용할수가 없습니다.해당 메뉴설정을 변경 하시겠습니까?"))
	{
		location.replace("${servletPath }?method=delete&codeno=" + codeno);
	}
}

function go_update_parent()
{
	if(confirm("해당 부모코드 내용을 수정 하시겠습니까?")) jQuery("form[name='category_modify_parent']").submit();
}

function go_update_chlid(this_form)
{
	if(confirm("해당 코드 내용을 수정 하시겠습니까?")) jQuery(this_form).submit();
}

function goBody(target_url){
	parent.bodyFrame.location.href = target_url;
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
        <li class="on"><a href="javascript:;" onclick = "goBody('/admin/goods/inventory/inventory_cate.do?codeno=0509');">공통코드</a></li>
        <li><a href="javascript:;" onclick = "goBody('/admin/goods/inventory/inventory_cate2.do');">제조사</a></li>
        <li><a href="javascript:;" onclick = "goBody('/admin/goods/inventory/inventory_cate3.do');">차량명</a></li>
        <li><a href="javascript:;" onclick = "goBody('/admin/goods/inventory/inventory_cate4.do');">차량모델명</a></li>
        <li><a href="javascript:;" onclick = "goBody('/admin/goods/inventory/inventory_cate5.do');">부품정보</a></li>
      </ul>
    </div>
    <div class="contents">
       <div class="category">
         <div class="category_left">
             <jsp:include page="/admin/category/menuTree.do" />
         </div>
         
         <div class="category_right">
           <table class="style_1" style="table-layout: fixed;">
             <colgroup>
               <col width="15%;" />
               <col width="*" />
               <col width="15%;" />
               <col width="*" />
             </colgroup>
            <tr>
              <th>코드</th>
              <td>${article.codeno }
              <c:if test = "${not empty article.codeno}">
               <span class="bt_all" id="dialog-link_parent"><span><input type="button" value="수정" onclick="" class="btall"/></span></span>
		         <!-- <span class="bt_all"><span><input type="button" value="취소" onclick="" class="btall"/></span></span> -->
		         <span class="bt_all"><span><input type="button" value="삭제" onclick="go_delete('${article.codeno }');" class="btall"/></span></span>
              </c:if>
              </td>
              <th>상위코드</th>
              <c:choose>
              	<c:when test="${article.codeno ne 05 }">
              		<td>${article.upcodeno }</td>
              	</c:when>
              	<c:otherwise>
              		<td>최상위 메뉴 입니다.</td>
              	</c:otherwise>
              </c:choose>
              
            </tr>
            <tr>
              <th>코드명</th>
              <td>${article.codenm }</td>
              <th>순서</th>
              <td>${article.sortno }</td>
            </tr>
            <tr>
              <th>코드설명</th>
              <td colspan="3">${article.ref}</td>
            </tr>
           </table>
           <table class="style_3" style="table-layout: fixed;">
             <colgroup>
               <col width="" />
               <col width="" />
               <col width="" />
               <col width="" />
             </colgroup>
             <tr>
               <th>코드</th>
               <th>코드명</th>
               <th>순서</th>
               <th>사용유무</th>
               <th>비고</th>
             </tr>
              <c:forEach items="${list }" var="chlidList">
             <tr>
               <td>${chlidList.codeno }</td>
               <td onclick = "goBody('${servletPath }?codeno=${chlidList.codeno}');" style = "cursor:pointer;">${chlidList.codenm }</td>
               <td>${chlidList.sortno }</td>
               <td>${chlidList.useyn }</td>
               <td>
               	 <span class="bt_all" id="dialog-link_child_${chlidList.codeno }"><span><input type="button" value="수정" onclick="" class="btall"/></span></span>
		         <!-- <span class="bt_all"><span><input type="button" value="취소" onclick="" class="btall"/></span></span> -->
		         <span class="bt_all"><span><input type="button" value="삭제" onclick="go_delete('${chlidList.codeno }');" class="btall"/></span></span>
               </td>
             </tr>
            
            </c:forEach>
           </table>
			<jsp:include page="/WEB-INF/jsp/paging.jsp" />
           <div class="btn_bottom">
		        <div class="r_btn">
		          <a href="#" id="dialog-link"><span class="bt_all"><span><input type="button" value="등록" onclick="" class="btall"/></span></span></a>
		        </div>
		    </div>
         </div>
         <!-- 카테고리등록 팝업 -->
	     <div id="dialog" title="카테고리등록" >
	       <table class="style_1" style="table-layout: fixed;">
             <colgroup>
               <col width="15%;" />
               <col width="*" />
               <col width="15%;" />
               <col width="*" />
             </colgroup>
            <tr>
              <th>코드</th>
              <td>
	              <c:choose>
	              	<c:when test = "${empty lastest.codeno}">
	              	${article.codeno }${0}${0 }${1 }
	              	</c:when>
	              	<c:otherwise>
	              	${0}${lastest.codeno + 1 }
	              	</c:otherwise>
	              </c:choose>
              </td>	
              <th>상위코드</th>
              <td>${article.codeno }</td>
            </tr>
            <tr>
              <th>코드명</th>
              <td>
                <input type="text" id="codeName_form" class="input_1"/>
              </td>
              <th>순서</th>
              <td>${orderCount.count + 1}</td>
            </tr>
            <tr>
              <th>코드설명</th>
              <td colspan="3">
                <textarea rows="5" cols="10" style="width: 93%;" id = "codeRef_form" ></textarea>
              </td>
            </tr>
           </table>
           <div class="btn_bottom">
		        <div class="r_btn">
		         <span class="bt_all"><span><input type="button" value="등록" onclick="go_insert();" class="btall"/></span></span>
		        
		        </div>
		    </div>
	     </div>
	     
	     <!-- 부모코드 수정 -->
	     <div id="dialog_parent" title="부모코드수정" >
	     <form id = "category_modify_parent" name = "category_modify_parent" method = "post" action = "${servletPath }">
     		<input type = "hidden" name = "codeno" value = "${article.codeno}"/>
     		<input type = "hidden" name = "method" value = "update"/>
     		<input type = "hidden" name = "cpage" value = "${params.cpage }"/>
     		<input type = "hidden" name = "rows" value = "${params.rows }"/>
     		<input type = "hidden" name = "qry_method" value = "<c:choose><c:when test = "${article.mst_yn eq 'I' }">qry_insert</c:when><c:otherwise>qry_update</c:otherwise></c:choose>"/>
     		<input type = "hidden" name = "upcodeno" value = "${article.upcodeno}"/>
     		<input type = "hidden" name = "mst_yn" value = "P"/>
	       <table class="style_1" style="table-layout: fixed;">
             <colgroup>
               <col width="15%;" />
               <col width="*" />
               <col width="15%;" />
               <col width="*" />
             </colgroup>
            <tr>
              <th>코드</th>
              <td>${article.codeno}</td>
              <th>상위코드</th>
              <td>${article.upcodeno}</td>
            </tr>
            <tr>
              <th>코드명</th>
              <td>
                <input type="text" name="codenm" id="codenm" class="input_1" value = "${article.codenm }"/>
              </td>
              <th>순서</th>
              <td><input type="text" name="sortno" id="sortno" class="input_1" value = "${article.sortno}"/></td>
            </tr>
            <tr>
              <th>코드설명</th>
              <td colspan="3">
                <textarea rows="5" cols="10" style="width: 93%;" id = "ref" name = "ref">${article.ref }</textarea>
              </td>
            </tr>
           </table>
           <div class="btn_bottom">
		        <div class="r_btn">
		         <span class="bt_all"><span><input type="button" value="수정" onclick="go_update_parent();" class="btall"/></span></span>
		        
		        </div>
		    </div>
		   </form>
	     </div>
	      <!-- 부모코드 수정 -->
		 <!-- 자식코드 수정 -->
		 <c:forEach items="${list }" var="chlidList">
	     <div id="dialog_child_${chlidList.codeno }" title="부모코드수정" >
	     <form id = "category_child_${chlidList.codeno }" name = "category_child_${chlidList.codeno }" method = "post" action = "${servletPath }">
     		<input type = "hidden" name = "codeno" value = "${chlidList.codeno}"/>
     		<input type = "hidden" name = "method" value = "update"/>
     		<input type = "hidden" name = "cpage" value = "${params.cpage }"/>
     		<input type = "hidden" name = "rows" value = "${params.rows }"/>
     		<input type = "hidden" name = "qry_method" value = "<c:choose><c:when test = "${chlidList.mst_yn eq 'I' }">qry_insert</c:when><c:otherwise>qry_update</c:otherwise></c:choose>"/>
     		<input type = "hidden" name = "upcodeno" value = "${chlidList.upcodeno}"/>
     		<input type = "hidden" name = "mst_yn" value = "P"/>
	       <table class="style_1" style="table-layout: fixed;">
             <colgroup>
               <col width="15%;" />
               <col width="*" />
               <col width="15%;" />
               <col width="*" />
             </colgroup>
            <tr>
              <th>코드</th>
              <td>${article.codeno}</td>
              <th>상위코드</th>
              <td>${article.upcodeno}</td>
            </tr>
            <tr>
              <th>코드명</th>
              <td>
                <input type="text" name="codenm" id="codenm" class="input_1" value = "${chlidList.codenm }"/>
              </td>
              <th>순서</th>
              <td><input type="text" name="sortno" id="sortno" class="input_1" value = "${chlidList.sortno}"/></td>
            </tr>
            <tr>
              <th>코드설명</th>
              <td colspan="3">
                <textarea rows="5" cols="10" style="width: 93%;" id = "ref" name = "ref">${chlidList.ref }</textarea>
              </td>
            </tr>
           </table>
           <div class="btn_bottom">
		        <div class="r_btn">
		         <span class="bt_all"><span><input type="button" value="수정" onclick="go_update_chlid(this.form);" class="btall"/></span></span>
		        
		        </div>
		    </div>
		   </form>
	     </div>
	    </c:forEach>
	      <!-- 자식코드 수정 -->
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
	width: 650,
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

//Link to open the dialog
$( "#dialog-link_parent" ).click(function( event ) {
	$( "#dialog_parent" ).dialog( "open" );
	event.preventDefault();
});

$( "#dialog_parent" ).dialog({
	autoOpen: false,
	width: 650,
});

// Link to open the dialog
$( "#dialog-link2" ).click(function( event ) {
	$( "#dialog2" ).dialog( "open" );
	event.preventDefault();
});

// Link to open the dialog
$( "#dialog-link_parent" ).click(function( event ) {
	$( "#dialog_parent" ).dialog( "open" );
	event.preventDefault();
});
<c:forEach items="${list }" var="chlidList">

$( "#dialog_child_${chlidList.codeno }" ).dialog({
	autoOpen: false,
	width: 650,
});

// Link to open the dialog
$( "#dialog-link_child_${chlidList.codeno }" ).click(function( event ) {
	$( "#dialog_child_${chlidList.codeno }" ).dialog( "open" );
	event.preventDefault();
});

</c:forEach>

</script>
<form name = "cate" id = "cate" method = "post" action = "${servletPath }">
<input type = "hidden" name = "method" value = ""/>
<c:choose>
	<c:when test = "${empty lastest.codeno}">
	<input type = "hidden" name = "codeNo" value = "${article.codeno }${0}${0 }${1 }"/>
	</c:when>
	<c:otherwise>
	<input type = "hidden" name = "codeNo" value = "${0}${lastest.codeno + 1 }"/>
	</c:otherwise>
</c:choose>

<input type = "hidden" name = "upcodeNo" value = "${article.codeno }"/>
<input type = "hidden" name = "codeName" value = ""/>
<input type = "hidden" name = "orderCount" value = "${orderCount.count}"/>
<input type = "hidden" name = "codeRef" value = ""/>
<input type = "hidden" name = "mst_yn" value = "P"/> <!-- 고유아이디 미디어코어 전용 -->

</form>

</body>
</html>
