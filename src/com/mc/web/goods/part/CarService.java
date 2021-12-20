package com.mc.web.goods.part;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.googlecode.ehcache.annotations.TriggersRemove;
import com.googlecode.ehcache.annotations.When;
import com.mc.common.util.StringUtil;
import com.mc.web.common.FileDAO;
import com.mc.web.common.FileUtil;

@Service
public class CarService {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Value("#{config['upload.temp']}")
	private String TEMP_PATH;
	
	@Value("#{config['upload.board']}")
	private String UPLOAD_PATH;
	
	@Autowired
	private FileDAO fileDAO;
	
	@Autowired
	private FileUtil fileUtil;

	@Autowired
	private PartDAO partDAO;
	
	public Map adminlist(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", partDAO.list(params));
		rstMap.put("pagination", partDAO.pagination(params));
		return rstMap;
	}
	
	public Map view(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", partDAO.view(params));
		params.put("table_nm", "NSH_GOODS");
		params.put("table_seq", params.get("seq"));
		rstMap.put("files", fileDAO.list(params));
		return rstMap;
	}

	@TriggersRemove(cacheName="mainCache", removeAll=true, when=When.AFTER_METHOD_INVOCATION)
	public Map write(HttpServletRequest request, Map params) throws Exception {
		Map rstMap = new HashMap();
		
		partDAO.write(params);
		
		List list = (List) params.get("files");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				if(!StringUtil.isEmpty((String) m.get("uuid"))){
					m.put("table_nm", "NSH_GOODS");
					m.put("table_seq", params.get("parent_seq"));
					m.put("session_member_id", params.get("session_member_id"));
					m.put("session_member_seq", params.get("session_member_seq"));
					m.put("session_member_nm", params.get("session_member_nm"));
					m.put("ip", params.get("ip"));
					String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH + File.separator + m.get("yyyy") + File.separator + m.get("mm"));
					fileDAO.insert(m);
					fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid"),path);
					fileUtil.thumb(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + (String) m.get("uuid"), path + File.separator + m.get("uuid")+"_thumb" , 172, 118, false);
				}
			}
		}
		
		rstMap.put("rst", "1");
		return rstMap;
	}

	@TriggersRemove(cacheName="mainCache", removeAll=true, when=When.AFTER_METHOD_INVOCATION)
	public Map modify(HttpServletRequest request, Map params) throws Exception {
		Map rstMap = new HashMap();
		
		partDAO.modify(params);

		params.put("table_seq", params.get("item_seq"));
		params.put("table_nm", "NSH_GOODS");
		fileDAO.delete_all(params);
		List list = (List) params.get("files");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				if(!StringUtil.isEmpty((String) m.get("uuid"))){
					m.put("table_nm", "NSH_GOODS");
					m.put("table_seq", params.get("item_seq"));
					m.put("session_member_id", params.get("session_member_id"));
					m.put("session_member_seq", params.get("session_member_seq"));
					m.put("session_member_nm", params.get("session_member_nm"));
					m.put("ip", params.get("ip"));
					String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH + File.separator + m.get("yyyy") + File.separator + m.get("mm"));
					fileDAO.insert(m);
					fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid"),path);
					fileUtil.thumb(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + (String) m.get("uuid"), path + File.separator + m.get("uuid")+"_thumb" , 172, 118, false);
				}
			}
		}
		
		list = (List) params.get("removeFiles");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				fileUtil.delete(request.getSession().getServletContext().getRealPath(UPLOAD_PATH) + File.separator + m.get("yyyy") + File.separator + m.get("mm") + File.separator + m.get("uuid"));
				fileUtil.delete(request.getSession().getServletContext().getRealPath(UPLOAD_PATH) + File.separator + m.get("yyyy") + File.separator + m.get("mm") + File.separator + m.get("uuid")+"_thumb");
			}
		}
		
		rstMap.put("rst", "1");
		return rstMap;
	}

	@TriggersRemove(cacheName="mainCache", removeAll=true, when=When.AFTER_METHOD_INVOCATION)
	public Map del(Map params) throws Exception {
		Map rstMap = new HashMap();
		
		List list = (List) params.get("del");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_seq", params.get("session_member_seq"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", params.get("ip"));
				partDAO.del(m);
			}
		}
		
		rstMap.put("rst", "1");
		return rstMap;
	}
	
}