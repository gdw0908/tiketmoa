package com.mc.web.goods.event;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class EventDAO extends EgovAbstractMapper {
	
	public Object list(Map<String, String> params){
		return list("event.list", params);
	}
	
	public Map pageinfo(Map<String, String> params){
		return (Map) selectByPk("event.pageinfo", params);
	}
	
	public int write(Map<String, String> params){
		return update("event.insert_event", params);
	}
	
	public int delete(Map<String, String> params){
		return update("event.delete_event", params);
	}
	
	public int modify(Map<String, String> params){
		return update("event.modify_event", params);
	}
		
	public int item_write(Map<String, String> params){
		return update("event.insert_select_item", params);
	}
	
	public int item_delete(Map<String, String> params){
		return update("event.delete_item", params);
	}	

	public Object itemList(Map<String, String> params){
		return list("event.item_select", params);
	}
	
	public Object itemSelectList(Map<String, String> params){
		return list("event.item_select_list", params);
	}
	
	public Map itemPageinfo(Map<String, String> params){
		return (Map) selectByPk("event.item_select_pageinfo", params);
	}
	
	public Map view(Map<String, String> params){
		return (Map) selectByPk("event.view", params);
	}
	
	public Object item(Map<String, String> params){
		return list("event.item", params);
	}
	
	public Map itemPagination(Map<String, String> params){
		return (Map) selectByPk("event.itemPagination", params);
	}
}