package com.mc.web.seller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class SellerDAO extends EgovAbstractMapper {
	
	public List seller_list(Map params) {
		return list("seller.seller_list", params);
	}
	
	public Map seller_pagination(Map<String, String> params) {
		return (Map) selectByPk("seller.seller_pagination", params);
	}
	
	public Map seller_view(Map params){
		return (Map) selectByPk("seller.seller_view", params);
	}
	
	public int seller_write(Map<String, String> params){
		return update("seller.seller_write", params);
	}
	
	public int seller_del(Map params){
		return update("seller.seller_del", params);
	}
	
	public Map seller_Info(Map params){
		return (Map) selectByPk("seller.seller_Info", params);
	}
	
	
	public List getList(String queryId, Map<String, String> params){
		return list(queryId, params);
	}
	
	public MCMap getRequest(String queryId, Map<String, String> params){
		return (MCMap) selectByPk(queryId, params);
	}

}
