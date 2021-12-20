package com.mc.web.category;

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
@RequestMapping("/admin/goods/inventory/inventory_cate.do")
public class CategoryController {
	

	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private CategoryDAO categoryDAO;
	
	@RequestMapping(params="!method")
	public String _default(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return list(params, request, session);
	}
	
	@RequestMapping(params="method=list")
	public String list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		if(StringUtil.isEmptyByParam(params, "cpage")) params.put("cpage", "1");
	
		MCMap article = (MCMap) categoryDAO.getArticle(params);
		MCMap lastest = (MCMap) categoryDAO.getUpCodeData(params);
		MCMap orderCount = (MCMap) categoryDAO.getUpCodeCount(params);
		
		params.put("rows", "10");
		
		request.setAttribute("page_info", categoryDAO.getPageInfo(params));
		request.setAttribute("servletPath", request.getServletPath());
		request.setAttribute("orderCount", orderCount);
		request.setAttribute("article", article);
		request.setAttribute("lastest", lastest);
		request.setAttribute("list", categoryDAO.getChildList(params));
		
		request.setAttribute("params", params);

		return "/admin/goods/inventory/inventory_cate";
	}
	
	
	@RequestMapping(params="method=insert")
	@TriggersRemove(cacheName="mainCache", removeAll=true, when=When.AFTER_METHOD_INVOCATION)
	public String insert(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		if(params.get("codeNo").length() <= 12)
		{
			categoryDAO.getInsertRow(params);
			
			if(StringUtil.isEmptyByParam(params, "cpage")) params.put("cpage", "1");
			
			params.put("rows", "10");
			
			request.setAttribute("servletPath", request.getServletPath());
			request.setAttribute("page_info", categoryDAO.getPageInfo(params));
			request.setAttribute("params", params);
			
			request.setAttribute("message", "등록되었습니다.");
			request.setAttribute("redirect", "/admin/goods/inventory/inventory_cate.do");
			return "message";
		}
		else
		{
			request.setAttribute("message", "더이상 하위메뉴를 등록할수 없습니다.");
			request.setAttribute("redirect", "/admin/goods/inventory/inventory_cate.do");
			return "message";
		}
		
	
	}
	
	
	@RequestMapping(params="method=delete")
	@TriggersRemove(cacheName="mainCache", removeAll=true, when=When.AFTER_METHOD_INVOCATION)
	public String delete(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		categoryDAO.getUpdateUseData(params);
		
		if(StringUtil.isEmptyByParam(params, "cpage")) params.put("cpage", "1");
		
		params.put("rows", "10");
		
		request.setAttribute("servletPath", request.getServletPath());
		request.setAttribute("page_info", categoryDAO.getPageInfo(params));
		request.setAttribute("params", params);
		request.setAttribute("redirect", "/admin/goods/inventory/inventory_cate.do");

		request.setAttribute("message", "삭제되었습니다.");
		request.setAttribute("redirect", "/admin/goods/inventory/inventory_cate.do");
		return "message";
		
	}
	
	@RequestMapping(params="method=update")
	@TriggersRemove(cacheName="mainCache", removeAll=true, when=When.AFTER_METHOD_INVOCATION)
	public String update(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		if(params.get("qry_method").equals("qry_update"))
		
			categoryDAO.getUpdateModifyData(params);
		else
			categoryDAO.getInsertQry(params);
			
		if(StringUtil.isEmptyByParam(params, "cpage")) params.put("cpage", "1");
		
		params.put("rows", "10");
		
		request.setAttribute("servletPath", request.getServletPath());
		request.setAttribute("page_info", categoryDAO.getPageInfo(params));
		request.setAttribute("params", params);
		
		request.setAttribute("message", "수정되었습니다.");
		request.setAttribute("redirect", "/admin/goods/inventory/inventory_cate.do");
		return "message";
	}


}
