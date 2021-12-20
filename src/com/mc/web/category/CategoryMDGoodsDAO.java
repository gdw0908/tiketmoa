package com.mc.web.category;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class CategoryMDGoodsDAO extends EgovAbstractMapper {

	public Object getDeps1List(Map<String, String> params) {
		return list("category.getDeps1List", params);
	}
	
	public Object getMDGoodsList(Map<String, String> params) {
		return list("category.getMDGoodsList", params);
	}
	
	public Object getMDGoodsSearchList(Map<String, String> params) {
		return list("category.getMDGoodsSearchList", params);
	}

	public void deleteMDGoodsService(Map<String, String> params) {
		update("category.deleteMDGoodsService", params);
	}
	
	public void insertMDGoodsService(Map<String, String> params) {
		update("category.insertMDGoodsService", params);
	}
	
	public Object CheckRegMDGoodsCount(Map<String, String> params) {
		return selectByPk("category.CheckRegMDGoodsCount", params);
	}
	
	public Object goodsSearchCarmaker(Map<String, String> params) {
		return list("old_code.carmaker", params);
	}

	public Object goodsSearchCODEMST(Map<String, String> params) {
		return list("old_code.codeList", params);
	}
	public Object getMDGoodsSearchPaging(Map<String, String> params) {
		return selectByPk("category.getMDGoodsSearchPaging", params);
	}
	
	
}
