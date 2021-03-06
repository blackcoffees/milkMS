package com.cy.milkms.service.impl;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cy.milkms.db.dao.SaleMapper;
import com.cy.milkms.db.entity.Distributor;
import com.cy.milkms.db.entity.Milk;
import com.cy.milkms.db.entity.Sale;
import com.cy.milkms.db.entity.Sale_detailed;
import com.cy.milkms.db.entity.Stock;
import com.cy.milkms.db.entity.StockRecord;
import com.cy.milkms.db.query.SaleQuery;
import com.cy.milkms.service.IDistributorService;
import com.cy.milkms.service.ILogService;
import com.cy.milkms.service.IMilkService;
import com.cy.milkms.service.ISaleDetailedService;
import com.cy.milkms.service.ISaleService;
import com.cy.milkms.service.IStockRecordService;
import com.cy.milkms.service.IStockService;
import com.cy.milkms.util.CommonTool;
import com.cy.milkms.util.DateTool;
import com.cy.milkms.util.Enum;
import com.cy.milkms.util.Pager;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service("saleService")
public class SaleService implements ISaleService{
	
	@Autowired
	private SaleMapper mapper;
	
	@Autowired
	private IDistributorService distributorService;
	
	@Autowired
	private IMilkService milkService;
	
	@Autowired
	private ISaleDetailedService detailedService;
	
	@Autowired
	private IStockService stockService;
	
	@Autowired
	private IStockRecordService stockRecordService;
	
	@Autowired
	private ILogService logService;

	@Override
	public Map<String, Object> addSale(String saleTime, int distributorID, double totalPrice, String list, int status) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("succ", false);
		result.put("message", "系统繁忙，请稍后再试");
		JSONArray jsonArray = JSONArray.fromObject(list);
		Distributor distributor = distributorService.getDistributorByID(distributorID);
		if(distributor == null){
			result.put("message", "商家不存在，请重新选择");
			return result;
		}
		double totalAmount = 0;
		List<Sale_detailed> detailedList = new ArrayList<Sale_detailed>();
		Map<Integer, Stock> stockMap = new HashMap<Integer, Stock>();
		for(int i=0;i<jsonArray.size();i++){
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			String milkName = jsonObject.getString("milkName");
			Milk milk = milkService.getMilkByNameOrCode(milkName, "");
			if(milk == null){
				throw new Exception(milkName+"商品不存在，请重新选择");
			}
			String numberStr = jsonObject.getString("number");
			if(!CommonTool.isNumber(numberStr)){
				throw new Exception("商品数量错误");
			}
			int number = Integer.parseInt(numberStr);
			String priceStr = jsonObject.getString("price");
			if(!CommonTool.isNumber(priceStr)){
				throw new Exception("商品单价错误");
			}
			/*判断库存是否充足*/
			Stock stock = stockService.getStockByMilkID(milk.getId());
			if(stock.getQuantity() < number){
				throw new Exception(milkName+"库存不足");
			}
			stockMap.put(stock.getMilk_ID(), stock);
			/*生成销售分单*/
			double price = Double.parseDouble(priceStr);
			double signTotalAmount = number * price;
			totalAmount += signTotalAmount;
			Sale_detailed detailed = new Sale_detailed();
			detailed.setCreated(DateTool.getNowTime());
			detailed.setMilk_ID(milk.getId());
			detailed.setNumber(number);
			detailed.setPrice(price);
			detailed.setTotal_price(signTotalAmount);
			detailed.setUpdated(DateTool.getNowTime());
			detailed.setCost_price(stock.getCost_price());
			detailedList.add(detailed);
		}
		/*生成销售单*/
		Sale sale = new Sale();
		sale.setCreated(DateTool.getNowTime());
		sale.setDistributor_id(distributorID);
		sale.setReceivables_price(totalAmount);
		if(status == Enum.SALE_STATUS_PAID){
			sale.setPaid_price(totalAmount);
			sale.setUnpaid_price(0);
			sale.setPaid_time(DateTool.getNowTime());
		}
		else if(status == Enum.SALE_STATUS_UNPAID){
			sale.setPaid_price(0);
			sale.setUnpaid_price(totalAmount);
			sale.setPaid_time(null);
		}
		sale.setSale_time(DateTool.getNowTime());
		sale.setCreated(DateTool.getNowTime());
		sale.setUpdated(DateTool.getNowTime());
		sale.setStatus(status);
		int addResult = mapper.addSale(sale);
		if(addResult <= 0){
			throw new Exception("新增失败");
		}
		/*操作日志*/
		logService.addLog(mapper, "addSale", sale);
		
