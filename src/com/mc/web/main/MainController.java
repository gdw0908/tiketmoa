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
import org.springframework.web.bind.annotation.ResponseBody;

import com.mc.web.Globals;

@Controller
public class MainController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private MainService mainService;
	
	@Autowired
	private Globals globals;
	
	@RequestMapping("/inc/gnb.do")	
	public String updateCodeOrderSeq(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		model.addAttribute("main", mainService.menu_category());
		return "/inc/gnb";
	}
	
	@RequestMapping("/popup/latest_part.do")	
	public String latest_part(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		model.addAttribute("data", mainService.latest_part(params));
		return "latest_part";
	}
	
	@RequestMapping("/inc/header.do")	
	public String header(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		model.addAttribute("list", mainService.headerList());
		return "/inc/header";
	}

	@RequestMapping("inc/all_menu_box.do")	
	public String all_menu(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		model.addAttribute("data", mainService.all_menu());
		return "/inc/all_menu_box";
	}
	
	@RequestMapping("/index.do")	
	public String main(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		model.addAttribute("list", mainService.mainList(params,request));
		return "/index";
	}

	@ResponseBody
	@RequestMapping("/autocomplete.do")
	public Map autocomplete(ModelMap model, HttpServletRequest request, @RequestParam Map<String, String> params, @RequestParam(value = "prefix", required = false, defaultValue = "") String prefix) throws Exception {
		return mainService.autocomplete(prefix);
	}
}
