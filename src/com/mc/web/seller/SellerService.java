package com.mc.web.seller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;
import com.mc.web.code.CodeDAO;
import com.mc.web.common.FileDAO;
import com.mc.web.common.FileUtil;
import com.mc.web.goods.part.PartDAO;

@Service
public class SellerService {
	
	@Value("#{config['upload.temp']}")
	private String TEMP_PATH;
	
	@Value("#{config['upload.board']}")
	private String UPLOAD_PATH;
	
	@Autowired
	private SellerDAO sellerDAO;
	
	@Autowired
	private FileDAO fileDAO;
	
	@Autowired
	private FileUtil fileUtil;

	public Map seller_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", sellerDAO.seller_list(params));
		rstMap.put("pagination", sellerDAO.seller_pagination(params));
		return rstMap;
	}
	
	public Map seller_modify_form(Map params) throws Exception {
		Map rstMap = new HashMap();
		Map view = sellerDAO.seller_view(params);
		//View Page
		rstMap.put("view", view);
		
		//File List
		params.put("table_nm", "NSH_GOODS");
		params.put("table_seq", params.get("seq"));
		rstMap.put("files", fileDAO.list(params));
		
		
		//MemberInfo
		rstMap.put("MemberInfo", sellerDAO.seller_Info(params));
		//Part1
		params.put("upcodeno","050901");
		params.put("use_yn", "Y");
		rstMap.put("part1", sellerDAO.getList("old_code.codeList",params));
		//Part2
		params.put("upcodeno",view.get("part1"));
		rstMap.put("part2", sellerDAO.getList("old_code.codeList",params));
		//Part3
		params.put("upcodeno",view.get("part2"));
		rstMap.put("part3", sellerDAO.getList("old_code.carpart",params));
		//Grade
		params.put("code_group_seq","38");
		rstMap.put("grade", sellerDAO.getList("code.codeList",params));
		//Color
		params.put("code_group_seq","37");
		rstMap.put("color", sellerDAO.getList("code.codeList",params));
		//Car Maker
		rstMap.put("carmakerseq", sellerDAO.getList("old_code.carmaker",params));
		//Car Model
		rstMap.put("carmodel", sellerDAO.getList("old_code.carmodel",view));
		//Car Grade
		rstMap.put("cargrade", sellerDAO.getList("old_code.cargrade",view));
		
		return rstMap;
	}
	
	public Map seller_modify(Map params,List fileList,HttpServletRequest request) throws Exception {
		Map rstMap = new HashMap();
		Map oldfile = new HashMap();
		List<Map<String,String>> allFile = new ArrayList<Map<String,String>>();
		if(fileList != null){//새파일 복사
			for (int i = 0; i < fileList.size(); i++) {
				String file = (String)fileList.get(i);
				String fileInfo[] = file.split("/");
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH+"/"+fileInfo[0]+"/"+fileInfo[1]);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + fileInfo[2], path + File.separator + fileInfo[2],path);
				fileUtil.thumb(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + (String) fileInfo[2], path + File.separator + fileInfo[2]+"_thumb" , 172, 118, false);
				Map m = new HashMap();
				m.put("uuid", fileInfo[2]);
				m.put("attach_nm", fileInfo[3]);
				m.put("reg_seq", params.get("session_member_seq"));
				m.put("reg_nm", params.get("session_member_nm"));
				m.put("yyyy", fileInfo[0]);
				m.put("mm", fileInfo[1]);
				allFile.add(m);
			}
		}
		if(params.get("del_files") != null){//파일 삭제
			String delFile[] = ((String)params.get("del_files")).split(",");
			for (int i = 0; i < delFile.length; i++) {
				Map m = new HashMap();
				m.put("uuid", delFile[i]);
				sellerDAO.update("attach.delete", m);
			}
		}
		
		rstMap.put("table_nm", "NSH_GOODS");
		rstMap.put("table_seq", params.get("item_seq"));
		List oldFile = fileDAO.list(rstMap);
		fileDAO.delete_all(rstMap);//파일 전체 삭제
		if(oldFile != null){//기존 파일 받아오기
			for (int i = 0; i < oldFile.size(); i++) {
				Map m = (Map)oldFile.get(i);
				allFile.add(m);
			}
		}
		if(params.get("view_image") != null){
			int x = 1;
			for (int i = 0; i < allFile.size(); i++) {//대표이미지 설정
				Map m = (Map)allFile.get(i);
				if(m.get("uuid").equals(params.get("view_image"))){
					m.put("order_seq", x);
					m.put("table_nm", "NSH_GOODS");
					m.put("table_seq", params.get("item_seq"));//mysql auto_increment 의 값을 가져온 값
					m.put("session_member_id", params.get("session_member_id"));
					m.put("session_member_seq", params.get("session_member_seq"));
					m.put("session_member_nm", params.get("session_member_nm"));
					fileDAO.insert(m);
					x++;
				}
			}
			for (int i = 0; i < allFile.size(); i++) {//대표이미지 아닌것들 설정
				Map m = (Map)allFile.get(i);
				if(!m.get("uuid").equals(params.get("view_image"))){
					m.put("order_seq", x);
					m.put("table_nm", "NSH_GOODS");
					m.put("table_seq", params.get("item_seq"));//mysql auto_increment 의 값을 가져온 값
					m.put("session_member_id", params.get("session_member_id"));
					m.put("session_member_seq", params.get("session_member_seq"));
					m.put("session_member_nm", params.get("session_member_nm"));
					fileDAO.insert(m);
					x++;
				}
			}			
		}else{//대표이미지 설정이 없을시 그대로 입력
			for (int i = 0; i < allFile.size(); i++) {
				Map m = (Map)allFile.get(i);
				m.put("order_seq", i+1);
				m.put("table_nm", "NSH_GOODS");
				m.put("table_seq", params.get("item_seq"));//mysql auto_increment 의 값을 가져온 값
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_seq", params.get("session_member_seq"));
				m.put("session_member_nm", params.get("session_member_nm"));
				fileDAO.insert(m);
			}
		}
		rstMap.put("session_member_com_seq",params.get("session_member_com_seq"));
		sellerDAO.update("seller.seller_modify",params);
		return rstMap;
	}
	
	public Map seller_delete(Map params) throws Exception {
		Map rstMap = new HashMap();
		sellerDAO.seller_del(params);
		rstMap.put("rst", "1");
		return rstMap;
	}

	public Map seller_insert_form(Map params) throws Exception {
		Map rstMap = new HashMap();
		
		//MemberInfo
		rstMap.put("MemberInfo", sellerDAO.seller_Info(params));
		
		//Part1
		params.put("upcodeno","050901");
		params.put("use_yn", "Y");
		rstMap.put("part1", sellerDAO.getList("old_code.codeList",params));
		//Grade
		params.put("code_group_seq","38");
		rstMap.put("grade", sellerDAO.getList("code.codeList",params));
		//Color
		params.put("code_group_seq","37");
		rstMap.put("color", sellerDAO.getList("code.codeList",params));
		//Car Maker
		rstMap.put("carmakerseq", sellerDAO.getList("old_code.carmaker",params));
		return rstMap;
	}
	
	public Map seller_insert(Map params,List fileList,HttpServletRequest request) throws Exception {
		Map rstMap = new HashMap();
		sellerDAO.seller_write(params);
		if(fileList != null){//새파일 복사
			for (int i = 0; i < fileList.size(); i++) {
				String file = (String)fileList.get(i);
				String fileInfo[] = file.split("/");
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH+"/"+fileInfo[0]+"/"+fileInfo[1]);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + fileInfo[2], path + File.separator + fileInfo[2],path);
				fileUtil.thumb(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + (String) fileInfo[2], path + File.separator + fileInfo[2]+"_thumb" , 172, 118, false);
				Map m = new HashMap();
				m.put("uuid", fileInfo[2]);
				m.put("attach_nm", fileInfo[3]);
				m.put("reg_seq", params.get("session_member_seq"));
				m.put("reg_nm", params.get("session_member_nm"));
				m.put("yyyy", fileInfo[0]);
				m.put("mm", fileInfo[1]);
				m.put("order_seq", i+1);
				m.put("table_nm", "NSH_GOODS");
				m.put("table_seq", params.get("parent_seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_seq", params.get("session_member_seq"));
				m.put("session_member_nm", params.get("session_member_nm"));
				fileDAO.insert(m);
			}
		}
		return rstMap;
	}
	
	public Map product_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", sellerDAO.getList("seller.product_list",params));
		rstMap.put("pagination", sellerDAO.getRequest("seller.product_pagination", params));
		return rstMap;
	}
	
	
	public Map product_view(Map params) throws Exception {
		Map rstMap = new HashMap();
		Map view = new HashMap();
		view = (Map)sellerDAO.selectByPk("spell.view", params);
		/* 권한 검사 해야함 */
		
		if(!view.get("com_seq").equals(params.get("session_member_com_seq"))){
			rstMap.put("rst", "0");
		}else{
			rstMap.put("rst", "1");
			rstMap.put("view", view);
		}		
		return rstMap;
	}
}
