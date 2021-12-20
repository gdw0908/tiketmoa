package com.mc.web.goods.spell;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.googlecode.ehcache.annotations.TriggersRemove;
import com.googlecode.ehcache.annotations.When;
import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;

@Controller
@RequestMapping("/admin/goods/spell/specification_pop.do")
public class SpecificationController {
	

	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private SpecificationDAO specificationDAO;
	
	@RequestMapping(params="!method")
	public String _default(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return view(params, request, session);
	}
	
	@RequestMapping(params="method=list")
	public String view(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		MCMap specification = (MCMap) specificationDAO.getView(params);
		request.setAttribute("specification", specification);
		request.setAttribute("params", params);

		return "/admin/goods/spell/specification_pop";
	}

}
