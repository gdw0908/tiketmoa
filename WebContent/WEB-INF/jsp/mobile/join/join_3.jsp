<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<link rel="stylesheet" href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" type="text/css">
<script type="text/javascript" src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript">
$(function(){
	var Width = ($(window).width() * 0.92);
	var Height = ($(window).height() * 0.5);
	$("#modal_dialog" ).dialog({
		autoOpen: false,
		modal : true,
		width:Width,
		height:Height
	});
});

function inputEmail2(value)
{
	if(value == "")
	{
		jQuery("#email2").attr("readonly",false);
		jQuery("#email2").val("");
		jQuery("#email2").focus();
	}
	else
	{
		jQuery("#email2").attr("readonly",true);
		jQuery("#email2").val(value);
	}
}

function CheckPassword(uid, upw) 
{
	if(upw == "")
	{
		return false;
	}
	
    if(!/^[a-zA-Z0-9]{6,15}$/.test(upw))
    { 
        return false;
    }
  
    var chk_num = upw.search(/[0-9]/g); 
    var chk_eng = upw.search(/[a-z]/ig); 

    if(chk_num < 0 || chk_eng < 0)
    { 
        return false;
    }
    
    if(/(\w)\1\1\1/.test(upw))
    {
        return false;
    }
    
    if(upw.search(uid)>-1)
    {
        return false;
    }
    
    return true;
}

function join_form_chk()
{
	if(jQuery("#member_id").val() == "")
	{
		alert("아이디를 입력하세요.");	
		jQuery("#member_id").val("");
		jQuery("#member_id").focus();
		return false;
	}
	else if(jQuery("#member_id_chk").val() == "")
	{
		alert("아이디 중복확인을 진행해주세요.");	
		return false;
	}
	else if(!CheckPassword(jQuery("#member_id").val(), jQuery("#member_pw").val() ))
	{
		alert("비밀번호는 아이디와 같을 수 없으며\n6~15글자 이내, 영문 대/소문자, 숫자를 조합해야합니다.");	
		jQuery("#member_pw").val("");
		jQuery("#member_pw").focus();
		return false;
	}
	
	else if(jQuery("#member_pw_chk").val() == "")
	{
		alert("비밀번호 확인을 입력하세요.");	
		jQuery("#member_pw_chk").val("");
		jQuery("#member_pw_chk").focus();
		return false;
	}
	else if(jQuery("#member_pw_chk").val() != jQuery("#member_pw").val())
	{
		alert("비밀번호가 일치 하지 않습니다. 확인해주세요.");	
		jQuery("#member_pw").val("");
		jQuery("#member_pw_chk").val("");
		jQuery("#member_pw").focus();
		return false;
	}
	/*
	else if(jQuery("#tel2").val() == "" || isNaN(jQuery("#tel2").val()))
	{
		alert("전화번호를 입력하지 않았거나 숫자만 입력가능합니다.");	
		jQuery("#tel2").val("");
		jQuery("#tel2").focus();
		return false;
	}
	else if(jQuery("#tel3").val() == "" || isNaN(jQuery("#tel3").val()))
	{
		alert("전화번호를 입력하지 않았거나 숫자만 입력가능합니다.");	
		jQuery("#tel3").val("");
		jQuery("#tel3").focus();
		return false;
	}
	*/
	else if(jQuery("#cell1").val() == "" || isNaN(jQuery("#cell1").val()))
	{
		alert("휴대폰번호를 입력하지 않았거나 숫자만 입력가능합니다.");	
		jQuery("#cell1").val("");
		jQuery("#cell1").focus();
		return false;
	}
	else if(jQuery("#cell2").val() == "" || isNaN(jQuery("#cell2").val()))
	{
		alert("휴대폰번호를 입력하지 않았거나 숫자만 입력가능합니다.");	
		jQuery("#cell2").val("");
		jQuery("#cell2").focus();
		return false;
	}
	else if(jQuery("#cell3").val() == "" || isNaN(jQuery("#cell3").val()))
	{
		alert("휴대폰번호를 입력하지 않았거나 숫자만 입력가능합니다.");	
		jQuery("#cell3").val("");
		jQuery("#cell3").focus();
		return false;
	}
	else if(jQuery("#email1").val() == "")
	{
		alert("이메일을 입력하세요.");	
		jQuery("#email1").val("");
		jQuery("#email1").focus();
		return false;
	}
	else if(jQuery("#email2").val() == "")
	{
		alert("이메일을 선택하거나 직접입력을 선택하여 직접 입력하세요.");	
		jQuery("#email2").val("");
		jQuery("#email2").focus();
		return false;
	}
	else if(!chk_email(jQuery("#email2").val()))
	{
		alert("입력하신 이메일 형식이 올바르지 않습니다. 다시 입력하세요.");	
		jQuery("#email2").val("");
		jQuery("#email2").focus();
		return false;
	}
	
	else if(jQuery("#zip_cd1").val() == "" || jQuery("#addr1").val() == "")
	{
		alert("주소검색 버튼을 이용하여 주소를 등록해야합니다.");	
		return false;
	}
	else if(jQuery("#addr2").val() == "")
	{
		alert("상세주소를 입력하세요.");	
		jQuery("#addr2").val("");

		jQuery("#addr2").focus();
		return false;
	}
	
	return true;
}

