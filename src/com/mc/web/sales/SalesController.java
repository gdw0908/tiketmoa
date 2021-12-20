package com.mc.web.sales;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jxl.CellView;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mc.common.util.DateUtil;
import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.calculate.CalculateDAO;

@Controller
public class SalesController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private SalesDAO salesDAO;
	
	@Autowired
	private CalculateDAO calculateDAO;
	
	@RequestMapping("/admin/sales/sales_period.do")
	public String sales_period(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		MCMap member = (MCMap) session.getAttribute("member");
		params.put("session_member_id", (String)member.get("member_id"));
		params.put("session_group_seq", (String)member.get("group_seq"));
		request.setAttribute("com_list", salesDAO.com_list_group(params));
		request.setAttribute("list", salesDAO.list(params));
		request.setAttribute("params", params);
		return "/admin/sales/sales_period";
	}
	
	@RequestMapping("/admin/sales/view_detail.do")
	public String confirm_view_detail(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		request.setAttribute("list", calculateDAO.select_confirm_detail(params));
		request.setAttribute("params", params);
		return "/admin/sales/view_detail";
	}
	
	@RequestMapping("/admin/sales/period_excel.do")
	public void period_excel(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException, RowsExceededException, WriteException{

		List<MCMap> list = salesDAO.list(params);
		
		OutputStream output = response.getOutputStream();
		response.setContentType("application/xls");
		response.setHeader("Content-Disposition","attachment; filename=sales_period.xls");
		
		
		WritableWorkbook writebook = Workbook.createWorkbook(output);
		WritableSheet writeSheet = writebook.createSheet("기간별조회", 0);

		WritableCellFormat headerFormat = new WritableCellFormat(); // 번호 셀 포멧 생성
		WritableCellFormat dataFormat = new WritableCellFormat(); // 데이터 셀 포멧 생성

		headerFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		headerFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		headerFormat.setBackground(Colour.GRAY_25);
		
		dataFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		dataFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		dataFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		dataFormat.setWrap(true);
		
		
		writeSheet.setColumnView(0, 20); 
		writeSheet.setColumnView(1, 18); 
		writeSheet.setColumnView(2, 18); 
		writeSheet.setColumnView(3, 18); 
		writeSheet.setColumnView(4, 18); 
		writeSheet.setColumnView(5, 18); 
		writeSheet.setColumnView(6, 18); 
		writeSheet.setColumnView(7, 18); 

		
		CellView cv = new CellView();
		cv.setAutosize(true);
			
		int i = 1;
		
		String[] header = {"협력업체명", "주문건수", "주문수량", "할인전매출총액", "카드", "현금", "할인금액", "결제완료액+결제예정금액"};
		if (header != null && header.length > 0)
		{
			for(int x=0;x<header.length;x++){
				Label headerLabels =new Label(x, i, header[x], headerFormat); // 데이터 포멧에 맞게 대문자 A에서 E까지 생성
				writeSheet.addCell(headerLabels); // 셀에 삽입
			}
			i++;
		}
		try {
			for(MCMap map : list){
				int cell = 0;
				int bf_discount = map.getIntNullVal("bf_discount", 0);
				int ordercount = map.getIntNullVal("ordercount", 0);
				int orderqty = map.getIntNullVal("orderqty", 0);
				int card = map.getIntNullVal("card", 0);
				int iche = map.getIntNullVal("iche", 0);
				int virtual = map.getIntNullVal("virtual", 0);
				int sale_price = map.getIntNullVal("sale_price", 0);

				writeSheet.addCell(new Label(cell++, i, StringUtil.isNullDef((String)map.get("com_nm"), "합계"), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(ordercount), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(orderqty), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(bf_discount), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(card), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(iche + virtual), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(sale_price), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand((card + virtual + iche) - sale_price), dataFormat));
				
				i++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		writebook.write(); // 준비된 정보를 엑셀 포멧에 맞게 작성
		writebook.close(); // 처리 후 메모리에서 해제 처리
	}
	
	@RequestMapping("/admin/sales/sales_day.do")
	public String sales_day(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		MCMap member = (MCMap) session.getAttribute("member");
		params.put("session_member_id", (String)member.get("member_id"));
		params.put("session_group_seq", (String)member.get("group_seq"));
		request.setAttribute("com_list", salesDAO.com_list_group(params));
		request.setAttribute("list", salesDAO.list(params));
		request.setAttribute("params", params);
		return "/admin/sales/sales_day";
	}
	
	@RequestMapping("/admin/sales/day_excel.do")
	public void day_excel(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException, RowsExceededException, WriteException{

		List<MCMap> list = salesDAO.list(params);
		
		OutputStream output = response.getOutputStream();
		response.setContentType("application/xls");
		response.setHeader("Content-Disposition","attachment; filename=sales_day.xls");
		
		
		WritableWorkbook writebook = Workbook.createWorkbook(output);
		WritableSheet writeSheet = writebook.createSheet("일조회", 0);

		WritableCellFormat headerFormat = new WritableCellFormat(); // 번호 셀 포멧 생성
		WritableCellFormat dataFormat = new WritableCellFormat(); // 데이터 셀 포멧 생성

		headerFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		headerFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		headerFormat.setBackground(Colour.GRAY_25);
		
		dataFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		dataFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		dataFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		dataFormat.setWrap(true);
		
		
		writeSheet.setColumnView(0, 20); 
		writeSheet.setColumnView(1, 18); 
		writeSheet.setColumnView(2, 18); 
		writeSheet.setColumnView(3, 18); 
		writeSheet.setColumnView(4, 18); 
		writeSheet.setColumnView(5, 18); 
		writeSheet.setColumnView(6, 18); 
		writeSheet.setColumnView(7, 18); 

		
		CellView cv = new CellView();
		cv.setAutosize(true);
			
		int i = 1;
		
		String[] header = {"협력업체명", "주문건수", "주문수량", "할인전매출총액", "카드", "현금", "할인금액", "결제완료액+결제예정금액"};
		if (header != null && header.length > 0)
		{
			for(int x=0;x<header.length;x++){
				Label headerLabels =new Label(x, i, header[x], headerFormat); // 데이터 포멧에 맞게 대문자 A에서 E까지 생성
				writeSheet.addCell(headerLabels); // 셀에 삽입
			}
			i++;
		}
		try {
			for(MCMap map : list){
				int cell = 0;
				int bf_discount = map.getIntNullVal("bf_discount", 0);
				int ordercount = map.getIntNullVal("ordercount", 0);
				int orderqty = map.getIntNullVal("orderqty", 0);
				int card = map.getIntNullVal("card", 0);
				int iche = map.getIntNullVal("iche", 0);
				int virtual = map.getIntNullVal("virtual", 0);
				int sale_price = map.getIntNullVal("sale_price", 0);

				writeSheet.addCell(new Label(cell++, i, StringUtil.isNullDef((String)map.get("com_nm"), "합계"), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(ordercount), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(orderqty), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(bf_discount), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(card), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(iche + virtual), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(sale_price), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand((card + virtual + iche) - sale_price), dataFormat));
				
				i++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		writebook.write(); // 준비된 정보를 엑셀 포멧에 맞게 작성
		writebook.close(); // 처리 후 메모리에서 해제 처리
	}
	
	@RequestMapping("/admin/sales/sales_month.do")
	public String sales_month(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		MCMap member = (MCMap) session.getAttribute("member");
		params.put("session_member_id", (String)member.get("member_id"));
		params.put("session_group_seq", (String)member.get("group_seq"));
		request.setAttribute("com_list", salesDAO.com_list_group(params));
		request.setAttribute("list", salesDAO.list(params));
		request.setAttribute("params", params);
		return "/admin/sales/sales_month";
	}
	
	@RequestMapping("/admin/sales/month_excel.do")
	public void month_excel(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException, RowsExceededException, WriteException{

		List<MCMap> list = salesDAO.list(params);
		
		OutputStream output = response.getOutputStream();
		response.setContentType("application/xls");
		response.setHeader("Content-Disposition","attachment; filename=sales_month.xls");
		
		
		WritableWorkbook writebook = Workbook.createWorkbook(output);
		WritableSheet writeSheet = writebook.createSheet("월조회", 0);

		WritableCellFormat headerFormat = new WritableCellFormat(); // 번호 셀 포멧 생성
		WritableCellFormat dataFormat = new WritableCellFormat(); // 데이터 셀 포멧 생성

		headerFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		headerFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		headerFormat.setBackground(Colour.GRAY_25);
		
		dataFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		dataFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		dataFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		dataFormat.setWrap(true);
		
		
		writeSheet.setColumnView(0, 20); 
		writeSheet.setColumnView(1, 18); 
		writeSheet.setColumnView(2, 18); 
		writeSheet.setColumnView(3, 18); 
		writeSheet.setColumnView(4, 18); 
		writeSheet.setColumnView(5, 18); 
		writeSheet.setColumnView(6, 18); 
		writeSheet.setColumnView(7, 18); 

		
		CellView cv = new CellView();
		cv.setAutosize(true);
			
		int i = 1;
		
		String[] header = {"협력업체명", "주문건수", "주문수량", "할인전매출총액", "카드", "현금", "할인금액", "결제완료액+결제예정금액"};
		if (header != null && header.length > 0)
		{
			for(int x=0;x<header.length;x++){
				Label headerLabels =new Label(x, i, header[x], headerFormat); // 데이터 포멧에 맞게 대문자 A에서 E까지 생성
				writeSheet.addCell(headerLabels); // 셀에 삽입
			}
			i++;
		}
		try {
			for(MCMap map : list){
				int cell = 0;
				int bf_discount = map.getIntNullVal("bf_discount", 0);
				int ordercount = map.getIntNullVal("ordercount", 0);
				int orderqty = map.getIntNullVal("orderqty", 0);
				int card = map.getIntNullVal("card", 0);
				int iche = map.getIntNullVal("iche", 0);
				int virtual = map.getIntNullVal("virtual", 0);
				int sale_price = map.getIntNullVal("sale_price", 0);

				writeSheet.addCell(new Label(cell++, i, StringUtil.isNullDef((String)map.get("com_nm"), "합계"), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(ordercount), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(orderqty), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(bf_discount), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(card), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(iche + virtual), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(sale_price), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand((card + virtual + iche) - sale_price), dataFormat));
				
				i++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		writebook.write(); // 준비된 정보를 엑셀 포멧에 맞게 작성
		writebook.close(); // 처리 후 메모리에서 해제 처리
	}
	
	@RequestMapping("/admin/sales/sales_quarter.do")
	public String sales_quarter(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		String year = DateUtil.getCurrentYearStr();
		if(StringUtil.isEmptyByParam(params, "branch")){
			int month_int = DateUtil.getCurrentMonth();
			
			if(month_int >= 1 && month_int <= 3)
				params.put("branch", "1");
			else if(month_int >= 4 && month_int <= 6)
				params.put("branch", "2");
			else if(month_int >= 7 && month_int <= 9)
				params.put("branch", "3");
			else
				params.put("branch", "4");
		}
		
		String branch = params.get("branch");
		if(branch.equals("1")){
			params.put("start_month", "01");
			params.put("end_month", "03");
		}else if(branch.equals("2")){
			params.put("start_month", "04");
			params.put("end_month", "06");
		}else if(branch.equals("3")){
			params.put("start_month", "07");
			params.put("end_month", "09");
		}else{
			params.put("start_month", "10");
			params.put("end_month", "12");
		}

		request.setAttribute("com_list", salesDAO.com_list_group(params));
		request.setAttribute("list", salesDAO.list(params));
		request.setAttribute("params", params);
		return "/admin/sales/sales_quarter";
	}
	
	@RequestMapping("/admin/sales/quarter_excel.do")
	public void quarter_excel(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException, RowsExceededException, WriteException{

		String year = DateUtil.getCurrentYearStr();
		if(StringUtil.isEmptyByParam(params, "branch")){
			int month_int = DateUtil.getCurrentMonth();
			
			if(month_int >= 1 && month_int <= 3)
				params.put("branch", "1");
			else if(month_int >= 4 && month_int <= 6)
				params.put("branch", "2");
			else if(month_int >= 7 && month_int <= 9)
				params.put("branch", "3");
			else
				params.put("branch", "4");
		}
		
		String branch = params.get("branch");
		if(branch.equals("1")){
			params.put("start_month", "01");
			params.put("end_month", "03");
		}else if(branch.equals("2")){
			params.put("start_month", "04");
			params.put("end_month", "06");
		}else if(branch.equals("3")){
			params.put("start_month", "07");
			params.put("end_month", "09");
		}else{
			params.put("start_month", "10");
			params.put("end_month", "12");
		}
		
		List<MCMap> list = salesDAO.list(params);
		
		OutputStream output = response.getOutputStream();
		response.setContentType("application/xls");
		response.setHeader("Content-Disposition","attachment; filename=sales_quarter.xls");
		
		
		WritableWorkbook writebook = Workbook.createWorkbook(output);
		WritableSheet writeSheet = writebook.createSheet("분기조회", 0);

		WritableCellFormat headerFormat = new WritableCellFormat(); // 번호 셀 포멧 생성
		WritableCellFormat dataFormat = new WritableCellFormat(); // 데이터 셀 포멧 생성

		headerFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		headerFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		headerFormat.setBackground(Colour.GRAY_25);
		
		dataFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		dataFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		dataFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		dataFormat.setWrap(true);
		
		
		writeSheet.setColumnView(0, 20); 
		writeSheet.setColumnView(1, 18); 
		writeSheet.setColumnView(2, 18); 
		writeSheet.setColumnView(3, 18); 
		writeSheet.setColumnView(4, 18); 
		writeSheet.setColumnView(5, 18); 
		writeSheet.setColumnView(6, 18); 
		writeSheet.setColumnView(7, 18); 

		
		CellView cv = new CellView();
		cv.setAutosize(true);
			
		int i = 1;
		
		String[] header = {"협력업체명", "주문건수", "주문수량", "할인전매출총액", "카드", "현금", "할인금액", "결제완료액+결제예정금액"};
		if (header != null && header.length > 0)
		{
			for(int x=0;x<header.length;x++){
				Label headerLabels =new Label(x, i, header[x], headerFormat); // 데이터 포멧에 맞게 대문자 A에서 E까지 생성
				writeSheet.addCell(headerLabels); // 셀에 삽입
			}
			i++;
		}
		try {
			for(MCMap map : list){
				int cell = 0;
				int bf_discount = map.getIntNullVal("bf_discount", 0);
				int ordercount = map.getIntNullVal("ordercount", 0);
				int orderqty = map.getIntNullVal("orderqty", 0);
				int card = map.getIntNullVal("card", 0);
				int iche = map.getIntNullVal("iche", 0);
				int virtual = map.getIntNullVal("virtual", 0);
				int sale_price = map.getIntNullVal("sale_price", 0);

				writeSheet.addCell(new Label(cell++, i, StringUtil.isNullDef((String)map.get("com_nm"), "합계"), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(ordercount), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(orderqty), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(bf_discount), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(card), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(iche + virtual), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(sale_price), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand((card + virtual + iche) - sale_price), dataFormat));
				
				i++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		writebook.write(); // 준비된 정보를 엑셀 포멧에 맞게 작성
		writebook.close(); // 처리 후 메모리에서 해제 처리
	}
	
	@RequestMapping("/admin/sales/sales_year.do")
	public String sales_year(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		
		MCMap member = (MCMap) session.getAttribute("member");
		params.put("session_member_id", (String)member.get("member_id"));
		params.put("session_group_seq", (String)member.get("group_seq"));
		request.setAttribute("com_list", salesDAO.com_list_group(params));
		request.setAttribute("list", salesDAO.list(params));
		request.setAttribute("params", params);
		return "/admin/sales/sales_year";
	}
	
	@RequestMapping("/admin/sales/year_excel.do")
	public void year_excel(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException, RowsExceededException, WriteException{

		List<MCMap> list = salesDAO.list(params);
		
		OutputStream output = response.getOutputStream();
		response.setContentType("application/xls");
		response.setHeader("Content-Disposition","attachment; filename=sales_year.xls");
		
		
		WritableWorkbook writebook = Workbook.createWorkbook(output);
		WritableSheet writeSheet = writebook.createSheet("년조회", 0);

		WritableCellFormat headerFormat = new WritableCellFormat(); // 번호 셀 포멧 생성
		WritableCellFormat dataFormat = new WritableCellFormat(); // 데이터 셀 포멧 생성

		headerFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		headerFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		headerFormat.setBackground(Colour.GRAY_25);
		
		dataFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		dataFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		dataFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		dataFormat.setWrap(true);
		
		
		writeSheet.setColumnView(0, 20); 
		writeSheet.setColumnView(1, 18); 
		writeSheet.setColumnView(2, 18); 
		writeSheet.setColumnView(3, 18); 
		writeSheet.setColumnView(4, 18); 
		writeSheet.setColumnView(5, 18); 
		writeSheet.setColumnView(6, 18); 
		writeSheet.setColumnView(7, 18); 

		
		CellView cv = new CellView();
		cv.setAutosize(true);
			
		int i = 1;
		
		String[] header = {"협력업체명", "주문건수", "주문수량", "할인전매출총액", "카드", "현금", "할인금액", "결제완료액+결제예정금액"};
		if (header != null && header.length > 0)
		{
			for(int x=0;x<header.length;x++){
				Label headerLabels =new Label(x, i, header[x], headerFormat); // 데이터 포멧에 맞게 대문자 A에서 E까지 생성
				writeSheet.addCell(headerLabels); // 셀에 삽입
			}
			i++;
		}
		try {
			for(MCMap map : list){
				int cell = 0;
				int bf_discount = map.getIntNullVal("bf_discount", 0);
				int ordercount = map.getIntNullVal("ordercount", 0);
				int orderqty = map.getIntNullVal("orderqty", 0);
				int card = map.getIntNullVal("card", 0);
				int iche = map.getIntNullVal("iche", 0);
				int virtual = map.getIntNullVal("virtual", 0);
				int sale_price = map.getIntNullVal("sale_price", 0);

				writeSheet.addCell(new Label(cell++, i, StringUtil.isNullDef((String)map.get("com_nm"), "합계"), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(ordercount), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(orderqty), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(bf_discount), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(card), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(iche + virtual), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(sale_price), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand((card + virtual + iche) - sale_price), dataFormat));
				
				i++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		writebook.write(); // 준비된 정보를 엑셀 포멧에 맞게 작성
		writebook.close(); // 처리 후 메모리에서 해제 처리
	}
	
}
