<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="dtf" uri="/WEB-INF/tlds/DateUtil_fn.tld"%>
<%@ taglib prefix="suf" uri="/WEB-INF/tlds/StringUtil_fn.tld"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta
	content="minimum-scale=1.0, width=device-width, maximum-scale=1, user-scalable=yes"
	name="viewport" />
<meta name="author" content="31system" />
<meta name="description" content="안녕하세요  티켓모아 입니다." />
<meta name="Keywords"
	content="티켓모아, 음향기기, 중고음향기기, 중고악기, 중고 쇼핑몰, 중고 악기 쇼핑몰, 중고 음향기기 쇼핑몰" />
<title>주문/반품/교환/조회</title>

<link rel="stylesheet"
	href="/lib/css/redmond/jquery-ui-1.9.1.custom.min.css" type="text/css">
<script type="text/javascript"
	src="/lib/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/lib/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/lib/js/jquery.lck.util.js"></script>
<script type="text/javascript">
	$(function() {

		// 햄버거 메뉴
		$(document).ready(function() {
			$('.ham_wrap').click(function() {
				$(this).toggleClass('open');
				$('.mo_menu_wrap').toggleClass('active');
				$('.mo_bg').toggleClass('active');
			});
		});

		//전체 카테고리
		$("#allmenu_open").click(function() {
			$('i.xi-bars').toggleClass('xi-close');
		});

		$("#sdate,#edate").datepicker();

		$.ajaxSetup({
			cache : false
		});

		$("td[orderno]").each(function() {
			var _o = $("td[orderno='" + $(this).attr("orderno") + "']");
			var size = _o.size();
			if (size > 1) {
				$(this).attr("rowspan", size);
				_o.last().remove();
			}
		});
		$("#modal_dialog").dialog({
			autoOpen : false,
			modal : true,
			width : "1100",
			height : "750"
		});

		$("#modal_dialog2").dialog({
			autoOpen : false,
			modal : true,
			width : "1100",
			height : "380"
		});
	});

	function cancel_popup(cart_no) {
		$("#modal_dialog").load(
				"/popup/mypage/shopping/state/index.do?mode=cancel_popup", {
					cart_no : cart_no
				});
		$("#modal_dialog").dialog({
			title : '취소신청'
		}).dialog("open");
	}

	function status_popup(cart_no) {
		$("#modal_dialog2").load(
				"/popup/mypage/shopping/state/index.do?mode=status_popup", {
					cart_no : cart_no
				});
		$("#modal_dialog2").dialog({
			title : '자세히보기'
		}).dialog("open");
	}

	function pay_cancel(cart_no) {
		if (!confirm("정말 취소 하시겠습니까?")) {
			return;
		}
		$("#modal_dialog").load(
				"/popup/mypage/shopping/state/index.do?mode=pay_cancel", {
					cart_no : cart_no,
					sayu : $('#sayu').val()
				});
		$("#modal_dialog").dialog("open");
	}

	function payCancelBank(f) {
		if (!confirm("정말 취소 하시겠습니까?")) {
			return;
		}
		if (f.bank.value == "") {
			alert("환불 받으실 은행을 선택해 주시기 바랍니다.");
			f.bank.focus();
			return false;
		}
		if (f.accountNo.value == "") {
			alert("환불 받으실 계좌번호를 입력해 주시기 바랍니다.");
			f.accountNo.focus();
			return false;
		}
		$("#modal_dialog").load(
				"/popup/mypage/shopping/state/index.do?mode=pay_cancel", {
					cart_no : f.cart_no.value,
					sayu : f.sayu.value,
					form_submit : f.form_submit.value,
					bank : f.bank.value,
					accountNo : f.accountNo.value
				});
		$("#modal_dialog").dialog("open");
	}

	function return_popup(cart_no) {
		$("#modal_dialog").load(
				"/popup/mypage/shopping/state/index.do?mode=return_popup", {
					cart_no : cart_no
				});
		$("#modal_dialog").dialog({
			title : '반품신청'
		}).dialog("open");
	}

	function return_send(cart_no) {
		$("#modal_dialog").load(
				"/popup/mypage/shopping/state/index.do?mode=return_send", {
					cart_no : cart_no,
					sayu : $('#sayu').val()
				});
		$("#modal_dialog").dialog("open");
	}

	function exchange_popup(cart_no) {
		$("#modal_dialog").load(
				"/popup/mypage/shopping/state/index.do?mode=exchange_popup", {
					cart_no : cart_no
				});
		$("#modal_dialog").dialog({
			title : '교환신청'
		}).dialog("open");
	}

	function exchange_send(cart_no) {
		$("#modal_dialog").load(
				"/popup/mypage/shopping/state/index.do?mode=exchange_send", {
					cart_no : cart_no,
					sayu : $('#sayu').val()
				});
		$("#modal_dialog").dialog("open");
	}

	function refunds_popup(cart_no) {
		$("#modal_dialog").load(
				"/popup/mypage/shopping/state/index.do?mode=refunds_popup", {
					cart_no : cart_no
				});
		$("#modal_dialog").dialog({
			title : '환불신청'
		}).dialog("open");
	}

	function refunds_send(cart_no) {
		$("#modal_dialog").load(
				"/popup/mypage/shopping/state/index.do?mode=refunds_send", {
					cart_no : cart_no
				});
		$("#modal_dialog").dialog("open");
	}

	function cancelBank(f) {
		if (f.bank.value == "") {
			alert("환불 받으실 은행을 선택해 주시기 바랍니다.");
			f.bank.focus();
			return false;
		}
		if (f.accountNo.value == "") {
			alert("환불 받으실 계좌번호를 입력해 주시기 바랍니다.");
			f.accountNo.focus();
			return false;
		}

		$("#modal_dialog").load(
				"/popup/mypage/shopping/state/index.do?mode=refunds_send", {
					cart_no : f.cart_no.value,
					form_submit : f.form_submit.value,
					bank : f.bank.value,
					accountNo : f.accountNo.value
				});
		$("#modal_dialog").dialog("open");
	}

	function week() {
		var sdt = new Date();
		sdt.setDate(sdt.getDate() - 7);
		var edt = new Date();

		$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
		$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
	}
	function day15() {
		var sdt = new Date();
		sdt.setDate(sdt.getDate() - 15);
		var edt = new Date();

		$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
		$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
	}
	function month1() {
		var today = new Date();
		var sdt = new Date(today.getFullYear(), today.getMonth() - 1, today
				.getDate());
		var edt = new Date();

		$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
		$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
	}
	function month3() {
		var today = new Date();
		var sdt = new Date(today.getFullYear(), today.getMonth() - 3, today
				.getDate());
		var edt = new Date();

		$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
		$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
	}
	function bmonth() {
		var today = new Date();
		var sdt = new Date(today.getFullYear(), today.getMonth() - 1, 1);
		var edt = new Date(today.getFullYear(), today.getMonth(), 0);

		$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
		$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
	}
	function cmonth() {
		var today = new Date();
		var sdt = new Date(today.getFullYear(), today.getMonth(), 1);
		var edt = new Date(today.getFullYear(), today.getMonth() + 1, 0);

		$("#sdate").val($.datepicker.formatDate('yy-mm-dd', sdt));
		$("#edate").val($.datepicker.formatDate('yy-mm-dd', edt));
	}

	function track(cart_no) {
		window.open("/popup/mypage/shopping/state/index.do?mode=track&cart_no="
				+ cart_no, "delivery",
				"width=1000,height=750, scrollbars=yes, resizable=yes");
	}

	function goSubmit() {
		$("#searchFrm").submit();
	}