function chk_email(value)
{
	var pattern = new RegExp(/^([\w-]+\.)+([a-zA-Z]{2,3}$|[\.]?[a-zA-Z]?$)/);
	
	return pattern.test(value);
}

function chk_member_id()
{
	if(jQuery("#member_id").val() == "")
	{
		alert("아이디를 입력하세요.");
		jQuery("#member_id").val("");
		jQuery("#member_id").focus();
		return;
	}
	else
	{
		getJSON("/json/list/member.getMemberIdCheck.do",{"member_id":jQuery("#member_id").val()},function(data){
			$("body").data("chk_member_id",data);
			var chk_member_id = $("body").data("chk_member_id");
			
			$.each(chk_member_id, function(){
				var data = this["member_id"];
			});

			if(data == "" || data == null)
			{
				jQuery("#check_member_id").html("사용 가능한 아이디 입니다.");
				jQuery("#member_id_chk").val("Y");
				return ;
			}
			else
			{
				jQuery("#check_member_id").html("이미 가입 되어있는 아이디 입니다.");
				jQuery("#member_id").val("");
				jQuery("#member_id").focus();
				return ;
			}
			
		});
	}

}
/*
function open_zipcode()
{
	var param = "";
	
	if(arguments[0]){
		param = "?fun="+arguments[0];
	}
	
	window.open("/addr/road.jsp"+param,"addr","width=570,height=420");
	
	com_juso = true;
}
*/

function open_zipcode(){
	$("#modal_dialog").load("/addr/addr_mobile.jsp", "");
	$("#modal_dialog").dialog({title:'주소검색'}).dialog("open");
}

function setAddr(roadAddrPart1, addrDetail, zipNo, jibunAddr)
{
	var zip = zipNo.split("-");
	jQuery("#zip_cd1").val(zip[0]);
	jQuery("#zip_cd2").val(zip[1]);
	jQuery("#addr1").val(jibunAddr);
	jQuery("#addr2").val(addrDetail);
	$("#modal_dialog").dialog({title:'주소검색'}).dialog("close");
}

function move_tab()
{
	jQuery("#move_form").submit();
}
/* 주소검색*/
function changeAreaList(idx, obj){	
	if(obj.id == '' || obj.id == 'undefined')
		return;
	
	areaIdx = idx;
	
	// 통합검색 
	if(obj.id == 'city1'){
		dataFrom 	= 'city';
		dataTo 		= 'county';
		objFrom		= 'city1';
		objTo		= 'county1';
		objClear	= 'town1_oldaddr';		

		//①세종시예외처리 
		document.getElementById("county1").disabled = false;
		
		if(document.getElementById(obj.id).value =='36'){
			document.getElementById("county1").disabled = true;
			dataTo 		= 'town';
			objTo		= 'town1_oldaddr';
		}
	}
	// 통합검색 
	else if(obj.id == 'county1'){
		dataFrom 	= 'county';
		objFrom		= 'county1';
		objClear	= '';
		dataTo 		= 'town';
		objTo		= 'town1_oldaddr';
	}
	else if(obj.id == 'town1_oldaddr'){
		dataFrom 	= 'town';
		objFrom		= 'town1_oldaddr';
		objClear	= '';
		dataTo 		= 'ri';
		objTo		= 'ri1_oldaddr';
		
	}
	// 통합검색 
	else if(obj.id == 'rd_nm_idx1'){
		dataFrom 	= 'county';
		objFrom		= 'county1';
		objClear	= '';
		
	}

	//	update해야 할 select를 초기화
	clearList(objTo);
	
	//	clear해야 할 select가 설정된 경우 초기화
	
	// from object 선택값이 없으면 return
	if(document.getElementById(objFrom).value == ''){
		return;
	}
	
	var url = "/addr/AjaxRequestXML.jsp?getUrl=http://125.60.46.141/getAreaCode.do?" + escape(createParameter());
	 
  	createXMLHttpRequest();
 	xmlHttp.onreadystatechange = handleStateChange;
  	xmlHttp.open("GET", url, true);
  	xmlHttp.send(null);
}


