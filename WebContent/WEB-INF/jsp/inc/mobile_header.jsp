<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="header">
<div class="h_top">
  <h1><a href="/mobile"><img src="/images/logo/logo.gif" alt="국내최대 자동차 중고부품 쇼핑몰 PARTSMOA"></a></h1>
  <div class="search_box">
    <form action="/mobile/goods/list.do" method="post" id="frmall" name="frmall">
    <fieldset>
    <legend>Parts MOA 통합검색</legend>
    <div class="search_top">
      <span class="search"><input type="text" id="search_all_text" name="search_all_text" value="${param.search_all_text }" class="main_search" title="Parts MOA 통합검색"></span>
      <span class="btn_search"><a href="javascript:document.frmall.submit();"><img src="/images/header/search.gif" alt="검색"></a></span>
    </div>
    </fieldset>
    </form>
  </div>
  </div>
  <div class="total_product">
      <span class="total_t">총 부품수량 : </span>
      <span class="total_n"><b><fmt:parseNumber var="total_goods_cnt" value="${list.total_goods_cnt + 90000 }" integerOnly="true" type="number"/>${suf:getThousand(total_goods_cnt) }</b> 개</span>
      </div>
</div>