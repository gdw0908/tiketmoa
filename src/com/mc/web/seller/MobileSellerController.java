package com.mc.web.seller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.mc.web.Globals;
import com.mc.web.MCMap;
import com.mc.web.board.BoardDAO;
import com.mc.web.board.BoardService;
import com.mc.web.board.MypageService;
import com.mc.web.common.FileDAO;

/**
 *
 * @Description : 
 * @ClassName   : com.mc.web.seller.SellerController.java
 * @Modification Information
 *
 * @author 오승택
 * @since 2015. 3. 23.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class MobileSellerController {
	Logger log = Logger.getLogger(this.getClass());
	
	private Globals globals;
	
	@Autowired
	private SellerService sellerService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MypageService mypageService;
	
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private FileDAO fileDAO;
	
	@Value("#{config['upload.board']}")
	private String UPLOAD_PATH;
	
	@RequestMapping("/mobile/seller/{path}.do")
	public String main(
			ModelMap model, 
			HttpServletRequest request, 
			HttpSession session,
			@PathVariable("path") String path, 
			@RequestParam Map params,
			@RequestParam(value = "new_files", required = false) List attachList
	) throws Exception{
		
		MCMap member = (MCMap) session.getAttribute("member");
		/*		권한 체크		*/
		if(member == null){
			request.setAttribute("message", globals.PERMISSION_DENIED);
			return "message";
		}else{
			if(!(member.get("group_seq").equals("1") || member.get("group_seq").equals("3") || member.get("group_seq").equals("8"))){
				request.setAttribute("message", globals.PERMISSION_DENIED);
				return "message";
			}
			if(member.get("group_seq").equals("8")){
				if(path.indexOf("resources") == -1){
					request.setAttribute("message", globals.PERMISSION_DENIED);
					return "message";
				}
			}
		}
		
		params.put("session_member_seq", member.get("member_seq"));
		params.put("session_member_group_seq", member.get("group_seq"));		
		params.put("session_member_id", member.get("member_id"));
		params.put("session_member_nm", member.get("member_nm"));
		params.put("session_member_com_seq", member.get("com_seq"));
		params.put("ip", request.getRemoteHost());

		
		/* 상품 관리 리스트 */
		if(path.equals("seller_list")){
			return sellerList(model,request,session,params);
		/* 상품 관리 등록 */	
		}else if(path.equals("seller_insert")){
			if(request.getMethod().equals("POST")){
				return sellerInsert(model,request,session,params,attachList);
			}else{
				return sellerInsertForm(model,request,session,params);
			}
		/* 상품 관리 수정 */	
		}else if(path.equals("seller_modify")){
			if(request.getMethod().equals("POST")){
				return sellerModify(model,request,session,params,attachList);
			}else{
				return sellerModifyForm(model,request,session,params);
			}
		/* 상품 관리 삭제 */	
		}else if(path.equals("seller_delete")){
			if(request.getMethod().equals("POST")){
				return sellerDelete(model,request,session,params);
			}else{
				request.setAttribute("message", globals.ABNORMAL_MSG);
				return "message";
			}
		
		
		/* 자원 관리 리스트*/
		}else if(path.equals("resources_list")){
			return resourcesList(model,request,session,params);
		/* 자원 관리 등록 */	
		}else if(path.equals("resources_insert")){
			if(request.getMethod().equals("POST")){
				return resourcesInsert(model,request,session,params);
			}else{
				return resourcesInsertForm(model,request,session,params);
			}
		/* 자원 관리 수정 */	
		}else if(path.equals("resources_modify")){
			if(request.getMethod().equals("POST")){
				return resourcesModify(model,request,session,params);
			}else{
				return resourcesModifyForm(model,request,session,params);
			}
		/* 자원 관리 삭제 */	
		}else if(path.equals("resources_delete")){
			if(request.getMethod().equals("POST")){
				return resourcesDelete(model,request,session,params);
			}else{
				request.setAttribute("message", globals.ABNORMAL_MSG);
				return "message";
			}
			
			
			
		/* 주문 현황 리스트 */	
		}else if(path.equals("product_list")){
			return productList(model,request,session,params);
		/* 주문 현황 뷰 */
		}else if(path.equals("product_view")){
			return productView(model,request,session,params);
		/* 비정상적인 접근 */	
		}else{
			request.setAttribute("message", globals.ABNORMAL_MSG);
			return "message";
		}
	}
	
	public String resourcesList(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		if("8".equals(params.get("session_member_group_seq")) || "1".equals(params.get("session_member_group_seq"))){
			params.put("board_seq","7");
			params.put("user", "Y");
			model.addAttribute("data", boardService.resourcesList(params));
		}else{
			Map parent = (Map) boardDAO.selectByPk("article.cooperation_parentSeq", params);
			params.put("keyword", parent.get("parent_seq"));
			params.put("board_seq","7");
			params.put("user", "Y");
			model.addAttribute("data", boardService.resourcesList(params));
		}
		return "mobile/seller/resources_list";
	}
	
	public String resourcesInsertForm(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		return "mobile/seller/resources_insert";
	}	
	public String resourcesInsert(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		MultipartRequest mreq = (MultipartRequest)request;
		List<MultipartFile> attachList = null;
		attachList = mreq.getFiles("attach");
		params.put("article_seq", boardDAO.getNextval());
		String[] item_cate = request.getParameterValues("cate_seq");
		String[] item_weight = request.getParameterValues("item_weight");
		List resources = new ArrayList();
		for(int i=0;i < item_cate.length;i++){
			Map m = new HashMap();
			m.put("cate_seq", item_cate[i]);
			m.put("item_weight", item_weight[i]);
			resources.add(m);
		}
		params.put("upload_path",request.getSession().getServletContext().getRealPath(UPLOAD_PATH));
		params.put("resources", resources);
		model.addAttribute("data", mypageService.resourcesWrite(attachList,params));
		return "redirect:/mobile/seller/resources_list.do?menu=menu8";
	}
	
	public String resourcesModifyForm(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", boardService.resourcesView(params));
		Map m = new HashMap();
		m.put("board_seq", "7");
		m.put("group_code", "2");
		m.put("order", "Y");
		params.put("table_seq", params.get("article_seq"));
		params.put("table_nm", "NSH_ARTICLE");
		model.addAttribute("files", fileDAO.list(params));
		model.addAttribute("resourcesList", boardDAO.list("article.categoryList", m));
		return "mobile/seller/resources_modify";
	}	
	public String resourcesModify(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		MultipartRequest mreq = (MultipartRequest)request;
		List<MultipartFile> attachList = null;
		attachList = mreq.getFiles("attach");
		List<String> delAttachList = null;
		if(null != request.getParameterValues("delattach")){
			delAttachList = Arrays.asList(request.getParameterValues("delattach"));
		}
		String[] seq = request.getParameterValues("seq");
		String[] del_yn = request.getParameterValues("del_yn");
		String[] gubun = request.getParameterValues("gubun");
		String[] item_cate = request.getParameterValues("cate_seq");
		String[] item_weight = request.getParameterValues("item_weight");
		List resources = new ArrayList();
		for(int i=0;i < item_cate.length;i++){
			Map m = new HashMap();
			m.put("cate_seq", item_cate[i]);
			m.put("item_weight", item_weight[i]);
			m.put("seq", seq[i]);
			if(gubun[i].equals("old")){
				m.put("del_yn", del_yn[i]);
			}
			resources.add(m);
		}
		params.put("upload_path",request.getSession().getServletContext().getRealPath(UPLOAD_PATH));
		params.put("resources", resources);
		model.addAttribute("data", mypageService.resourcesModify(attachList, delAttachList, params));
		return "redirect:/mobile/seller/resources_list.do?menu=menu8";
	}
	
	public String resourcesDelete(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", boardService.resourcesDel(params));
		return "redirect:/mobile/seller/resources_list.do?menu=menu8";
	}
	
	
	
	
	
	
	
	
	public String sellerList(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", sellerService.seller_list(params));
		return "mobile/seller/seller_list";
	}
	
	public String sellerInsertForm(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", sellerService.seller_insert_form(params));
		return "mobile/seller/seller_insert";
	}	
	public String sellerInsert(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params,List fileList) throws Exception{
		model.addAttribute("data", sellerService.seller_insert(params,fileList,request));
		return "redirect:/mobile/seller/seller_list.do?menu=menu8";
	}
	
	public String sellerModifyForm(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", sellerService.seller_modify_form(params));
		return "mobile/seller/seller_modify";
	}	
	public String sellerModify(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params,List fileList) throws Exception{
		model.addAttribute("data", sellerService.seller_modify(params,fileList,request));
		return "redirect:/mobile/seller/seller_list.do?menu=menu8";
	}
	
	public String sellerDelete(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", sellerService.seller_delete(params));
		return "redirect:/mobile/seller/seller_list.do?menu=menu8";
	}
	
	
	
	
	
	
	
	
	public String productList(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		model.addAttribute("data", sellerService.product_list(params));
		return "mobile/seller/product_list";
	}
	public String productView(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		Map map = sellerService.product_view(params);
		if(((String)map.get("rst")).equals("0")){
			request.setAttribute("message", globals.ABNORMAL_MSG);
			return "message";
		}else{
			model.addAttribute("data", map);
			return "mobile/seller/product_view";
		}		
	}
	
}
