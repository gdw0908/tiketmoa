package com.mc.web.category;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.googlecode.ehcache.annotations.TriggersRemove;
import com.googlecode.ehcache.annotations.When;
import com.mc.common.util.StringUtil;
import com.mc.web.Globals;
import com.mc.web.MCMap;

@Controller
@RequestMapping("/admin/goods/inventory/inventory_cate5.do")
public class CategoryPartsInfoController {
	
	@Value("#{config['upload.board']}")
	private String upload_board;
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private CategoryPartsInfoDAO CategoryPartsInfoDAO;
	
	@RequestMapping(params="!method")
	public String _default(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return list(params, request, session);
	}
	
	@RequestMapping(params="method=list")
	public String list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		if(StringUtil.isEmptyByParam(params, "cpage")) params.put("cpage", "1");
		params.put("rows", "10");
		
		MCMap view = (MCMap) CategoryPartsInfoDAO.getCarPartsInfoViewList(params);
		MCMap view_StockPart = (MCMap) CategoryPartsInfoDAO.getCarPartsShopBunViewList(params);
		MCMap view_ShopPart = (MCMap) CategoryPartsInfoDAO.getCarPartsShopViewList(params);
		
		request.setAttribute("deps1", CategoryPartsInfoDAO.getCarParts1DepsMenuList(params));	
		request.setAttribute("shopcodelist", CategoryPartsInfoDAO.getShopCodeList(params));	
		request.setAttribute("view", view);
		request.setAttribute("view_StockPart", view_StockPart);
		request.setAttribute("view_ShopPart", view_ShopPart);
		request.setAttribute("list", CategoryPartsInfoDAO.getCarPartsInfoList(params));
		request.setAttribute("page_info", CategoryPartsInfoDAO.getPartInfoPageInfo(params));
		request.setAttribute("servletPath", request.getServletPath());
		request.setAttribute("params", params);

		return "/admin/goods/inventory/inventory_cate5";
	}
	
	@RequestMapping(params="method=insert")
	@TriggersRemove(cacheName="mainCache", removeAll=true, when=When.AFTER_METHOD_INVOCATION)
	public String insert(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		MCMap member = (MCMap) session.getAttribute("member");
		
		if(member == null ){
			request.setAttribute("message", Globals.ABNORMAL_MSG);
    		request.setAttribute("redirect", "/admin/index.do");
			return "message";
    	}

		params.put("photourl", upload_board + "/" + params.get("yyyy") + "/" + params.get("uuid"));
		
		CategoryPartsInfoDAO.InsertPartsData(params);
		
		MCMap table_seq = (MCMap) CategoryPartsInfoDAO.getTableSeq(params);
		
		
		params.put("uuid", params.get("uuid"));
		params.put("attach_nm", params.get("attach_nm"));
		params.put("reg_seq", (String) member.get("member_seq"));
		params.put("reg_nm", (String) member.get("member_id"));
		params.put("yyyy", params.get("yyyy"));
		params.put("mm", params.get("mm"));
		params.put("table_nm", "IS_CARPART");
		params.put("table_seq", (String) table_seq.get("carpartseq"));
		
		CategoryPartsInfoDAO.InsertAttachData(params);

		if(StringUtil.isEmptyByParam(params, "cpage")) params.put("cpage", "1");
		params.put("rows", "10");
		
		request.setAttribute("servletPath", request.getServletPath());
		request.setAttribute("page_info", CategoryPartsInfoDAO.getPartInfoPageInfo(params));
		
		
		request.setAttribute("params", params);
		
		request.setAttribute("message", "등록 되었습니다.");
		request.setAttribute("redirect", "/admin/goods/inventory/inventory_cate5.do");
		return "message";
		
	}
	
	
	@RequestMapping(params="method=delete")
	@TriggersRemove(cacheName="mainCache", removeAll=true, when=When.AFTER_METHOD_INVOCATION)
	public String delete(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		CategoryPartsInfoDAO.updateCarPartsState(params);
		
		if(StringUtil.isEmptyByParam(params, "cpage")) params.put("cpage", "1");
		params.put("rows", "10");
		
		request.setAttribute("servletPath", request.getServletPath());
		request.setAttribute("page_info", CategoryPartsInfoDAO.getPartInfoPageInfo(params));
		request.setAttribute("params", params);
		
		list(params, request, session);
		
		return "/admin/goods/inventory/inventory_cate5";
	}
	
	@RequestMapping(params="method=update")
	@TriggersRemove(cacheName="mainCache", removeAll=true, when=When.AFTER_METHOD_INVOCATION)
	public String update(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		
		MCMap member = (MCMap) session.getAttribute("member");
		
		if(member == null ){
			request.setAttribute("message", Globals.ABNORMAL_MSG);
    		request.setAttribute("redirect", "/admin/index.do");
			return "message";
    	}

		params.put("photourl", upload_board + "/" + params.get("yyyy") + "/" + params.get("uuid"));
		
		if(params.get("qry_method").equals("qry_update"))
		{
			CategoryPartsInfoDAO.getUpdateCarPartInfo(params);
			CategoryPartsInfoDAO.UpdateAttachData(params);
		}
		else
		{
			CategoryPartsInfoDAO.InsertPartsDataQry(params);
			
			MCMap table_seq = (MCMap) CategoryPartsInfoDAO.getTableSeq(params);
			
			
			params.put("uuid", params.get("uuid"));
			params.put("attach_nm", params.get("attach_nm"));
			params.put("reg_seq", (String) member.get("member_seq"));
			params.put("reg_nm", (String) member.get("member_id"));
			params.put("yyyy", params.get("yyyy"));
			params.put("mm", params.get("mm"));
			params.put("table_nm", "IS_CARPART");
			params.put("table_seq", (String) table_seq.get("carpartseq"));
			
			CategoryPartsInfoDAO.InsertAttachData(params);
		}
		
		if(StringUtil.isEmptyByParam(params, "cpage")) params.put("cpage", "1");
		params.put("rows", "10");
		
		request.setAttribute("servletPath", request.getServletPath());
		request.setAttribute("page_info", CategoryPartsInfoDAO.getPartInfoPageInfo(params));
		request.setAttribute("params", params);
		
		list(params, request, session);
		
		return "/admin/goods/inventory/inventory_cate5";
	}

}
