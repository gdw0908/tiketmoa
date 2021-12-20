package com.mc.web.goods.event;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;

@Service
public class EventService {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private EventDAO eventDAO;
	
	public Map userView(Map params) throws Exception {
		Map rst = new HashMap();
		Map view = eventDAO.view(params);
		rst.put("view", view);
		if(view.get("icnt") == null){
			view.put("icnt", "0");
		}
		return rst;
	}
	
	public Map userItem(Map params) throws Exception {
		Map rst = new HashMap();
		params.put("userYN", "Y");
		if(params.get("search_event_text") != null){
			String search_all_text = (String)params.get("search_event_text");
			String[] search_all_textList = null;
			search_all_textList = search_all_text.split(" ");
			params.put("search_all_text_arr",search_all_textList);
		}
		rst.put("item", eventDAO.item(params));
		rst.put("pagination", eventDAO.itemPagination(params));
		return rst;
	}
	
	public Map write(Map params) throws Exception {
		Map rstMap = new HashMap();
		eventDAO.write(params);
		if(params.get("item_list") != null){
			List list = (List)params.get("item_list");
			String item_seq = "";
			if(list != null){
				for (int i = 0; i < list.size(); i++) {
					if(list.get(i) != null)
						item_seq += list.get(i)+",";
				}
				if(item_seq.length() > 0){
					item_seq = item_seq.substring(0, item_seq.length()-1);
					rstMap.put("event_seq", params.get("event_seq"));
					rstMap.put("event_item_seq", item_seq);
					eventDAO.item_write(rstMap);
				}
			}
		}
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map delete(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("rst", eventDAO.delete(params));
		return rstMap;
	}
	
	public Map modify(Map params) throws Exception {
		Map rstMap = new HashMap();
		eventDAO.modify(params);
		eventDAO.item_delete(params);
		if(params.get("item_list") != null){
			List list = (List)params.get("item_list");
			String item_seq = "";
			if(list != null){
				for (int i = 0; i < list.size(); i++) {
					if(list.get(i) != null)
						item_seq += list.get(i)+",";
				}
				if(item_seq.length() > 0){
					item_seq = item_seq.substring(0, item_seq.length()-1);
					rstMap.put("event_seq", params.get("seq"));
					rstMap.put("event_item_seq", item_seq);
					eventDAO.item_write(rstMap);
				}
			}
		}
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map view(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", eventDAO.view(params));
		rstMap.put("items", eventDAO.item(params));
		return rstMap;
	}
	
	public Map list(Map params){
		Map rstMap = new HashMap();
		rstMap.put("list", eventDAO.list(params));
		rstMap.put("page_info", eventDAO.pageinfo(params));
		return rstMap;
	}
	
	public Map itemSearch(Map params){
		Map rstMap = new HashMap();
		List item_list = (List)params.get("item_list");
		String item_seq = "";
		if(item_list.size() > 0 ){
			for(int x = 0;x < item_list.size(); x++){
				item_seq += item_list.get(x)+",";		
			}
			params.put("item_seq", (item_seq.substring(0, item_seq.length()-1)));
		}
		
		if(params.get("search_all_text") != null){
			String search_all_text = (String)params.get("search_all_text");
			String[] search_all_textList = null;
			search_all_textList = search_all_text.split(" ");
			params.put("search_all_text_arr",search_all_textList);
		}		
		rstMap.put("list", eventDAO.itemList(params));
		rstMap.put("page_info", eventDAO.itemPageinfo(params));
		return rstMap;
	}
	
	public Map itemSelectList(Map params){
		Map rstMap = new HashMap();
		List item_list = (List)params.get("item");
		String item_seq = "";
		if(item_list.size() > 0 ){
			for(int x = 0;x < item_list.size(); x++){
				item_seq += item_list.get(x)+",";		
			}
			params.put("item_seq", (item_seq.substring(0, item_seq.length()-1)));
		}
		rstMap.put("list", eventDAO.itemSelectList(params));
		return rstMap;
	}
	
}