</script>
</head>
<body>
	<div id="sub">
		<div class="contents">

			<div class="period_line">
				<form id="searchFrm" name="searchFrm" action="index.do?mode=list2"
					method="post">

					<p class="title">기간별조회</p>

					<ul>
						<li><a class="first" href="#" onclick="week();">1주일</a></li>
						<li><a href="#" onclick="day15();">15일</a></li>
						<li><a href="#" onclick="month1();">1개월</a></li>
						<li><a href="#" onclick="month3();">3개월</a></li>
						<li class="cut"><a class="first" href="#" onclick="bmonth();">전월</a></li>
						<li><a href="#" onclick="cmonth();">당월</a></li>
					</ul>

					<div class="inquiry_top">
						<input type="text" id="sdate" name="sdate" value="${param.sdate }">
						~ <input type="text" id="edate" name="edate"
							value="${param.edate }"> <a href="javascript:goSubmit();"
							class="lockup_btn">조회하기</a>
					</div>
				</form>
			</div>

			<article class="table_container">
				<table class="cart_style_1 t_top_style_1">
					<colgroup>
						<col width="18%">
						<col width="">
						<col width="26%">
						<col width="18%">
					</colgroup>

					<thead>
						<tr>
							<th scope="col">주문번호/날짜</th>
							<th scope="col">&nbsp;</th>
							<th scope="col">상태</th>
							<th scope="col">확인</th>
						</tr>
					</thead>

					<tbody>
						<c:choose>
							<c:when test="${fn:length(data.list) == 0}">
								<td class="b_none none_td" colspan="4">
									<p class="none_img">
										<img src="/images/sub_2/none_cart.gif" alt="상품없음이미지">
									</p>
									<p class="none_text">상품이 존재하지 않습니다.</p>
								</td>

							</c:when>
							<c:otherwise>
								<c:forEach var="item" items="${data.list }" varStatus="status">
									<c:set var="status_view" value="N" />
									<c:if
										test="${(item.status eq '2') or (item.status eq '3') or (item.status eq '4') or (item.status eq '5') or (item.status eq '19') or (item.status eq '10') or (item.status eq '12') or (item.status eq '20') or (item.status eq '21') or (item.status eq '22') }">
										<%-- 취소 종류일 경우 --%>
										<c:set var="status_view" value="Y" />
									</c:if>
									<tr>
										<td orderno="${item.orderno }">
											<p class="date">${item.orderno }</p>
											<p>${dtf:simpleDateFormat(item.orderdate, 'yyyy-MM-dd HH:mm:ss' , 'yyyy-MM-dd') }</p>
										</td>
										<td class="cart_main">
											<div class="product_box">
												<div class="pb_l">
													<a href="#"><img src="${item.thumb }" alt=""></a>
												</div>
												<div class="pb_r_2">
													<p>
														<a href="#"> <span> <strong>${item.part3_nm }
																	/ ${item.carmodelnm } ${item.cargradenm }
																	(${item.caryyyy }) / ${item.grade }급</strong> <c:if
																	test="${item.discount_rate > 0}">
																	<span class="f_style_1">${item.discount_rate }%↓</span>
																</c:if>
														</span> <span>${item.com_nm } / ${item.sigungu_nm }</span>
														</a>
													</p>
													<p class="last">
														<b class="c1">${suf:getThousand(item.amt) }
															원(수량:${item.qty })</b>
														<c:if test="${item.cod_yn eq 'Y' }">
															<b class="c1">배송비 ${suf:getThousand(item.fee_amt) } 원</b>
														</c:if>
														<c:if test="${status_view eq 'Y'}">
															<a href="javascript:status_popup('${item.cart_no }')"><img
																src="/images/sub_2/cart_btn2.gif" alt="상세내역"></a>
														</c:if>
													</p>
												</div>
											</div>
										</td>
										<td>
											<p class="status_back status_${item.status }">${item.status_nm }</p>
											<c:if test="${item.status eq '7' || item.status eq '8' }">
												<p class="btn_m2">
													<a href="#" onclick="track('${item.cart_no}')"><img
														src="/images/sub_2/btn_trace.gif" alt="배송추적"></a>
												</p>
											</c:if>
										</td>
										<td class="b_none"><c:if
												test="${item.status eq '11' || item.status eq '12' }">
												<p class="btn_m1">
													<a href="#" onclick="refunds_popup('${item.cart_no}');"><img
														src="/images/sub_2/btn_type_b5.gif" alt="환불신청"></a>
												</p>
											</c:if> <c:if test="${item.status eq '18' }">
												<p class="btn_m1">
													<a href="#"><img src="/images/sub_2/btn_type_a1.gif"
														alt="수취확인"></a>
												</p>
											</c:if></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>

					</tbody>

				</table>
			</article>

		</div>
	</div>

	<div id="modal_dialog" title="취소신청"></div>
	<div id="modal_dialog2" title="취소신청"></div>
</body>