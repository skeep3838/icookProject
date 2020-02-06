package com.icook.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icook.model.orderBean;
import com.icook.model.orderDetail;
import com.icook.order.dao.OrdersDao;

@Transactional
@Service
public class SearchOrdersService implements SearchOrdersServiceDao {
	OrdersDao dao;
	@Autowired
	public void setDao(OrdersDao dao) {
		this.dao = dao;
	}
	@Override
	public List<orderBean> searchAllDetails(int userId) {
		List<orderBean> list = dao.getAllOrders(userId);
		return list;
	}
	public List<orderDetail> searchAllOrdDetails(int orderId) {
		List<orderDetail> list = dao.getAllOrderDetails(orderId);
		return list;
	}
	@Override
	public void Delete(int orderId) {
		dao.DeleteOrders(orderId);
	}
	
 }
