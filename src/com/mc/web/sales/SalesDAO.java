package com.mc.web.sales;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class SalesDAO extends EgovAbstractMapper {
	
	public List<MCMap> list(Map<String, String> params){
		List<MCMap> list = getSqlSession().selectList("sales.list", params);
		
		return list;
	}

	public List<MCMap> com_list_group(Map<String, String> params){
		List<MCMap> list = getSqlSession().selectList("sales.com_list_group", params);
		
		return list;
	}
}
