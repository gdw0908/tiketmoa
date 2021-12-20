package com.mc.web.admin;

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
import com.mc.web.MCMap;

@Controller
public class AdminController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private Globals globals;
	
	@RequestMapping("/admin/inc/header.do")	
	public String updateCodeOrderSeq(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		MCMap member = (MCMap) session.getAttribute("member");
		params.put("com_seq", (String) member.get("com_seq"));
		params.put("group_seq", (String) member.get("group_seq"));
		model.addAttribute("data", adminService.header(params));
		return "/admin/inc/header";
	}
}