/*
 *	행정구역 조회 쿼리에 사용할 파라메터값 설정
 */
function createParameter() {
	var valFrom		= document.getElementById(objFrom).value;
	var valTo		= document.getElementById(objTo).value;

	//	시군구>도로명, 시군구>지번주소인 경우
	//	시도코드도 가져가야함

	if(dataFrom == 'county' && (areaIdx == 1 || areaIdx == 3)){
		var cityName = 'city'+areaIdx;
		var cityVal = document.getElementById(cityName).value;
	
		valFrom = cityVal+valFrom;
	
	}else if(dataFrom == 'town' && (areaIdx == 1 || areaIdx == 3)){
		var cityName	= 'city'+areaIdx;
		var countyName	= 'county'+areaIdx;

		if(document.getElementById(cityName).value=='36'){
			valFrom = '36110'+valFrom;
		}else
			valFrom = document.getElementById(cityName).value+document.getElementById(countyName).value+valFrom;
	}

	var queryString = "from="+encodeURI(dataFrom)+"&to="+encodeURI(dataTo)+"&valFrom="+encodeURI(valFrom)+"&valTo="+encodeURI(valTo);

  	return queryString;
}

/*
 *	지정된 행정구역코드 리스트를 초기화
 */
function clearList(obj) {
	if(obj == 'town1_oldaddr'){
		var toObject = document.getElementById(obj);
		  
		toObject.options.length = 0;
		toObject.options[0] = new Option('::선택::', '');
		
		document.getElementById("ri1_oldaddr").options.length = 0;
		document.getElementById("ri1_oldaddr").options[0] = new Option('::선택::', '');
	}
	else if(obj != '' && obj != 'town1_oldaddr'){
	
		var toObject = document.getElementById(obj);
		  
		toObject.options.length = 0;
		toObject.options[0] = new Option('::선택::', '');
	}
}
	
function normalSearch(currentPage){
	var form = document.check;
	if(form.bun1.value == ""){
		alert("번지를 입력하세요.");
		return;
	}
	
	var keyword = "";
	var cityText='',countyText='',townText='',riText='',orgCode='219',orgNm='국민생활체육회';
	var special_pattern = /['~!@#$%^&*|\\\'\'';:\.?]/gi;
	cityText= form.city1.options[form.city1.selectedIndex].text;
	countyText = form.county1.options[form.county1.selectedIndex].text;
	townText = form.town1_oldaddr.options[form.town1_oldaddr.selectedIndex].text;
	riText = form.ri1_oldaddr.options[form.ri1_oldaddr.selectedIndex].text;
	
	if(form.san.checked){
		form.san1.value = '1';
	}else{
		form.san1.value ='0';
	}

	if(form.city1.value == "") cityText = "";
	if(form.county1.value == "") countyText = "";
	if(form.town1_oldaddr.value == "") townText = "";
	if(form.ri1_oldaddr.value == "") riText = "";
	
	form.engineCtpNm.value =cityText;
	form.engineSigNm.value =countyText;
	form.engineEmdNm.value =townText;
	form.engineLiNm.value = riText;
	form.engineBdMaSn.value= form.bun1.value;
	form.engineBdSbSn.value = form.bun2.value;
	form.engineMtYn.value= form.san1.value;
	form.currentPage.value =currentPage;

	if(cityText == ''){
		alert('시군구를 선택해 주세요');
		return;
	}

	var url;
	
	url = "/addr/AjaxRequestXML.jsp?getUrl="+escape("http://125.60.46.141/link/search.do?extend=false&mode=jibun_search&searchType=location_jibun&topTab=1&engineCtpNm="+encodeURI(cityText)+"&engineSigNm="+encodeURI(countyText)+"&engineEmdNm="+encodeURI(townText)+"&engineLiNm="+encodeURI(riText)+"&engineBdMaSn="+encodeURI(form.bun1.value)+"&engineBdSbSn="+encodeURI(form.bun2.value)+"&engineMtYn="+encodeURI(form.san1.value)+"&currentPage="+currentPage+"&orgCode="+orgCode+"&orgNm="+encodeURI(orgNm));
	
	createXMLHttpRequest();
	
 	xmlHttp.onreadystatechange = handleStateChangeSearch;
  	xmlHttp.open("GET", url, true);
  	xmlHttp.send(null);
}

