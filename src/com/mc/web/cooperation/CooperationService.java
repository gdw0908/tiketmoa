package com.mc.web.cooperation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.Encryption;
import com.mc.common.util.StringUtil;
import com.mc.web.code.CodeDAO;

@Service
public class CooperationService {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CooperationDAO cooperationDAO;
	
	@Autowired
	private CodeDAO codeDAO;
	
	public Map view(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", cooperationDAO.view(params));
		rstMap.put("memberList", cooperationDAO.memberList(params));
		return rstMap;
	}
	
	public Map write(Map params) throws Exception {
		Map rstMap = new HashMap();
		if(!StringUtil.isEmpty((String)params.get("zip1")) && !StringUtil.isEmpty((String)params.get("zip2"))){
			params.put("zip_cd", params.get("zip1")+"-"+params.get("zip2"));
		}
		if(!StringUtil.isEmpty((String)params.get("tel1")) && !StringUtil.isEmpty((String)params.get("tel2")) && !StringUtil.isEmpty((String)params.get("tel3"))){
			params.put("tel", params.get("tel1")+"-"+params.get("tel2")+"-"+params.get("tel3"));
		}
		if(!StringUtil.isEmpty((String)params.get("fax1")) && !StringUtil.isEmpty((String)params.get("fax2")) && !StringUtil.isEmpty((String)params.get("fax3"))){
			params.put("fax", params.get("fax1")+"-"+params.get("fax2")+"-"+params.get("fax3"));
		}
		if(!StringUtil.isEmpty((String)params.get("staff_tel1")) && !StringUtil.isEmpty((String)params.get("staff_tel2")) && !StringUtil.isEmpty((String)params.get("staff_tel3"))){
			params.put("staff_tel", params.get("staff_tel1")+"-"+params.get("staff_tel2")+"-"+params.get("staff_tel3"));
		}
		if(!StringUtil.isEmpty((String)params.get("staff_tel2_1")) && !StringUtil.isEmpty((String)params.get("staff_tel2_2")) && !StringUtil.isEmpty((String)params.get("staff_tel2_3"))){
			params.put("staff_tel2", params.get("staff_tel2_1")+"-"+params.get("staff_tel2_2")+"-"+params.get("staff_tel2_3"));
		}
		if(!StringUtil.isEmpty((String)params.get("sms_tel1")) && !StringUtil.isEmpty((String)params.get("sms_tel2")) && !StringUtil.isEmpty((String)params.get("sms_tel3"))){
			params.put("sms_tel", params.get("sms_tel1")+"-"+params.get("sms_tel2")+"-"+params.get("sms_tel3"));
		}
		if(!StringUtil.isEmpty((String)params.get("staff_email1")) && !StringUtil.isEmpty((String)params.get("staff_email2"))){
			params.put("staff_email", params.get("staff_email1")+"@"+params.get("staff_email2"));
		}
		if(!StringUtil.isEmpty((String)params.get("busi_no1")) && !StringUtil.isEmpty((String)params.get("busi_no2")) && !StringUtil.isEmpty((String)params.get("busi_no3"))){
			params.put("busi_no", params.get("busi_no1")+"-"+params.get("busi_no2")+"-"+params.get("busi_no3"));
		}
		
		cooperationDAO.write(params);
		
		List list = (List) params.get("memberList");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("parent_seq", params.get("parent_seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("member_pw", Encryption.stringEncryption((String)m.get("member_pw"), ""));
				m.put("login_yn", params.get("login_yn"));
				cooperationDAO.insertMember(m);
			}
		}
		
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map modify(Map params) throws Exception {
		Map rstMap = new HashMap();
		if(!StringUtil.isEmpty((String)params.get("zip1")) && !StringUtil.isEmpty((String)params.get("zip2"))){
			params.put("zip_cd", params.get("zip1")+"-"+params.get("zip2"));
		}
		if(!StringUtil.isEmpty((String)params.get("tel1")) && !StringUtil.isEmpty((String)params.get("tel2")) && !StringUtil.isEmpty((String)params.get("tel3"))){
			params.put("tel", params.get("tel1")+"-"+params.get("tel2")+"-"+params.get("tel3"));
		}
		if(!StringUtil.isEmpty((String)params.get("fax1")) && !StringUtil.isEmpty((String)params.get("fax2")) && !StringUtil.isEmpty((String)params.get("fax3"))){
			params.put("fax", params.get("fax1")+"-"+params.get("fax2")+"-"+params.get("fax3"));
		}
		if(!StringUtil.isEmpty((String)params.get("staff_tel1")) && !StringUtil.isEmpty((String)params.get("staff_tel2")) && !StringUtil.isEmpty((String)params.get("staff_tel3"))){
			params.put("staff_tel", params.get("staff_tel1")+"-"+params.get("staff_tel2")+"-"+params.get("staff_tel3"));
		}
		if(!StringUtil.isEmpty((String)params.get("staff_tel2_1")) && !StringUtil.isEmpty((String)params.get("staff_tel2_2")) && !StringUtil.isEmpty((String)params.get("staff_tel2_3"))){
			params.put("staff_tel2", params.get("staff_tel2_1")+"-"+params.get("staff_tel2_2")+"-"+params.get("staff_tel2_3"));
		}else{
			params.put("staff_tel2","");
		}
		if(!StringUtil.isEmpty((String)params.get("sms_tel1")) && !StringUtil.isEmpty((String)params.get("sms_tel2")) && !StringUtil.isEmpty((String)params.get("sms_tel3"))){
			params.put("sms_tel", params.get("sms_tel1")+"-"+params.get("sms_tel2")+"-"+params.get("sms_tel3"));
		}
		if(!StringUtil.isEmpty((String)params.get("staff_email1")) && !StringUtil.isEmpty((String)params.get("staff_email2"))){
			params.put("staff_email", params.get("staff_email1")+"@"+params.get("staff_email2"));
		}
		if(!StringUtil.isEmpty((String)params.get("busi_no1")) && !StringUtil.isEmpty((String)params.get("busi_no2")) && !StringUtil.isEmpty((String)params.get("busi_no3"))){
			params.put("busi_no", params.get("busi_no1")+"-"+params.get("busi_no2")+"-"+params.get("busi_no3"));
		}
		
		cooperationDAO.modify(params);
		
		List list = (List) params.get("memberList");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("parent_seq", params.get("seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("member_pw", Encryption.stringEncryption((String)m.get("member_pw"), ""));
				m.put("login_yn", params.get("login_yn"));
				if("0".equals((String)m.get("seq"))){//새로운 멤버
					cooperationDAO.insertMember(m);
				}else if("-1".equals((String)m.get("seq"))){//멤버삭제
					cooperationDAO.removeMember(m);
				}else{//업뎃
					cooperationDAO.updateMember(m);
				}
			}
		}
		
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map statusUpdate(Map params) throws Exception {
		Map rstMap = new HashMap();
		cooperationDAO.statusUpdate(params);
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map del(Map params) throws Exception {
		Map rstMap = new HashMap();
		cooperationDAO.del(params);
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", cooperationDAO.cooperation_list(params));
		rstMap.put("pagination", cooperationDAO.cooperation_pagination(params));
		rstMap.put("sido", codeDAO.sido(params));
		rstMap.put("sigungu", codeDAO.sigungu(params));
		rstMap.put("dong", codeDAO.dong(params));
		return rstMap;
	}
	
	public Map other_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", cooperationDAO.cooperation_other_list(params));
		rstMap.put("pagination", cooperationDAO.cooperation_other_pagination(params));
		return rstMap;
	}
	
	
	public Map repair_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", cooperationDAO.repair_list(params));
		rstMap.put("pagination", cooperationDAO.repair_pagination(params));
		rstMap.put("sido", codeDAO.sido(params));
		rstMap.put("sigungu", codeDAO.sigungu(params));
		rstMap.put("dong", codeDAO.dong(params));
		return rstMap;
	}
	
	public Map repair_view(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", cooperationDAO.repair_view(params));
		rstMap.put("sido", codeDAO.sido(params));
		rstMap.put("sigungu", codeDAO.sigungu(params));
		rstMap.put("dong", codeDAO.dong(params));
		return rstMap;
	}

	public Map updateUserCommission(Map params) throws Exception {
		Map rstMap = new HashMap();
		
		cooperationDAO.updateUserCommission(params);
		
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map updateComCommission(Map params) throws Exception {
		Map rstMap = new HashMap();
		
		cooperationDAO.updateComCommission(params);
		
		rstMap.put("rst", "1");
		return rstMap;
	}
}