<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld" %>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld" %>
<div class="all_menu_box" style="display:none;" id="all_menu">
    <div class="all_menu_wrap">
      <div class="menu_con_box">
        <div class="viewcate">
          <h3><a href="/goods/list.do?menu=menu1">갤러리아</a></h3>
        </div>
        <div class="viewcate">
          <h3><a href="/goods/list.do?menu=menu2">신세계</a></h3>
        </div>
        <div class="viewcate">
          <h3><a href="/goods/list.do?menu=menu3">롯데</a></h3>
        </div>
      </div>
    </div>
  </div>
  
  <script>
  	$(function() {
  		$('.viewcate').hover(function() {
  			$('.all_menu_box').addClass('active');
  			$(this).find('ul').addClass('active');
  		}, function() {
  			$(this).find('ul').removeClass('active');
  			$('.all_menu_box').removeClass('active');
  		})
  	});
  </script>