<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="sub_wrap">
<div id="header" style="overflow:auto;border-bottom:0px;">
<div class="h_top" style="height:auto;">
  <h1 style="width:100%;text-align:center;margin-bottom:10px;">견적의뢰자 이름</h1>
  <div class="search_box" style="width:100%;">
    <form action="quotation_list.do" name="articleSearchForm" id="articleSearchForm" method="post" onsubmit="return goPage(1);">
	  <input type="hidden" name="rows" value="10">
	  <input type="hidden" name="cpage" value="1">
	  <input type="hidden" name="type_state" value="0">
	  <input type="hidden" name="condition" value="REG_NM">
    <fieldset>
    <legend>Parts MOA 통합검색</legend>
    <div class="search_top">
      <span class="search"><input type="text" id="search_all_text" name="keyword" value="" class="main_search" title="검색바"></span>
      <span class="btn_search"><a href="javascript:document.articleSearchForm.submit();"><img src="/images/header/search.gif" alt="검색"></a></span>
    </div>
    </fieldset>
    </form>
  </div>
  </div>
</div>
</div>