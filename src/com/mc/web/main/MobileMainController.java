package com.mc.web.main;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mc.web.Globals;

@Controller
public class MobileMainController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private MainService mainService;
	
	@Autowired
	private Globals globals;
	/*
	@RequestMapping("/inc/gnb.do")	
	public String updateCodeOrderSeq(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		model.addAttribute("main", mainService.menu_category(params));
		return "/inc/gnb";
	}
	
	@RequestMapping("/inc/header.do")	
	public String header(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		model.addAttribute("list", mainService.headerList(params));
		return "/inc/header";
	}
	*/
	
	@RequestMapping("/mobile/popup/latest_part.do")	
	public String latest_part(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		model.addAttribute("data", mainService.mobile_latest_part(params));
		return "/mobile/latest_part";
	}
	
	@RequestMapping("/mobile/index.do")	
	public String main(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		model.addAttribute("list", mainService.mainList(params,request));
		return "/mobile/index";
	}
	@RequestMapping("/inc/mobile_mymenu.do")	
	public String mymenu(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		model.addAttribute("list", mainService.mymenu(params));
		return "/inc/mobile_mymenu";
	}
	
	@RequestMapping("/inc/mobile_header.do")	
	public String mobile_header(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		model.addAttribute("list", mainService.mobile_header());
		return "/inc/mobile_header";
	}
}