function normalSearch2(currentPage){
	var url;
	var form = document.check;
	form.currentPage.value =currentPage;
	var orgCode='219',orgNm='국민생활체육회';

	currentPage=parseInt((currentPage/10)+1);
	
	url = "/addr/AjaxRequestXML.jsp?getUrl="+escape("http://125.60.46.141/link/search.do?extend=false&mode=jibun_search&searchType=location_jibun&topTab=1&engineCtpNm="+encodeURI(form.engineCtpNm.value)+"&engineSigNm="+encodeURI(form.engineSigNm.value)+"&engineEmdNm="+encodeURI(form.engineEmdNm.value)+"&engineLiNm="+encodeURI(form.engineLiNm.value)+"&engineBdMaSn="+form.engineBdMaSn.value+"&engineBdSbSn="+form.engineBdSbSn.value+"&engineMtYn="+form.engineMtYn.value+"&currentPage="+currentPage+"&orgCode="+orgCode+"&orgNm="+encodeURI(orgNm));


	createXMLHttpRequest();
	
 	xmlHttp.onreadystatechange = handleStateChangeSearch;
  	xmlHttp.open("GET", url, true);
  	xmlHttp.send(null);
}

</script>
<script src="/addr/common_c.js"></script>
<div class="wrap">
    <div class="title_rocation"><img src="/images/mobile/join/title_rocation3.gif" alt=""></div>

    <div class="j_wrap">

      <div class="j_visual"><img src="/images/mobile/join/jm_img1.gif" alt="국내최대 자동차 중고부품 쇼핑몰 PARTS MOA에 오신 것을 환영합니다"></div>
      
      <div class="join_tab">
        <a href="javascript:;"><img src="/images/mobile/join/j_tab1_on.gif" alt="개인회원"></a>
        <a href="javascript:;"><img src="/images/mobile/join/j_tab2_off.gif" alt="사업자회원" onclick = "move_tab();"></a>
      </div>
	<form method = "post" name = "join_form" id = "join_form" action = "/mobile/join/join_4.do" onsubmit = "return join_form_chk();">
		<input type = "hidden" name = "mode" value = "minsert"/>
		<input type = "hidden" name = "ipin" value = "<%=request.getParameter("ipin")%>"/>
		<input type = "hidden" name = "group_seq" value = "2"/>
		<input type = "hidden" name = "member_type" value = "1"/>
      <div class="j_write">

        <h5><span><img src="/images/join/j_write_title1.gif" alt="회원정보 입력"></span> <span class="s_text">[ <b>*</b> 표시된 항목은 필수사항입니다. ]</span></h5>

        <table class="join_style_1">
        <colgroup>
        <col width="23%">
        <col width="">
        </colgroup>
        <tbody>

        <tr>
          <th scope="row"><b>*</b> 아이디</th>
          <td>
            <p><input type="text" id="member_id" name="member_id" class="input_j1 ws_1" placeholder="아이디를 입력해 주세요."> <a onclick = "chk_member_id();" class="btn_type_1" href="javascript:;"><img class="btn" src="/images/join/jw_btn1_off.gif" alt="아이디 중복확인"></a></p>
             <br>
            <div id = "check_member_id"></div>
            <p class="c1">※ 6~15자의 영문과 숫자만 사용 가능합니다.  </p>
            <input type = "hidden" name = "member_id_chk" id = "member_id_chk" value = ""/></td>
          </td>
        </tr>

        <tr>
          <th scope="row"><b>*</b> 비밀번호</th>
          <td><input type="password" id="member_pw" name="member_pw" class="input_j1 ws_2" placeholder="비밀번호를 입력해 주세요"></td>
        </tr>

        <tr>
          <th scope="row"><b>*</b> 비밀번호확인</th>
          <td>
            <p><input type="password" id="member_pw_chk" name="member_pw_chk" class="input_j1 ws_2" placeholder="비밀번호를 다시한번 입력해 주세요"></p>
            <p class="c1">※ 6~15글자 이내, 영문 대/소문자,  숫자 및 특수문자 사용가능</p>
          </td>
        </tr>

        <tr>
          <th scope="row" class="fv_1">이름 (실명)</th>
           <td class="fs_2"><%=request.getParameter("member_nm")%><input type = "hidden" name = "member_nm" id = "member_nm" value = "<%=request.getParameter("member_nm")%>"></td> 
        	<!--<td class="fs_2"><input type = "hidden" name = "member_nm" id = "member_nm" value = ""></td> -->
        </tr>

        <tr>
          <th scope="row">전화번호</th>
          <td>
            <select id="tel1" name="tel1" class="select_j1">
	          <option value = "02" selected>02</option>
	          <option value = "051">051</option>
	          <option value = "053">053</option>
	          <option value = "032">032</option>
	          <option value = "062">062</option>
	          <option value = "042">042</option>
	          <option value = "052">052</option>
	          <option value = "044">044</option>
	          <option value = "031">031</option>
	          <option value = "033">033</option>
	          <option value = "043">043</option>
	          <option value = "041">041</option>
	          <option value = "063">063</option>
	          <option value = "061">061</option>
	          <option value = "054">054</option>
	          <option value = "055">055</option>
	          <option value = "064">064</option>
	          <option value = "070">070</option>
	          <option value = "080">080</option>
	        </select>
            - <input type="text" id="tel2" name="tel2" class="input_j1 ws_4" maxlength = "4"> - <input type="text" id="tel3" name="tel3" class="input_j1 ws_4" maxlength = "4">
          </td>
        </tr>

        <tr>
          <th scope="row"><b>*</b> 휴대폰번호</th>
          <td><input type="text" id="cell1" name="cell1" class="input_j1 ws_3" maxlength = "3"> - <input type="text" id="cell2" name="cell2" class="input_j1 ws_4" maxlength = "4"> - <input type="text" id="cell3" name="cell3" class="input_j1 ws_4" maxlength = "4"></td>
        </tr>

        <tr>
          <th scope="row" class="fs_1">알림 설정</th>
          <td><label><input type="checkbox" id="sms_yn" name="sms_yn" class="check" value = "Y"> 휴대폰 알림문자를 받겠습니다.</label></td>
        </tr>

        <tr>
          <th scope="row"><b>*</b> 이메일</th>
          <td>
            <input type="text" id="email1" name="email1" class="input_j1 ws_5"> 
            @ 
            <input type="text" id="email2" name="email2" class="input_j1 ws_5" readonly value = "naver.com">
            <select id="" name="" class="select_j2" onchange = "inputEmail2(this.value);">
	          <option value="hanmail.net">hanmail.net</option>
	          <option value="naver.com" selected>naver.com</option>
	          <option value="daum.net">daum.net</option>
	          <option value="nate.com">nate.com</option>
	          <option value="gmail.com">gmail.com</option>
	          <option value="korea.com">korea.com</option>
	          <option value="dreamwiz.com">dreamwiz.com</option>
	          <option value="hotmail.com">hotmail.com</option>
	          <option value="yahoo.co.kr">yahoo.co.kr</option>
	          <option value="sportal.or.kr">sportal.or.kr</option>
	          <option value = "">직접입력</option>
	        </select>
          </td>
        </tr>

        <tr>
          <th scope="row" class="fs_1">광고성 메일 수신</th>
          <td>
            <p><label><input type="checkbox" id="email_yn" name="email_yn" value = "Y" class="check"> 수신함</label> <label style="margin-left:15px;"><input type="checkbox" id="email_yn" name="email_yn" value = "N" class="check"> 수신안함</label></p>
            <p class="c2">
            ※ 주요 공지사항 및 알림 등은 설정에 관계 없이 발송되며,<br>
            설정변경은 고객센터&gt;회원정보 에서 변경 가능합니다.
            </p>
          </td>
        </tr>

        <tr>
          <th scope="row"><b>*</b> 주소</th>
          <td>
            <p><input type="text" id="zip_cd1" name="zip_cd1" class="input_j1 ws_5" readonly> - <input type="text" id="zip_cd2" name="zip_cd2" class="input_j1 ws_5" readonly> <a class="btn_type_1" href="javascript:open_zipcode();"><img class="btn" src="/images/join/jw_btn2_off.gif" alt="주소검색"></a></p>
            <p style="margin-top:8px;"><input type="text" id="addr1" name="addr1" class="input_j1 ws_6" readonly></p>
          </td>
        </tr>
        <tr>
          <th scope="row">상세주소</th>
          <td><input type="text" id="addr2" name="addr2" class="input_j1 ws_6"></td>
        </tr>

        </tbody>
        </table>

      </div>
      <div class="j_btn1"><input type = "image" src = "/images/join/jw_bottom_btn.gif"></div>
	</form>
    </div>
  </div>
  <div>
  	<div id="modal_dialog"></div>
  </div>
  <form name = "move_form" id = "move_form" method = "post" action = "/mobile/join/join_3_2.do">
	<input type = "hidden" name = "member_nm" value = "<%=request.getParameter("member_nm")%>"/>
	<input type = "hidden" name = "ipin" name = "<%=request.getParameter("ipin")%>"/>
	</form>
</body>
</html>
