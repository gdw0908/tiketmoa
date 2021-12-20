package com.mc.web.category;

import java.util.Map;
import java.util.Calendar;

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
import com.mc.web.Globals;
import com.mc.web.MCMap;

@Controller
@RequestMapping({"/admin/goods/inventory/inventory_md_2.do"})
public class CategoryMDGoodsController {
	

	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private CategoryMDGoodsDAO CategoryMDGoodsDAO;
	
	@RequestMapping(params="!method")
	public String _default(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return list(params, request, session);
	}
	
	@RequestMapping(params="method=list")
	public String list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		Calendar cal = Calendar.getInstance();
		
		if(StringUtil.isEmptyByParam(params, "cpage")) params.put("cpage", "1");
		
		params.put("rows", "10");
		params.put("getYear", Integer.toString(cal.YEAR));
		params.put("upcodeno", "050901");
		
		request.setAttribute("goodsList", CategoryMDGoodsDAO.getMDGoodsList(params));
		request.setAttribute("goodsSearchCarmaker", CategoryMDGoodsDAO.goodsSearchCarmaker(params));
		
		request.setAttribute("goodsSearchcodemst", CategoryMDGoodsDAO.goodsSearchCODEMST(params));
		request.setAttribute("goodsSearchList", CategoryMDGoodsDAO.getMDGoodsSearchList(params));
		request.setAttribute("page_info", CategoryMDGoodsDAO.getMDGoodsSearchPaging(params));
		request.setAttribute("servletPath", request.getServletPath());
		
		request.setAttribute("params", params);

		return "/admin/goods/inventory/inventory_md_2";
	}
	
	@RequestMapping(params="method=delete")
	@TriggersRemove(cacheName="mainCache", removeAll=true, when=When.AFTER_METHOD_INVOCATION)
	public String delete(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		//CategoryMDDAO.deleteService(params);
		
		
		if(params.get("seq").indexOf(",") != -1)
		{
			String[] value = params.get("seq").split(",");
			
			for(int i = 0; i < value.length; i ++)
			{
				params.put("seq", value[i]);
				CategoryMDGoodsDAO.deleteMDGoodsService(params);
			}
		}
		else
		{
			CategoryMDGoodsDAO.deleteMDGoodsService(params);
		}
		
		
		
		request.setAttribute("servletPath", request.getServletPath());
		request.setAttribute("params", params);
		request.setAttribute("message", "삭제 되었습니다.");
		request.setAttribute("redirect", "/admin/goods/inventory/inventory_md_2.do");
		return "message";
	}
	
	@RequestMapping(params="method=insert")
	@TriggersRemove(cacheName="mainCache", removeAll=true, when=When.AFTER_METHOD_INVOCATION)
	public String insert(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		MCMap article = (MCMap) CategoryMDGoodsDAO.CheckRegMDGoodsCount(params);
		
		int inserServiceData = Integer.parseInt((String) article.get("count")); //초기 데이터
		int limitCount = 20; //
		
		if(params.get("seq").indexOf(",") != -1) //다중 등록일 경우 사용
		{
			String[] value = params.get("seq").split(",");
			
			for(int i = 0; i < value.length; i ++)
			{
				++inserServiceData;
						
				if(inserServiceData > limitCount)
				{
					request.setAttribute("message", "등록 갯수를 초과 하였습니다. 기존 등록되어있는 서비스를 삭제 후 등록 해주세요.");
					request.setAttribute("redirect", "/admin/goods/inventory/inventory_md_2.do");
					return "message";
				}
				else
				{
					params.put("seq", value[i]);
					CategoryMDGoodsDAO.insertMDGoodsService(params);
				}
				 
				
			}
		}
		else //한개등록일 경우 
		{
			++inserServiceData;
			
			if(inserServiceData > limitCount)
			{
				request.setAttribute("message", "등록 갯수를 초과 하였습니다. 기존 등록되어있는 서비스를 삭제 후 등록 해주세요.");
				request.setAttribute("redirect", "/admin/goods/inventory/inventory_md_2.do");
				return "message";
			}
			else
			{
				CategoryMDGoodsDAO.insertMDGoodsService(params);
			}
			
		}

		request.setAttribute("servletPath", request.getServletPath());
		request.setAttribute("params", params);
		request.setAttribute("message", "등록 되었습니다.");
		request.setAttribute("redirect", "/admin/goods/inventory/inventory_md_2.do");
		return "message";
	}

}