		/*销售分单保存*/
		for(int i=0;i<detailedList.size();i++){
			Sale_detailed detailed = detailedList.get(i);
			detailed.setSale_ID(sale.getId());
			int detailedResult = detailedService.addSaleDetailed(detailed);
			if(detailedResult <= 0){
				throw new Exception("新增失败");
			}
		}
		/*商家金额变动*/
		distributor.setTotal_price(distributor.getTotal_price() + totalAmount);
		if(status == Enum.SALE_STATUS_PAID){
			distributor.setPaid_price(distributor.getPaid_price() + totalAmount);
		}
		else if(status == Enum.SALE_STATUS_UNPAID){
			distributor.setUnpaid_price(distributor.getUnpaid_price() + totalAmount);
		}
		distributor.setTotal_price(distributor.getTotal_price() + totalAmount);
		distributor.setUpdated(DateTool.getNowTime());
		int disResult = distributorService.updateDistributorAmount(distributor);
		if(disResult <= 0){
			throw new Exception("新增失败");
		}
		/*库存修改*/
		for(int i=0;i<detailedList.size();i++){
			int newStockNumber = stockMap.get(detailedList.get(i).getMilk_ID()).getQuantity() - detailedList.get(i).getNumber();
			StockRecord stockRecord = new StockRecord();
			stockRecord.setCreated(DateTool.getNowTime());
			stockRecord.setMilk_id(detailedList.get(i).getMilk_ID());
			stockRecord.setNew_qty(newStockNumber);
			stockRecord.setOld_qty(stockMap.get(detailedList.get(i).getMilk_ID()).getQuantity());
			stockRecord.setUpdated(DateTool.getNowTime());
			int addStockRecordResult = stockRecordService.addStockRecord(stockRecord);
			if(addStockRecordResult <= 0){
				throw new Exception("减少库存失败, 请联系管理员");
			}
			Stock stock = stockMap.get(detailedList.get(i).getMilk_ID());
			stock.setQuantity(newStockNumber);
			stock.setUpdated(DateTool.getNowTime());
			int updateStockResult = stockService.updateStock(stock);
			if(updateStockResult < 0){
				throw new Exception("减少库存失败, 请联系管理员");
			}
		}
		result.put("succ", true);
		result.put("message", "新增成功");
		return result;
	}

	@Override
	public List<List<SaleQuery>> getSaleByCondition(String startTime, String endTime, int saleID, Pager pager, String distributorName, int status) {
		List<SaleQuery> rows = mapper.getSaleByCondition(startTime, endTime, saleID, pager, distributorName, status);
		Map<Integer, List<SaleQuery>> map = new HashMap<Integer, List<SaleQuery>>();
		for(int i=0;i < rows.size(); i++){
			if(map.get(rows.get(i).getId()) != null){
				List<SaleQuery> list = map.get(rows.get(i).getId());
				list.add(rows.get(i));
			}
			else{
				List<SaleQuery> list2 = new ArrayList<SaleQuery>();
				list2.add(rows.get(i));
				map.put(rows.get(i).getId(), list2);
			}
		}
		Set<Integer> keys = map.keySet();
		Iterator<Integer> iterator = keys.iterator();
		List<List<SaleQuery>> result = new ArrayList<List<SaleQuery>>();
		while(iterator.hasNext()){
			result.add(map.get(iterator.next()));
		}
		return result;
	}

	@Override
	public int getSaleByConditionCount(String startTime, String endTime, int saleID, String distributorName, int status) {
		return mapper.getSaleByConditionCount(startTime, endTime, saleID, distributorName, status);
	}

	@Override
	public int updateSaleStatus(int status, int saleID, Timestamp updated) {
		/*操作日志*/
		logService.addLog(mapper, "updateSaleStatus", new Object[]{status, saleID, updated});
		return mapper.updateSaleStatus(status, saleID, updated);
	}
	
	@Override
	public Map<String, Object> abandonSale(int saleID){
		Map<String, Object> result = new HashMap<>();
		result.put("succ", false);
		result.put("message", "系统繁忙，请稍后再试");
		Sale sale = this.getSaleByID(saleID);
		if(sale == null){
			result.put("message", "销售单不存在");
			return result;
		}
		else if(sale.getStatus() == Enum.SALE_STATUS_OFF){
			result.put("message", "该销售单无法废弃");
			return result;
		}
		try {
			/*减少库存*/
			List<Sale_detailed> detailedList = detailedService.getSaleDetailedBySaleID(saleID);
			for(int i=0;i<detailedList.size();i++){
				Stock stock = stockService.getStockByMilkID(detailedList.get(i).getMilk_ID());
				if(stock == null){
					throw new Exception("该商品不存在");
				}
				if(stock.getQuantity() < detailedList.get(i).getNumber()){
					throw new Exception("库存不足无法废弃");
				}
				int newStockNumber = stock.getQuantity() - detailedList.get(i).getNumber();
				StockRecord stockRecord = new StockRecord();
				stockRecord.setCreated(DateTool.getNowTime());
				stockRecord.setMilk_id(detailedList.get(i).getMilk_ID());
				stockRecord.setNew_qty(newStockNumber);
				stockRecord.setOld_qty(stock.getQuantity());
				stockRecord.setUpdated(DateTool.getNowTime());
				int addStockRecordResult = stockRecordService.addStockRecord(stockRecord);
				if(addStockRecordResult <= 0){
					throw new Exception("废弃失败, 请联系管理员");
				}
				stock.setQuantity(newStockNumber);
				stock.setUpdated(DateTool.getNowTime());
				int updateStockResult = stockService.updateStock(stock);
				if(updateStockResult <= 0){
					throw new Exception("废弃失败, 请联系管理员");
				}
			}
			/*废弃销售单*/
			int updateSaleResult = this.updateSaleStatus(Enum.SALE_STATUS_OFF, saleID, DateTool.getNowTime());
			if(updateSaleResult <= 0){
				throw new Exception("废弃失败");
			}
			/*商家金额变动*/
			Distributor distributor = distributorService.getDistributorByID(sale.getDistributor_id());
			if(sale.getStatus() == Enum.SALE_STATUS_PAID){
				distributor.setPaid_price(distributor.getPaid_price() - sale.getReceivables_price());
			}
			else if(sale.getStatus() == Enum.SALE_STATUS_UNPAID){
				distributor.setUnpaid_price(distributor.getUnpaid_price() - sale.getReceivables_price());
			}
			distributor.setTotal_price(distributor.getTotal_price() - sale.getReceivables_price());
			distributor.setUpdated(DateTool.getNowTime());
			int updateDisResult = distributorService.updateDistributorAmount(distributor);
			if(updateDisResult <= 0){
				throw new Exception("废弃失败");
			}
			result.put("succ", true);
			result.put("message", "废弃成功");
		} catch (Exception e) {
			result.put("message", e.getMessage());
			return result;
		}
		return result;
	}

	@Override
	public Sale getSaleByID(int saleID) {
		return mapper.getSaleByID(saleID);
	}

	@Override
	public Map<String, Object> balanceSale(int saleID, double amount) {
		Map<String, Object> result = new HashMap<>();
		result.put("succ", false);
		result.put("message", "系统繁忙，请稍后再试");
		Sale sale = this.getSaleByID(saleID);
		if(sale == null){
			result.put("message", "销售单不存在");
			return result;
		}
		else if(sale.getStatus() != Enum.SALE_STATUS_UNPAID){
			result.put("message", "该销售单无法结算");
			return result;
		}
		try {
			Distributor distributor = distributorService.getDistributorByID(sale.getDistributor_id());
			distributor.setUnpaid_price(distributor.getUnpaid_price() - amount);
			distributor.setPaid_price(distributor.getPaid_price() + amount);
			distributor.setUpdated(DateTool.getNowTime());
			int updateDisResult = distributorService.updateDistributorAmount(distributor);
			if(updateDisResult <= 0){
				throw new Exception("结算失败");
			}
			
			if(sale.getUnpaid_price() == amount){
				sale.setStatus(Enum.SALE_STATUS_PAID);
			}
			sale.setPaid_price(sale.getPaid_price() + amount);
			sale.setUnpaid_price(sale.getUnpaid_price() - amount);
			sale.setUpdated(DateTool.getNowTime());
			sale.setPaid_time(DateTool.getNowTime());
			int updateSaleResult = this.updateBalanceSale(sale);
			if(updateSaleResult <= 0){
				throw new Exception("结算失败");
			}
			result.put("succ", true);
			result.put("message", "结算成功");
			return result;
		} catch (Exception e) {
			result.put("message", e.getMessage());
			return result;
		}
	}

	@Override
	public int updateBalanceSale(Sale sale) {
		/*操作日志*/
		logService.addLog(mapper, "updateBalanceSale", sale);
		return mapper.updateBalanceSale(sale);
	}

}
