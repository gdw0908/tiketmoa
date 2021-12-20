package com.mc.web.category;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin/category/menuTree.do")
public class MenuTreeController {
	

	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private MenuTreeDAO menuTreeDAO;
	
	@RequestMapping(params="!mode")
	public String _default(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return list(params, request, session);
	}
	
	@RequestMapping(params="mode=list")
	public String list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		request.setAttribute("menuTreeList", menuTreeDAO.getList(params));
		return "/admin/goods/inventory/menuTree";
	}

}
