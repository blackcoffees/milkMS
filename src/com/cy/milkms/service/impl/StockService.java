package com.cy.milkms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cy.milkms.db.dao.StockMapper;
import com.cy.milkms.db.entity.Stock;
import com.cy.milkms.db.query.StockQuery;
import com.cy.milkms.service.ILogService;
import com.cy.milkms.service.IStockService;
import com.cy.milkms.util.Pager;

@Service("stockService")
public class StockService implements IStockService{

	@Autowired
	private StockMapper mapper;
	
	@Autowired
	private ILogService logService;
	
	@Override
	public int updateStock(Stock stock) {
		/*操作日志*/
		logService.addLog(mapper, "updateStock", stock);
		return mapper.updateStock(stock);
	}

	@Override
	public Stock getStockByMilkID(int milkID) {
		return mapper.getStockByMilkID(milkID);
	}

	@Override
	public int addStock(Stock stock) {
		/*操作日志*/
		logService.addLog(mapper, "addStock", stock);
		return mapper.addStock(stock);
	}

	@Override
	public List<StockQuery> getStockByMilkName(String milkName) {
		return mapper.getStockByMilkName(milkName);
	}

	@Override
	public List<StockQuery> getStockByCondition(String milkName, Pager pager) {
		return mapper.getStockByCondition(milkName, pager);
	}

	@Override
	public int getStockByConditionCount(String milkName) {
		// TODO Auto-generated method stub
		return mapper.getStockByConditionCount(milkName);
	}

}
