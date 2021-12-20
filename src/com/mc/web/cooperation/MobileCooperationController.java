package com.mc.web.cooperation;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
/**
 * 
 *
 * @Description : 
 * @ClassName   : com.mc.web.cooperation.CooperationController.java
 * @Modification Information
 *
 * @author 오승택
 * @since 2015. 3. 17.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class MobileCooperationController {
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private CooperationService cooperationService;
	
	@RequestMapping("/mobile/cooperation/list.do")
	public String list(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", cooperationService.list(params));
		return "mobile/cooperation/list";
	}

	@RequestMapping("/mobile/cooperation/view.do")
	public String view(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", cooperationService.view(params));
		return "mobile/cooperation/view";
	}
	
	@RequestMapping("/mobile/popup/cooperation/other_list.do")
	public String other_list(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", cooperationService.other_list(params));
		return "mobile/cooperation/other_list";
	}
	
	@RequestMapping("/mobile/cooperation/repair_list.do")
	public String repair_list(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", cooperationService.repair_list(params));
		return "mobile/cooperation/repair_list";
	}
	
	@RequestMapping("/mobile/cooperation/repair_view.do")
	public String repair_view(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", cooperationService.repair_view(params));
		return "mobile/cooperation/repair_view";
	}
}
