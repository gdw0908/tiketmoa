package com.mc.web.carallbaro;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


@Repository
public class CarallbaroDAO extends EgovAbstractMapper{

	public List<MCMap> getList(Map params) throws Exception{
		return list("carallbaro.list", params);
	}
	
	public List<MCMap> getList_carall(Map params) throws Exception{
		return list("carallbaro.list_carall", params);
	}
	
	public MCMap getPagination_carall(Map params) throws Exception{
		return (MCMap)selectByPk("carallbaro.pagination_carall", params);
	}
	
	
	public MCMap getPagination(Map params) throws Exception{
		return (MCMap)selectByPk("carallbaro.pagination", params);
	}
	
	public MCMap getView(Map params) throws Exception{
		return (MCMap)selectByPk("carallbaro.view",params);
	}
	
	public int setInsert(Map params) throws Exception{
		return insert("carallbaro.insert", params);
	}
	
	public int setModify(Map params) throws Exception{
		return update("carallbaro.update",params);
	}	
	
	public int setDelete(Map params) throws Exception{
		return update("carallbaro.delete",params);
	}
	
	public String getNextval() {
		return selectByPk("article.nextval",null).toString();
	}
}
