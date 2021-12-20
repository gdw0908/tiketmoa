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
public class CooperationController {
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private CooperationService cooperationService;
	
	@RequestMapping("/cooperation/list.do")
	public String list(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", cooperationService.list(params));
		return "cooperation/list";
	}

	@RequestMapping("/cooperation/view.do")
	public String view(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", cooperationService.view(params));
		return "cooperation/view";
	}
	
	@RequestMapping("/popup/cooperation/other_list.do")
	public String other_list(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", cooperationService.other_list(params));
		return "cooperation/other_list";
	}
	
	@RequestMapping("/cooperation/repair_list.do")
	public String repair_list(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", cooperationService.repair_list(params));
		return "cooperation/repair_list";
	}
	
	@RequestMapping("/cooperation/repair_view.do")
	public String repair_view(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", cooperationService.repair_view(params));
		return "cooperation/repair_view";
	}
}
