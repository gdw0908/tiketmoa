package com.mc.web.carallbaro;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;
import com.mc.web.board.BoardDAO;

@Service
public class UserCarallbaroCommentService {
	
	@Autowired
	private BoardDAO boardDAO;
	
	public Map commentWrite(Map params) throws Exception {
		Map rstMap = new HashMap();
		params.put("conts", ((String)params.get("conts")).replaceAll("\n", "<br/>"));
		boardDAO.commentWrite(params);
		rstMap.put("rst", "1");
		List list = (List) boardDAO.commentList(params);
		List commentList = new ArrayList();
		for(int x=0; x < list.size(); x++){
			Map map = new HashMap();
			map = (Map)list.get(x);
			String conts = (String)map.get("conts");
			map.put("conts", StringUtil.clearXSS(conts,"br"));
			commentList.add(map);
		}
		rstMap.put("comment",commentList);
		rstMap.put("article_seq", params.get("article_seq"));
		rstMap.put("session_id", params.get("reg_id"));
		rstMap.put("servletPath", params.get("servletPath"));
		rstMap.put("boolean", "true");
		rstMap.put("img", commentPcMobile((String)params.get("servletPath")));
		return rstMap;
	}

	public Map commentReply(Map params) throws Exception {
		Map rstMap = new HashMap();
		Map commentInfo = new HashMap();
		commentInfo = boardDAO.commentReplyInfo(params);
		params.put("grp", commentInfo.get("grp"));
		params.put("article_seq", commentInfo.get("article_seq"));
		params.put("seq", commentInfo.get("article_seq"));
		boardDAO.commentReplyInfoUpdate(params);
		if(commentInfo.get("password") == null){
			params.put("reply_id", commentInfo.get("reg_id"));
		}else{
			params.put("reply_id", commentInfo.get("reg_nm"));
		}
		params.put("article_seq", commentInfo.get("article_seq"));
		params.put("lvl", String.valueOf((Integer.parseInt((String)commentInfo.get("lvl"))+1)));		
		params.put("seq", String.valueOf((Integer.parseInt((String)commentInfo.get("seq"))+1)));
		params.put("conts", ((String)params.get("conts")).replaceAll("\n", "<br/>"));
		boardDAO.commentWrite(params);
		rstMap.put("rst", "1");
		List list = (List) boardDAO.commentList(params);
		List commentList = new ArrayList();
		for(int x=0; x < list.size(); x++){
			Map map = new HashMap();
			map = (Map)list.get(x);
			String conts = (String)map.get("conts");
			map.put("conts", StringUtil.clearXSS(conts,"br"));
			commentList.add(map);
		}
		rstMap.put("comment",commentList);
		rstMap.put("seq", params.get("seq"));
		rstMap.put("session_id", params.get("reg_id"));
		rstMap.put("servletPath", params.get("servletPath"));
		rstMap.put("boolean", "true");
		rstMap.put("img", commentPcMobile((String)params.get("servletPath")));
		return rstMap;
	}

	public Map commentDel(Map params) throws Exception {
		Map rstMap = new HashMap();
		Map commentInfo = new HashMap();
		commentInfo = boardDAO.commentReplyInfo(params);
		if(params.get("reg_id").equals(commentInfo.get("reg_id"))){
			params.put("grp", commentInfo.get("grp"));
			params.put("seq", commentInfo.get("seq"));
			params.put("lvl", commentInfo.get("lvl"));
			params.put("article_seq", commentInfo.get("article_seq"));
			boardDAO.commentDelReply(params);
			boardDAO.commentDel(params);
			params.put("reply_id", commentInfo.get("reg_id"));		
			params.put("article_seq", commentInfo.get("article_seq"));
			rstMap.put("rst", "1");
			List list = (List) boardDAO.commentList(params);
			List commentList = new ArrayList();
			for(int x=0; x < list.size(); x++){
				Map map = new HashMap();
				map = (Map)list.get(x);
				String conts = (String)map.get("conts");
				map.put("conts", StringUtil.clearXSS(conts,"br"));
				commentList.add(map);
			}
			rstMap.put("comment",commentList);
			rstMap.put("article_seq", params.get("article_seq"));
			rstMap.put("session_id", params.get("reg_id"));
			rstMap.put("servletPath", params.get("servletPath"));
			rstMap.put("boolean", "true");
			rstMap.put("img", commentPcMobile((String)params.get("servletPath")));
		}else{
			rstMap.put("rst", "2");
			rstMap.put("boolean", "false");
		}
		return rstMap;
	}

	public Map commentReplyUpdate(Map params) throws Exception {
		Map rstMap = new HashMap();
		Map commentInfo = new HashMap();
		commentInfo = boardDAO.commentReplyInfo(params);
		if(params.get("reg_id").equals(commentInfo.get("reg_id"))){
			params.put("conts", ((String)params.get("conts")).replaceAll("\n", "<br/>"));
			boardDAO.commentReplyUpdate(params);
			params.put("article_seq", commentInfo.get("article_seq"));
			rstMap.put("rst", "1");
			List list = (List) boardDAO.commentList(params);
			List commentList = new ArrayList();
			for(int x=0; x < list.size(); x++){
				Map map = new HashMap();
				map = (Map)list.get(x);
				String conts = (String)map.get("conts");
				map.put("conts", StringUtil.clearXSS(conts,"br"));
				commentList.add(map);
			}
			rstMap.put("comment",commentList);
			rstMap.put("article_seq", commentInfo.get("article_seq"));
			rstMap.put("session_id", params.get("reg_id"));
			rstMap.put("servletPath", params.get("servletPath"));
			rstMap.put("boolean", "true");
			rstMap.put("img", commentPcMobile((String)params.get("servletPath")));
		}else{
			rstMap.put("rst", "2");
			rstMap.put("boolean", "false");
		}
		return rstMap;
	}
	
	public String commentPcMobile(String folder) throws Exception{
		String[] folderName = folder.split("/");
		String result = "";
		if(folderName[1].equals("mobile") || folderName[1].equals("m")){
			result = "mobile/";
		}
		return result;
	}
}
