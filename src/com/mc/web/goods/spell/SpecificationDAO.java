package com.mc.web.goods.spell;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class SpecificationDAO extends EgovAbstractMapper {

	public Object getView(Map<String, String> params) {
		return selectByPk("spell.specification_pop", params);
	}
	
}
